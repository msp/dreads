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
			(cloudsSend: 0.55, decay: 0.58, decayMod: 0.21, delaySend: 0.34, distAmount: 0.24, distDrive: 0.07, droneMode: 1.0, dur: 0.35, engine: 14.0, fmMod: 0.23, harm: 0.35, harmMod: 0.29, legato: 9.0, lpgColour: 0.89, morph: 0.64, morphMod: 0.32, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 52.0, pitchMod: 0.0, revDamp: 0.8, revDrywet: 0.17, revFreeze: 0.0, revHp: 0.7, revTime: 0.13, reverbSend: 0.11, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 60.0, timbMod: 0.26, timbre: 0.3, volume: 0.15, volumeMod: 0.0),
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
				lpgColour: Pseq([0.1, 0.91, 0.16, 0.7, 0.73, 0.39, 0.82, 0.03, 0.86], inf).asStream,

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
				volume: Pseq([0.86, 0.36, 0.05, 0.62], inf).asStream,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.0, decay: 0.24, decayMod: 0.0, delaySend: 0.15, distAmount: 0.09, distDrive: 0.0, droneMode: 0.0, dur: 4.0, engine: 10.0, fmMod: 0.0, harm: 0.72, harmMod: 0.0, legato: 9.0, lpgColour: 0.5, morph: 0.66, morphMod: 0.36, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 4.82, pitchMod: 0.0, revDamp: 0.71, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.46, revTime: 0.18, reverbSend: 0.1, sendToPhones: 0.0, speed: 0.25, stereoMode: 1.0, tempo: 60.0, timbMod: 0.69, timbre: 0.55, volume: 0.27, volumeMod: 1.0),
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
			(cloudsSend: 0.0, decay: 0.59, decayMod: 0.3, delaySend: 0.0, distAmount: 0.14, distDrive: 0.0, droneMode: 1.0, dur: Rest(1.4), engine: 2.0, fmMod: 0.0, harm: 0.07, harmMod: 0.0, legato: 9.0, lpgColour: 0.5, morph: 0.43, morphMod: 0.4, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 49.0, pitchMod: 0.0, revDamp: 0.0, revDrywet: 0.66, revFreeze: 0.0, revHp: 0.22, revTime: 0.9, reverbSend: 0.51, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 60.0, timbMod: 0.16, timbre: 0.0, volume: 0.1, volumeMod: 0.68),
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
			(atk: 0.5, bankName: 'msp-summer2026', cloudsSend: 0.07, decay: 0.5, delaySend: 0.3, distAmount: 0.0, distDrive: 0.04, dur: 0.81, legato: 6.43, mul: 1.0, mute: 1.0, panDur: 0.09, phaseOffset: 0.25, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.51, revFreeze: 0.0, revHp: 0.65, revTime: 1.01, reverbSend: 0.32, speed: 0.5, startPos: 0.6, tempo: 60.0, variant: 1.0, volume: 0.9, volumeMod: 0.71),
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
			(atk: 0.01, bankName: 'msp-summer2026', cloudsSend: 0.49, decay: 0.5, delaySend: 0.34, distAmount: 0.0, distDrive: 0.0, dur: 32.0, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.16, phaseOffset: 0.0, rate: 2.77, rateMod: 0.56, revDamp: 0.8, revDrywet: 0.09, revFreeze: 0.0, revHp: 0.37, revTime: 0.57, reverbSend: 0.07, speed: 0.25, startPos: 0.91, tempo: 60.0, variant: 0.0, volume: 0.76, volumeMod: 0.0),
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
			(atk: 0.18, bankName: 'msp-loops-msp', cloudsSend: 0.0, decay: 0.06, delaySend: 0.42, distAmount: 0.0, distDrive: 0.0, dur: 0.87, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.14, phaseOffset: 0.0, rate: 1.15, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 0.5, startPos: 0.47, tempo: 60.0, variant: 2.0, volume: 0.21, volumeMod: 0.0),
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
	delay: (feedback: 0.83, filterFreq: 5409.81, spread: 1.5, time: 1.43),
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
	lfo1: (freq: 3.012453109026, shape: 4, base: true), // plaits 0 timbre
	lfo2: (freq: 2.9524377882481, base: true), // plaits 0 morph
	lfo3: (freq: 0.56670137047768), // plaits 0 decay
	lfo4: (freq: 3.8532237112522, shape: 1, base: true), // plaits 0 pitch
	lfo5: (freq: 2.0258145928383, base: true), // plaits 0 volume
	lfo6: (freq: 0.4617148399353, shape: 2), // plaits 0 harm
	lfo7: (freq: 0.0665), // plaits 1 timbre
	lfo8: (freq: 0.0165), // plaits 1 morph
	lfo11: (freq: 0.10000000149012, shape: 1), // plaits 1 volume
	lfo12: (freq: 0.0665), // plaits 1 harm
	lfo13: (freq: 0.0165), // plaits 2 timbre
	lfo17: (freq: 0.47737297415733, base: true), // plaits 2 volume
	lfo20: (freq: 2.3102073669434, base: true), // sample 0 volume
	lfo21: (shape: 4), // sample 1 rate
);
~base = 0.87900000810623;
// $LFO_SOURCES_END

~applyPatch.();
)
