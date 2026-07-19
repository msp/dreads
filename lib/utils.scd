////////////////////////////////////////////////////////////////////////////////
// Utility Functions
////////////////////////////////////////////////////////////////////////////////

(

// Bipolar modulation function for UI parameter mapping
//
// Gradually introduce the sequence values until they are full at uiValue = max/2.
// After max/2, gradually pull them towards max.
//
// For normalized 0-1 parameters (default max=1.0):
//   Neutral sequence = 0.5, you can pass Pseq([0.5], inf).asStream for "UI only mode"
// For time parameters (e.g., max=60.0):
//   Neutral sequence = 30.0, you can pass Pseq([30.0], inf).asStream for "UI only mode"
~modulateBipolar = { |seqValue, uiValue, max=1.0|
	var midpoint = max / 2;
	var output;

	if (uiValue <= midpoint) {
		// Gradually introduce sequence: at 0 output=0, at midpoint output=seqValue
		output = seqValue * (uiValue / midpoint);
	} {
		// Pull from seqValue towards max
		var blend = (uiValue - midpoint) / midpoint;  // 0 at midpoint, 1 at max
		output = seqValue + (blend * (max - seqValue));
	};

	// ['modulateBipolar:', seqValue, uiValue.round(0.0001), max, output.round(0.0001)].postln;

	output;
};

// TODO: Update to support non-normalized parameters when LFOs are added to samples
// Add max parameter and pass through: ~modulateLayered = { |seqValue, lfoValue, uiValue, lfoAmount=0.3, max=1.0|
~modulateLayered = { |seqValue, lfoValue, uiValue, lfoAmount=0.3|
	// First combine sequence + LFO
	var combinedMod = seqValue + ((lfoValue - 0.5) * lfoAmount);
	combinedMod = combinedMod.clip(0, 1);

	// Then apply existing bipolar logic with UI
	~modulateBipolar.(combinedMod, uiValue);
};

// Merge user sequences into ~sequenceLibrary, warn on clashes, refresh UI
~mergeUserSequences = { |userPatterns|
	// Remove previous user entries so renames/deletions are clean
	if (~userSequenceKeys.notNil) {
		~userSequenceKeys.do { |key| ~sequenceLibrary.removeAt(key) };
	};
	// Warn on clashes with built-in sequences
	userPatterns.keysValuesDo { |key, val|
		if (~sequenceLibrary[key].notNil) {
			("WARNING: user sequence '" ++ key ++ "' overrides built-in sequence").postln;
		};
	};
	~userSequenceKeys = userPatterns.keys.asArray;
	~sequenceLibrary.putAll(userPatterns);
	["Merged", userPatterns.size, "user sequences"].postln;
	~pushStateToUI.();
};

// Scalar randomisation ranges (static profiles). \colour = tonal minus engine/pitch.
~randomiseRanges = (
	tonal: (
		engine:    [0, 23, \int],
		harm:      [0.0, 1.0],
		timbre:    [0.0, 1.0],
		morph:     [0.0, 1.0],
		decay:     [0.1, 0.9],
		lpgColour: [0.0, 1.0],
		fmMod:     [-0.3, 0.3],
		pitch:     [36, 72, \int],
	),
	colour: (
		harm:      [0.0, 1.0],
		timbre:    [0.0, 1.0],
		morph:     [0.0, 1.0],
		decay:     [0.1, 0.9],
		lpgColour: [0.0, 1.0],
		fmMod:     [-0.3, 0.3],
	),
	fx: (
		revDrywet:  [0.0, 0.4],
		revTime:    [0.1, 0.6],
		delaySend:  [0.0, 0.2],
		reverbSend: [0.0, 0.3],
		cloudsSend: [0.0, 0.3],
		distDrive:  [0.0, 0.3],
		distAmount: [0.0, 0.3],
	),
);

// Params \mod (animate sound) can touch — LFO-able ∪ sequenceable sound params, excl
// fx / timing / engine. LFO-able ones can go smooth OR stepped; the rest are stepped only.
~modSoundParams = ~plaitsLFOParams ++ [\lpgColour, \fmMod];
// fx sends \modFx can animate (stepped only — no LFO sources for fx)
~modFXParams = [\cloudsSend, \delaySend, \distAmount, \distDrive, \reverbSend, \revDamp, \revDrywet, \revHp, \revTime];

// \lfo profile — the LFO's *character* only (freq/shape/base). Depth lives in \mod.
~randomiseLFO = (
	baseProb: 0.5,                 // ×base mode vs absolute Hz
	freqBase: [0.25, 4.0],         // multiplier range when base = true
	freqHz:   [0.05, 1.5],         // Hz range when base = false
	shapes:   [\sine, \sine, \sine, \tri, \tri, \saw, \square, \noise],  // weighted
);
// \mod / \modFx — animation amount + sparsity (coin-flip which params actually move)
~randomiseMod = (
	animateProb: 0.5,              // chance a given param gets animated (else left static)
	depth:       [0.1, 0.5],       // *Mod depth for the smooth (LFO) method
);
// \seq — timing
~randomiseSeq = (
	legato: [0.5, 9.0],
);

// \lfo — dice each LFO param's source character (freq/shape/base). No depth (that's \mod).
~randomiseInstanceLFO = { |idx|
	~plaitsLFOParams.do { |param|
		var base, freq, shape;
		base = ~randomiseLFO.baseProb.coin;
		freq = if (base) {
			rrand(~randomiseLFO.freqBase[0], ~randomiseLFO.freqBase[1])
		} {
			rrand(~randomiseLFO.freqHz[0], ~randomiseLFO.freqHz[1])
		};
		shape = ~randomiseLFO.shapes.choose;
		~lfoTweak.(\plaits, idx, param, (base: base, freq: freq, shape: shape));
	};
};

// \mod — animate the sound. Per param: coin-flip whether it animates at all; if so,
// smooth (LFO depth) or stepped (dice a sequence). Non-animated params are made static
// (depth 0 + sequence cleared) so each roll is a fresh, self-contained animation setup.
~randomiseInstanceMod = { |idx|
	var inst, summary;
	inst = ~dreads.synths[idx];
	summary = List.new;
	~modSoundParams.do { |param|
		var animate, lfoAble, method, depth;
		animate = ~randomiseMod.animateProb.coin;
		lfoAble = ~plaitsLFOParams.includes(param);
		method = if (animate) { if (lfoAble) { [\lfo, \seq].choose } { \seq } } { \none };
		switch(method,
			\lfo, {
				depth = rrand(~randomiseMod.depth[0], ~randomiseMod.depth[1]);
				~lfoTweak.(\plaits, idx, param, (mod: depth));
				if (inst.sequences[param].notNil) { inst.sequences[param] = \hold };
				summary.add(param.asString ++ " lfo=" ++ depth.round(0.01));
			},
			\seq, {
				~diceSeq.(idx + 1, param);   // ~diceSeq prints its own value line
				if (lfoAble) { ~lfoTweak.(\plaits, idx, param, (mod: 0.0)) };
				summary.add(param.asString ++ " seq");
			},
			{ // \none — de-animate
				if (lfoAble) { ~lfoTweak.(\plaits, idx, param, (mod: 0.0)) };
				if (inst.sequences[param].notNil) { inst.sequences[param] = \hold };
				summary.add(param.asString ++ " -");
			}
		);
	};
	("Mod plaits " ++ (idx + 1) ++ ": " ++ summary.join(", ")).postln;
};

// \modFx — animate the fx sends (stepped only; fx has no LFO sources).
~randomiseInstanceModFX = { |idx|
	var inst;
	inst = ~dreads.synths[idx];
	~modFXParams.do { |param|
		if (~randomiseMod.animateProb.coin) {
			~diceSeq.(idx + 1, param);
		} {
			if (inst.sequences[param].notNil) { inst.sequences[param] = \hold };
		};
	};
};

// \seq — timing: dice the rhythm (duration) + randomise legato (note-length overlap).
~randomiseInstanceSeq = { |idx|
	~diceSeq.(idx + 1, \duration);
	~dreads.synths[idx][\legato] = rrand(~randomiseSeq.legato[0], ~randomiseSeq.legato[1]);
};

// Randomise a plaits instance (1-based). Profiles:
//   static:  \tonal \colour (sound) · \fx (sends)
//   animate: \mod (sound) · \modFx (sends) · \lfo (LFO character)
//   timing:  \seq (duration + legato)
//   \full = tonal+fx+lfo+mod (new animated sound; no rhythm change) · \default = tonal+mod
~randomise = { |inst=1, mode=\default|
	var idx, tiers;
	idx = inst - 1;
	tiers = switch(mode,
		\tonal,  { [\tonal] },
		\colour, { [\colour] },
		\fx,     { [\fx] },
		\lfo,    { [\lfo] },
		\mod,    { [\mod] },
		\modFx,  { [\modFx] },
		\seq,    { [\seq] },
		\full,   { [\tonal, \fx, \lfo, \mod] },
		         { [\tonal, \mod] }
	);
	tiers.do { |tier|
		switch(tier,
			\lfo,   { ~randomiseInstanceLFO.(idx) },
			\mod,   { ~randomiseInstanceMod.(idx) },
			\modFx, { ~randomiseInstanceModFX.(idx) },
			\seq,   { ~randomiseInstanceSeq.(idx) },
			{ // scalar tiers: \tonal \colour \fx
				~randomiseRanges[tier].keysValuesDo { |param, range|
					var val;
					val = rrand(range[0], range[1]);
					if (range[2] == \int) { val = val.round.asInteger };
					~dreads.synths[idx][param] = val;
					// Reset active sequence so the scalar is heard — except \engine
					// (its sequence holds the "e" placeholder ~setEngine needs).
					if ((param != \engine) and: { ~dreads.synths[idx].sequences[param].notNil }) {
						~dreads.synths[idx].sequences[param] = \hold;
					};
				};
			}
		);
	};
	("Randomised plaits " ++ inst ++ " (" ++ mode ++ ")").postln;
	~pushStateToUI.();
};

// Randomise all unmuted plaits instances
~randomiseAll = { |mode=\default|
	~dreads.synths.do { |inst, idx|
		if (inst.mute != 1) {
			~randomise.(idx + 1, mode);
		};
	};
};

// Param-to-type mapping for dice randomisation
~diceParamTypes = (
	duration: \rhythm, div: \timing,
	pitch: \pitch, harm: \shape, timbre: \shape, morph: \shape,
	decay: \shape, fmMod: \shape, lpgColour: \shape,
	mul: \accent, cloudsSend: \accent, delaySend: \accent,
	reverbSend: \accent, distDrive: \accent, distAmount: \accent,
	rate: \timing, variant: \shape,
);

// Generate a random concrete sequence and assign directly to an instance
// inst: 1-based plaits number, param: symbol, len: steps (optional)
~diceSeq = { |inst=1, param=\duration, len|
	var idx, type, values, source, valStrings;
	idx = inst - 1;
	len = len ? rrand(4, 16);
	type = ~diceParamTypes[param] ? \shape;

	values = switch(type,
		\rhythm, {
			Array.fill(len, {
				var dur;
				dur = [0.25, 0.5, 0.75, 1.0].choose;
				if (0.3.coin) { Rest(dur) } { dur };
			});
		},
		\pitch, {
			Array.fill(len, { [-12, -7, -5, -3, 0, 3, 5, 7, 12].choose });
		},
		\accent, {
			Array.fill(len, { rrand(0.2, 1.0).round(0.1) });
		},
		\timing, {
			Array.fill(len, { [0.5, 2/3, 1, 3/2, 2].choose });
		},
		{ // \shape
			Array.fill(len, { rrand(0.0, 1.0).round(0.01) });
		}
	);

	// Build source string for patch serialization
	valStrings = values.collect { |v|
		if (v.isKindOf(Rest)) {
			"Rest(" ++ v.value ++ ")"
		} {
			v.asString
		};
	};
	source = "Pseq([" ++ valStrings.join(", ") ++ "], inf).asStream";

	// Store as Event with stream + source on the instance
	~dreads.synths[idx].sequences[param] = (
		stream: Pseq(values, inf).asStream,
		source: source
	);

	// Update seqModal UI to show custom indicator
	~ui.().sendMsg("/plaits/" ++ inst ++ "/" ++ param ++ "/seq", "custom");

	("Dice " ++ param ++ " on plaits " ++ inst ++ ": " ++ values).postln;
};

// Duration calculation with safety bounds
~setDuration = { |seqValue, divSeqValue|
	var output = 1;
	divSeqValue = divSeqValue.max(0.001);
	output = seqValue / divSeqValue;
	output = output.clip(0.001, 500);

	// ['~setDuration:', output.round(0.0001)].postln;

	output;
};

// Engine selection with expression evaluation
~setEngine = { |seqExpr, currentEngine=0|
	// Replace "e" placeholder with current engine value in the expression
	var engines = (0..23);
	var expr = seqExpr.asString.replace("e", currentEngine.asString);
	var output = engines.wrapAt(expr.interpret);

	// ['~setEngine:', seqExpr, expr, output].postln;

	output;
};

// Variant selection with expression evaluation (mirrors ~setEngine)
// Uses "v" as placeholder for current variant value
// e.g. Pseq(["v", "v", "v-5", "v+3"], inf)
~setVariant = { |seqExpr, currentVariant=0, numVariants=1|
	var expr = seqExpr.asString.replace("v", currentVariant.asString);
	var output = expr.interpret.asInteger.wrap(0, numVariants - 1);
	output;
};

// Generic multiply: sequence value multiplies base value
~multiply = { |seqValue, baseValue|
	baseValue * seqValue;
};

// Generic add: sequence value adds to base value
~add = { |seqValue, baseValue|
	baseValue + seqValue;
};

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

// Resolve sequence value with lazy loading and caching
// If value is a Symbol, look it up in ~sequenceLibrary and cache the stream
// If value is already a stream, use it directly
~getSequenceValue = { |instance, instanceIdx, instanceType, paramKey|
	var value = instance.sequences[paramKey];
	var cacheKey, cached, stream, pattern;

	if(value.isKindOf(Symbol)) {
		// Build cache key: "plaits_0_duration" or "samples_1_rate"
		cacheKey = (instanceType.asString ++ "_" ++ instanceIdx.asString ++ "_" ++ paramKey.asString).asSymbol;
		cached = ~sequenceStreamCache[cacheKey];

		// Check if we have a cached stream and the symbol hasn't changed
		// Use .and {} for short-circuit evaluation (&& doesn't short-circuit in SC!)
		if(cached.notNil.and { cached.symbol == value }) {
			stream = cached.stream;
		} {
			// Symbol changed or first time - resolve from library
			pattern = ~sequenceLibrary[value];
			if(pattern.notNil) {
				stream = pattern.pattern.asStream;
				~sequenceStreamCache[cacheKey] = (symbol: value, stream: stream);
			} {
				("WARNING: Sequence '" ++ value ++ "' not found in library").warn;
				^0.5;  // Return neutral value
			};
		};
		stream.next;
	} {
		// Inline sequence with source (from dice/randomisation)
		if (value.isKindOf(Dictionary) and: { value[\stream].notNil }) {
			value[\stream].next;
		} {
			// Direct stream - just call .next
			value.next;
		};
	};
};

// Fade out by reducing reverb time to kill MiVerb internal feedback
~fadeOutReverb = { |fadeTime = 2|
	// plaits insert reverbs
	~voiceGroup.set(\revTime, 0.9);
	// global reverb
	~fx.reverb.set(\time, 0.9);
	("Stopping reverb feedback..").postln;
};

~activatePhones = { | value = false|
	[("~activatePhones"), value].postln;
	~sendToPhones = value;
};

~sinePattern = { |dur=8.0, lo=0.05, hi=0.5, repeats=inf|
	Pn(
		Pif(Ptime(inf) <= dur, Env.sine(dur).range(lo, hi)),
		repeats
	)
};

// Smooth 0..1 sine mapped to [lo, hi], driven by beats
~sineAtBeat = { |beats, cycleBeats = 16.0, lo = 0.05, hi = 0.5|
	var phase = (beats.asFloat / cycleBeats).frac;      // 0..1
	var u     = (phase * 2pi).cos.neg * 0.5 + 0.5;      // 0.5 - 0.5*cos(...), in 0..1
	lo + u * (hi - lo)
};

~sineAtBeatWithPhase = { |beats, cycleBeats = 16.0, lo = 0.05, hi = 0.5, phaseOffset = 0|
	var phase = ((beats.asFloat / cycleBeats) + phaseOffset).frac;
	var u = (phase * 2pi).cos.neg * 0.5 + 0.5;
	u.linlin(0, 1, lo, hi);
};

~filterWithRests = { |pattern, every=4|
	var counter = 0;
	Pif(
		Pfunc({ (counter = counter + 1) % every == 1 }),
		pattern,
		Rest()
	)
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
					buf = Buffer.read(s, file.fullPath, action: { |buffer|
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
		("WARNING: Sample library folder not found: " ++ basePath).warn;
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
		("WARNING: Sample bank not found: " ++ bankName).warn;
		^nil;
	};

	// Use wrapAt for safe indexing (SuperDirt style)
	bank.wrapAt(variant);
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
		("WARNING: Sample not found in library: " ++ filepath).warn;
	};

	result;
};

// Orchestrator: apply LFO state then push UI — replaces ~pushStateToUI.() in patch footers
// Note: during initial SETUP boot, ~applyLFOState is nil (defined later in lfo.scd during RUN).
// nil.() is a silent no-op in SC — lfo.scd calls ~applyLFOState.() itself after creating sources.
~applyPatch = {
	~applyLFOState.();
	~pushStateToUI.();
};

// Start a persistent drone synth for a plaits instance
~startDrone = { |i|
	var instance = ~dreads.synths[i];
	var out;

	// Stop existing drone if any
	if (~drones.notNil && ~drones[i].notNil) {
		~drones[i].release;
		~drones[i] = nil;
	};

	out = ~voiceOutBus.(\plaits, i);

	~drones[i] = Synth(\plaitsDrone, [
		\out, out,
		\pitch, instance.pitch,
		\engine, instance.engine,
		\harm, instance.harm,
		\timbre, instance.timbre,
		\morph, instance.morph,
		\decay, instance.decay,
		\fmMod, instance.fmMod,
		\lpgColour, instance.lpgColour,
		\mul, if (instance.mute == 1) { 0 } { instance.mul },
		\revDrywet, instance.revDrywet,
		\revTime, instance.revTime,
		\revDamp, instance.revDamp,
		\revHp, instance.revHp,
		\revFreeze, instance.revFreeze,
		\volume, instance.volume,
		\cloudsSend, instance.cloudsSend,
		\delaySend, instance.delaySend,
		\reverbSend, instance.reverbSend,
		\distDrive, instance.distDrive,
		\distAmount, instance.distAmount,
		\stereoMode, instance.stereoMode,
		\timbMod, instance.timbMod,
		\morphMod, instance.morphMod,
		\decayMod, instance.decayMod,
		\pitchMod, instance.pitchMod,
		\volumeMod, instance.volumeMod,
		\harmMod, instance.harmMod,
	], ~voiceGroup, \addToHead);

	// Map LFO buses to drone control args — instance.lfo is already hydrated
	~plaitsLFOParams.do { |param|
		~drones[i].map((param ++ "LFO").asSymbol, instance.lfo[param].bus);
	};

	["Drone started for plaits", i].postln;
};

// Stop a persistent drone synth for a plaits instance
~stopDrone = { |i|
	if (~drones.notNil && ~drones[i].notNil) {
		~drones[i].release;
		~drones[i] = nil;
		["Drone stopped for plaits", i].postln;
	};
};

// Custom event type for one-shot sample playback
// Never sends gate=0, synth is expected to free itself via doneAction
Event.addEventType(\oneShotSample, {
	var server = ~server ?? { Server.default };

	// ["oneShotSample event at", thisThread.beats, "dur =", ~dur].postln;

	// Build the synth - based on standard 'note' event type
	// but without storing the node for later gate-off
	if (~bufnum.notNil) {
		server.makeBundle(server.latency, {
			Synth(
				~instrument,
				[
					\out, ~out,
					\bufnum, ~bufnum,
					\numChannels, ~numChannels,
					\mul, ~mul,
					\rate, ~rate,
					\startPos, ~startPos,
					\panDur, ~panDur,
					\atk, ~atk,
					\decay, ~decay,
					\gate, 1,
					\volume, ~volume,
					\cloudsSend, ~cloudsSend,
					\delaySend, ~delaySend,
					\reverbSend, ~reverbSend,
					\distDrive, ~distDrive,
					\distAmount, ~distAmount,
					\revDrywet, ~revDrywet,
					\revTime, ~revTime,
					\revDamp, ~revDamp,
					\revHp, ~revHp,
					\revFreeze, ~revFreeze,
					\rateLFO, ~rateLFO,
					\rateMod, ~rateMod,
					\volumeLFO, ~volumeLFO,
					\volumeMod, ~volumeMod
				],
				~group ?? { server.defaultGroup },
				\addToHead
			);
		});
	};

	// Return the delta time for the pattern to wait
	// ["oneShotSample returning delta:", ~dur].postln;
	~dur;
});

// Load sub-modules
(Document.current.dir ++ "/lib/fm.scd").load;
// (Document.current.dir ++ "/tempo.scd").load;
(Document.current.dir ++ "/lib/tempo.scd").load;

)