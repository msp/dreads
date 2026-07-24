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
			(cloudsSend: 0.0, decay: 0.1, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 0.75, engine: 20.0, fmMod: -0.03, harm: 0.99, harmMod: 0.0, legato: 8.0, lpgColour: 0.5, morph: 0.0, morphMod: 0.9, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 48.0, pitchMod: 0.0, revDamp: 0.58, revDrywet: 1.0, revFreeze: 0.0, revHp: 0.14, revTime: 0.82, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 133.26, timbMod: 0.2, timbre: 0.27, volume: 1.0, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: Pseq([0.75, Rest(0.5), 0.5, 0.75], inf).asStream,

				// duration: Pseq([0.5, Rest(1.0), 0.5, Rest(0.5), 0.5, Rest(1.0)], inf).asStream,
				div: \unit,
				delaySend: Pseq([0.5, 0.9, 0.7, 0.7, 0.9, 1.0, 0.3, 0.2, 0.7, 0.2, 0.8, 0.2, 0.8], inf).asStream,
				cloudsSend: \gate_prob20,
				revDrywet: \sweep_slow,
				harm: \hold,
				pitch: \triad_maj,
				morph: \gate_every8,
				timbre: \gauss,
				decay: \gate_every8,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.28, decay: 0.42, decayMod: 0.0, delaySend: 0.21, distAmount: 0.49, distDrive: 0.0, droneMode: 1.0, dur: 1.0, engine: 20.0, fmMod: -0.02, harm: 0.67, harmMod: 0.0, legato: 15.0, lpgColour: 0.5, morph: 0.72, morphMod: 0.81, mul: 0.5, mute: 0.0, phaseOffset: -0.5, pitch: 0.0, pitchMod: 0.0, revDamp: 0.04, revDrywet: 0.59, revFreeze: 0.0, revHp: 0.47, revTime: 0.84, reverbSend: 0.08, sendToPhones: 0.0, speed: 0.5, stereoMode: 1.0, tempo: 133.26, timbMod: 0.0, timbre: 0.57, volume: 1.39, volumeMod: 0.5),
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
			(cloudsSend: 0.84, decay: 0.1, decayMod: 0.0, delaySend: 0.39, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 1.0, engine: 23.0, fmMod: 0.0, harm: 0.45, harmMod: 0.0, legato: 9.0, lpgColour: 0.5, morph: 0.09, morphMod: 0.22, mul: 0.5, mute: 1.0, phaseOffset: 0.0, pitch: 52.0, pitchMod: 0.0, revDamp: 0.69, revDrywet: 0.47, revFreeze: 0.0, revHp: 0.94, revTime: 0.88, reverbSend: 0.0, sendToPhones: 0.0, speed: 0.5, stereoMode: 1.0, tempo: 133.26, timbMod: 0.42, timbre: 0.3, volume: 0.43, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: \unit,
				duration: \hold,
				pitch: \triad_min,
				delaySend: \gate_every5,
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
			(atk: 0.17, bankName: 'msp-form-msp8', cloudsSend: 0.0, decay: 0.84, delaySend: 0.0, distAmount: 0.67, distDrive: 0.0, dur: 4.0, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.83, phaseOffset: 0.0, rate: 2.28, rateMod: 0.2, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.0, revTime: 0.92, reverbSend: 0.14, speed: 0.25, startPos: 0.0, tempo: 133.26, variant: 6.0, volume: 0.94, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \hold,
				mul: \unit,
				duration: \unit,
				startPos: \hold,
				distAmount: \hold,
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
			(atk: 0.0, bankName: 'KICKS', cloudsSend: 0.09, decay: 0.61, delaySend: 0.12, distAmount: 0.27, distDrive: 0.14, dur: 2.0, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.24, phaseOffset: 0.0, rate: 2.45, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.0, revTime: 0.16, reverbSend: 0.21, speed: 0.5, startPos: 0.0, tempo: 133.26, variant: 1.0, volume: 1.19, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \hold,
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
			(atk: 0.0, bankName: 'msp-form-msp7', cloudsSend: 0.2, decay: 0.59, delaySend: 0.0, distAmount: 0.13, distDrive: 0.18, dur: 0.5, legato: 1.13, mul: 1.0, mute: 0.0, panDur: 0.01, phaseOffset: -0.25, rate: 1.7, rateMod: 0.73, revDamp: 0.8, revDrywet: 0.14, revFreeze: 0.0, revHp: 0.09, revTime: 0.45, reverbSend: 0.19, speed: 1.0, startPos: 0.0, tempo: 133.26, variant: 0.0, volume: 1.2, volumeMod: 0.49),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \hold,
				mul: \unit,
				duration: \eucl_5_8,
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
	delay: (feedback: 0.64, filterFreq: 5579.09, spread: 1.5, time: 0.33),
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
	lfo1: (freq: 1.2, shape: 2), // plaits 0 timbre
	lfo2: (freq: 1.56), // plaits 0 morph
	lfo3: (freq: 0.16666666666667), // plaits 0 decay
	lfo4: (freq: 1.2, shape: 3), // plaits 0 pitch
	lfo5: (freq: 1.2), // plaits 0 volume
	lfo6: (freq: 1.0), // plaits 0 harm
	lfo8: (freq: 0.16666666666667), // plaits 1 morph
	lfo11: (freq: 0.2), // plaits 1 volume
	lfo13: (freq: 0.16666666666667), // plaits 2 timbre
	lfo14: (freq: 1, shape: 4), // plaits 2 morph
	lfo15: (freq: 6), // plaits 2 decay
	lfo16: (freq: 0.33333333333333, shape: 4), // plaits 2 pitch
	lfo17: (freq: 1), // plaits 2 volume
	lfo19: (freq: 0.083333333333333), // sample 0 rate
	lfo21: (freq: 0.55291941761971, shape: 1), // sample 1 rate
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

