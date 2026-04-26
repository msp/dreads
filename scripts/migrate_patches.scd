////////////////////////////////////////////////////////////////////////////////
// Patch Migration Script
// Adds sequence section markers to patch files
////////////////////////////////////////////////////////////////////////////////

// Find the closing paren of a sequence block using depth tracking
~findSequenceBlockEnd = { |lines, startIdx|
	var depth, inString, offset, line, charIdx, char, result, found;

	depth = 1;  // Start at 1 (we're already past the opening paren)
	inString = false;
	found = false;
	result = lines.size - 1;  // Default fallback

	// Iterate through lines starting AFTER the opening paren line
	offset = 1;  // Start from next line
	while ({ ((startIdx + offset) < lines.size) && found.not }) {
		line = lines[startIdx + offset];

		// Character-by-character state machine
		charIdx = 0;
		while ({ (charIdx < line.size) && found.not }) {
			char = line[charIdx];

			// Track string literals (ignore parens inside strings)
			if (char == $") { inString = inString.not };

			if (inString.not) {
				// Track bracket/paren depth
				if ((char == $() || (char == $[)) { depth = depth + 1 };
				if ((char == $)) || (char == $])) { depth = depth - 1 };

				// Found the closing paren when depth reaches 0
				if (depth == 0) {
					result = startIdx + offset;
					found = true;
				};
			};

			charIdx = charIdx + 1;
		};

		offset = offset + 1;
	};

	result;
};

// Migrate a single patch file to add sequence markers
~migratePatchFile = { |filePath, dryRun = false|
	var content, lines, output, i, line, nextIdx, endIdx, markerType, startMarker, endMarker;
	var foundScalarsEnd, indent, j, shouldSkip;

	("  Migrating: " ++ filePath.basename).postln;

	// Read file
	content = File.readAllString(filePath);

	// Check if already migrated
	shouldSkip = content.contains("// $PRESET_SEQUENCES_START");

	if (shouldSkip) {
		("    ⊘ Skipping (already migrated)").postln;
	} {
		lines = content.split($\n);
		output = [];
		i = 0;

	while ({ i < lines.size }) {
		line = lines[i];
		output = output.add(line);

		// Check for SCALARS_END markers (both plaits and sample)
		foundScalarsEnd = false;
		markerType = nil;

		if (line.contains("// $PRESET_SCALARS_END")) {
			foundScalarsEnd = true;
			markerType = \plaits;
			startMarker = "// $PRESET_SEQUENCES_START";
			endMarker = "// $PRESET_SEQUENCES_END";
		};

		if (line.contains("// $PRESET_SAMPLE_SCALARS_END")) {
			foundScalarsEnd = true;
			markerType = \sample;
			startMarker = "// $PRESET_SAMPLE_SEQUENCES_START";
			endMarker = "// $PRESET_SAMPLE_SEQUENCES_END";
		};

		if (foundScalarsEnd) {
			("    Processing " ++ markerType ++ " at line " ++ i).postln;

			// Find next non-comment, non-whitespace line (should be opening paren)
			nextIdx = i + 1;
			while ({ (nextIdx < lines.size) &&
			         (lines[nextIdx].stripWhiteSpace.isEmpty ||
			          lines[nextIdx].stripWhiteSpace.beginsWith("//")) }) {
				output = output.add(lines[nextIdx]);
				nextIdx = nextIdx + 1;
			};

			// This line should have the opening paren
			if (nextIdx < lines.size) {
				// Get indentation from the opening paren line
				indent = "";
				j = 0;
				while ({ (j < lines[nextIdx].size) &&
				         ((lines[nextIdx][j] == $ ) || (lines[nextIdx][j] == $\t)) }) {
					indent = indent ++ lines[nextIdx][j].asString;
					j = j + 1;
				};

				// Insert START marker with same indentation
				output = output.add(indent ++ startMarker);

				// Add the opening paren line
				output = output.add(lines[nextIdx]);

				// Find the closing paren using depth tracking
				endIdx = ~findSequenceBlockEnd.(lines, nextIdx);
				("    Found end at line " ++ endIdx).postln;

				// Add all lines between opening and closing paren
				j = nextIdx + 1;
				while ({ j <= endIdx }) {
					output = output.add(lines[j]);
					j = j + 1;
				};
				("    Added lines, inserting markers").postln;

				// Insert END marker after closing paren with same indentation
				output = output.add(indent ++ endMarker);

				// Update i to continue after the sequence block
				i = endIdx;
			};
		};

		i = i + 1;
	};

	// Write back to file (or just show if dry run)
	if (dryRun) {
		"=== DRY RUN - Would write: ===".postln;
		output.do { |l| l.postln };
		"".postln;
	} {
		File.use(filePath, "w", { |file|
			output.do { |l, idx|
				file.write(l);
				if (idx < (output.size - 1)) {
					file.write("\n");
				};
			};
		});
		("  ✓ Migrated: " ++ filePath).postln;
	};
	};  // End of shouldSkip if-else
};

// Migrate all files in a directory
~migrateDirectory = { |dirPath, dryRun = false|
	var files, fullPath;

	("=== Migrating directory: " ++ dirPath ++ " ===").postln;
	"".postln;

	// Get all .scd files in directory (not recursive)
	files = PathName(dirPath).files.select({ |f| f.extension == "scd" });

	("Found " ++ files.size ++ " patch files").postln;
	"".postln;

	files.do { |file, idx|
		fullPath = file.fullPath;
		("Processing file " ++ (idx + 1) ++ "/" ++ files.size).postln;
		~migratePatchFile.(fullPath, dryRun);
		("Finished file " ++ (idx + 1)).postln;
	};

	"".postln;
	("✓ Directory migration complete: " ++ files.size ++ " files").postln;
};

// Migrate all patches recursively (excluding default.scd)
~migrateAllPatches = { |basePath, dryRun = false|
	var patchDir, allFiles, filesToMigrate, count;

	patchDir = basePath +/+ "patches/dreads";

	("=== Migrating all patches in: " ++ patchDir ++ " ===").postln;
	"".postln;

	// Get all .scd files recursively
	allFiles = List.new;
	PathName(patchDir).filesDo({ |file|
		if (file.extension == "scd") {
			allFiles.add(file);
		};
	});

	// Filter out default.scd
	filesToMigrate = allFiles.select({ |f|
		f.fileName != "default.scd"
	});

	("Found " ++ filesToMigrate.size ++ " preset files to migrate").postln;
	"".postln;

	count = 0;
	filesToMigrate.do { |file|
		~migratePatchFile.(file.fullPath, dryRun);
		count = count + 1;
	};

	"".postln;
	("✓✓✓ Migration complete: " ++ count ++ " files processed ✓✓✓").postln;
};

"".postln;
"=== Patch Migration Script Loaded ===".postln;
"".postln;
"Usage:".postln;
"  ~migratePatchFile.(\"path/to/file.scd\", dryRun: true)".postln;
"  ~migrateDirectory.(\"path/to/dir\", dryRun: true)".postln;
"  ~migrateAllPatches.(~basePath, dryRun: true)".postln;
"".postln;
