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
			(cloudsSend: 0.0, decay: 0.4, decayMod: 0.0, delaySend: 0.07, distAmount: 0.1, distDrive: 0.15, droneMode: 1.0, dur: 0.5, engine: 23.0, fmMod: -0.01, harm: 0.31, harmMod: 0.0, legato: 8.0, lpgColour: 0.63, morph: 0.28, morphMod: 0.53, mul: 0.5, mute: 0.0, phaseOffset: 0.75, pitch: 56.0, pitchMod: 0.0, revDamp: 0.88, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.0, revTime: 0.46, reverbSend: 0.36, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 80.0, timbMod: 0.2, timbre: 0.86, volume: 0.34, volumeMod: 0.0),
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
				reverbSend: \sine_slow,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.0, decay: 0.04, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 1.0, dur: 1.0, engine: 19.0, fmMod: -0.02, harm: 0.48, harmMod: 0.0, legato: 15.0, lpgColour: 0.5, morph: 0.66, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: -0.25, pitch: 52.0, pitchMod: 0.0, revDamp: 0.27, revDrywet: 0.51, revFreeze: 0.0, revHp: 0.0, revTime: 0.84, reverbSend: 0.42, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 80.0, timbMod: 0.64, timbre: 0.2, volume: 0.78, volumeMod: 1.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: \unit,
				duration: \four_floor,
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
			(cloudsSend: 0.0, decay: 0.76, decayMod: 0.92, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 1.0, dur: 0.5, engine: 6.0, fmMod: 0.0, harm: 0.78, harmMod: 0.0, legato: 9.0, lpgColour: 0.57, morph: 0.53, morphMod: 0.06, mul: 0.5, mute: 0.0, phaseOffset: -0.25, pitch: 52.0, pitchMod: 0.0, revDamp: 0.49, revDrywet: 0.6, revFreeze: 0.0, revHp: 0.48, revTime: 0.88, reverbSend: 0.27, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 80.0, timbMod: 0.23, timbre: 0.32, volume: 0.84, volumeMod: 0.94),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: \unit,
				duration: \hold,
				pitch: \hold,
				delaySend: \gate_every16,
				revDrywet: \sine_slow,
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
			(atk: 0.08, bankName: 'halfmastv6', cloudsSend: 0.04, decay: 0.64, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 4.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.1, phaseOffset: 0.0, rate: 0.63, rateMod: 0.2, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.0, revTime: 0.92, reverbSend: 0.14, speed: 0.25, startPos: 0.49, tempo: 80.0, variant: 10.0, volume: 0.56, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \hold,
				mul: \unit,
				duration: \unit,
				startPos: \rndm_walk_slow,
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
			(atk: 0.0, bankName: 'KICKS', cloudsSend: 0.0, decay: 1.0, delaySend: 0.25, distAmount: 0.31, distDrive: 0.0, dur: 10.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 0.5, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.69, revFreeze: 0.0, revHp: 0.0, revTime: 0.64, reverbSend: 0.0, speed: 0.1, startPos: 0.0, tempo: 80.0, variant: 3.0, volume: 1.34, volumeMod: 0.0),
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
			(atk: 0.07, bankName: 'SoundFX', cloudsSend: 0.0, decay: 0.01, delaySend: 0.12, distAmount: 0.16, distDrive: 0.0, dur: 0.44, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.16, phaseOffset: 0.0, rate: 2.1, rateMod: 0.88, revDamp: 0.62, revDrywet: 0.92, revFreeze: 0.0, revHp: 0.98, revTime: 0.55, reverbSend: 0.69, speed: 1.0, startPos: 0.28, tempo: 80.0, variant: 17.0, volume: 0.22, volumeMod: 0.96),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \hold,
				mul: \unit,
				duration: \gauss,
				startPos: \sine_slow,
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
	reverb: (damp: 0.26, diffuse: 0.63, freeze: 0.0, hp: 0.49, time: 0.51)
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
	lfo1: (freq: 0.31658712029457, shape: 2), // plaits 0 timbre
	lfo2: (freq: 1.56, shape: 4, base: true), // plaits 0 morph
	lfo3: (freq: 1.4028999090195, shape: 3), // plaits 0 decay
	lfo4: (freq: 1.2, shape: 3, base: true), // plaits 0 pitch
	lfo5: (freq: 1.2, base: true), // plaits 0 volume
	lfo6: (freq: 0.29716300368309), // plaits 0 harm
	lfo7: (base: true), // plaits 1 timbre
	lfo8: (freq: 0.16666666666667), // plaits 1 morph
	lfo11: (freq: 0.30000001192093, base: true), // plaits 1 volume
	lfo13: (freq: 0.050000000745058, shape: 4, base: true), // plaits 2 timbre
	lfo14: (freq: 0.30000001192093, shape: 4, base: true), // plaits 2 morph
	lfo15: (freq: 4.5783667564392, shape: 4), // plaits 2 decay
	lfo16: (freq: 0.33333333333333, shape: 4), // plaits 2 pitch
	lfo17: (freq: 0.20000000298023, base: true), // plaits 2 volume
	lfo19: (freq: 0.083333333333333), // sample 0 rate
	lfo21: (freq: 0.083333333333333), // sample 1 rate
);
~base = 1.9290000200272;
// $LFO_SOURCES_END

// ~base = 0.5;
// ~dreads.lfoSources[\lfo1].freq = ~base + 0.04;
// ~dreads.lfoSources[\lfo4].freq = ~base + 0.03;
// ~dreads.lfoSources[\lfo5].freq = ~base;
// ~dreads.lfoSources[\lfo5].freq = ~base/5;

~applyPatch.();


)

