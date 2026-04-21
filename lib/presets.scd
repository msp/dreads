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

// Sequence Section Parser Functions
// Parser: Extract parameter name and remaining content from line
~parseSequenceParamLine = { |line|
	var match = line.findRegexp("^(\\s*)(\\w+):\\s*(.*)$");
	if (match.size > 0) {
		(
			indent: match[1][1],
			paramName: match[2][1].asSymbol,
			rest: match[3][1]
		)
	} { nil };
};

// Parser: Check if line is a simple symbol assignment
~isSymbolLine = { |line|
	var trimmed = line.stripWhiteSpace;
	var colonIdx, afterColon, firstChar;

	// Find the colon
	colonIdx = trimmed.find(":");
	if (colonIdx.isNil) { ^false };

	// Get the part after the colon
	afterColon = trimmed[(colonIdx + 1)..].stripWhiteSpace;

	// Check if it starts with backslash (symbol)
	if (afterColon.size == 0) { ^false };
	firstChar = afterColon[0];

	// Symbol line starts with \ and doesn't contain opening brackets/parens
	(firstChar == $\\) && (afterColon.contains("(").not) && (afterColon.contains("[").not)
};

// Parser: Find end of multi-line pattern using depth tracking
~findPatternEnd = { |lines, startIdx|
	var depth = 0;
	var inString = false;
	var inComment = false;
	var endIdx = startIdx;
	var found = false;

	(lines.size - startIdx).do { |offset|
		var lineIdx = startIdx + offset;
		var line, i;

		if (found.not && (lineIdx < lines.size)) {
			line = lines[lineIdx];
			i = 0;
			inComment = false;  // Reset per line

			// Character-by-character state machine
			line.size.do { |charIdx|
				var char = line[charIdx];
				var nextChar = if ((charIdx+1) < line.size) { line[charIdx+1] } { nil };

				// Detect comment start
				if (char == $/ && (nextChar == $/)) {
					inComment = true;
				};

				if (inComment.not) {
					// Track string literals
					if (char == $") {
						inString = inString.not;
					};

					if (inString.not) {
						// Track bracket/paren depth
						if ((char == $() || (char == $[)) { depth = depth + 1 };
						if ((char == $)) || (char == $])) { depth = depth - 1 };
					};
				};
			};

			// Check if we found .asStream at depth 0
			if ((depth == 0) && line.contains(".asStream")) {
				endIdx = lineIdx;
				found = true;
			};
		};
	};

	endIdx;
};

// Parser: Build map of all parameters in sequence section
~parseSequenceSection = { |lines|
	var blocks = Dictionary.new;
	var i = 0;

	("Parsing sequence section (" ++ lines.size ++ " lines)...").postln;

	// Use a manual loop with early exit capability
	block { |break|
		loop {
			var line, parsed;

			if (i >= lines.size) { break.value };

			line = lines[i];
			parsed = ~parseSequenceParamLine.(line);

			if (parsed.notNil) {
				var paramName = parsed.paramName;
				var startLine = i;
				var endLine = i;
				var isSymbol = ~isSymbolLine.(line);

				if (isSymbol.not) {
					// Multi-line pattern - find end using depth tracking
					endLine = ~findPatternEnd.(lines, i);
					("  Parsed " ++ paramName ++ ": pattern (lines " ++ startLine ++ "-" ++ endLine ++ ")").postln;
				} {
					("  Parsed " ++ paramName ++ ": symbol (line " ++ startLine ++ ")").postln;
				};

				blocks[paramName] = (
					startLine: startLine,
					endLine: endLine,
					isSymbol: isSymbol,
					indent: parsed.indent
				);

				i = endLine + 1;
			} {
				// Not a param line (closing paren, blank line, etc)
				i = i + 1;
			};
		};
	};

	("Parsed " ++ blocks.size ++ " parameters").postln;
	blocks;
};

// Helper: Comment out a block of lines
~commentLines = { |lines, indent|
	lines.collect { |line|
		if (line.stripWhiteSpace.size > 0) {
			indent ++ "// " ++ line.stripWhiteSpace;
		} {
			line;  // Preserve blank lines as-is
		};
	};
};

// Process sequence section: parse and update symbols while preserving patterns
~processSequenceSection = { |lines, instanceType, instanceIdx|
	var blocks, output, runtimeInstance, runtimeSequences, processedParams, newParamIndent;
	var openParenLine, closeParenLine, contentLines, processedLineIndices;

	// Get runtime sequences dictionary
	runtimeInstance = if(instanceType == \plaits) {
		~plaits.synths[instanceIdx]
	} { ~plaits.samples[instanceIdx] };

	if (runtimeInstance.isNil) {
		("WARNING: Instance " ++ instanceType ++ "[" ++ instanceIdx ++ "] not found in runtime").warn;
		^lines;  // Return lines unchanged
	};

	runtimeSequences = runtimeInstance.sequences;

	// Find opening and closing parens
	openParenLine = lines.detect({ |line| line.stripWhiteSpace == "(" });
	closeParenLine = lines.detect({ |line| line.stripWhiteSpace == ")" });

	// Extract content lines (between parens)
	contentLines = lines.select({ |line|
		(line.stripWhiteSpace != "(") && (line.stripWhiteSpace != ")")
	});

	// Parse the content
	blocks = ~parseSequenceSection.(contentLines);
	output = [];
	processedParams = Set.new;
	processedLineIndices = Set.new;  // Track which lines we've processed

	// Process lines in order, preserving structure
	contentLines.do { |line, idx|
		var blockInfo, paramName, runtimeValue, blockLines, commentedLines;
		var foundParam;

		// Check if this line starts a parameter block
		foundParam = nil;
		blocks.keysValuesDo { |key, info|
			if (info.startLine == idx) {
				foundParam = (key: key, info: info);
			};
		};

		if (foundParam.notNil) {
			// This line starts a parameter block
			paramName = foundParam.key;
			blockInfo = foundParam.info;
			runtimeValue = runtimeSequences[paramName];

			processedParams.add(paramName);

			// Mark these line indices as processed
			(blockInfo.startLine..blockInfo.endLine).do { |i| processedLineIndices.add(i) };

			// Extract original block lines
			blockLines = contentLines[blockInfo.startLine..blockInfo.endLine];

			// Decision logic based on template type and runtime type
			if (runtimeValue.isKindOf(Symbol)) {
				// Runtime is symbol — write it
				("  Writing symbol: " ++ paramName ++ " → \\" ++ runtimeValue).postln;
				output = output.add(blockInfo.indent ++ paramName ++ ": \\" ++ runtimeValue ++ ",");
				if (blockInfo.isSymbol.not) {
					// Comment out old pattern from template
					output = output.add("");
					commentedLines = ~commentLines.(blockLines, blockInfo.indent);
					output = output.addAll(commentedLines);
				};
			} {
				if (runtimeValue.isKindOf(Dictionary) and: { runtimeValue[\source].notNil }) {
					// Runtime is inline sequence with source — serialize it
					("  Writing inline sequence: " ++ paramName).postln;
					output = output.add(blockInfo.indent ++ paramName ++ ": " ++ runtimeValue[\source] ++ ",");
					if (blockInfo.isSymbol.not) {
						output = output.add("");
						commentedLines = ~commentLines.(blockLines, blockInfo.indent);
						output = output.addAll(commentedLines);
					};
				} {
					// Runtime is plain stream — preserve template code
					("  Preserving template: " ++ paramName).postln;
					output = output.addAll(blockLines);
				};
			};
		} {
			// Not a parameter block start - check if it's an unprocessed line
			if (processedLineIndices.includes(idx).not) {
				// Standalone comment, blank line, etc - preserve it
				output = output.add(line);
			};
		};
	};

	// Before adding new symbols, ensure last line has trailing comma
	if (output.size > 0) {
		var lastIdx, lastLine;
		// Find last non-blank line
		lastIdx = output.size - 1;
		while { (lastIdx >= 0) && (output[lastIdx].stripWhiteSpace.size == 0) } {
			lastIdx = lastIdx - 1;
		};

		if (lastIdx >= 0) {
			lastLine = output[lastIdx];
			// Add comma if line doesn't already end with one
			if (lastLine.stripWhiteSpace.endsWith(",").not) {
				output[lastIdx] = lastLine ++ ",";
				("  Added trailing comma to: " ++ lastLine.stripWhiteSpace).postln;
			};
		};
	};

	// Add any new params from runtime that aren't in template (skip \hold defaults)
	// Derive indent from existing parsed blocks, fallback to 3 tabs
	newParamIndent = if (blocks.size > 0) {
		blocks.values.first.indent;
	} { "\t\t\t" };
	runtimeSequences.keysValuesDo { |paramName, value|
		if (processedParams.includes(paramName).not) {
			if (value.isKindOf(Symbol) && (value != \hold)) {
				("  Adding new symbol: " ++ paramName ++ " → \\" ++ value).postln;
				output = output.add(newParamIndent ++ paramName ++ ": \\" ++ value ++ ",");
			};
			if (value.isKindOf(Dictionary) and: { value[\source].notNil }) {
				("  Adding new inline sequence: " ++ paramName).postln;
				output = output.add(newParamIndent ++ paramName ++ ": " ++ value[\source] ++ ",");
			};
		};
	};

	// Wrap output with opening/closing parens
	if (openParenLine.notNil) {
		output = [openParenLine] ++ output;
	};
	if (closeParenLine.notNil) {
		output = output ++ [closeParenLine];
	};

	output;
};

~replaceScalarValues = { |content|
	var lines, plaitsIndex, sampleIndex, inScalarsSection, inSampleScalarsSection, inSequencesSection, inSampleSequencesSection, inFXSection, result, match, currentPlaits, currentSample, currentFX, paramLines, currentValue, formattedValue, categoryLines;
	var sequenceSectionLines, sampleSequenceSectionLines;  // For accumulating lines in sequence sections

	lines = content.split($\n);
	plaitsIndex = -1;
	sampleIndex = -1;
	inScalarsSection = false;
	inSampleScalarsSection = false;
	inSequencesSection = false;
	inSampleSequencesSection = false;
	inFXSection = false;
	result = [];
	sequenceSectionLines = [];
	sampleSequenceSectionLines = [];

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

			// Generate compact scalar section
			if ((plaitsIndex.isInteger) && (plaitsIndex >= 0) && (plaitsIndex < ~plaits.synths.size)) {
				currentPlaits = ~plaits.synths[plaitsIndex];
				paramLines = [];

				~defaultScalars.keys.asArray.sort.do { |key|
					if (key != \sequences) {
						currentValue = currentPlaits[key];
						if (currentValue.notNil) {
							formattedValue = if (currentValue.isNumber) {
								currentValue.round(0.01).asString;
							} {
								if (currentValue.isKindOf(Symbol)) {
									"'" ++ currentValue.asString ++ "'";
								} {
									currentValue.asString;
								};
							};
							paramLines = paramLines.add(key ++ ": " ++ formattedValue);
						};
					};
				};

				result = result.add("\t\t\t(" ++ paramLines.join(", ") ++ "),");
			};
		};

		// Handle sample scalar section replacement
		if (line.contains("$PRESET_SAMPLE_SCALARS_START")) {
			inSampleScalarsSection = true;
			result = result.add(line);
			("Entering sample scalars section for sample " ++ sampleIndex).postln;

			// Generate compact sample scalar section
			if ((sampleIndex.isInteger) && (sampleIndex >= 0) && (sampleIndex < ~plaits.samples.size)) {
				currentSample = ~plaits.samples[sampleIndex];
				paramLines = [];

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
									"'" ++ currentValue.asString ++ "'";
								} {
									currentValue.asString;
								};
							};
						};
						paramLines = paramLines.add(key ++ ": " ++ formattedValue);
					};
				};

				result = result.add("\t\t\t(" ++ paramLines.join(", ") ++ "),");
			};
		};

		// Handle sequence sections - parse and update symbols while preserving patterns
		if (line.contains("$PRESET_SEQUENCES_START")) {
			inSequencesSection = true;
			sequenceSectionLines = [];  // Start accumulating lines
			result = result.add(line);
			("Entering sequences section for synth " ++ plaitsIndex ++ " - will parse and process").postln;
		};

		if (line.contains("$PRESET_SAMPLE_SEQUENCES_START")) {
			inSampleSequencesSection = true;
			sampleSequenceSectionLines = [];  // Start accumulating lines
			result = result.add(line);
			("Entering sample sequences section for sample " ++ sampleIndex ++ " - will parse and process").postln;
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

		if (line.contains("$PRESET_SEQUENCES_END")) {
			// Process accumulated sequence section lines
			if (sequenceSectionLines.size > 0) {
				var processedLines = ~processSequenceSection.(sequenceSectionLines, \plaits, plaitsIndex);
				result = result.addAll(processedLines);
			};
			inSequencesSection = false;
			result = result.add(line);
			("Exiting sequences section").postln;
		};

		if (line.contains("$PRESET_SAMPLE_SEQUENCES_END")) {
			// Process accumulated sample sequence section lines
			if (sampleSequenceSectionLines.size > 0) {
				var processedLines = ~processSequenceSection.(sampleSequenceSectionLines, \samples, sampleIndex);
				result = result.addAll(processedLines);
			};
			inSampleSequencesSection = false;
			result = result.add(line);
			("Exiting sample sequences section").postln;
		};

		// Accumulate sequence section lines (excluding markers)
		if (inSequencesSection) {
			if (line.contains("$PRESET_SEQUENCES_START").not &&
			   line.contains("$PRESET_SEQUENCES_END").not) {
				sequenceSectionLines = sequenceSectionLines.add(line);
			};
		};

		if (inSampleSequencesSection) {
			if (line.contains("$PRESET_SAMPLE_SEQUENCES_START").not &&
			   line.contains("$PRESET_SAMPLE_SEQUENCES_END").not) {
				sampleSequenceSectionLines = sampleSequenceSectionLines.add(line);
			};
		};

		// Pass through lines outside all sections
		if (inScalarsSection.not && inSampleScalarsSection.not && inSequencesSection.not && inSampleSequencesSection.not && inFXSection.not &&
		   line.contains("$PRESET_SCALARS_START").not &&
		   line.contains("$PRESET_SCALARS_END").not &&
		   line.contains("$PRESET_SAMPLE_SCALARS_START").not &&
		   line.contains("$PRESET_SAMPLE_SCALARS_END").not &&
		   line.contains("$PRESET_SEQUENCES_START").not &&
		   line.contains("$PRESET_SEQUENCES_END").not &&
		   line.contains("$PRESET_SAMPLE_SEQUENCES_START").not &&
		   line.contains("$PRESET_SAMPLE_SEQUENCES_END").not &&
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

	presetDir = if (~currentPresetTemplate.notNil) {
		~currentPresetTemplate.dirname
	} {
		~basePath +/+ "presets/plaits"
	};

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
	var filepath, wasPlaying;

	// Check if it's already a full path
	if (nameOrPath.contains("/")) {
		filepath = nameOrPath.standardizePath;
	} {
		// It's just a name, build the path
		filepath = ~basePath +/+ "presets/plaits" +/+ (nameOrPath ++ ".scd");
	};

	// Stop playback before reloading to ensure sequence streams start at position 0.
	// Without this, the old pattern can advance newly-created streams between the
	// cache clear (in sequencer.scd) and the Pdef hot-swap, causing patterns like
	// \offbeat [Rest(1/2), 1/2] to randomly start on the hit instead of the rest.
	// Known limitation: switching sequences live (e.g. four_floor → offbeat via UI)
	// can still start mid-stream since that doesn't reload the sequencer.
	wasPlaying = Pdef(\plaitsSequence).isPlaying;
	Pdef(\plaitsSequence).stop;

	this.executeFile(filepath);

	// Reload sequencer to rebuild pattern with new preset structure
	// This is critical because the pattern "bakes in" the samples array size at creation:
	// - If old preset had 1 sample, pattern has code accessing ~plaits.samples[0]
	// - If new preset has 0 samples, ~plaits.samples[0] is nil → crashes
	// Reloading sequencer rebuilds pattern to match new samples array length
	(~basePath +/+ "lib/sequencer.scd").load;

	// Start/stop drones based on loaded preset's droneMode values
	// Only start if playback is active — drones will be created on play otherwise
	~plaits.synths.do { |instance, i|
		if (wasPlaying) {
			if (instance.droneMode == 1) {
				~startDrone.(i);
			} {
				~stopDrone.(i);
			};
		} {
			~stopDrone.(i);
		};
	};

	// Apply loaded FX values to the running FX synths
	~plaits.fx.delay.keysValuesDo { |param, value| ~delayFX.set(param, value) };
	~plaits.fx.reverb.keysValuesDo { |param, value| ~reverbFX.set(param, value) };
	~plaits.fx.clouds.keysValuesDo { |param, value| ~cloudsFX.set(param, value) };

	// Resume playback if it was running — causes a brief timing gap
	if (wasPlaying) { Pdef(\plaitsSequence).play(~tempoClock) };

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

~loadAdjacentPreset = { |direction|
	var currentPath, dir, files, currentIdx;

	if (~currentPresetTemplate.isNil) {
		"No preset currently loaded".postln;
	} {
		currentPath = ~currentPresetTemplate.standardizePath;
		dir = currentPath.dirname;
		files = (dir +/+ "*.scd").pathMatch.sort;

		if (files.size == 0) {
			("No preset files found in: " ++ dir).postln;
		} {
			currentIdx = files.detectIndex({ |f| f == currentPath });
			if (currentIdx.isNil) {
				("Current preset not found in directory listing").postln;
			} {
				currentIdx = (currentIdx + direction).wrap(0, files.size - 1);
				("Loading " ++ if(direction > 0, "next", "previous") ++ " preset: " ++ files[currentIdx].basename).postln;
				~loadPreset.(files[currentIdx]);
			};
		};
	};
};

// Select a predefined sequence from the library for a specific parameter
~selectSequence = { |instanceType, instanceIdx, paramKey, seqName|
	var instance, ui, path;

	instance = if(instanceType == \plaits) {
		~plaits.synths[instanceIdx]
	} { ~plaits.samples[instanceIdx] };

	if(~sequenceLibrary[seqName].notNil) {
		instance.sequences[paramKey] = seqName;

		ui = ~ui.();
		path = "/" ++ instanceType ++ "/" ++ (instanceIdx + 1) ++ "/" ++ paramKey ++ "/seq";
		ui.sendMsg(path, seqName.asString);

		("Selected " ++ instanceType ++ "[" ++ instanceIdx ++ "]." ++ paramKey ++ " → " ++ seqName).postln;
	} {
		("Sequence '" ++ seqName ++ "' not found in library").warn;
	};
};


// ~savePreset.("hybrid-test");
// ~savePreset.();
)