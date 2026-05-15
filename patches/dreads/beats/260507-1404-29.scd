////////////////////////////////////////////////////////////////////////////////
// Plaits State - Data structures and synth instance definitions
////////////////////////////////////////////////////////////////////////////////
(
~dreads = ~patchFactory.(
	// Synth instances array
	[
	// $PLAITS1
	~plaitsFactory.(
		// $PRESET_SCALARS_START
			(cloudsSend: 0.0, decay: 0.3, decayMod: 0.3, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 0.35, engine: 3.0, fmMod: 0.25, harm: 0.4, legato: 9.0, lpgColour: 0.5, morph: 0.21, morphMod: 0.0, mul: 0.7, mute: 0.0, phaseOffset: 0.0, pitch: 42.0, pitchMod: 0.0, revDamp: 0.78, revDrywet: 0.19, revFreeze: 0.0, revHp: 0.61, revTime: 0.56, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 165.0, timbMod: 0.0, timbre: 0.29, volume: 1.22, volumeMod: 0.0),
		// $PRESET_SCALARS_END
		// $PRESET_SEQUENCES_START
		(
			decay: Pseq([0.5, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
			div: Pseq([2], inf).asStream,
			duration: Pseq([
				0.7,
				Pwrand([0.7, Rest(0.7)], [0.9, 0.1].normalizeSum),
				0.7,
				Pwrand([0.7, Rest(1.4)], [0.95, 0.05].normalizeSum),
				0.7,
				Pwrand([1.4, 0.7], [0.6, 0.4].normalizeSum),
			], inf).asStream,
			engine: Pseq(["e", "e", "e+3", "e", "e", "e+6"], inf).asStream,
			harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
			timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
		),
		// $PRESET_SEQUENCES_END
		// $PRESET_LFO_START
			()
		// $PRESET_LFO_END
	),

	// $PLAITS2
	~plaitsFactory.(
		// $PRESET_SCALARS_START
			(cloudsSend: 0.0, decay: 0.59, decayMod: 0.3, delaySend: 0.3, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(1.4), engine: 13.0, fmMod: 0.7, harm: 0.5, legato: 9.0, lpgColour: 0.5, morph: 0.87, morphMod: 0.4, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 33.36, pitchMod: 0.0, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.61, revTime: 0.56, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 165.0, timbMod: 0.6, timbre: 0.28, volume: 2.0, volumeMod: 0.0),
		// $PRESET_SCALARS_END
		// $PRESET_SEQUENCES_START
		(
			div: Pseq([0.5], inf).asStream,
			duration: Pseq([
				0.7,
				Rest(0.7),
				Rest(0.7),
				Rest(0.7),
				Rest(0.7),
				Rest(0.7),
			], inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", "e"], inf).asStream,
		),
		// $PRESET_SEQUENCES_END
		// $PRESET_LFO_START
			()
		// $PRESET_LFO_END
	),

	// $PLAITS3
	~plaitsFactory.(
		// $PRESET_SCALARS_START
			(cloudsSend: 0.0, decay: 0.5, decayMod: 0.3, delaySend: 0.1, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(1.4), engine: 6.0, fmMod: 0.0, harm: 0.48, legato: 9.0, lpgColour: 0.5, morph: 0.3, morphMod: 0.39, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 49.0, pitchMod: 0.0, revDamp: 0.78, revDrywet: 0.28, revFreeze: 0.0, revHp: 0.61, revTime: 0.56, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 165.0, timbMod: 0.53, timbre: 0.39, volume: 0.8, volumeMod: 0.0),
		// $PRESET_SCALARS_END
		// $PRESET_SEQUENCES_START
		(
			div: Pseq([0.5], inf).asStream,
			duration: Pseq([
				0.7,
				Rest(0.7),
				Rest(0.7),
				Pwrand([Rest(1.4), 0.7], [0.5, 0.5].normalizeSum),
			], inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", "e+9"], inf).asStream,
		),
		// $PRESET_SEQUENCES_END
		// $PRESET_LFO_START
			()
		// $PRESET_LFO_END
	)
	],
	// Samples array
	[
		// $SAMPLE1
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 165.0, variant: 0.0, volume: 0.0, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
			div: \unit,
			rate: \unit,
			mul: \unit,
			duration: \unit,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 165.0, variant: 0.0, volume: 0.0, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
			div: \unit,
			rate: \unit,
			mul: \unit,
			duration: \unit,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 165.0, variant: 0.0, volume: 0.0, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
			div: \unit,
			rate: \unit,
			mul: \unit,
			duration: \unit,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		)
	],
	// Global FX settings
	// $PRESET_FX_START
(
	clouds: (blend: 0.5, density: 0.7, feedback: 0.28, freeze: 0.0, inGain: 1.0, lofi: 0.0, mix: 1.0, mode: 3.0, pitch: 0.5, position: 0.5, reverb: 0.66, size: 0.5, spread: 0.5, texture: 0.5, volume: 0.0),
	delay: (feedback: 0.4, filterFreq: 6000.0, spread: 1.5, time: 0.25),
	reverb: (damp: 0.2, diffuse: 0.63, freeze: 0.0, hp: 0.3, time: 0.2)
),
	// $PRESET_FX_END
);

~states = Pseq([\a, \b, \c, \d], inf).asStream;
~state = ~states.next;
~playCount = 0;

~tempoClock.tempo = ~dreads.synths[0].tempo/60;

// $LFO_SOURCES_START
~dreads.lfoSources = (
	lfo1: (freq: 0.0001), // plaits 0 timbre
	lfo2: (freq: 0.0002), // plaits 0 morph
	lfo3: (freq: 0.0004), // plaits 0 decay
	lfo6: (freq: 0.0133), // plaits 1 timbre
	lfo7: (freq: 0.0173), // plaits 1 morph
	lfo8: (freq: 0.0043), // plaits 1 decay
	lfo11: (freq: 0.0133), // plaits 2 timbre
	lfo12: (freq: 0.0173), // plaits 2 morph
	lfo13: (freq: 0.0043), // plaits 2 decay
);
// $LFO_SOURCES_END

~applyPatch.();
)