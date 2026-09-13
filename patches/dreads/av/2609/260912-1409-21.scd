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
			(amDepth: 0.39, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.05, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 1.0, decayMod: 0.0, delaySend: 0.35, distAmount: 0.0, distDrive: 0.0, droneMode: 1.0, dur: 0.5, engine: 18.0, fmMod: 0.27, harm: 0.63, harmMod: 0.0, legato: 8.0, lpgColour: 0.5, morph: 0.77, morphMod: 0.82, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 40.2, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.58, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.14, revTime: 0.82, reverbSend: 0.5, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 120.0, timbMod: 0.0, timbre: 0.73, volume: 1.33, volumeMod: 1.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \hold,
				div: \unit,
				delaySend: \sine_slow,
				cloudsSend: \gate_prob20,
				revDrywet: \hold,
				harm: \hold,
				pitch: \hold,
				morph: \hold,
				timbre: \hold,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.2, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.28, decay: 0.42, decayMod: 0.0, delaySend: 0.21, distAmount: 0.0, distDrive: 0.0, droneMode: 1.0, dur: 1.0, engine: 20.0, fmMod: -0.02, harm: 0.11, harmMod: 0.0, legato: 15.0, lpgColour: 0.5, morph: 0.72, morphMod: 0.81, mul: 0.5, mute: 0.0, phaseOffset: -0.5, pitch: 39.0, pitchMod: 0.42, releaseTime: 1.0, revDamp: 0.57, revDrywet: 0.72, revFreeze: 0.0, revHp: 0.47, revTime: 0.63, reverbSend: 1.0, sendToPhones: 0.0, speed: 0.5, stereoMode: 1.0, tempo: 120.0, timbMod: 0.97, timbre: 0.41, volume: 0.08, volumeMod: 1.0),
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
			(amDepth: 0.0, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.1, decay: 0.46, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.18, droneMode: 1.0, dur: Rest(1.0), engine: 22.0, fmMod: -0.04, harm: 0.29, harmMod: 0.46, legato: 9.0, lpgColour: 0.95, morph: 0.94, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 61.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.69, revDrywet: 0.05, revFreeze: 0.0, revHp: 0.94, revTime: 0.42, reverbSend: 0.29, sendToPhones: 0.0, speed: 0.5, stereoMode: 1.0, tempo: 120.0, timbMod: 0.56, timbre: 0.69, volume: 0.14, volumeMod: 1.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: \unit,
				duration: \offbeat,
				pitch: \hold,

				// pitch: Pseq([5, 3, 7, -12, -12], inf).asStream,
				amRatio: Pseq([0.92, 0.09, 0.44, 0.64, 0.52, 0.8, 0.7], inf).asStream,

				// amRatio: Pseq([0.92, 0.09, 0.44, 0.64, 0.52, 0.8, 0.7], inf).asStream,

				// amRatio: Pseq([0.92, 0.09, 0.44, 0.64, 0.52, 0.8, 0.7], inf).asStream,

				// amRatio: Pseq([0.17, 0.33, 0.18, 0.8, 0.54, 0.24, 0.96, 0.6, 0.08, 0.47], inf).asStream,
				morph: \hold,

				// morph: Pseq([0.04, 0.11, 0.37, 0.68, 0.18, 0.05, 0.05, 0.67, 0.97, 0.43, 0.84, 0.98, 0.93, 0.82], inf).asStream,
				lpgColour: \hold,

				// lpgColour: Pseq([0.46, 0.27, 0.49, 0.35, 0.92, 0.71, 0.09, 0.52, 0.27, 0.39, 0.87], inf).asStream,

				// lpgColour: Pseq([0.46, 0.27, 0.49, 0.35, 0.92, 0.71, 0.09, 0.52, 0.27, 0.39, 0.87], inf).asStream,
				delaySend: \sine_slow,
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
			(atk: 0.08, bankName: 'halfmastv6', cloudsSend: 0.0, decay: 0.64, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 4.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.1, phaseOffset: 0.0, rate: 0.63, rateMod: 0.2, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.0, revTime: 0.92, reverbSend: 0.14, speed: 0.25, startPos: 0.49, tempo: 120.0, variant: 10.0, volume: 0.9, volumeMod: 0.0),
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
			(atk: 0.0, bankName: 'KICKS', cloudsSend: 0.0, decay: 1.0, delaySend: 0.47, distAmount: 0.31, distDrive: 0.0, dur: 2.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 0.5, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.69, revFreeze: 0.0, revHp: 0.0, revTime: 0.64, reverbSend: 0.0, speed: 0.5, startPos: 0.0, tempo: 120.0, variant: 3.0, volume: 1.33, volumeMod: 0.0),
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
			(atk: 0.0, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.6, revFreeze: 0.0, revHp: 0.09, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 120.0, variant: 0.0, volume: 0.82, volumeMod: 0.0),
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
	delay: (feedback: 0.48, filterFreq: 6119.04, spread: 1.5, time: 0.55),
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
	lfo1: (freq: 1.2, shape: 2, base: true), // plaits 0 timbre
	lfo2: (freq: 3.460000038147, base: true), // plaits 0 morph
	lfo3: (freq: 0.16666666666667), // plaits 0 decay
	lfo4: (freq: 1.2, shape: 3), // plaits 0 pitch
	lfo5: (freq: 1.4199999570847, base: true), // plaits 0 volume
	lfo6: (freq: 1.0), // plaits 0 harm
	lfo7: (freq: 2.382776260376, shape: 2, base: true), // plaits 1 timbre
	lfo8: (freq: 0.2285420447588), // plaits 1 morph
	lfo10: (shape: 4), // plaits 1 pitch
	lfo11: (freq: 0.10000000149012, base: true), // plaits 1 volume
	lfo13: (freq: 1.0002888441086, base: true), // plaits 2 timbre
	lfo14: (freq: 1.3347273647785, shape: 4), // plaits 2 morph
	lfo15: (freq: 3.1148696839809, base: true), // plaits 2 decay
	lfo16: (freq: 2.6335329711437, shape: 3, base: true), // plaits 2 pitch
	lfo17: (freq: 0.050000000745058), // plaits 2 volume
	lfo18: (freq: 1.0, shape: 3, base: true), // plaits 2 harm
	lfo19: (freq: 0.083333333333333), // sample 0 rate
	lfo21: (freq: 0.083333333333333), // sample 1 rate
	lfo27: (freq: 1.1066809177399), // plaits 2 amRing
	lfo28: (freq: 12.638051986694, shape: 4, base: true), // plaits 0 amDepth
	lfo30: (freq: 1.0710116624832, shape: 3, base: true), // plaits 2 amDepth
	lfo33: (freq: 0.47607775330544), // plaits 2 amRatio
);
~base = 3.2000000476837;
// $LFO_SOURCES_END

~applyPatch.();

)

   