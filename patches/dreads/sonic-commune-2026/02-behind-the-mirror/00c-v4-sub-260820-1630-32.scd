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
			(amDepth: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRing: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.16, decayMod: 0.0, delaySend: 0.37, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 0.33, engine: 19.0, fmMod: 0.0, harm: 0.64, harmMod: 0.0, legato: 9.0, lpgColour: 0.5, morph: 0.31, morphMod: 0.34, mul: 0.5, mute: 0.0, phaseOffset: -0.25, pitch: 42.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.69, revDrywet: 0.17, revFreeze: 0.0, revHp: 0.94, revTime: 0.88, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.5, stereoMode: 1.0, tempo: 114.01, timbMod: 0.34, timbre: 0.16, volume: 0.68, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: \unit,
				duration: \hold,
				pitch: \triad_min_inv,
				delaySend: \gate_every16,
				revDrywet: \sine_slow,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),
		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRing: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.12, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 2.0, engine: 13.0, fmMod: 0.27, harm: 0.45, harmMod: 0.0, legato: 8.0, lpgColour: 0.5, morph: 0.7, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: -0.25, pitch: 30.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.88, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.83, revTime: 0.82, reverbSend: 0.0, sendToPhones: 0.0, speed: 0.5, stereoMode: 0.0, tempo: 114.01, timbMod: 0.0, timbre: 0.6, volume: 1.18, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: \unit,
				// div: Pseq([1/4], inf).asStream,
				// duration: Pseq([1], inf).asStream,
				pitch: \hold,
				cloudsSend: \gate_prob20,
				delaySend: \gate_every8,
				revDrywet: \sweep_slow,
				div: \unit,
				duration: \four_floor,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRing: 0.0, amWave: 0.0, cloudsSend: 0.28, decay: 0.04, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 0.67, engine: 19.0, fmMod: -0.02, harm: 0.48, harmMod: 0.0, legato: 15.0, lpgColour: 0.5, morph: 0.05, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: -0.25, pitch: 40.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.04, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.47, revTime: 0.84, reverbSend: 0.42, sendToPhones: 0.0, speed: 1.5, stereoMode: 1.0, tempo: 114.01, timbMod: 0.0, timbre: 0.18, volume: 0.69, volumeMod: 0.5),
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
		)
	],
	// Samples array
	[
		// $SAMPLE1
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.08, bankName: 'halfmastv6', cloudsSend: 0.0, decay: 0.64, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 4.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.1, phaseOffset: 0.0, rate: 0.63, rateMod: 0.2, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.0, revTime: 0.92, reverbSend: 0.14, speed: 0.25, startPos: 0.49, tempo: 114.01, variant: 10.0, volume: 0.9, volumeMod: 0.0),
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
			(atk: 0.0, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.6, revFreeze: 0.0, revHp: 0.09, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 114.01, variant: 0.0, volume: 0.82, volumeMod: 0.0),
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
	delay: (feedback: 0.56, filterFreq: 2816.21, spread: 1.5, time: 0.35),
	reverb: (damp: 0.26, diffuse: 0.63, freeze: 1.0, hp: 0.49, time: 0.51)
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
	lfo1: (freq: 0.16666666666667), // plaits 0 timbre
	lfo2: (freq: 1), // plaits 0 morph
	lfo3: (freq: 6), // plaits 0 decay
	lfo4: (freq: 0.33333333333333, shape: 4), // plaits 0 pitch
	lfo5: (freq: 1), // plaits 0 volume
	lfo7: (freq: 1.2, shape: 2), // plaits 1 timbre
	lfo8: (freq: 1.56), // plaits 1 morph
	lfo9: (freq: 0.16666666666667), // plaits 1 decay
	lfo10: (freq: 1.2, shape: 3), // plaits 1 pitch
	lfo11: (freq: 1.2), // plaits 1 volume
	lfo12: (freq: 1.0), // plaits 1 harm
	lfo14: (freq: 0.16666666666667), // plaits 2 morph
	lfo17: (freq: 0.2), // plaits 2 volume
	lfo19: (freq: 0.083333333333333), // sample 0 rate
	lfo21: (freq: 0.083333333333333), // sample 1 rate
);
~base = 1.2;
// $LFO_SOURCES_END

~applyPatch.();
)

