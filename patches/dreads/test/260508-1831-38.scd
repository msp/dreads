////////////////////////////////////////////////////////////////////////////////
// Dreads Patch with global FX
////////////////////////////////////////////////////////////////////////////////
(
~dreads = ~patchFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.0, decay: 0.5, decayMod: 0.3, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 1.0, engine: 13.0, fmMod: 0.47, harm: 0.6, legato: 0.05, lpgColour: 0.5, morph: 0.46, morphMod: 0.75, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 31.71, pitchMod: 0.0, revDamp: 0.8, revDrywet: 0.2, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.08, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 120.0, timbMod: 0.0, timbre: 0.31, volume: 1.38, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: Pseq([1], inf).asStream,
				duration: \four_floor,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.1, decay: 0.23, decayMod: 0.3, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(0.5), engine: 15.0, fmMod: 0.0, harm: 0.66, legato: 9.0, lpgColour: 0.5, morph: 0.16, morphMod: 0.26, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 93.78, pitchMod: 0.0, revDamp: 0.8, revDrywet: 0.58, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 120.0, timbMod: 0.67, timbre: 0.37, volume: 0.51, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: Pseq([0.5], inf).asStream,
				// duration: \hold,
				duration: \offbeat,
				// duration: Pseq([Rest(1/4), 1/4], inf).asStream,
				div: \unit,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.0, decay: 0.19, decayMod: 0.1, delaySend: 0.17, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(2.0), engine: 18.0, fmMod: 0.0, harm: 0.17, legato: 9.0, lpgColour: 0.5, morph: 0.44, morphMod: 0.74, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 39.0, pitchMod: 1.0, revDamp: 0.4, revDrywet: 0.01, revFreeze: 0.0, revHp: 0.4, revTime: 0.37, reverbSend: 0.1, sendToPhones: 0.0, speed: 0.5, stereoMode: 1.0, tempo: 120.0, timbMod: 0.07, timbre: 0.54, volume: 0.78, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: Pseq([1], inf).asStream,
				duration: \backbeat,
				delaySend: \gate_every8,
				cloudsSend: \swell_4,
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
			(atk: 0.0, bankName: 'CLAPS', cloudsSend: 0.0, decay: 0.19, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 2.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.05, rateMod: 0.0, revDamp: 0.55, revDrywet: 0.4, revFreeze: 0.0, revHp: 0.33, revTime: 0.48, reverbSend: 0.2, speed: 1.0, startPos: 0.0, tempo: 120.0, variant: 2.0, volume: 0.33, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				duration: Pseq([2], inf).asStream,
				reverbSend: \gate_every4,
				div: \unit,
				rate: \unit,
				mul: \unit,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 120.0, variant: 0.0, volume: 0.0, volumeMod: 0.0),
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
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 120.0, variant: 0.0, volume: 0.0, volumeMod: 0.0),
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
	clouds: (blend: 0.5, density: 0.7, feedback: 0.0, freeze: 0.0, inGain: 1.0, lofi: 0.0, mix: 1.0, mode: 3.0, pitch: 0.5, position: 0.5, reverb: 0.24, size: 0.5, spread: 0.5, texture: 0.5, volume: 1.0),
	delay: (feedback: 0.48, filterFreq: 1234.11, spread: 1.5, time: 0.5),
	reverb: (damp: 0.27, diffuse: 0.56, freeze: 0.0, hp: 0.41, time: 0.36)
),
	// $PRESET_FX_END
);

~states = Pseq([\a, \b, \c, \d], inf).asStream;
~state = ~states.next;
~playCount = 0;

~tempoClock.tempo = ~dreads.synths[0].tempo/60;

// $LFO_SOURCES_START
~dreads.lfoSources = (
	lfo2: (freq: 0.5), // plaits 0 morph
	lfo3: (freq: 1), // plaits 0 decay
	lfo7: (freq: 0.5), // plaits 1 morph
	lfo8: (freq: 1), // plaits 1 decay
	lfo10: (freq: 3.5), // plaits 1 volume
	lfo11: (freq: 0.5), // plaits 2 timbre
	lfo12: (freq: 2), // plaits 2 morph
	lfo13: (freq: 0.0), // plaits 2 decay
	lfo14: (freq: 2, shape: 5, width: 0.5), // plaits 2 pitch
);
// $LFO_SOURCES_END

~applyPatch.();
)
// 