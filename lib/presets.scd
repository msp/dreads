////////////////////////////////////////////////////////////////////////////////
// Preset Utils
////////////////////////////////////////////////////////////////////////////////
(
// Template factory function to create plaits instances with inheritance
~plaitsFactory = { |scalarOverrides, sequenceOverrides|
	var scalars, sequences, sortedSequences;

	scalars = ~defaultScalars.copy;
	sequences = ~defaultSequences.copy;

	// Use empty dictionaries if no overrides provided
	scalarOverrides = scalarOverrides ?? ();
	sequenceOverrides = sequenceOverrides ?? ();

	// Merge overrides into defaults
	scalars.putAll(scalarOverrides);
	sequences.putAll(sequenceOverrides);

	// Create alphabetically sorted sequences dictionary
	sortedSequences = ();
	sequences.keys.asArray.sort.do { |key|
		sortedSequences.put(key, sequences[key]);
	};

	// Create the merged instance
	scalars.putAll((sequences: sortedSequences))
};

// Template factory function to create sample instances with inheritance
~sampleFactory = { |scalarOverrides, sequenceOverrides|
	var scalars, sequences, sortedSequences;

	scalars = ~defaultSampleScalars.copy;
	sequences = ~defaultSampleSequences.copy;

	// Use empty dictionaries if no overrides provided
	scalarOverrides = scalarOverrides ?? ();
	sequenceOverrides = sequenceOverrides ?? ();

	// Merge overrides into defaults
	scalars.putAll(scalarOverrides);
	sequences.putAll(sequenceOverrides);

	// Create alphabetically sorted sequences dictionary
	sortedSequences = ();
	sequences.keys.asArray.sort.do { |key|
		sortedSequences.put(key, sequences[key]);
	};

	// Create the merged instance
	scalars.putAll((sequences: sortedSequences))
};

// New preset factory function that creates the full preset structure with FX
~presetFactory = { |synthArray, samplesArray, fxOverrides|
	var fx, sortedFX;

	fx = ~defaultFX.deepCopy;
	fxOverrides = fxOverrides ?? ();
	samplesArray = samplesArray ?? [];  // Default to empty samples array

	// Merge FX overrides into defaults (nested structure)
	fxOverrides.keysValuesDo { |category, categoryValues|
		if (categoryValues.isKindOf(Dictionary)) {
			categoryValues.keysValuesDo { |param, value|
				fx[category][param] = value;
			};
		} {
			fx[category] = categoryValues;
		};
	};

	// Create alphabetically sorted FX dictionary
	sortedFX = ();
	fx.keys.asArray.sort.do { |category|
		var sortedCategory = ();
		fx[category].keys.asArray.sort.do { |param|
			sortedCategory.put(param, fx[category][param]);
		};
		sortedFX.put(category, sortedCategory);
	};

	// Return the new preset structure
	(
		synths: synthArray,
		samples: samplesArray,
		fx: sortedFX
	)
};

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
	var lines, plaitsIndex, sampleIndex, inScalarsSection, inSampleScalarsSection, inFXSection, result, match, currentPlaits, currentSample, currentFX, paramLines, currentValue, formattedValue, categoryLines;

	lines = content.split($\n);
	plaitsIndex = -1;
	sampleIndex = -1;
	inScalarsSection = false;
	inSampleScalarsSection = false;
	inFXSection = false;
	result = [];

	lines.do { |line|
		// Track plaits instance markers
		if (line.contains("$PLAITS")) {
			match = line.findRegexp("\\$PLAITS([0-9]+)");
			if (match.notNil && match.size > 1) {
				plaitsIndex = match[1][1].asInteger - 1;
				("Processing plaits instance: " ++ plaitsIndex).postln;
			};
		};

		// Track sample instance markers
		if (line.contains("$SAMPLE")) {
			match = line.findRegexp("\\$SAMPLE([0-9]+)");
			if (match.notNil && match.size > 1) {
				sampleIndex = match[1][1].asInteger - 1;
				("Processing sample instance: " ++ sampleIndex).postln;
			};
		};

		// Handle FX section replacement
		if (line.contains("$PRESET_FX_START")) {
			inFXSection = true;
			result = result.add(line);
			("Entering FX section").postln;

			// Generate new FX section with nested structure
			currentFX = ~plaits.fx ?? ~defaultFX.deepCopy;
			("Current FX values for save: " ++ currentFX).postln;
			paramLines = [];

			// Get all FX categories in alphabetical order
			~defaultFX.keys.asArray.sort.do { |category|
				paramLines = paramLines.add("\t" ++ category ++ ": (");
				
				// Get all parameters within category in alphabetical order
				categoryLines = [];
				currentFX[category].keys.asArray.sort.do { |param|
					currentValue = currentFX[category][param];
				if (currentValue.notNil) {
					formattedValue = if (currentValue.isNumber) {
						currentValue.round(0.01).asString;
					} {
						currentValue.asString;
					};
						categoryLines = categoryLines.add("\t\t" ++ param ++ ": " ++ formattedValue ++ ",");
					};
				};
				
				// Remove trailing comma from last parameter in category
				if (categoryLines.size > 0) {
					categoryLines[categoryLines.size - 1] = categoryLines[categoryLines.size - 1][0..categoryLines[categoryLines.size - 1].size - 2];
					paramLines = paramLines.addAll(categoryLines);
				};
				
				paramLines = paramLines.add("\t),");
			};

			// Template format: add opening paren
			result = result.add("(");
			if (paramLines.size > 0) {
				// Remove trailing comma from last parameter
				paramLines[paramLines.size - 1] = paramLines[paramLines.size - 1][0..paramLines[paramLines.size - 1].size - 2];
				result = result.addAll(paramLines);
			};
			result = result.add("),");
		};

		// Handle scalar section replacement
		if (line.contains("$PRESET_SCALARS_START")) {
			inScalarsSection = true;
			result = result.add(line);
			("Entering scalars section for synth " ++ plaitsIndex).postln;

			// Generate new scalar section with ALL parameters in alphabetical order
			if ((plaitsIndex.isInteger) && (plaitsIndex >= 0) && (plaitsIndex < ~plaits.synths.size)) {
				currentPlaits = ~plaits.synths[plaitsIndex];
				paramLines = [];

				// Get all scalar keys in alphabetical order
				~defaultScalars.keys.asArray.sort.do { |key|
					if (key != \sequences) {
						currentValue = currentPlaits[key];
						if (currentValue.notNil) {
							formattedValue = if (currentValue.isNumber) {
								currentValue.round(0.01).asString;
							} {
								if (currentValue.isKindOf(Symbol)) {
									"\\" ++ currentValue.asString;
								} {
									currentValue.asString;
								};
							};
							paramLines = paramLines.add("\t\t\t" ++ key ++ ": " ++ formattedValue ++ ",");
						};
					};
				};

				// Template format: add opening paren
				result = result.add("\t\t(");
				if (paramLines.size > 0) {
					// Remove trailing comma from last parameter
					paramLines[paramLines.size - 1] = paramLines[paramLines.size - 1][0..paramLines[paramLines.size - 1].size - 2];
					result = result.addAll(paramLines);
				};
				result = result.add("\t\t),");
			};
		};

		// Handle sample scalar section replacement
		if (line.contains("$PRESET_SAMPLE_SCALARS_START")) {
			inSampleScalarsSection = true;
			result = result.add(line);
			("Entering sample scalars section for sample " ++ sampleIndex).postln;

			// Generate new sample scalar section with ALL parameters in alphabetical order
			if ((sampleIndex.isInteger) && (sampleIndex >= 0) && (sampleIndex < ~plaits.samples.size)) {
				currentSample = ~plaits.samples[sampleIndex];
				paramLines = [];

				// Get all scalar keys in alphabetical order
				~defaultSampleScalars.keys.asArray.sort.do { |key|
					if (key != \sequences) {
						currentValue = currentSample[key];
						formattedValue = if (currentValue.isNil) {
							"nil";
						} {
							if (currentValue.isNumber) {
								currentValue.round(0.01).asString;
							} {
								if (currentValue.isKindOf(Symbol)) {
									"\\" ++ currentValue.asString;
								} {
									currentValue.asString;
								};
							};
						};
						paramLines = paramLines.add("\t\t\t" ++ key ++ ": " ++ formattedValue ++ ",");
					};
				};

				// Template format: add opening paren
				result = result.add("\t\t(");
				if (paramLines.size > 0) {
					// Remove trailing comma from last parameter
					paramLines[paramLines.size - 1] = paramLines[paramLines.size - 1][0..paramLines[paramLines.size - 1].size - 2];
					result = result.addAll(paramLines);
				};
				result = result.add("\t\t),");
			};
		};

		if (line.contains("$PRESET_FX_END")) {
			inFXSection = false;
			result = result.add(line);
			("Exiting FX section").postln;
		};

		if (line.contains("$PRESET_SCALARS_END")) {
			inScalarsSection = false;
			result = result.add(line);
			("Exiting scalars section").postln;
		};

		if (line.contains("$PRESET_SAMPLE_SCALARS_END")) {
			inSampleScalarsSection = false;
			result = result.add(line);
			("Exiting sample scalars section").postln;
		};

		if (inScalarsSection.not && inSampleScalarsSection.not && inFXSection.not &&
		   line.contains("$PRESET_SCALARS_START").not &&
		   line.contains("$PRESET_SCALARS_END").not &&
		   line.contains("$PRESET_SAMPLE_SCALARS_START").not &&
		   line.contains("$PRESET_SAMPLE_SCALARS_END").not &&
		   line.contains("$PRESET_FX_START").not &&
		   line.contains("$PRESET_FX_END").not) {
			// Outside sections, keep all lines as-is
			result = result.add(line);
		};
	};

	result.join("\n");
};

// Update UI preset selector to reflect current preset
~updatePresetUI = {
	var presetName;

	if (~currentPresetTemplate.notNil) {
		presetName = ~currentPresetTemplate.basename.splitext[0];
		~ui.().sendMsg("/loadPreset", presetName);
		("UI preset selector updated to: " ++ presetName).postln;
	};
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

	// Update UI to show new preset
	~updatePresetUI.();
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

		// Update UI to confirm current preset
		~updatePresetUI.();
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

	// Reload sequencer to rebuild pattern with new preset structure
	// This is critical because the pattern "bakes in" the samples array size at creation:
	// - If old preset had 1 sample, pattern has code accessing ~plaits.samples[0]
	// - If new preset has 0 samples, ~plaits.samples[0] is nil → crashes
	// Reloading sequencer rebuilds pattern to match new samples array length
	(~basePath +/+ "lib/sequencer.scd").load;

	Document.open(filepath);
	~currentPresetTemplate = filepath;
	("Preset loaded: " ++ filepath).postln;
	("Current preset template updated to: " ++ filepath.basename).postln;

	// Update UI to show loaded preset
	~updatePresetUI.();
};

~loadRandomPreset = {
	var presetDir = (~basePath +/+ "presets/plaits").standardizePath;
	var presetFiles = [];
	
	// Recursive function to find .scd files
	var findScdFiles = { |dir|
		var files = (dir +/+ "*").pathMatch;
		files.do { |path|
			if (File.exists(path)) {
				if (path.endsWith(".scd")) {
					presetFiles = presetFiles.add(path);
				};
				if (File.type(path) == \directory) {
					findScdFiles.(path);
				};
			};
		};
	};
	
	findScdFiles.(presetDir);

	if (presetFiles.size > 0) {
		var randomFile = presetFiles.choose;
		("Loading random preset: " ++ randomFile.basename).postln;
		~loadPreset.(randomFile);
	} {
		("No preset files found in: " ++ presetDir).postln;
	};
};


// ~savePreset.("hybrid-test");
// ~savePreset.();
)