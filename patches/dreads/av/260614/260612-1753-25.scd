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
			(cloudsSend: 0.0, decay: 1.0, decayMod: 0.0, delaySend: 0.57, distAmount: 0.51, distDrive: 0.0, droneMode: 1.0, dur: 0.5, engine: 2.0, fmMod: 0.3, harm: 0.11, legato: 8.0, lpgColour: 0.5, morph: 0.8, morphMod: 1.0, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 48.0, pitchMod: 0.1, revDamp: 0.58, revDrywet: 0.48, revFreeze: 0.0, revHp: 0.14, revTime: 0.82, reverbSend: 0.5, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 68.94, timbMod: 0.0, timbre: 0.69, volume: 0.95, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \hold,
				div: \unit,
				delaySend: \gate_prob20,
				cloudsSend: \gate_prob20,
				revDrywet: \gate_prob20,
				harm: \hold,
				pitch: \hold,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.28, decay: 0.42, decayMod: 0.0, delaySend: 0.21, distAmount: 0.0, distDrive: 0.0, droneMode: 1.0, dur: 1.0, engine: 20.0, fmMod: -0.02, harm: 0.11, legato: 15.0, lpgColour: 0.5, morph: 0.72, morphMod: 0.81, mul: 0.5, mute: 1.0, phaseOffset: -0.5, pitch: 60.0, pitchMod: 0.0, revDamp: 0.04, revDrywet: 0.78, revFreeze: 0.0, revHp: 0.47, revTime: 0.84, reverbSend: 1.0, sendToPhones: 0.0, speed: 0.5, stereoMode: 1.0, tempo: 68.94, timbMod: 0.0, timbre: 0.57, volume: 0.25, volumeMod: 0.5),
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
			(cloudsSend: 0.84, decay: 0.75, decayMod: 0.0, delaySend: 0.66, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(1.0), engine: 23.0, fmMod: 0.0, harm: 0.38, legato: 9.0, lpgColour: 0.5, morph: 0.31, morphMod: 0.73, mul: 0.5, mute: 1.0, phaseOffset: 0.0, pitch: 52.0, pitchMod: 0.0, revDamp: 0.69, revDrywet: 1.0, revFreeze: 0.0, revHp: 0.94, revTime: 0.88, reverbSend: 0.0, sendToPhones: 0.0, speed: 0.5, stereoMode: 1.0, tempo: 68.94, timbMod: 0.42, timbre: 0.3, volume: 0.3, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: \unit,
				duration: \offbeat,
				pitch: \triad_min,
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
			(atk: 0.08, bankName: 'halfmastv6', cloudsSend: 0.0, decay: 0.64, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 4.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.1, phaseOffset: 0.0, rate: 0.63, rateMod: 0.2, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.0, revTime: 0.92, reverbSend: 0.14, speed: 0.25, startPos: 0.49, tempo: 68.94, variant: 10.0, volume: 0.9, volumeMod: 0.0),
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
			(atk: 0.0, bankName: 'KICKS', cloudsSend: 0.0, decay: 1.0, delaySend: 0.47, distAmount: 0.31, distDrive: 0.0, dur: 2.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 0.5, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.69, revFreeze: 0.0, revHp: 0.0, revTime: 0.64, reverbSend: 0.0, speed: 0.5, startPos: 0.0, tempo: 68.94, variant: 3.0, volume: 1.33, volumeMod: 0.0),
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
			(atk: 0.0, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.6, revFreeze: 0.0, revHp: 0.09, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 68.94, variant: 0.0, volume: 0.82, volumeMod: 0.0),
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
	clouds: (blend: 0.26, density: 0.93, feedback: 0.36, freeze: 0.0, inGain: 1.0, lofi: 0.0, mix: 1.0, mode: 3.0, pitch: 1.92, position: 0.69, reverb: 0.55, size: 0.27, spread: 0.5, texture: 0.59, volume: 0.84),
	delay: (feedback: 0.48, filterFreq: 4636.46, spread: 1.5, time: 0.5),
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
	lfo1: (freq: 1.0, shape: 2), // plaits 0 timbre
	lfo2: (freq: 0.65), // plaits 0 morph
	lfo3: (freq: 0.16666666666667), // plaits 0 decay
	lfo4: (freq: 0.5, shape: 3), // plaits 0 pitch
	lfo5: (freq: 1.0), // plaits 0 volume
	lfo6: (freq: 1.0), // plaits 1 timbre
	lfo8: (freq: 0.16666666666667), // plaits 1 decay
	lfo11: (freq: 0.2), // plaits 2 timbre
	lfo13: (freq: 0.16666666666667), // plaits 2 decay
	lfo14: (freq: 1), // plaits 2 pitch
	lfo15: (freq: 6), // plaits 2 volume
	lfo16: (freq: 0.33333333333333, shape: 4), // sample 0 rate
	lfo17: (freq: 1), // sample 0 volume
	lfo19: (freq: 0.083333333333333), // sample 1 volume
	lfo21: (freq: 0.083333333333333), // sample 2 volume
);
// $LFO_SOURCES_END

// ~base = 0.5;
// ~dreads.lfoSources[\lfo1].freq = ~base + 0.04;
// ~dreads.lfoSources[\lfo4].freq = ~base + 0.03;
// ~dreads.lfoSources[\lfo5].freq = ~base;
// ~dreads.lfoSources[\lfo5].freq = ~base/5;

~applyPatch.();

// --- livecoding area ---
~base = 0.5;
~mod = 0.5;
// ~mod = 0;

// ~lfoTweak.(\plaits, 0, \volume, (freq: ~base/1.3, shape: \sine, mod: 1.0));
~lfoTweak.(\plaits, 0, \volume, (freq: ~base*2, shape: \sine, mod: 0));
// ~lfoTweak.(\plaits, 0, \volume, (freq: ~base*2, shape: \sine, mod: ~mod * 2));
// ~lfoTweak.(\plaits, 0, \morph, (freq: ~base*1.3, shape: \sine, mod: ~mod - 0.1));
~lfoTweak.(\plaits, 0, \morph, (freq: ~base*1.3, shape: \sine, mod: 0.8));
// ~lfoTweak.(\plaits, 0, \morph, (freq: ~base*1.3, shape: \sine, mod: 0.3));
// ~lfoTweak.(\plaits, 0, \pitch, (freq: 20, shape: \noise, mod: 0.0));
~lfoTweak.(\plaits, 0, \pitch, (freq: ~base, shape: \square, mod: ~mod * 0.2));
~lfoTweak.(\plaits, 0, \timbre, (freq: ~base*2, shape: \saw, mod: ~mod));
// ~lfoTweak.(\plaits, 0, \timbre, (freq: ~base*2, shape: \saw, mod: 0.0));
)

