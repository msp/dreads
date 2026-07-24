////////////////////////////////////////////////////////////////////////////////
// Plaits State - Template-based default preset with global FX
////////////////////////////////////////////////////////////////////////////////
(
~dreads = ~patchFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.13, decay: 0.36, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.21, droneMode: 0.0, dur: 1.0, engine: 13.0, fmMod: -0.25, harm: 0.8, harmMod: 0.0, legato: 9.0, lpgColour: 0.34, morph: 0.69, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 30.0, pitchMod: 0.0, revDamp: 0.8, revDrywet: 0.18, revFreeze: 0.0, revHp: 0.7, revTime: 0.56, reverbSend: 0.14, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 138.88, timbMod: 0.0, timbre: 0.77, volume: 1.33, volumeMod: 0.48),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				timbre: \hold,

				// timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
				decay: \hold,

				// decay: Pseq([0.5, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
				// decay: \gauss,
				morph: \hold,

				// morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
				harm: \hold,

				// harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
				lpgColour: \hold,

				// lpgColour: Pseq([0.58, 0.3, 0.17, 0.86, 0.35], inf).asStream,

				// lpgColour: Pseq([0.58, 0.3, 0.17, 0.86, 0.35], inf).asStream,

				// lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
				// engine: Pseq(["e", "e", "(e-5).mod(16)", "e", "e", "(e-6).mod(16)"], inf)0.asStream,
				// duration: \gauss,

				duration: \four_floor,

				// duration: Pseq([
				// 0.7,
				// Pwrand([0.7, Rest(0.7)], [0.9, 0.1].normalizeSum),
				// 0.7,
				// Pwrand([0.7, Rest(1.4)], [0.95, 0.05].normalizeSum),
				// 0.7,
				// Pwrand([1.4, 0.7], [0.6, 0.4].normalizeSum),
				// ], inf).asStream,
				div: Pseq([1, 2, 1, 1, 2], inf).asStream,
				fmMod: Pseq([0.53, 0.66, 0.48, 0.22, 0.81, 0.1, 0.69, 0.74, 0.7, 0.75, 0.15], inf).asStream,

				// fmMod: Pseq([0.39, 0.03, 0.98, 0.44, 0.76, 0.31, 0.16, 0.65, 0.46, 0.0, 0.2, 0.24, 0.56, 0.13, 0.94, 0.13], inf).asStream,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.29, decay: 0.58, decayMod: 0.0, delaySend: 0.02, distAmount: 0.13, distDrive: 0.16, droneMode: 1.0, dur: 1.0, engine: 12.0, fmMod: 0.0, harm: 0.54, harmMod: 0.0, legato: 9.0, lpgColour: 0.99, morph: 0.3, morphMod: 0.09, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 48.0, pitchMod: 0.0, revDamp: 0.71, revDrywet: 0.35, revFreeze: 0.0, revHp: 0.46, revTime: 0.3, reverbSend: 0.21, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 138.88, timbMod: 0.13, timbre: 0.33, volume: 0.2, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \hold,

				// duration: Pseq([
				// 0.7,
				// Rest(0.7),
				// Rest(0.7),
				// Rest(0.7),
				// ], inf).asStream,
				div: Pseq([0.5], inf).asStream,
				timbre: \hold,
				morph: \hold,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.04, decay: 0.33, decayMod: 0.0, delaySend: 0.03, distAmount: 0.22, distDrive: 0.06, droneMode: 0.0, dur: 1.6, engine: 2.0, fmMod: 0.16, harm: 0.94, harmMod: 0.0, legato: 9.0, lpgColour: 0.73, morph: 0.18, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 41.0, pitchMod: 0.0, revDamp: 0.0, revDrywet: 0.18, revFreeze: 0.0, revHp: 0.22, revTime: 0.58, reverbSend: 0.26, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 138.88, timbMod: 0.31, timbre: 0.54, volume: 0.72, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \eucl_2_5,

				// duration: Pseq([
				// 0.7,
				// Rest(0.7),
				// Rest(0.7),
				// Pwrand([Rest(1.4), 0.7], [0.5, 0.5].normalizeSum),
				// ], inf).asStream,
				div: Pseq([0.5], inf).asStream,
				lpgColour: Pseq([0.96, 0.21, 0.25, 0.26], inf).asStream,
				decay: Pseq([0.99, 0.58, 0.23, 0.46, 0.0, 0.44], inf).asStream,
				harm: Pseq([0.89, 0.04, 0.51, 0.31, 0.33, 0.49, 0.12, 0.74, 1.0, 0.52, 0.67, 0.64, 0.66, 0.04], inf).asStream,
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
			(atk: 0.0, bankName: 'msp-iris-hits', cloudsSend: 0.28, decay: 0.44, delaySend: 0.23, distAmount: 0.2, distDrive: 0.06, dur: 0.25, legato: 6.43, mul: 1.0, mute: 0.0, panDur: 0.46, phaseOffset: 0.25, rate: 0.92, rateMod: 0.61, revDamp: 0.8, revDrywet: 0.66, revFreeze: 0.0, revHp: 0.65, revTime: 0.26, reverbSend: 0.12, speed: 2.0, startPos: 0.0, tempo: 138.88, variant: 3.0, volume: 0.15, volumeMod: 0.31),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: Pseq([1, 2, 0.66666666666667, 1.5, 2, 2, 1.5, 0.5, 0.66666666666667, 0.66666666666667, 0.5, 1, 0.5, 2, 1], inf).asStream,
				mul: \unit,
				duration: \hold,
				startPos: Pseq([0.17, 0.25, 0.39, 0.87, 0.06, 0.58, 0.56, 0.53, 0.2, 0.03, 0.37, 0.68, 0.34, 0.36, 0.58], inf).asStream,

				// startPos: Pwhite(0.0, 0.5, inf).asStream,
				// decay: Pwhite(0.01, 0.05, inf).asStream,
				decay: \rndm_walk_slow,

				// decay: Pbrown(0.12, 0.05, 0.01, inf).asStream,
				panDur: Pseq([0.4, 0.59, 0.07, 0.84, 0.46, 0.45, 0.79, 0.5, 0.9, 0.95, 0.4], inf).asStream,

				// panDur: Pseq([0.89, 0.77, 0.42, 0.3, 0.36, 0.81, 0.56, 0.31, 0.36, 0.65, 0.03, 0.02, 0.19, 0.84], inf).asStream,
				revHp: \hold,
				revDrywet: \hold,
				atk: \hold,

				// atk: Pbrown(0.01, 0.07, 0.01, inf).asStream,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.02, bankName: 'msp-iris-hits', cloudsSend: 0.49, decay: 0.69, delaySend: 0.0, distAmount: 0.22, distDrive: 0.0, dur: Rest(2.0), legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.15, phaseOffset: 0.0, rate: 1.17, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.42, revFreeze: 0.0, revHp: 0.37, revTime: 0.97, reverbSend: 0.28, speed: 1.0, startPos: 0.01, tempo: 138.88, variant: 7.0, volume: 0.76, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				// div: Pbrown(0.0, 0.07, 0.01, inf).asStream,
				div: Pseq([1/2, 1/4, 1/8], inf).asStream,
				rate: \hold,
				mul: \unit,
				duration: \offbeat,
				startPos: \hold,
				decay: \hold,

				// decay: Pbrown(0.12, 0.05, 0.01, inf).asStream,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.18, bankName: 'msp-loops-msp', cloudsSend: 0.0, decay: 0.06, delaySend: 0.42, distAmount: 0.0, distDrive: 0.0, dur: 1.15, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.14, phaseOffset: 0.0, rate: 1.15, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 0.5, startPos: 0.47, tempo: 138.88, variant: 2.0, volume: 0.21, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \unit,
				mul: \unit,
				duration: \gauss,
				startPos: \rndm_walk_slow,
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
	clouds: (blend: 0.68, density: 0.7, feedback: 0.51, freeze: 0.0, inGain: 1.0, lofi: 0.0, mix: 1.0, mode: 3.0, pitch: 37.0, position: 0.68, reverb: 0.52, size: 0.28, spread: 0.5, texture: 0.5, volume: 0.25),
	delay: (feedback: 0.83, filterFreq: 5053.01, spread: 1.5, time: 0.25),
	reverb: (damp: 0.6, diffuse: 0.63, freeze: 0.0, hp: 0.8, time: 0.67)
),
	// $PRESET_FX_END
);

~states = Pseq([\a, \b, \c, \d], inf).asStream;
~state = ~states.next;
~playCount = 0;
~tempoClock.tempo = ~dreads.synths[0].tempo/60;

// $LFO_SOURCES_START
~dreads.lfoSources = (
	lfo1: (freq: 0.088382977247238, shape: 3), // plaits 0 timbre
	lfo2: (freq: 0.62258744239807, base: true), // plaits 0 morph
	lfo3: (freq: 1.2834408283234, shape: 1, base: true), // plaits 0 decay
	lfo4: (freq: 0.83513745069504, shape: 2), // plaits 0 pitch
	lfo5: (freq: 3.4411586225033, shape: 4, base: true), // plaits 0 volume
	lfo6: (freq: 0.38443538546562, shape: 1, base: true), // plaits 0 harm
	lfo7: (freq: 0.080679589509964, shape: 1), // plaits 1 timbre
	lfo8: (freq: 1.9133893549442, base: true), // plaits 1 morph
	lfo9: (freq: 1.3694436013699, shape: 4), // plaits 1 decay
	lfo10: (freq: 0.2648416519165), // plaits 1 pitch
	lfo11: (freq: 3.9399180710316, base: true), // plaits 1 volume
	lfo12: (freq: 3.3298335373402, shape: 2, base: true), // plaits 1 harm
	lfo13: (freq: 0.60204506516457), // plaits 2 timbre
	lfo14: (freq: 0.94582814574242, shape: 4), // plaits 2 morph
	lfo15: (freq: 1.0452012598515, shape: 1), // plaits 2 decay
	lfo16: (freq: 2.6719962954521, base: true), // plaits 2 pitch
	lfo17: (freq: 0.18064697384834), // plaits 2 volume
	lfo18: (freq: 1.0314531028271, base: true), // plaits 2 harm
	lfo19: (freq: 0.23660845756531), // sample 0 rate
	lfo20: (freq: 0.16349714398384), // sample 0 volume
	lfo21: (shape: 4), // sample 1 rate
);
~base = 0.39800000190735;
// $LFO_SOURCES_END

~applyPatch.();
)
