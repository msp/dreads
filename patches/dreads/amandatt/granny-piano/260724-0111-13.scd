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
			(cloudsSend: 0.01, decay: 0.69, decayMod: 0.0, delaySend: 0.2, distAmount: 0.16, distDrive: 0.02, droneMode: 1.0, dur: 1.4, engine: 22.0, fmMod: 0.2, harm: 0.53, harmMod: 0.0, legato: 9.0, lpgColour: 0.1, morph: 0.59, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 42.0, pitchMod: 0.41, revDamp: 0.8, revDrywet: 0.11, revFreeze: 0.0, revHp: 0.7, revTime: 0.15, reverbSend: 0.05, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 60.0, timbMod: 0.12, timbre: 0.12, volume: 0.29, volumeMod: 0.29),
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
				lpgColour: Pseq([0.75, 0.08, 0.32, 0.79, 0.15, 0.25, 0.56], inf).asStream,

				// lpgColour: Pseq([0.75, 0.08, 0.32, 0.79, 0.15, 0.25, 0.56], inf).asStream,

				// lpgColour: Pseq([0.58, 0.3, 0.17, 0.86, 0.35], inf).asStream,

				// lpgColour: Pseq([0.58, 0.3, 0.17, 0.86, 0.35], inf).asStream,

				// lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
				// engine: Pseq(["e", "e", "(e-5).mod(16)", "e", "e", "(e-6).mod(16)"], inf)0.asStream,
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
				fmMod: \hold,

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
			(cloudsSend: 0.22, decay: 0.62, decayMod: 0.0, delaySend: 0.15, distAmount: 0.1, distDrive: 0.1, droneMode: 0.0, dur: 4.0, engine: 11.0, fmMod: -0.05, harm: 0.88, harmMod: 0.11, legato: 9.0, lpgColour: 0.02, morph: 0.22, morphMod: 0.36, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 47.0, pitchMod: 0.0, revDamp: 0.71, revDrywet: 0.11, revFreeze: 0.0, revHp: 0.46, revTime: 0.31, reverbSend: 0.3, sendToPhones: 0.0, speed: 0.25, stereoMode: 1.0, tempo: 60.0, timbMod: 0.0, timbre: 0.38, volume: 0.33, volumeMod: 0.11),
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
				lpgColour: Pseq([0.68, 0.32, 0.99, 0.72, 0.3, 0.25, 0.27, 0.38, 0.73], inf).asStream,

				// lpgColour: Pseq([0.68, 0.32, 0.99, 0.72, 0.3, 0.25, 0.27, 0.38, 0.73], inf).asStream,
				fmMod: Pseq([0.01, 0.53, 0.04, 0.63, 0.34], inf).asStream,

				// fmMod: Pseq([0.01, 0.53, 0.04, 0.63, 0.34], inf).asStream,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.28, decay: 0.52, decayMod: 0.0, delaySend: 0.12, distAmount: 0.29, distDrive: 0.14, droneMode: 1.0, dur: Rest(1.4), engine: 3.0, fmMod: -0.15, harm: 0.0, harmMod: 0.0, legato: 9.0, lpgColour: 0.86, morph: 0.41, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 67.0, pitchMod: 0.16, revDamp: 0.0, revDrywet: 0.13, revFreeze: 0.0, revHp: 0.22, revTime: 0.41, reverbSend: 0.21, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 60.0, timbMod: 0.0, timbre: 0.27, volume: 0.03, volumeMod: 0.41),
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
				lpgColour: Pseq([0.17, 0.15, 0.99, 0.68, 0.83, 0.19, 0.3, 0.82, 0.14, 0.79], inf).asStream,

				// lpgColour: Pseq([0.17, 0.15, 0.99, 0.68, 0.83, 0.19, 0.3, 0.82, 0.14, 0.79], inf).asStream,
				decay: Pseq([0.8, 0.38, 0.23, 0.2, 0.37, 0.8, 0.51, 0.86, 0.24, 0.78, 0.46, 0.41, 0.15, 0.59, 0.23], inf).asStream,

				// decay: Pseq([0.8, 0.38, 0.23, 0.2, 0.37, 0.8, 0.51, 0.86, 0.24, 0.78, 0.46, 0.41, 0.15, 0.59, 0.23], inf).asStream,
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
			(atk: 0.5, bankName: 'msp-summer2026', cloudsSend: 0.07, decay: 0.5, delaySend: 0.3, distAmount: 0.0, distDrive: 0.04, dur: 1.12, legato: 6.43, mul: 1.0, mute: 0.0, panDur: 0.09, phaseOffset: 0.25, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.1, revFreeze: 0.0, revHp: 0.65, revTime: 1.01, reverbSend: 0.32, speed: 0.5, startPos: 0.6, tempo: 60.0, variant: 1.0, volume: 1.2, volumeMod: 0.71),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \hold,
				mul: \unit,
				duration: \gauss,
				startPos: Pwhite(0.0, 0.5, inf).asStream,
				// decay: Pwhite(0.01, 0.05, inf).asStream,
				decay: Pbrown(0.12, 0.05, 0.01, inf).asStream,
				panDur: Pseq([0.89, 0.77, 0.42, 0.3, 0.36, 0.81, 0.56, 0.31, 0.36, 0.65, 0.03, 0.02, 0.19, 0.84], inf).asStream,
				revHp: \hold,
				revDrywet: \rndm_walk_slow,
				atk: Pbrown(0.01, 0.07, 0.01, inf).asStream,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.01, bankName: 'msp-summer2026', cloudsSend: 0.2, decay: 0.5, delaySend: 0.51, distAmount: 0.0, distDrive: 0.0, dur: 32.0, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.16, phaseOffset: 0.0, rate: 2.77, rateMod: 0.56, revDamp: 0.8, revDrywet: 0.09, revFreeze: 0.0, revHp: 0.37, revTime: 0.57, reverbSend: 0.07, speed: 0.25, startPos: 0.91, tempo: 60.0, variant: 0.0, volume: 0.16, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				// div: Pbrown(0.0, 0.07, 0.01, inf).asStream,
				div: Pseq([1/2, 1/4, 1/8], inf).asStream,
				rate: \unit,
				mul: \unit,
				duration: \unit,
				startPos: \sine_slow,
				decay: Pbrown(0.12, 0.05, 0.01, inf).asStream,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.18, bankName: 'msp-loops-msp', cloudsSend: 0.0, decay: 0.06, delaySend: 0.42, distAmount: 0.0, distDrive: 0.0, dur: 1.27, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.14, phaseOffset: 0.0, rate: 1.15, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 0.5, startPos: 0.47, tempo: 60.0, variant: 2.0, volume: 0.21, volumeMod: 0.0),
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
	lfo1: (freq: 2.436404466629, shape: 2, base: true), // plaits 0 timbre
	lfo2: (freq: 3.9904678761959, shape: 2, base: true), // plaits 0 morph
	lfo3: (freq: 1.1823518455029), // plaits 0 decay
	lfo4: (freq: 2.3490136265755, base: true), // plaits 0 pitch
	lfo5: (freq: 1.7399080991745, shape: 4, base: true), // plaits 0 volume
	lfo6: (freq: 0.91417521834373), // plaits 0 harm
	lfo7: (freq: 1.7133832871914, base: true), // plaits 1 timbre
	lfo8: (freq: 0.8988234102726, shape: 1), // plaits 1 morph
	lfo9: (freq: 0.84790060520172, shape: 3), // plaits 1 decay
	lfo10: (freq: 3.3019935488701, shape: 4, base: true), // plaits 1 pitch
	lfo11: (freq: 0.36641017794609), // plaits 1 volume
	lfo12: (freq: 0.73817979097366), // plaits 1 harm
	lfo13: (freq: 0.8981228351593, shape: 3), // plaits 2 timbre
	lfo14: (freq: 1.3701196312904), // plaits 2 morph
	lfo15: (freq: 2.6539575457573, shape: 4, base: true), // plaits 2 decay
	lfo16: (freq: 0.59924283623695, base: true), // plaits 2 pitch
	lfo17: (freq: 1.698311060667, shape: 4, base: true), // plaits 2 volume
	lfo18: (freq: 0.66394710540771, shape: 3, base: true), // plaits 2 harm
	lfo20: (freq: 2.3102073669434, base: true), // sample 0 volume
	lfo21: (shape: 4), // sample 1 rate
);
~base = 0.14699999988079;
// $LFO_SOURCES_END

~applyPatch.();
)
