////////////////////////////////////////////////////////////////////////////////
// FM Patch Preview Preset
// PLAITS1 configured for clean FM auditioning — load this, then run fm-patches.scd
////////////////////////////////////////////////////////////////////////////////
(
~div = [2, 1, 1, 1, 1, 1];
~dreads = ~patchFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRing: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.59, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 4.0, engine: 13.0, fmMod: 0.55, harm: 0.41, harmMod: 0.0, legato: 8.0, lpgColour: 0.5, morph: 0.4, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 30.0, pitchMod: 0.0, revDamp: 0.88, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.0, revTime: 0.76, reverbSend: 0.0, sendToPhones: 0.0, speed: 0.25, stereoMode: 1.0, tempo: 190.0, timbMod: 0.0, timbre: 0.45, volume: 1.31, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \four_floor,
				div: Pseq(~div, inf).asStream,
				delaySend: \gate_every8,
				cloudsSend: \gate_prob20,
				revDrywet: \hold,
				harm: \hold,
				pitch: \hold,
				morph: Pseq([1] ++ (0 ! 6), inf).asStream,
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
			(amDepth: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRing: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.0, decayMod: 0.0, delaySend: 0.5, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 1.5, engine: 2.0, fmMod: -0.04, harm: 0.63, harmMod: 0.0, legato: 1.0, lpgColour: 0.5, morph: 0.61, morphMod: 0.7, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 46.0, pitchMod: 0.0, revDamp: 0.04, revDrywet: 0.49, revFreeze: 0.0, revHp: 0.47, revTime: 0.84, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 0.0, tempo: 190.0, timbMod: 0.5, timbre: 0.44, volume: 0.63, volumeMod: 0.5),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: Pseq(~div, inf).asStream,
				duration: \tresillo,
				pitch: \oct_updown,
				fmMod: \hold,
				div: \unit,
				revDrywet: \gate_every16,
				delaySend: \gate_every16,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRing: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.12, decayMod: 0.0, delaySend: 0.29, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 5.0, engine: 19.0, fmMod: 0.01, harm: 0.55, harmMod: 0.0, legato: 9.0, lpgColour: 0.5, morph: 0.06, morphMod: 0.65, mul: 0.5, mute: 1.0, phaseOffset: 0.5, pitch: 46.0, pitchMod: 0.0, revDamp: 0.76, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.72, revTime: 0.88, reverbSend: 0.23, sendToPhones: 0.0, speed: 0.1, stereoMode: 1.0, tempo: 190.0, timbMod: 0.06, timbre: 0.63, volume: 0.81, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: Pseq(~div, inf).asStream,
				duration: \hold,
				pitch: \hold,
				delaySend: \gate_every16,
				revDrywet: \sine_slow,
				div: \unit,
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
			(atk: 0.49, bankName: 'HATS', cloudsSend: 0.0, decay: 1.0, delaySend: 0.22, distAmount: 0.14, distDrive: 0.0, dur: 0.5, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.11, phaseOffset: -1.0, rate: 3.39, rateMod: 0.3, revDamp: 0.57, revDrywet: 0.39, revFreeze: 0.0, revHp: 0.83, revTime: 0.29, reverbSend: 0.14, speed: 2.0, startPos: 0.39, tempo: 190.0, variant: 1.0, volume: 1.05, volumeMod: 1.0),
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
			(atk: 0.0, bankName: 'CLAPS', cloudsSend: 0.09, decay: 0.11, delaySend: 0.0, distAmount: 0.5, distDrive: 0.0, dur: Rest(2.0), legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.05, phaseOffset: 0.75, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.39, revTime: 0.95, reverbSend: 0.0, speed: 0.25, startPos: 0.0, tempo: 190.0, variant: 2.0, volume: 0.58, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \unit,
				mul: \unit,
				duration: \eucl_3_8,
				decay: \hold,
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
			(atk: 0.0, bankName: 'KICKS', cloudsSend: 0.0, decay: 1.0, delaySend: 0.15, distAmount: 0.0, distDrive: 0.0, dur: 3.0, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.1, phaseOffset: 0.0, rate: 1.83, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.09, revTime: 0.3, reverbSend: 0.07, speed: 0.5, startPos: 0.0, tempo: 190.0, variant: 2.0, volume: 0.86, volumeMod: 0.62),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				duration: \tresillo,
				div: Pseq(~div, inf).asStream,
				rate: \unit,
				mul: \unit,
				delaySend: \gate_every32,
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
	delay: (feedback: 0.33, filterFreq: 5000.87, spread: 1.5, time: 0.32),
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
	lfo13: (freq: 0.93332344293594), // plaits 2 timbre
	lfo14: (freq: 1), // plaits 2 morph
	lfo15: (freq: 6), // plaits 2 decay
	lfo16: (freq: 0.33333333333333, shape: 4), // plaits 2 pitch
	lfo17: (freq: 1), // plaits 2 volume
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

