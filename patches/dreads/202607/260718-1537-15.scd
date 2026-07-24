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
			(cloudsSend: 0.22, decay: 0.25, decayMod: 0.16, delaySend: 0.02, distAmount: 0.24, distDrive: 0.07, droneMode: 1.0, dur: 0.7, engine: 14.0, fmMod: 0.12, harm: 0.08, harmMod: 0.33, legato: 2.17, lpgColour: 0.47, morph: 0.08, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 72.0, pitchMod: 0.27, revDamp: 0.8, revDrywet: 0.3, revFreeze: 0.0, revHp: 0.7, revTime: 0.23, reverbSend: 0.25, sendToPhones: 0.0, speed: 0.5, stereoMode: 1.0, tempo: 170.0, timbMod: 0.39, timbre: 0.96, volume: 1.45, volumeMod: 0.0),
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

				// lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
				engine: Pseq(["e", "e", "(e-5).mod(16)", "e", "e", "(e-6).mod(16)"], inf).asStream,
				// duration: \gauss,

				duration: Pseq([
					0.7,
					Pwrand([0.7, Rest(0.7)], [0.9, 0.1].normalizeSum),
					0.7,
					Pwrand([0.7, Rest(1.4)], [0.95, 0.05].normalizeSum),
					0.7,
					Pwrand([1.4, 0.7], [0.6, 0.4].normalizeSum),
				], inf).asStream,
				div: Pseq([1, 2, 1, 1, 2], inf).asStream,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.16, decay: 0.9, decayMod: 0.0, delaySend: 0.09, distAmount: 0.05, distDrive: 0.01, droneMode: 1.0, dur: 1.4, engine: 23.0, fmMod: 0.08, harm: 0.15, harmMod: 0.13, legato: 1.64, lpgColour: 0.13, morph: 0.17, morphMod: 0.41, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 45.0, pitchMod: 0.37, revDamp: 0.8, revDrywet: 0.3, revFreeze: 0.0, revHp: 0.7, revTime: 0.41, reverbSend: 0.22, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 170.0, timbMod: 0.42, timbre: 0.16, volume: 0.5, volumeMod: 0.27),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: Pseq([
					0.7,
					Rest(0.7),
					Rest(0.7),
					Rest(0.7),
				], inf).asStream,
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
			(cloudsSend: 0.07, decay: 0.68, decayMod: 0.0, delaySend: 0.05, distAmount: 0.14, distDrive: 0.16, droneMode: 1.0, dur: Rest(1.4), engine: 0.0, fmMod: 0.04, harm: 0.99, harmMod: 0.23, legato: 7.63, lpgColour: 0.59, morph: 0.06, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 70.0, pitchMod: 0.0, revDamp: 0.4, revDrywet: 0.36, revFreeze: 0.0, revHp: 0.4, revTime: 0.25, reverbSend: 0.16, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 170.0, timbMod: 0.0, timbre: 0.82, volume: 0.13, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: Pseq([
					0.7,
					Rest(0.7),
					Rest(0.7),
					Pwrand([Rest(1.4), 0.7], [0.5, 0.5].normalizeSum),
				], inf).asStream,
				div: Pseq([0.5], inf).asStream,
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
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.57, distAmount: 0.0, distDrive: 0.0, dur: Rest(1.0), legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.5, rate: 4.28, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 170.0, variant: 0.0, volume: 1.01, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \unit,
				mul: \unit,
				duration: \backbeat,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 170.0, variant: 0.0, volume: 0.0, volumeMod: 0.0),
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
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 170.0, variant: 0.0, volume: 0.0, volumeMod: 0.0),
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
	clouds: (blend: 0.5, density: 0.7, feedback: 0.0, freeze: 0.0, inGain: 1.0, lofi: 0.0, mix: 1.0, mode: 3.0, pitch: 0.5, position: 0.5, reverb: 0.0, size: 0.5, spread: 0.5, texture: 0.5, volume: 1.0),
	delay: (feedback: 0.5, filterFreq: 4950.37, spread: 1.5, time: 0.25),
	reverb: (damp: 0.6, diffuse: 0.63, freeze: 0.0, hp: 0.3, time: 0.4)
),
	// $PRESET_FX_END
);

~states = Pseq([\a, \b, \c, \d], inf).asStream;
~state = ~states.next;
~playCount = 0;
~tempoClock.tempo = ~dreads.synths[0].tempo/60;

// $LFO_SOURCES_START
~dreads.lfoSources = (
	lfo1: (freq: 0.47768304347992), // plaits 0 timbre
	lfo2: (freq: 1.0940448105335), // plaits 0 morph
	lfo3: (freq: 0.79018586874008, shape: 1), // plaits 0 decay
	lfo4: (freq: 0.61470577120781, shape: 1, base: true), // plaits 0 pitch
	lfo5: (freq: 1.4484703063965), // plaits 0 volume
	lfo6: (freq: 0.63993696570396, shape: 4), // plaits 0 harm
	lfo7: (freq: 2.489675372839, base: true), // plaits 1 timbre
	lfo8: (freq: 1.0452499389648, shape: 2, base: true), // plaits 1 morph
	lfo9: (freq: 1.0414757490158, shape: 3), // plaits 1 decay
	lfo10: (freq: 0.052657622098923, shape: 3), // plaits 1 pitch
	lfo11: (freq: 2.7700869143009, shape: 1, base: true), // plaits 1 volume
	lfo12: (freq: 0.84863609671593, shape: 1), // plaits 1 harm
	lfo13: (freq: 2.0289800465107, base: true), // plaits 2 timbre
	lfo14: (freq: 1.486883187294, shape: 4), // plaits 2 morph
	lfo15: (freq: 2.789875805378, shape: 4, base: true), // plaits 2 decay
	lfo16: (freq: 0.44517863988876, shape: 3), // plaits 2 pitch
	lfo17: (freq: 0.10681278705597, shape: 4), // plaits 2 volume
	lfo18: (freq: 0.3346300303936, shape: 4), // plaits 2 harm
);
~base = 0.14699999988079;
// $LFO_SOURCES_END

~applyPatch.();
)
