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
			(cloudsSend: 0.0, decay: 0.32, decayMod: 0.0, delaySend: 0.1, distAmount: 0.16, distDrive: 0.0, droneMode: 1.0, dur: 0.7, engine: 4.0, fmMod: -0.01, harm: 0.69, harmMod: 0.0, legato: 9.0, lpgColour: 0.64, morph: 0.0, morphMod: 0.0, mul: 0.5, mute: 1.0, phaseOffset: 0.0, pitch: 12.8, pitchMod: 0.0, revDamp: 0.8, revDrywet: 0.26, revFreeze: 0.0, revHp: 0.7, revTime: 0.74, reverbSend: 0.1, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 60.0, timbMod: 0.0, timbre: 0.68, volume: 0.39, volumeMod: 0.53),
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
				lpgColour: Pseq([0.58, 0.3, 0.17, 0.86, 0.35], inf).asStream,

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
			(cloudsSend: 0.0, decay: 0.24, decayMod: 0.0, delaySend: 0.15, distAmount: 0.09, distDrive: 0.0, droneMode: 0.0, dur: 4.0, engine: 10.0, fmMod: 0.0, harm: 0.72, harmMod: 0.0, legato: 9.0, lpgColour: 0.5, morph: 0.66, morphMod: 0.36, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 98.4, pitchMod: 0.0, revDamp: 0.71, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.46, revTime: 0.18, reverbSend: 0.1, sendToPhones: 0.0, speed: 0.25, stereoMode: 1.0, tempo: 60.0, timbMod: 0.69, timbre: 0.55, volume: 0.27, volumeMod: 1.0),
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
			(cloudsSend: 0.0, decay: 0.59, decayMod: 0.3, delaySend: 0.0, distAmount: 0.14, distDrive: 0.0, droneMode: 1.0, dur: 1.4, engine: 2.0, fmMod: 0.0, harm: 0.07, harmMod: 0.0, legato: 9.0, lpgColour: 0.5, morph: 0.43, morphMod: 0.4, mul: 0.5, mute: 1.0, phaseOffset: 0.0, pitch: 49.0, pitchMod: 0.0, revDamp: 0.0, revDrywet: 0.23, revFreeze: 0.0, revHp: 0.22, revTime: 0.9, reverbSend: 0.51, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 60.0, timbMod: 0.7, timbre: 0.44, volume: 0.03, volumeMod: 0.75),
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
			(atk: 0.28, bankName: 'breathing', cloudsSend: 0.29, decay: 0.53, delaySend: 0.03, distAmount: 0.14, distDrive: 0.09, dur: 0.74, legato: 6.43, mul: 1.0, mute: 0.0, panDur: 0.59, phaseOffset: 0.25, rate: 2.37, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.18, revFreeze: 0.0, revHp: 0.65, revTime: 0.45, reverbSend: 0.2, speed: 0.5, startPos: 0.1, tempo: 60.0, variant: 1.0, volume: 0.9, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: Pseq([0.66666666666667, 1, 0.66666666666667, 2, 0.66666666666667, 0.5, 0.66666666666667, 0.66666666666667, 0.66666666666667, 0.66666666666667], inf).asStream,
				mul: \unit,
				duration: \gauss,
				startPos: Pseq([0.49, 0.04, 0.63, 0.99, 0.71, 0.06, 0.9, 0.38], inf).asStream,

				// startPos: Pwhite(0.0, 0.5, inf).asStream,
				// decay: Pwhite(0.01, 0.05, inf).asStream,
				decay: \hold,

				// decay: Pbrown(0.12, 0.05, 0.01, inf).asStream,
				panDur: Pseq([0.98, 0.22, 0.14, 0.12, 0.28, 0.48, 0.28, 0.11], inf).asStream,

				// panDur: Pseq([0.89, 0.77, 0.42, 0.3, 0.36, 0.81, 0.56, 0.31, 0.36, 0.65, 0.03, 0.02, 0.19, 0.84], inf).asStream,
				revHp: \hold,
				revDrywet: \hold,
				atk: Pseq([0.16, 0.87, 0.08, 0.6, 0.22, 0.9, 0.23], inf).asStream,

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
			(atk: 0.13, bankName: 'msp-form-msp5', cloudsSend: 0.09, decay: 0.12, delaySend: 0.08, distAmount: 0.3, distDrive: 0.29, dur: 32.0, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.75, phaseOffset: 0.0, rate: 2.58, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.13, revFreeze: 0.0, revHp: 0.37, revTime: 0.41, reverbSend: 0.19, speed: 0.25, startPos: 0.38, tempo: 60.0, variant: 0.0, volume: 0.76, volumeMod: 0.27),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				// div: Pbrown(0.0, 0.07, 0.01, inf).asStream,
				div: Pseq([1/2, 1/4, 1/8], inf).asStream,
				rate: \hold,
				mul: \unit,
				duration: \unit,
				startPos: Pseq([0.79, 0.69, 0.15, 0.33, 0.47], inf).asStream,
				decay: Pseq([0.39, 0.73, 0.2, 0.57, 0.95, 0.54], inf).asStream,

				// decay: Pbrown(0.12, 0.05, 0.01, inf).asStream,
				atk: Pseq([0.72, 0.8, 0.44, 0.77, 0.64, 0.05, 0.64, 0.91, 0.51, 0.91], inf).asStream,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.17, bankName: 'RIMS', cloudsSend: 0.07, decay: 0.33, delaySend: 0.09, distAmount: 0.27, distDrive: 0.18, dur: 0.94, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.08, phaseOffset: 0.0, rate: 3.61, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.1, revFreeze: 0.0, revHp: 0.7, revTime: 0.25, reverbSend: 0.23, speed: 0.5, startPos: 0.0, tempo: 60.0, variant: 2.0, volume: 0.21, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: Pseq([2, 2, 1, 0.5, 2, 0.66666666666667, 0.66666666666667, 0.66666666666667, 0.66666666666667, 1.5, 0.5, 2, 0.66666666666667, 1, 0.66666666666667], inf).asStream,
				mul: \unit,
				duration: \gauss,
				startPos: Pseq([0.4, 0.26, 0.74, 0.21, 0.6, 0.85, 0.57, 0.03, 0.86, 0.27], inf).asStream,
				atk: Pseq([0.37, 0.19, 0.17, 0.01, 0.15, 0.3, 0.34, 0.62, 0.03, 0.22, 0.9, 0.89, 0.87, 0.13], inf).asStream,
				decay: Pseq([0.3, 0.22, 0.27, 0.32, 0.76, 0.86, 0.71, 0.01, 0.79, 0.08, 0.04, 0.32, 0.86, 0.99], inf).asStream,
				panDur: Pseq([0.98, 0.01, 0.82, 0.53, 0.59, 0.05, 0.04, 0.2, 0.29, 0.91, 0.21, 0.71, 0.82, 0.13, 0.57], inf).asStream,
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
	lfo1: (freq: 0.55372673273087, shape: 4), // plaits 0 timbre
	lfo2: (freq: 0.73465323448181, shape: 3), // plaits 0 morph
	lfo3: (freq: 3.685320109129, base: true), // plaits 0 decay
	lfo4: (freq: 2.1749002635479, shape: 4, base: true), // plaits 0 pitch
	lfo5: (freq: 0.87999999523163, base: true), // plaits 0 volume
	lfo6: (freq: 1.4922093212605), // plaits 0 harm
	lfo7: (freq: 0.0665), // plaits 1 timbre
	lfo8: (freq: 0.0165), // plaits 1 morph
	lfo11: (freq: 0.10000000149012, shape: 1), // plaits 1 volume
	lfo12: (freq: 0.0665), // plaits 1 harm
	lfo13: (freq: 0.0165), // plaits 2 timbre
	lfo17: (freq: 0.10000000149012, base: true), // plaits 2 volume
	lfo19: (freq: 3.7242733836174, shape: 4, base: true), // sample 0 rate
	lfo20: (freq: 0.085325545072556, shape: 3), // sample 0 volume
	lfo21: (freq: 0.57295808196068, shape: 2, base: true), // sample 1 rate
);
~base = 0.14699999988079;
// $LFO_SOURCES_END

~applyPatch.();
)
