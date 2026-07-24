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
			(cloudsSend: 0.0, decay: 0.5, decayMod: 0.3, delaySend: 0.1, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 0.35, engine: 1.0, fmMod: 0.0, harm: 0.48, harmMod: 0.0, legato: 9.0, lpgColour: 0.5, morph: 0.43, morphMod: 0.4, mul: 0.5, mute: 1.0, phaseOffset: 0.0, pitch: 49.0, pitchMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.1, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 80.0, timbMod: 0.3, timbre: 0.44, volume: 1.05, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
				decay: Pseq([0.5, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
				// decay: \gauss,
				morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
				harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
				lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
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
			(cloudsSend: 0.0, decay: 0.8, decayMod: 0.3, delaySend: 0.25, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 1.4, engine: 6.0, fmMod: 0.0, harm: 0.48, harmMod: 0.0, legato: 9.0, lpgColour: 0.5, morph: 0.43, morphMod: 0.12, mul: 0.5, mute: 1.0, phaseOffset: 0.0, pitch: 49.0, pitchMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.1, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 80.0, timbMod: 0.17, timbre: 0.44, volume: 1.0, volumeMod: 0.0),
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
				timbre: \sine,
				morph: \rndm_walk_slow,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.0, decay: 0.59, decayMod: 0.3, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(1.4), engine: 2.0, fmMod: 0.0, harm: 0.48, harmMod: 0.0, legato: 9.0, lpgColour: 0.5, morph: 0.43, morphMod: 0.4, mul: 0.5, mute: 1.0, phaseOffset: 0.0, pitch: 49.0, pitchMod: 0.0, revDamp: 0.4, revDrywet: 0.7, revFreeze: 0.0, revHp: 0.4, revTime: 0.9, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 80.0, timbMod: 0.7, timbre: 0.44, volume: 0.9, volumeMod: 0.0),
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
			(atk: 0.44, bankName: 'msp-summer2026', cloudsSend: 0.0, decay: 0.06, delaySend: 0.15, distAmount: 0.14, distDrive: 0.04, dur: 1.0, legato: 6.43, mul: 1.0, mute: 0.0, panDur: 0.1, phaseOffset: 0.25, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.35, revFreeze: 0.0, revHp: 0.7, revTime: 0.84, reverbSend: 0.28, speed: 1.0, startPos: 0.37, tempo: 80.0, variant: 0.0, volume: 1.2, volumeMod: 0.22),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \hold,
				mul: \unit,
				duration: Pseq([1], inf).asStream,
				startPos: Pseq([0.23, 0.72, 0.31, 0.09, 0.46, 0.94, 0.09, 0.91, 0.72, 0.57, 0.84, 0.63, 0.32], inf).asStream,
				decay: \hold,

				// decay: Pseq([0.53, 0.73, 0.94, 0.89, 0.15, 0.36, 0.13, 0.64, 0.54, 0.98, 0.62, 0.75, 0.1, 0.66, 0.18, 0.94], inf).asStream,
				panDur: Pseq([0.89, 0.77, 0.42, 0.3, 0.36, 0.81, 0.56, 0.31, 0.36, 0.65, 0.03, 0.02, 0.19, 0.84], inf).asStream,
				revHp: Pseq([0.75, 0.72, 0.58, 0.99, 0.49, 0.11, 0.16, 0.68, 0.8, 0.99, 0.16, 0.9], inf).asStream,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 80.0, variant: 0.0, volume: 0.0, volumeMod: 0.0),
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
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 80.0, variant: 0.0, volume: 0.0, volumeMod: 0.0),
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
	reverb: (damp: 0.6, diffuse: 0.63, freeze: 0.0, hp: 0.3, time: 0.7)
),
	// $PRESET_FX_END
);

~states = Pseq([\a, \b, \c, \d], inf).asStream;
~state = ~states.next;
~playCount = 0;
~tempoClock.tempo = ~dreads.synths[0].tempo/60;

// $LFO_SOURCES_START
~dreads.lfoSources = (
	lfo1: (freq: 0.05), // plaits 0 timbre
	lfo2: (freq: 0.0665), // plaits 0 morph
	lfo3: (freq: 0.0165), // plaits 0 decay
	lfo6: (freq: 0.05), // plaits 0 harm
	lfo7: (freq: 0.0665), // plaits 1 timbre
	lfo8: (freq: 0.0165), // plaits 1 morph
	lfo11: (freq: 0.05), // plaits 1 volume
	lfo12: (freq: 0.0665), // plaits 1 harm
	lfo13: (freq: 0.0165), // plaits 2 timbre
);
// $LFO_SOURCES_END

~applyPatch.();
)
