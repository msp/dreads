////////////////////////////////////////////////////////////////////////////////
// Randomisation & Dice
//
// Instance/global randomisers, dice, and their private range/profile tables.
// Split out of utils.scd. Loaded from the tail of utils.scd.
////////////////////////////////////////////////////////////////////////////////

(

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

// --- Sample randomisation config (mirrors plaits with sample params) ---
// Curated musical bands. \tonal also picks a fresh sample from the whole library
// (see ~randomiseSampleSelection); \colour keeps the sample + rate, reshapes the rest.
~randomiseSampleRanges = (
	tonal: (
		rate:     [0.25, 4.0],
		atk:      [0.001, 0.3],
		decay:    [0.1, 0.9],
		startPos: [0.0, 0.6],
		panDur:   [0.1, 1.0],
	),
	colour: (
		atk:      [0.001, 0.3],
		decay:    [0.1, 0.9],
		startPos: [0.0, 0.6],
		panDur:   [0.1, 1.0],
	),
	fx: ~randomiseRanges.fx,   // samples share the same fx sends
);
// \mod sound params for samples: rate/volume LFO-able, atk/decay/startPos/panDur seq-able
~modSampleParams = [\rate, \volume, \atk, \decay, \startPos, \panDur];

// Per-type dispatch: instance collection, ranges, LFO/mod param sets, seq defaults (for
// seq-able checks), the ~lfoTweak type symbol, and the OSC/log name.
~randomiseTypes = (
	plaits:  (coll: \synths,  ranges: ~randomiseRanges,       lfoParams: ~plaitsLFOParams, modParams: ~modSoundParams,  seqs: ~defaultSequences,       lfoType: \plaits, name: "plaits"),
	samples: (coll: \samples, ranges: ~randomiseSampleRanges, lfoParams: ~sampleLFOParams, modParams: ~modSampleParams, seqs: ~defaultSampleSequences, lfoType: \sample, name: "samples"),
);

// Pick a random sample (any bank, any variant) from the whole library for sample
// instance idx (0-based) + update the UI path. Reuses ~cycleSampleVariant's UI pattern.
~randomiseSampleSelection = { |idx|
	var inst, banks, bank, buffers, variant, paths;
	inst = ~dreads.samples[idx];
	banks = ~sampleLibrary.banks.keys.asArray;
	if (banks.isEmpty) {
		"WARNING: sample library empty — skipping sample selection".postln;
	} {
		bank = banks.choose;
		buffers = ~sampleLibrary.banks[bank];
		variant = rrand(0, buffers.size - 1);
		inst.bankName = bank;
		inst.variant = variant;
		paths = ~sampleLibrary.paths[bank];
		if (paths.notNil and: { paths[variant].notNil }) {
			~ui.().sendMsg("/samples/" ++ (idx + 1) ++ "/samplePath", paths[variant]);
		};
		("Sample select samples " ++ (idx + 1) ++ ": " ++ bank ++ " variant " ++ variant).postln;
	};
};

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
// Duration-aware ceilings for sample scalar randomisation (see the branch in
// ~randomise). Both use the picked variant's stored buffer duration:
//   startPos — leave at least minRemain seconds of audio after the offset, so
//     percussive one-shots start at the top and long sounds keep the full range.
//   panDur — cap the L→R sweep time at duration * panFactor, so the pan actually
//     traverses within a short sound instead of appearing hard-panned.
~randomiseSample = (
	minRemain: 0.4,                // seconds of audio to leave after startPos
	panFactor: 0.5,                // panDur ceiling = duration * this (capped at the range)
	                               // <1 keeps the sweep to a fraction of the sound so it
	                               // clears hard-left and crosses centre while still loud
);

// \lfo — dice each LFO param's source character (freq/shape/base). No depth (that's \mod).
~randomiseInstanceLFO = { |idx, type=\plaits|
	var cfg;
	cfg = ~randomiseTypes[type];
	cfg.lfoParams.do { |param|
		var base, freq, shape;
		base = ~randomiseLFO.baseProb.coin;
		freq = if (base) {
			rrand(~randomiseLFO.freqBase[0], ~randomiseLFO.freqBase[1])
		} {
			rrand(~randomiseLFO.freqHz[0], ~randomiseLFO.freqHz[1])
		};
		shape = ~randomiseLFO.shapes.choose;
		~lfoTweak.(cfg.lfoType, idx, param, (base: base, freq: freq, shape: shape));
	};
};

// \mod — animate the sound. Per param: coin-flip whether it animates at all; if so,
// smooth (LFO depth) or stepped (dice a sequence). Non-animated params are made static
// (depth 0 + sequence cleared) so each roll is a fresh, self-contained animation setup.
~randomiseInstanceMod = { |idx, type=\plaits|
	var cfg, inst, summary;
	cfg = ~randomiseTypes[type];
	inst = ~dreads[cfg.coll][idx];
	summary = List.new;
	cfg.modParams.do { |param|
		var animate, lfoAble, seqAble, method, depth;
		animate = ~randomiseMod.animateProb.coin;
		lfoAble = cfg.lfoParams.includes(param);
		seqAble = cfg.seqs[param].notNil;
		method = if (animate) {
			if (lfoAble and: { seqAble }) { [\lfo, \seq].choose } {
				if (lfoAble) { \lfo } { if (seqAble) { \seq } { \none } }
			}
		} { \none };
		switch(method,
			\lfo, {
				depth = rrand(~randomiseMod.depth[0], ~randomiseMod.depth[1]);
				~lfoTweak.(cfg.lfoType, idx, param, (mod: depth));
				if (inst.sequences[param].notNil) { inst.sequences[param] = \hold };
				summary.add(param.asString ++ " lfo=" ++ depth.round(0.01));
			},
			\seq, {
				~diceSeq.(idx + 1, param, nil, type);   // ~diceSeq prints its own value line
				if (lfoAble) { ~lfoTweak.(cfg.lfoType, idx, param, (mod: 0.0)) };
				summary.add(param.asString ++ " seq");
			},
			{ // \none — de-animate
				if (lfoAble) { ~lfoTweak.(cfg.lfoType, idx, param, (mod: 0.0)) };
				if (inst.sequences[param].notNil) { inst.sequences[param] = \hold };
				summary.add(param.asString ++ " -");
			}
		);
	};
	("Mod " ++ cfg.name ++ " " ++ (idx + 1) ++ ": " ++ summary.join(", ")).postln;
};

// \modFx — animate the fx sends (stepped only; fx has no LFO sources).
~randomiseInstanceModFX = { |idx, type=\plaits|
	var cfg, inst;
	cfg = ~randomiseTypes[type];
	inst = ~dreads[cfg.coll][idx];
	~modFXParams.do { |param|
		if (~randomiseMod.animateProb.coin) {
			~diceSeq.(idx + 1, param, nil, type);
		} {
			if (inst.sequences[param].notNil) { inst.sequences[param] = \hold };
		};
	};
};

// \seq — timing: dice the rhythm (duration) + randomise legato (note-length overlap).
~randomiseInstanceSeq = { |idx, type=\plaits|
	var cfg;
	cfg = ~randomiseTypes[type];
	~diceSeq.(idx + 1, \duration, nil, type);
	~dreads[cfg.coll][idx][\legato] = rrand(~randomiseSeq.legato[0], ~randomiseSeq.legato[1]);
};

// Randomise a plaits instance (1-based). Profiles:
//   static:  \tonal \colour (sound) · \fx (sends)
//   animate: \mod (sound) · \modFx (sends) · \lfo (LFO character)
//   timing:  \seq (duration + legato)
//   \full = tonal+fx+lfo+mod (new animated sound; no rhythm change) · \default = tonal+mod
~randomise = { |inst=1, mode=\default, type=\plaits|
	var idx, tiers, cfg, coll;
	idx = inst - 1;
	cfg = ~randomiseTypes[type];
	coll = ~dreads[cfg.coll];
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
			\lfo,   { ~randomiseInstanceLFO.(idx, type) },
			\mod,   { ~randomiseInstanceMod.(idx, type) },
			\modFx, { ~randomiseInstanceModFX.(idx, type) },
			\seq,   { ~randomiseInstanceSeq.(idx, type) },
			{ // scalar tiers: \tonal \colour \fx
				// samples: \tonal also picks a fresh sample from the whole library
				if ((type == \samples) and: { tier == \tonal }) { ~randomiseSampleSelection.(idx) };
				cfg.ranges[tier].keysValuesDo { |param, range|
					var val, bank, variant, metaList, dur, lo, hi;
					// Duration-aware ceilings for samples: startPos leaves at least
					// minRemain seconds of audio, panDur caps the sweep to the sound's
					// length. Both read the picked variant's stored buffer duration.
					dur = nil;
					lo = range[0];
					hi = range[1];
					if ((type == \samples) and: { [\startPos, \panDur].includes(param) }) {
						bank = coll[idx].bankName;
						variant = coll[idx].variant;
						metaList = ~sampleLibrary.metadata[bank];
						if (metaList.notNil and: { variant.notNil } and: { variant < metaList.size }) {
							dur = metaList[variant].duration;
						};
					};
					if (dur.notNil) {
						switch(param,
							\startPos, {
								hi = ((dur - ~randomiseSample.minRemain) / dur).clip(0.0, range[1]);
							},
							\panDur, {
								hi = (dur * ~randomiseSample.panFactor).min(range[1]);
								lo = range[0].min(hi);
							}
						);
					};
					val = rrand(lo, hi);
					if (range[2] == \int) { val = val.round.asInteger };
					coll[idx][param] = val;
					// Reset active sequence so the scalar is heard — except \engine
					// (its sequence holds the "e" placeholder ~setEngine needs).
					if ((param != \engine) and: { coll[idx].sequences[param].notNil }) {
						coll[idx].sequences[param] = \hold;
					};
				};
			}
		);
	};
	("Randomised " ++ cfg.name ++ " " ++ inst ++ " (" ++ mode ++ ")").postln;
	~pushStateToUI.();
};

// Randomise all unmuted instances of a type (\plaits or \samples)
~randomiseAll = { |mode=\default, type=\plaits|
	~dreads[~randomiseTypes[type].coll].do { |inst, idx|
		if (inst.mute != 1) {
			~randomise.(idx + 1, mode, type);
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
~diceSeq = { |inst=1, param=\duration, len, dest=\plaits|
	var idx, type, values, source, valStrings, coll, destName;
	idx = inst - 1;
	coll = if (dest == \plaits) { ~dreads.synths } { ~dreads.samples };
	destName = if (dest == \plaits) { "plaits" } { "samples" };
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
	coll[idx].sequences[param] = (
		stream: Pseq(values, inf).asStream,
		source: source
	);

	// Update seqModal UI to show custom indicator
	~ui.().sendMsg("/" ++ destName ++ "/" ++ inst ++ "/" ++ param ++ "/seq", "custom");

	("Dice " ++ param ++ " on " ++ destName ++ " " ++ inst ++ ": " ++ values).postln;
};

)
