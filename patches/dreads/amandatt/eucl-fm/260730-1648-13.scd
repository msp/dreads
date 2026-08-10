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
			(amDepth: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRing: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.59, decayMod: 0.0, delaySend: 0.24, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(0.25), engine: 13.0, fmMod: 0.65, harm: 0.37, harmMod: 0.0, legato: 8.0, lpgColour: 0.5, morph: 0.49, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 30.0, pitchMod: 0.0, revDamp: 0.88, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.0, revTime: 0.76, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 130.0, timbMod: 0.0, timbre: 0.45, volume: 1.31, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \eucl_7_16,
				div: Pseq([1, 2, 1], inf).asStream,
				delaySend: \gate_every8,
				cloudsSend: \gate_prob20,
				revDrywet: \hold,
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
			(amDepth: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRing: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.06, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(0.25), engine: 2.0, fmMod: 0.55, harm: 0.63, harmMod: 0.0, legato: 1.0, lpgColour: 0.5, morph: 0.17, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 46.0, pitchMod: 0.0, revDamp: 0.72, revDrywet: 0.35, revFreeze: 0.0, revHp: 0.15, revTime: 0.18, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 130.0, timbMod: 0.0, timbre: 0.62, volume: 1.07, volumeMod: 0.5),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: Pseq([1, 2, 1], inf).asStream,
				duration: \eucl_7_16,
				pitch: \hold,
				fmMod: \hold,
				revDrywet: \sweep_slow,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRing: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.18, decayMod: 0.0, delaySend: 0.09, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(0.083333333333333), engine: 19.0, fmMod: 0.56, harm: 0.18, harmMod: 0.0, legato: 9.0, lpgColour: 0.5, morph: 0.26, morphMod: 0.49, mul: 0.5, mute: 1.0, phaseOffset: -0.25, pitch: 42.0, pitchMod: 0.0, revDamp: 0.76, revDrywet: 0.68, revFreeze: 0.0, revHp: 0.0, revTime: 0.18, reverbSend: 0.15, sendToPhones: 0.0, speed: 3.0, stereoMode: 1.0, tempo: 130.0, timbMod: 0.37, timbre: 0.56, volume: 0.32, volumeMod: 0.67),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: \unit,
				duration: \eucl_7_16,
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
			(atk: 0.0, bankName: 'HATS', cloudsSend: 0.0, decay: 1.0, delaySend: 0.0, distAmount: 0.39, distDrive: 0.0, dur: 0.17, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.24, phaseOffset: -0.25, rate: 3.39, rateMod: 0.3, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.0, revTime: 0.92, reverbSend: 0.14, speed: 6.0, startPos: 0.0, tempo: 130.0, variant: 1.0, volume: 0.56, volumeMod: 1.0),
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
				atk: \sine_slow,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.0, bankName: 'CLAPS', cloudsSend: 0.1, decay: 0.33, delaySend: 0.09, distAmount: 0.5, distDrive: 0.0, dur: 0.2, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.11, phaseOffset: 0.5, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.39, revTime: 0.95, reverbSend: 0.0, speed: 1.25, startPos: 0.0, tempo: 130.0, variant: 2.0, volume: 0.29, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: Pseq([2], inf).asStream,
				rate: \unit,
				mul: \unit,
				duration: \hold,
				decay: \gate_every8,
				distAmount: \gate_every5,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.0, bankName: 'HATS', cloudsSend: 0.0, decay: 0.41, delaySend: 0.0, distAmount: 0.43, distDrive: 0.0, dur: 0.17, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.07, phaseOffset: 0.0, rate: 2.99, rateMod: 1.0, revDamp: 0.8, revDrywet: 0.2, revFreeze: 0.0, revHp: 0.09, revTime: 0.3, reverbSend: 0.0, speed: 6.0, startPos: 0.0, tempo: 130.0, variant: 0.0, volume: 0.45, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \unit,
				mul: \unit,
				duration: \unit,
				distAmount: \sine_slow,
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
	delay: (feedback: 0.74, filterFreq: 5342.0, spread: 1.5, time: 0.55),
	reverb: (damp: 0.86, diffuse: 0.44, freeze: 0.0, hp: 0.3, time: 0.41)
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
	lfo2: (freq: 1.56), // plaits 0 morph
	lfo3: (freq: 0.16666666666667), // plaits 0 decay
	lfo4: (freq: 1.2, shape: 3), // plaits 0 pitch
	lfo5: (freq: 1.2), // plaits 0 volume
	lfo6: (freq: 1.0), // plaits 0 harm
	lfo7: (freq: 0.40000000596046, base: true), // plaits 1 timbre
	lfo8: (freq: 0.92317014932632, base: true), // plaits 1 morph
	lfo11: (freq: 0.2), // plaits 1 volume
	lfo13: (freq: 4.0599050521851, shape: 1), // plaits 2 timbre
	lfo14: (freq: 4.1389727592468, shape: 1), // plaits 2 morph
	lfo15: (freq: 6), // plaits 2 decay
	lfo16: (freq: 0.33333333333333, shape: 4), // plaits 2 pitch
	lfo17: (freq: 0.66099917888641), // plaits 2 volume
	lfo19: (freq: 0.083333333333333), // sample 0 rate
	lfo20: (freq: 0.85935586690903), // sample 0 volume
	lfo21: (freq: 0.083333333333333), // sample 1 rate
);
~base = 2.9470000267029;
// $LFO_SOURCES_END

// ~base = 0.5;
// ~dreads.lfoSources[\lfo1].freq = ~base + 0.04;
// ~dreads.lfoSources[\lfo4].freq = ~base + 0.03;
// ~dreads.lfoSources[\lfo5].freq = ~base;
// ~dreads.lfoSources[\lfo5].freq = ~base/5;

~applyPatch.();
)

