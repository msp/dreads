////////////////////////////////////////////////////////////////////////////////
// FM Patch Preview Preset
// PLAITS1 configured for clean FM auditioning — load this, then run fm-patches.scd
////////////////////////////////////////////////////////////////////////////////
(
~dreads = ~patchFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.2, decay: 0.82, decayMod: 0.49, delaySend: 0.13, distAmount: 0.03, distDrive: 0.26, droneMode: 0.0, dur: 0.5, engine: 6.0, fmMod: -0.06, harm: 0.61, harmMod: 0.0, legato: 8.0, lpgColour: 0.59, morph: 0.19, morphMod: 0.36, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 47.0, pitchMod: 0.47, revDamp: 0.58, revDrywet: 0.28, revFreeze: 0.0, revHp: 0.14, revTime: 0.4, reverbSend: 0.18, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 114.01, timbMod: 0.0, timbre: 0.45, volume: 0.83, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \hold,
				div: \unit,
				delaySend: \hold,
				cloudsSend: \hold,
				revDrywet: \hold,
				harm: \hold,
				pitch: \hold,
				morph: \hold,
				timbre: \hold,
				volume: Pseq([0.45, 0.02, 0.43, 0.66, 0.27, 0.4, 0.92, 0.85, 0.95], inf).asStream,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.28, decay: 0.42, decayMod: 0.0, delaySend: 0.21, distAmount: 0.0, distDrive: 0.0, droneMode: 1.0, dur: 2.0, engine: 20.0, fmMod: -0.02, harm: 0.11, harmMod: 0.0, legato: 15.0, lpgColour: 0.5, morph: 0.72, morphMod: 0.81, mul: 0.5, mute: 1.0, phaseOffset: -0.5, pitch: 0.0, pitchMod: 0.0, revDamp: 0.04, revDrywet: 0.78, revFreeze: 0.0, revHp: 0.47, revTime: 0.84, reverbSend: 1.0, sendToPhones: 0.0, speed: 0.5, stereoMode: 1.0, tempo: 114.01, timbMod: 0.0, timbre: 0.57, volume: 0.93, volumeMod: 0.5),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: \unit,
				duration: \sync_1,
				pitch: \hold,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.0, decay: 0.23, decayMod: 0.0, delaySend: 0.19, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 0.33, engine: 19.0, fmMod: 0.0, harm: 0.64, harmMod: 0.0, legato: 9.0, lpgColour: 0.5, morph: 0.31, morphMod: 0.34, mul: 0.5, mute: 1.0, phaseOffset: -0.25, pitch: 42.0, pitchMod: 0.0, revDamp: 0.69, revDrywet: 0.06, revFreeze: 0.0, revHp: 0.94, revTime: 0.88, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.5, stereoMode: 1.0, tempo: 114.01, timbMod: 0.61, timbre: 0.3, volume: 0.68, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: \unit,
				duration: \hold,
				pitch: \triad_min_inv,
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
			(atk: 0.0, bankName: 'numbers', cloudsSend: 0.0, decay: 0.03, delaySend: 0.49, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.1, phaseOffset: 0.0, rate: 1.87, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.0, revTime: 0.92, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 114.01, variant: 0.0, volume: 0.9, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \hold,
				mul: \unit,
				duration: \unit,
				startPos: \hold,
				distAmount: \hold,
				decay: \sine_slow,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.0, bankName: 'KICKS', cloudsSend: 0.0, decay: 1.0, delaySend: 0.47, distAmount: 0.31, distDrive: 0.0, dur: 2.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 0.5, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.69, revFreeze: 0.0, revHp: 0.0, revTime: 0.64, reverbSend: 0.0, speed: 0.5, startPos: 0.0, tempo: 114.01, variant: 3.0, volume: 1.33, volumeMod: 0.0),
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
			(atk: 0.0, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.6, revFreeze: 0.0, revHp: 0.09, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 114.01, variant: 0.0, volume: 0.73, volumeMod: 0.0),
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
	clouds: (blend: 0.26, density: 0.93, feedback: 0.41, freeze: 0.0, inGain: 1.0, lofi: 0.0, mix: 1.0, mode: 3.0, pitch: 1.92, position: 0.69, reverb: 0.55, size: 0.27, spread: 0.5, texture: 0.59, volume: 0.73),
	delay: (feedback: 0.56, filterFreq: 2816.21, spread: 1.5, time: 0.55),
	reverb: (damp: 0.6, diffuse: 0.63, freeze: 0.0, hp: 0.23, time: 0.87)
),
	// $PRESET_FX_END
);

~states = Pseq([\a, \b, \c, \d], inf).asStream;
~state = ~states.next;
~playCount = 0;
~tempoClock.tempo = ~dreads.synths[0].tempo/60;


// ~drones[0].set(\volumeMod, 0.0);
// ~drones[0].set(\pitchMod, 0.6);


// ~dreads.samples[0].volume = 0.9;
// ~dreads.samples[0][\volumeMod] = 0.9;
// ~dreads.samples[0][\rateMod] = 0.9;
//
// ~dreads.synths[0][\volume] = 0.8;
// ~dreads.synths[0].volume = 0.3;


// $LFO_SOURCES_START
~dreads.lfoSources = (
	lfo1: (freq: 1.2027657926083, base: true), // plaits 0 timbre
	lfo2: (freq: 0.43897475600243), // plaits 0 morph
	lfo3: (freq: 0.35267585515976, shape: 1, base: true), // plaits 0 decay
	lfo4: (freq: 1.3978391051292, shape: 4), // plaits 0 pitch
	lfo5: (freq: 2.471617847681, base: true), // plaits 0 volume
	lfo6: (freq: 1.4637019813061, shape: 2), // plaits 0 harm
	lfo8: (freq: 0.16666666666667), // plaits 1 morph
	lfo11: (freq: 0.2), // plaits 1 volume
	lfo13: (freq: 0.16666666666667), // plaits 2 timbre
	lfo14: (freq: 1), // plaits 2 morph
	lfo15: (freq: 6), // plaits 2 decay
	lfo16: (freq: 0.33333333333333, shape: 4), // plaits 2 pitch
	lfo17: (freq: 1), // plaits 2 volume
	lfo19: (freq: 10.567001342773, shape: 1), // sample 0 rate
	lfo21: (freq: 0.083333333333333), // sample 1 rate
);
~base = 1.2029999494553;
// $LFO_SOURCES_END

// ~base = 0.5;
// ~dreads.lfoSources[\lfo1].freq = ~base + 0.04;
// ~dreads.lfoSources[\lfo4].freq = ~base + 0.03;
// ~dreads.lfoSources[\lfo5].freq = ~base;
// ~dreads.lfoSources[\lfo5].freq = ~base/5;

~applyPatch.();
)

