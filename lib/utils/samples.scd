////////////////////////////////////////////////////////////////////////////////
// Sample Library
//
// Bank/variant loading, lookup, buffer access, and the seconds->frames helper.
// Split out of utils.scd. Loaded from the tail of utils.scd.
////////////////////////////////////////////////////////////////////////////////

(

// Convert seconds to frame position for sample playback
// Usage: ~secondsToFrames.(1.5, ~sampleBuffers[\sample_0])
~secondsToFrames = { |seconds, buffer|
	var framePosition = 0;

	if (buffer.notNil) {
		var sampleRate = buffer.sampleRate;
		framePosition = (seconds * sampleRate).asInteger;
	} {
		"Buffer is nil, returning 0".warn;
	};

	framePosition;
};


// Load sample library with SuperDirt-style bank/variant structure
~loadSampleLibrary = {
	var basePath, builtinPath, totalBanks = 0, totalVariants = 0;
	var loadBankFromPath;

	// Helper function to load a bank from a folder path
	loadBankFromPath = { |folderPath, bankName|
		var folder = PathName(folderPath);
		var buffers = List.new;
		var paths = List.new;
		var metadata = List.new;

		if (folder.isFolder) {
			folder.files.do { |file|
				var ext = (file.fullPath.splitext[1] ? "").toLower;
				var validExts = ["wav", "aif", "aiff", "aifc"];
				var isValid = validExts.includesEqual(ext);
				var buf;

				if (isValid) {
					// Normalise to 2ch via a cheap header peek: mono -> duplicate L=R, stereo -> native.
					// The sample player reads PlayBuf(2), so this ends the channel-mismatch warnings.
					var nc = SoundFile.use(file.fullPath, { |sf| sf.numChannels });
					buf = Buffer.readChannel(s, file.fullPath,
						channels: (nc == 1).if({ [0, 0] }, { [0, 1] }),
						action: { |buffer|
							if (buffer.notNil) {
								var meta = (
									path: file.fullPath,
									filename: file.fileName,
									numChannels: buffer.numChannels,
									numFrames: buffer.numFrames,
									sampleRate: buffer.sampleRate,
									duration: buffer.numFrames / buffer.sampleRate
								);
								metadata.add(meta);
							};
						});

					buffers.add(buf);
					paths.add(file.fullPath);
				};
			};

			if (buffers.size > 0) {
				~sampleLibrary.banks[bankName] = buffers;
				~sampleLibrary.paths[bankName] = paths;
				~sampleLibrary.metadata[bankName] = metadata;

				("  " ++ bankName ++ ": " ++ buffers.size ++ " variants").postln;
				totalBanks = totalBanks + 1;
				totalVariants = totalVariants + buffers.size;
			};
		};
	};

	// Load built-in SC samples as 'default' bank
	builtinPath = Platform.resourceDir +/+ "sounds";
	("Loading built-in samples from: " ++ builtinPath).postln;
	loadBankFromPath.(builtinPath, \default);

	// Load user sample library
	basePath = ~basePath +/+ "samples";
	("Loading sample library from: " ++ basePath).postln;

	if (PathName(basePath).isFolder.not) {
		("Sample library folder not found: " ++ basePath).warn;
		("Please create the folder and add sample banks").postln;
	} {
		// Recursively load banks from samples/ folder (subfolders become bankName-subName)
		var loadFolderRecursive = { |folderPath, prefix|
			var folder = PathName(folderPath);
			var bankName = if (prefix.isNil) { folder.folderName } { prefix ++ "-" ++ folder.folderName };

			// Load audio files directly in this folder
			loadBankFromPath.(folder.fullPath, bankName.asSymbol);

			// Recurse into subfolders
			folder.folders.do { |subfolder|
				loadFolderRecursive.(subfolder.fullPath, bankName);
			};
		};

		PathName(basePath).folders.do { |folder|
			loadFolderRecursive.(folder.fullPath, nil);
		};
	};

	("Sample library loaded: " ++ totalBanks ++ " banks, " ++ totalVariants ++ " total samples").postln;
};

// Free entire sample library
~freeSampleLibrary = {
	~sampleLibrary.banks.keysValuesDo { |bankName, buffers|
		buffers.do { |buf|
			if (buf.notNil) {
				buf.free;
			};
		};
	};

	~sampleLibrary.banks.clear;
	~sampleLibrary.paths.clear;
	~sampleLibrary.metadata.clear;

	"Sample library freed".postln;
};

// List all loaded sample banks
~listSampleBanks = {
	if (~sampleLibrary.banks.size == 0) {
		"No sample banks loaded".postln;
		^nil;
	};

	"Sample Banks:".postln;
	~sampleLibrary.banks.keysValuesDo { |bankName, buffers|
		("  " ++ bankName ++ ": " ++ buffers.size ++ " variants").postln;
		if (~sampleLibrary.metadata[bankName].notNil) {
			~sampleLibrary.metadata[bankName].do { |meta, idx|
				if (meta.notNil) {
					("    [" ++ idx ++ "] " ++ meta.filename ++
					 " (" ++ meta.numChannels ++ "ch, " ++
					 meta.duration.round(0.01) ++ "s)").postln;
				};
			};
		};
	};
};

// Get buffer for a bank + variant combination
~getSampleBuffer = { |bankName, variant = 0|
	var bank;

	if (bankName.isNil) {
		^nil;  // Silently return nil if no bank selected
	};

	bank = ~sampleLibrary.banks[bankName];

	if (bank.isNil) {
		("Sample bank not found: " ++ bankName ++ " — playing default sample").warn;
		bank = ~sampleLibrary.banks[\default];   // audible placeholder beats silence
	};

	// Use wrapAt for safe indexing (SuperDirt style); nil-safe if no default bank
	bank !? { bank.wrapAt(variant) };
};

// Lookup bank and variant by file path
~lookupSampleByPath = { |filepath|
	var result = nil;

	filepath = filepath.standardizePath;

	~sampleLibrary.paths.keysValuesDo { |bankName, pathsArray|
		pathsArray.do { |path, idx|
			if (path.standardizePath == filepath) {
				result = (bankName: bankName, variant: idx);
			};
		};
	};

	if (result.isNil) {
		("Sample not found in library: " ++ filepath).warn;
	};

	result;
};

)
