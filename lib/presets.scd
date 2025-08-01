////////////////////////////////////////////////////////////////////////////////
// Preset Utils
////////////////////////////////////////////////////////////////////////////////
(
~generatePresetName = {
	var timestamp = Date.localtime;
	timestamp.year.asString[2..] ++
	timestamp.month.asString.padLeft(2, "0") ++
	timestamp.day.asString.padLeft(2, "0") ++ "-" ++
	timestamp.hour.asString.padLeft(2, "0") ++
	timestamp.minute.asString.padLeft(2, "0") ++ "-" ++
	timestamp.second.asString.padLeft(2, "0");
};

~readPresetTemplate = { |basePath|
	var stateFile = (basePath +/+ "presets/plaits/default.scd").standardizePath;
	var sourceFile = if (~currentPresetTemplate.notNil && File.exists(~currentPresetTemplate.standardizePath)) {
		~currentPresetTemplate.standardizePath;
	} {
		stateFile;
	};

	var content;
	try {
		content = File.use(sourceFile, "r", { |f| f.readAllString });
		("Reading template from: " ++ sourceFile).postln;
	} {
		("Error reading " ++ sourceFile ++ ", falling back to default.scd").postln;
		content = File.use(stateFile, "r", { |f| f.readAllString });
		~currentPresetTemplate = nil;
	};
	content;
};

~processParameterLine = { |line, plaitsIndex|
	var currentPlaits = ~plaits[plaitsIndex];
	var parts = line.split($,);

	parts = parts.collect { |part|
		var colonIdx = part.find(":");
		if (colonIdx.notNil) {
			var beforeColon = part[0..colonIdx-1];
			var keyPart = beforeColon.replace(" ", "").replace("\t", "");
			var key = keyPart.asSymbol;

			if (currentPlaits[key].notNil && (key != \sequences)) {
				var newValue = currentPlaits[key];
				var formattedValue = if (newValue.isNumber) {
					newValue.round(0.01).asString;
				} {
					newValue.asString;
				};
				var replacement = beforeColon ++ ": " ++ formattedValue;
				("Updated " ++ key ++ ": " ++ part.replace("\n", "").replace("\t", " ") ++ " -> " ++ replacement).postln;
				replacement;
			} { part };
		} { part };
	};
	parts.join(",");
};

~replaceScalarValues = { |content|
	var lines = content.split($\n);
	var plaitsIndex = -1;
	var inScalarsSection = false;

	lines.collect { |line|
		var match, trimmedLine, isComment;

		// Track plaits instance markers
		if (line.contains("$PLAITS")) {
			match = line.findRegexp("\\$PLAITS([0-9]+)");
			if (match.notNil && match.size > 1) {
				plaitsIndex = match[1][1].asInteger - 1;
				("Processing plaits instance: " ++ plaitsIndex).postln;
			};
		};

		// Track scalar section markers
		if (line.contains("$PRESET_SCALARS_START")) {
			inScalarsSection = true;
			("Entering scalars section").postln;
		};
		if (line.contains("$PRESET_SCALARS_END")) {
			inScalarsSection = false;
			("Exiting scalars section").postln;
		};

		// Check if line is commented
		trimmedLine = line.replace(" ", "").replace("\t", "");
		isComment = trimmedLine.beginsWith("//");

		// Process parameter lines
		if (isComment.not && line.contains(":") && inScalarsSection &&
		   (plaitsIndex.isInteger) && (plaitsIndex >= 0) && (plaitsIndex < ~plaits.size)) {
			~processParameterLine.(line, plaitsIndex);
		} { line };
	}.join("\n");
};

// Save all modified editor documents to capture changes
~saveAllModified = {
	Document.allDocuments.collect{ |doc, index|
		[index, doc.isEdited, doc.path].postln;
		if (doc.path.notNil && doc.isEdited) {
			var file = File(doc.path, "w");
			("Saving editor changes: " ++ doc.path.basename).postln;
			file.write(doc.string);
			file.close;
		};
	}
};

// Save preset with new name (creates new file)
~savePresetAs = { |name|
	var presetDir, filepath, content;

	// First save any editor changes
	~saveAllModified.();

	presetDir = ~basePath +/+ "presets/plaits";

	("~savePresetAs with name: " ++ name).postln;

	// Generate name if not provided
	if (name.isNil) {
		name = ~generatePresetName.();
		("Auto-generated preset name: " ++ name).postln;
	};

	filepath = (presetDir +/+ (name ++ ".scd")).standardizePath;

	// Read and process template
	content = ~readPresetTemplate.(~basePath);
	("Original content length: " ++ content.size).postln;

	content = ~replaceScalarValues.(content);
	("Updated content length: " ++ content.size).postln;

	// Save and update state
	File.mkdir(filepath.dirname);
	File.use(filepath, "w", { |f| f.write(content) });
	("New preset saved: " ++ filepath).postln;

	~currentPresetTemplate = filepath;
	Document.open(filepath);
	("New preset template: " ++ filepath).postln;
};

// Save preset to current template (updates existing file)
~savePreset = {
	var content, filepath;

	// First save any editor changes
	~saveAllModified.();

	if (~currentPresetTemplate.isNil) {
		("No current template set, using savePresetAs instead").postln;
		~savePresetAs.();
	} {
		filepath = ~currentPresetTemplate.standardizePath;

		("Updating current preset: " ++ filepath.basename).postln;

		// Read and process current template
		content = ~readPresetTemplate.(~basePath);
		content = ~replaceScalarValues.(content);

		// Overwrite current template file
		File.use(filepath, "w", { |f| f.write(content) });
		("Current preset updated: " ++ filepath).postln;
	};
};

~loadPreset = { |nameOrPath|
	var filepath;
	
	// Check if it's already a full path
	if (nameOrPath.contains("/")) {
		filepath = nameOrPath.standardizePath;
	} {
		// It's just a name, build the path
		filepath = ~basePath +/+ "presets/plaits" +/+ (nameOrPath ++ ".scd");
	};
	
	this.executeFile(filepath);
	Document.open(filepath);
	~currentPresetTemplate = filepath;
	("Preset loaded: " ++ filepath).postln;
	("Current preset template updated to: " ++ filepath.basename).postln;
};

~loadRandomPreset = {
	var presetDir = (~basePath +/+ "presets/plaits").standardizePath;
	var presetFiles = (presetDir +/+ "*.scd").pathMatch;

	if (presetFiles.size > 0) {
		var randomFile = presetFiles.choose;
		var presetName = randomFile.basename.splitext[0];
		("Loading random preset: " ++ presetName).postln;
		~loadPreset.(presetName);
	} {
		("No preset files found in: " ++ presetDir).postln;
	};
};


// ~savePreset.("hybrid-test");
// ~savePreset.();
)