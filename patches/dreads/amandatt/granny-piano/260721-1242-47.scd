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
			(cloudsSend: 0.21, decay: 0.62, decayMod: 0.0, delaySend: 0.05, distAmount: 0.1, distDrive: 0.07, droneMode: 1.0, dur: 0.38, engine: 11.0, fmMod: -0.04, harm: 0.93, harmMod: 0.28, legato: 7.22, lpgColour: 0.53, morph: 0.12, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 45.0, pitchMod: 0.0, revDamp: 0.8, revDrywet: 0.3, revFreeze: 0.0, revHp: 0.7, revTime: 0.12, reverbSend: 0.08, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 355.72, timbMod: 0.0, timbre: 0.39, volume: 0.23, volumeMod: 0.43),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				timbre: Pseq([0.39, 0.84, 0.11, 0.76, 0.35, 0.49, 0.11, 0.89, 0.92, 0.68, 0.93, 0.36, 0.93, 0.32], inf).asStream,

				// timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
				decay: \hold,

				// decay: Pseq([0.5, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
				// decay: \gauss,
				morph: Pseq([0.24, 0.32, 0.57, 0.42, 0.37, 0.22, 0.07, 0.51, 0.03, 0.44, 0.88], inf).asStream,

				// morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
				harm: \hold,

				// harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
				lpgColour: \hold,

				// lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
				engine: Pseq(["e", "e", "(e-5).mod(16)", "e", "e", "(e-6).mod(16)"], inf).asStream,
				// duration: \gauss,

				duration: Pseq([Rest(0.5), 1.0, 0.25, Rest(0.25), 0.75, 0.5, Rest(0.75), Rest(0.75)], inf).asStream,

				// duration: Pseq([
				// 0.7,
				// Pwrand([0.7, Rest(0.7)], [0.9, 0.1].normalizeSum),
				// 0.7,
				// Pwrand([0.7, Rest(1.4)], [0.95, 0.05].normalizeSum),
				// 0.7,
				// Pwrand([1.4, 0.7], [0.6, 0.4].normalizeSum),
				// ], inf).asStream,
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
			(cloudsSend: 0.21, decay: 0.8, decayMod: 0.0, delaySend: 0.17, distAmount: 0.11, distDrive: 0.07, droneMode: 1.0, dur: 1.5, engine: 4.0, fmMod: 0.01, harm: 0.88, harmMod: 0.0, legato: 0.58, lpgColour: 0.57, morph: 0.84, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 20.0, pitchMod: 0.5, revDamp: 0.8, revDrywet: 0.18, revFreeze: 0.0, revHp: 0.7, revTime: 0.11, reverbSend: 0.29, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 355.72, timbMod: 0.0, timbre: 0.58, volume: 0.25, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: Pseq([0.75, 0.5, 0.75, 1.0, Rest(0.75), Rest(0.5), Rest(0.5), 1.0, 0.25, Rest(0.5), 1.0, 0.25, 0.5, Rest(1.0), 0.75], inf).asStream,

				// duration: Pseq([
				// 0.7,
				// Rest(0.7),
				// Rest(0.7),
				// Rest(0.7),
				// ], inf).asStream,
				div: Pseq([0.5], inf).asStream,
				timbre: \hold,
				morph: \hold,
				pitch: \hold,

				// pitch: Pseq([5, -7, 7, -7, -12, -5, 12, -12, -5, 12, -5, -5], inf).asStream,
				lpgColour: Pseq([0.96, 0.21, 0.89, 0.49, 0.61, 0.16, 0.08, 0.86, 0.88, 0.51, 0.14, 0.34, 0.34, 0.39, 0.01], inf).asStream,
				decay: Pseq([0.06, 0.43, 0.29, 0.08, 0.25, 0.6, 0.31, 0.31, 0.75, 0.03], inf).asStream,
				fmMod: Pseq([0.46, 0.15, 0.19, 0.04, 0.44, 0.94, 0.65, 0.64, 0.96, 0.26, 0.3, 0.12, 0.47, 0.03, 0.34, 0.28], inf).asStream,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.2, decay: 0.38, decayMod: 0.25, delaySend: 0.13, distAmount: 0.01, distDrive: 0.07, droneMode: 1.0, dur: 2.0, engine: 12.0, fmMod: -0.26, harm: 0.08, harmMod: 0.0, legato: 8.98, lpgColour: 0.18, morph: 0.4, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 52.0, pitchMod: 0.0, revDamp: 0.4, revDrywet: 0.38, revFreeze: 0.0, revHp: 0.4, revTime: 0.35, reverbSend: 0.2, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 355.72, timbMod: 0.38, timbre: 0.34, volume: 1.11, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: Pseq([Rest(0.5), Rest(1.0), Rest(1.0), 0.5, Rest(0.75), 1.0, 0.75, 1.0, 0.75], inf).asStream,

				// duration: Pseq([
				// 0.7,
				// Rest(0.7),
				// Rest(0.7),
				// Pwrand([Rest(1.4), 0.7], [0.5, 0.5].normalizeSum),
				// ], inf).asStream,
				div: Pseq([0.5], inf).asStream,
				harm: Pseq([0.12, 0.06, 0.28, 0.44], inf).asStream,
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
			(atk: 0.26, bankName: 'msp-form-msp6', cloudsSend: 0.85, decay: 0.11, delaySend: 0.17, distAmount: 0.21, distDrive: 0.07, dur: Rest(1.0), legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.13, phaseOffset: 0.5, rate: 3.32, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.55, revFreeze: 0.0, revHp: 0.7, revTime: 1.06, reverbSend: 0.51, speed: 1.0, startPos: 0.13, tempo: 355.72, variant: 0.0, volume: 0.74, volumeMod: 0.24),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: Pseq([0.5, 1.5, 0.66666666666667, 0.66666666666667, 2, 1, 2, 1, 0.5, 0.5, 1, 1, 0.5], inf).asStream,
				mul: \unit,
				duration: \backbeat,
				startPos: Pseq([0.99, 0.87, 0.95, 0.64, 0.71, 0.52], inf).asStream,
				decay: Pseq([0.47, 0.36, 0.42, 0.64], inf).asStream,
				panDur: Pseq([0.22, 0.22, 0.4, 0.28, 0.42, 0.68, 0.59, 0.38, 0.84], inf).asStream,
				revHp: Pseq([0.3, 0.95, 0.01, 0.24, 0.96, 0.77, 0.36, 0.15, 0.86, 0.5, 0.3], inf).asStream,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.14, bankName: 'msp-iris-hits', cloudsSend: 0.08, decay: 0.71, delaySend: 0.16, distAmount: 0.04, distDrive: 0.09, dur: 1.0, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.33, phaseOffset: 0.0, rate: 1.95, rateMod: 0.23, revDamp: 0.8, revDrywet: 0.38, revFreeze: 0.0, revHp: 0.32, revTime: 0.2, reverbSend: 0.25, speed: 1.0, startPos: 0.26, tempo: 355.72, variant: 7.0, volume: 1.53, volumeMod: 0.22),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \hold,
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
			(atk: 0.2, bankName: 'breathing', cloudsSend: 0.14, decay: 0.1, delaySend: 0.09, distAmount: 0.02, distDrive: 0.03, dur: 1.0, legato: 8.72, mul: 1.0, mute: 0.0, panDur: 0.16, phaseOffset: 0.0, rate: 1.57, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.37, revFreeze: 0.0, revHp: 0.18, revTime: 0.28, reverbSend: 0.22, speed: 1.0, startPos: 0.48, tempo: 355.72, variant: 0.0, volume: 1.15, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \hold,
				mul: \unit,
				duration: Pseq([1.0, 0.5, 0.25, 0.25, 1.0, 0.25, 0.25, Rest(0.5)], inf).asStream,
				startPos: Pseq([0.47, 0.55, 0.74, 0.67, 0.39, 0.72, 0.02, 0.45, 0.17, 0.43, 0.9, 0.61, 0.45, 0.54], inf).asStream,
				decay: Pseq([0.53, 0.07, 0.49, 1.0, 0.47, 0.25, 0.54, 0.7], inf).asStream,
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
	clouds: (blend: 0.5, density: 0.7, feedback: 0.5, freeze: 0.0, inGain: 1.0, lofi: 0.0, mix: 1.0, mode: 3.0, pitch: 0.5, position: 0.5, reverb: 0.43, size: 0.5, spread: 0.5, texture: 0.5, volume: 0.59),
	delay: (feedback: 0.5, filterFreq: 4950.37, spread: 1.5, time: 0.25),
	reverb: (damp: 0.6, diffuse: 0.63, freeze: 1.0, hp: 0.3, time: 0.48)
),
	// $PRESET_FX_END
);

~states = Pseq([\a, \b, \c, \d], inf).asStream;
~state = ~states.next;
~playCount = 0;
~tempoClock.tempo = ~dreads.synths[0].tempo/60;

// $LFO_SOURCES_START
~dreads.lfoSources = (
	lfo1: (freq: 0.99130157232285, shape: 3), // plaits 0 timbre
	lfo2: (freq: 0.49869943261147, shape: 1), // plaits 0 morph
	lfo3: (freq: 1.8726246953011, shape: 3, base: true), // plaits 0 decay
	lfo4: (freq: 0.78149929046631, shape: 4), // plaits 0 pitch
	lfo5: (freq: 0.96777085661888, shape: 2), // plaits 0 volume
	lfo6: (freq: 0.56505540013313, shape: 1, base: true), // plaits 0 harm
	lfo7: (freq: 3.8817498981953, base: true), // plaits 1 timbre
	lfo8: (freq: 1.0521421909332, shape: 3), // plaits 1 morph
	lfo9: (freq: 2.7506037950516, shape: 1, base: true), // plaits 1 decay
	lfo10: (freq: 0.35719493031502, shape: 3, base: true), // plaits 1 pitch
	lfo11: (freq: 0.27801533341408, shape: 2), // plaits 1 volume
	lfo12: (freq: 0.56963884830475, shape: 1, base: true), // plaits 1 harm
	lfo13: (freq: 0.39001954197884, shape: 2), // plaits 2 timbre
	lfo14: (freq: 0.77652478218079, base: true), // plaits 2 morph
	lfo15: (freq: 2.9668837189674, shape: 1, base: true), // plaits 2 decay
	lfo16: (freq: 1.2341463506222, shape: 2), // plaits 2 pitch
	lfo17: (freq: 1.6870292425156, shape: 2, base: true), // plaits 2 volume
	lfo18: (freq: 0.43615648150444, shape: 1, base: true), // plaits 2 harm
	lfo19: (freq: 1.2469878077507, shape: 2), // sample 0 rate
	lfo20: (freq: 0.26795094013214, shape: 1), // sample 0 volume
	lfo21: (freq: 1.0239535927773), // sample 1 rate
);
// $LFO_SOURCES_END

~applyPatch.();
)
