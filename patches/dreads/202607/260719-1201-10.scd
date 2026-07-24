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
			(cloudsSend: 0.24, decay: 0.55, decayMod: 0.0, delaySend: 0.04, distAmount: 0.03, distDrive: 0.17, droneMode: 0.0, dur: 0.7, engine: 19.0, fmMod: -0.06, harm: 0.19, harmMod: 0.0, legato: 9.0, lpgColour: 0.81, morph: 0.04, morphMod: 0.11, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 45.0, pitchMod: 0.0, revDamp: 0.8, revDrywet: 0.05, revFreeze: 0.0, revHp: 0.7, revTime: 0.48, reverbSend: 0.21, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 165.0, timbMod: 0.0, timbre: 0.17, volume: 1.28, volumeMod: 0.0),
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
				volume: Pseq([0.65, 0.37, 0.02, 0.89, 0.19], inf).asStream,

				// volume: Pseq([0.65, 0.37, 0.02, 0.89, 0.19], inf).asStream,
				revDamp: Pseq([0.75, 0.01, 0.83, 0.86, 0.85, 0.77, 0.06, 0.65, 0.08, 0.85, 0.33, 0.38, 0.53, 0.24], inf).asStream,

				// revDamp: Pseq([0.75, 0.01, 0.83, 0.86, 0.85, 0.77, 0.06, 0.65, 0.08, 0.85, 0.33, 0.38, 0.53, 0.24], inf).asStream,
				pitch: Pseq([-5, 3, 12, 3], inf).asStream,

				// pitch: Pseq([-5, 3, 12, 3], inf).asStream,
				revHp: Pseq([0.2, 0.13, 0.42, 0.96, 0.87, 0.88, 0.09, 0.66, 0.7, 0.66, 0.11, 0.26, 0.92, 0.68, 0.14], inf).asStream,

				// revHp: Pseq([0.2, 0.13, 0.42, 0.96, 0.87, 0.88, 0.09, 0.66, 0.7, 0.66, 0.11, 0.26, 0.92, 0.68, 0.14], inf).asStream,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.0, decay: 0.26, decayMod: 0.3, delaySend: 0.25, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 1.4, engine: 10.0, fmMod: -0.2, harm: 0.32, harmMod: 0.0, legato: 9.0, lpgColour: 0.63, morph: 0.84, morphMod: 0.12, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 67.0, pitchMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.1, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 165.0, timbMod: 0.17, timbre: 0.38, volume: 1.0, volumeMod: 0.0),
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
			(cloudsSend: 0.0, decay: 0.73, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(1.4), engine: 18.0, fmMod: 0.01, harm: 0.28, harmMod: 0.0, legato: 9.0, lpgColour: 0.21, morph: 0.23, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 46.0, pitchMod: 0.0, revDamp: 0.4, revDrywet: 0.7, revFreeze: 0.0, revHp: 0.4, revTime: 0.9, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 165.0, timbMod: 0.46, timbre: 0.44, volume: 0.29, volumeMod: 0.0),
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
				lpgColour: Pseq([0.68, 0.31, 0.01, 0.46, 0.34, 0.79, 0.82, 0.56, 0.22, 0.96, 0.16, 0.31, 0.89, 0.91, 0.3], inf).asStream,
				harm: Pseq([0.78, 0.74, 0.41, 0.21, 1.0, 0.35, 0.14], inf).asStream,
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
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.57, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.5, rate: 4.28, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 165.0, variant: 0.0, volume: 1.01, volumeMod: 0.0),
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
	lfo1: (freq: 0.39254441261292, shape: 2), // plaits 0 timbre
	lfo2: (freq: 2.6301448941231, shape: 1, base: true), // plaits 0 morph
	lfo3: (freq: 0.8903634428978, shape: 1), // plaits 0 decay
	lfo4: (freq: 1.2612661957741, shape: 1), // plaits 0 pitch
	lfo5: (freq: 1.5941367447376, base: true), // plaits 0 volume
	lfo6: (freq: 3.4744005799294, base: true), // plaits 0 harm
	lfo7: (freq: 0.0665), // plaits 1 timbre
	lfo8: (freq: 0.0165), // plaits 1 morph
	lfo11: (freq: 0.05), // plaits 1 volume
	lfo12: (freq: 0.0665), // plaits 1 harm
	lfo13: (freq: 2.5609742999077, base: true), // plaits 2 timbre
	lfo14: (freq: 3.7639937698841, shape: 4, base: true), // plaits 2 morph
	lfo15: (freq: 2.9938578009605, shape: 2, base: true), // plaits 2 decay
	lfo16: (freq: 0.55554869174957, shape: 3), // plaits 2 pitch
	lfo17: (freq: 3.7121296823025, shape: 1, base: true), // plaits 2 volume
	lfo18: (freq: 0.40176476240158, shape: 2), // plaits 2 harm
);
// $LFO_SOURCES_END

~applyPatch.();
)
