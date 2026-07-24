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
			(cloudsSend: 0.11, decay: 0.65, decayMod: 0.0, delaySend: 0.16, distAmount: 0.1, distDrive: 0.14, droneMode: 1.0, dur: 0.35, engine: 22.0, fmMod: 0.24, harm: 0.29, harmMod: 0.3, legato: 2.4, lpgColour: 0.32, morph: 0.62, morphMod: 0.2, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 43.0, pitchMod: 0.43, revDamp: 0.8, revDrywet: 0.24, revFreeze: 0.0, revHp: 0.7, revTime: 0.58, reverbSend: 0.06, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 127.72, timbMod: 0.42, timbre: 0.6, volume: 1.13, volumeMod: 0.0),
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
			(cloudsSend: 0.26, decay: 0.51, decayMod: 0.0, delaySend: 0.05, distAmount: 0.27, distDrive: 0.25, droneMode: 1.0, dur: Rest(1.4), engine: 6.0, fmMod: -0.27, harm: 0.87, harmMod: 0.38, legato: 1.82, lpgColour: 0.7, morph: 0.5, morphMod: 0.41, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 40.0, pitchMod: 0.35, revDamp: 0.8, revDrywet: 0.27, revFreeze: 0.0, revHp: 0.7, revTime: 0.53, reverbSend: 0.27, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 127.72, timbMod: 0.0, timbre: 0.62, volume: 0.42, volumeMod: 0.2),
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
			(cloudsSend: 0.15, decay: 0.15, decayMod: 0.0, delaySend: 0.11, distAmount: 0.03, distDrive: 0.19, droneMode: 1.0, dur: Rest(2.8), engine: 23.0, fmMod: 0.04, harm: 0.18, harmMod: 0.0, legato: 2.14, lpgColour: 0.79, morph: 0.36, morphMod: 0.3, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 41.0, pitchMod: 0.0, revDamp: 0.4, revDrywet: 0.23, revFreeze: 0.0, revHp: 0.4, revTime: 0.35, reverbSend: 0.15, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 127.72, timbMod: 0.0, timbre: 0.9, volume: 0.16, volumeMod: 0.0),
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
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.57, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.5, rate: 4.28, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 127.72, variant: 0.0, volume: 1.01, volumeMod: 0.0),
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
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 127.72, variant: 0.0, volume: 0.0, volumeMod: 0.0),
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
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 127.72, variant: 0.0, volume: 0.0, volumeMod: 0.0),
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
	lfo1: (freq: 1.9266761243343, shape: 3, base: true), // plaits 0 timbre
	lfo2: (freq: 0.42536686658859, shape: 4), // plaits 0 morph
	lfo3: (freq: 3.8507788777351, shape: 1, base: true), // plaits 0 decay
	lfo4: (freq: 0.49816496968269, shape: 3), // plaits 0 pitch
	lfo5: (freq: 1.1439403474331), // plaits 0 volume
	lfo6: (freq: 0.30828854441643), // plaits 0 harm
	lfo7: (freq: 0.33466213941574, shape: 1, base: true), // plaits 1 timbre
	lfo8: (freq: 0.80136829614639, shape: 3, base: true), // plaits 1 morph
	lfo9: (freq: 2.0830207467079, base: true), // plaits 1 decay
	lfo10: (freq: 2.8531719148159, base: true), // plaits 1 pitch
	lfo11: (freq: 1.4835450410843), // plaits 1 volume
	lfo12: (freq: 1.923793643713, base: true), // plaits 1 harm
	lfo13: (freq: 0.52943519949913, shape: 1), // plaits 2 timbre
	lfo14: (freq: 0.34912137389183, shape: 3), // plaits 2 morph
	lfo15: (freq: 1.1611110925674), // plaits 2 decay
	lfo16: (freq: 1.1030039787292), // plaits 2 pitch
	lfo17: (freq: 1.3776795506477, shape: 3), // plaits 2 volume
	lfo18: (freq: 1.0471799135208), // plaits 2 harm
);
~base = 0.14699999988079;
// $LFO_SOURCES_END

~applyPatch.();
)
