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
			(amDepth: 0.0, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.53, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 0.25, engine: 13.0, fmMod: 1.0, harm: 0.85, harmMod: 0.0, legato: 8.0, lpgColour: 0.5, morph: 0.69, morphMod: 0.29, mul: 0.5, mute: 0.0, phaseOffset: 0.75, pitch: 30.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.88, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.83, revTime: 0.82, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 0.0, tempo: 119.0, timbMod: 0.03, timbre: 0.96, volume: 1.07, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \dense_burst,
				div: Pseq((1 ! 11) ++ [1/2], inf).asStream,
				delaySend: \gate_every8,
				cloudsSend: \gate_prob20,
				revDrywet: \sweep_slow,
				harm: \hold,
				pitch: \hold,
				morph: \hold,
				timbre: \hold,
				distAmount: \gate_every4,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.0, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.28, decay: 0.04, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 1.0, engine: 19.0, fmMod: -0.02, harm: 0.48, harmMod: 0.0, legato: 15.0, lpgColour: 0.5, morph: 0.11, morphMod: 0.0, mul: 0.5, mute: 1.0, phaseOffset: -0.25, pitch: 40.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.04, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.47, revTime: 0.84, reverbSend: 0.42, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 119.0, timbMod: 0.19, timbre: 0.35, volume: 0.84, volumeMod: 0.5),
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
			(amDepth: 0.07, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.07, amRingMod: 0.0, amWave: 2.0, cloudsSend: 0.2, decay: 0.61, decayMod: 0.12, delaySend: 0.19, distAmount: 0.05, distDrive: 0.0, droneMode: 0.0, dur: Rest(1.0), engine: 5.0, fmMod: -0.16, harm: 0.01, harmMod: 0.2, legato: 9.0, lpgColour: 0.11, morph: 0.0, morphMod: 0.24, mul: 0.5, mute: 0.0, phaseOffset: -0.25, pitch: 65.0, pitchMod: 0.29, releaseTime: 1.0, revDamp: 0.48, revDrywet: 0.2, revFreeze: 0.0, revHp: 0.53, revTime: 0.57, reverbSend: 0.28, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 119.0, timbMod: 0.41, timbre: 0.63, volume: 0.63, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: Pseq([1, 1/4, 1], inf).asStream,
				div: Pseq((1 ! 15) ++ [1/2] ++ (1 ! 15) ++ [1/4], inf).asStream,
				duration: \dense_burst,
				pitch: \hold,

				// pitch: Pseq([7, 12, 5, -3, -7, 12], inf).asStream,
				delaySend: \hold,
				revDrywet: \hold,
				decay: \hold,

				// decay: Pseq([0.63, 0.04, 0.78, 0.12, 0.76, 0.94], inf).asStream,
				revTime: \hold,
				morph: \hold,

				// morph: Pseq([0.68, 0.06, 0.35, 0.61, 0.81, 0.79, 0.17, 0.34, 0.91], inf).asStream,
				lpgColour: Pseq([0.86, 0.37, 0.65, 0.11, 0.76, 0.99, 0.67, 0.46, 0.91, 0.01, 0.35, 0.42, 0.85, 0.36], inf).asStream,
				amRatio: Pseq([0.44, 0.61, 0.43, 0.17], inf).asStream,
				timbre: Pseq([0.79, 0.68, 0.94, 0.21, 0.3, 0.29], inf).asStream,
				fmMod: Pseq([0.61, 0.4, 0.25, 0.48, 0.29, 0.66, 0.26, 0.82, 0.97], inf).asStream,
				amRing: Pseq([0.32, 0.97, 0.41, 0.01, 0.58], inf).asStream,
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
			(atk: 0.0, bankName: 'HATS', cloudsSend: 0.0, decay: 1.0, delaySend: 0.31, distAmount: 0.0, distDrive: 0.0, dur: 2.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.24, phaseOffset: -0.5, rate: 3.49, rateMod: 0.78, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.0, revTime: 0.92, reverbSend: 0.0, speed: 0.5, startPos: 0.0, tempo: 119.0, variant: 1.0, volume: 1.21, volumeMod: 1.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \hold,
				mul: \unit,
				duration: \unit,
				startPos: \hold,
				distAmount: \gate_every3,
				decay: \hold,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.03, bankName: 'CLAPS', cloudsSend: 0.0, decay: 0.11, delaySend: 0.52, distAmount: 0.24, distDrive: 0.0, dur: 0.25, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.07, phaseOffset: 0.5, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.29, revFreeze: 0.0, revHp: 0.5, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 119.0, variant: 2.0, volume: 0.76, volumeMod: 1.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: Pseq((1 ! 23) ++ [1/4], inf).asStream,
				rate: \unit,
				mul: \unit,
				duration: \dense_burst,
				decay: \gate_every3,
				distAmount: \gate_every5,
				delaySend: \gate_every16,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.0, bankName: 'msp-iris-hits', cloudsSend: 0.4, decay: 0.5, delaySend: 0.32, distAmount: 0.5, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.03, phaseOffset: 0.0, rate: 3.8, rateMod: 0.21, revDamp: 0.33, revDrywet: 0.36, revFreeze: 0.0, revHp: 0.2, revTime: 1.09, reverbSend: 0.08, speed: 1.0, startPos: 0.0, tempo: 119.0, variant: 1.0, volume: 0.76, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \unit,
				mul: \unit,
				duration: \backbeat,
				delaySend: \gate_every5,
				variant: Prand((0..19), inf).asStream,
				cloudsSend: \gate_every5,
				revDrywet: \sine_slow,
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
	delay: (feedback: 0.75, filterFreq: 5956.65, spread: 1.5, time: 0.76),
	reverb: (damp: 0.86, diffuse: 0.44, freeze: 0.0, hp: 0.3, time: 0.52)
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
	lfo1: (freq: 1.2, shape: 2), // plaits 0 timbre
	lfo2: (freq: 1.56, shape: 4), // plaits 0 morph
	lfo3: (freq: 0.16666666666667), // plaits 0 decay
	lfo4: (freq: 1.2, shape: 3), // plaits 0 pitch
	lfo5: (freq: 1.2), // plaits 0 volume
	lfo6: (freq: 1.0), // plaits 0 harm
	lfo8: (freq: 0.16666666666667), // plaits 1 morph
	lfo11: (freq: 0.2), // plaits 1 volume
	lfo13: (freq: 0.18193006515503), // plaits 2 timbre
	lfo14: (freq: 3.1879741847515, shape: 1, base: true), // plaits 2 morph
	lfo15: (freq: 0.89984023571014, base: true), // plaits 2 decay
	lfo16: (freq: 3.7472187876701, shape: 1, base: true), // plaits 2 pitch
	lfo17: (freq: 1.0991776943207, shape: 1), // plaits 2 volume
	lfo18: (freq: 3.8486666381359, shape: 2, base: true), // plaits 2 harm
	lfo19: (freq: 0.46420365571976), // sample 0 rate
	lfo20: (freq: 3.8411104679108), // sample 0 volume
	lfo21: (freq: 0.083333333333333), // sample 1 rate
	lfo22: (freq: 4.7915077209473), // sample 1 volume
	lfo27: (freq: 3.2372450232506, base: true), // plaits 2 amRing
	lfo30: (freq: 0.60504892468452, base: true), // plaits 2 amDepth
	lfo33: (freq: 1.2852942347527, shape: 2, base: true), // plaits 2 amRatio
);
~base = 1.2;
// $LFO_SOURCES_END

// ~base = 0.5;
// ~dreads.lfoSources[\lfo1].freq = ~base + 0.04;
// ~dreads.lfoSources[\lfo4].freq = ~base + 0.03;
// ~dreads.lfoSources[\lfo5].freq = ~base;
// ~dreads.lfoSources[\lfo5].freq = ~base/5;

~applyPatch.();
)

