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
			(amDepth: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRing: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.47, decayMod: 0.0, delaySend: 0.47, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 0.33, engine: 19.0, fmMod: 0.0, harm: 0.64, harmMod: 0.0, legato: 9.0, lpgColour: 0.5, morph: 0.28, morphMod: 0.34, mul: 0.5, mute: 0.0, phaseOffset: -0.25, pitch: 42.0, pitchMod: 0.0, revDamp: 0.76, revDrywet: 0.31, revFreeze: 0.0, revHp: 0.72, revTime: 0.88, reverbSend: 0.35, sendToPhones: 0.0, speed: 1.5, stereoMode: 1.0, tempo: 114.01, timbMod: 0.66, timbre: 0.42, volume: 0.44, volumeMod: 1.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// duration: \hold,
				// duration: Pseq([1/2, 1/2, 1/2, 1/2, 1/2, 1/2], inf).asStream,
				duration: Pseq([
					Pwrand([1/2, Rest(1/2)], [1.0, 0.0].normalizeSum, 1), //dom
					Pwrand([1/2, Rest(1/2)], [0.8, 0.2].normalizeSum, 1),
					Pwrand([1/2, Rest(1/2)], [1.0, 0.0].normalizeSum, 1), //dom
					Pwrand([1/2, Rest(1/2)], [0.7, 0.3].normalizeSum, 1),
					Pwrand([1/2, Rest(1/2)], [1.0, 0.0].normalizeSum, 1), //dom
					Pwrand([1/2, Rest(1/2)], [0.7, 0.3].normalizeSum, 1),
				], inf).asStream,
				div: \unit,
				delaySend: \gate_every32,
				cloudsSend: \hold,
				revDrywet: \sine_slow,
				harm: \hold,
				// pitch: \triad_min_inv,
				// pitch: Pseq([0, 3, 7, 12, 7, 3], inf).asStream,
				pitch: Pn(Plazy({
					var a = [0, 3, 7, 12, 7, 3];
					if (0.0.coin) { a.removeAt(2) };
					Pseq(a, 1)
				}), inf).asStream,
				morph: \hold,
				timbre: \hold,
				distAmount: \hold,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRing: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.54, decayMod: 0.0, delaySend: 0.5, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 0.33, engine: 13.0, fmMod: 0.65, harm: 0.44, harmMod: 0.0, legato: 8.0, lpgColour: 0.5, morph: 0.24, morphMod: 0.9, mul: 0.5, mute: 1.0, phaseOffset: 0.75, pitch: 30.0, pitchMod: 0.0, revDamp: 0.42, revDrywet: 0.22, revFreeze: 0.0, revHp: 0.0, revTime: 0.47, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.5, stereoMode: 0.0, tempo: 114.01, timbMod: 0.2, timbre: 0.53, volume: 1.13, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: \unit,
				duration: \eucl_5_8,
				pitch: \hold,
				distAmount: \gate_every4,
				cloudsSend: \gate_prob20,
				harm: \gate_every4,
				delaySend: Pseq([1] ++ (0 ! 14), inf).asStream,
				// delaySend: Pseq([1] ++ (0 ! 4), inf).asStream,
				revDrywet: \hold,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.01, amFixedHz: 0.0, amRatio: 1.0, amRing: 0.0, amWave: 0.0, cloudsSend: 0.28, decay: 0.04, decayMod: 0.0, delaySend: 0.5, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 1.0, engine: 19.0, fmMod: -0.02, harm: 0.48, harmMod: 0.0, legato: 15.0, lpgColour: 0.5, morph: 0.03, morphMod: 0.0, mul: 0.5, mute: 1.0, phaseOffset: -0.25, pitch: 40.0, pitchMod: 0.0, revDamp: 0.04, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.47, revTime: 0.84, reverbSend: 0.42, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 114.01, timbMod: 0.19, timbre: 0.35, volume: 0.63, volumeMod: 0.5),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: \unit,
				duration: \four_floor,
				pitch: \hold,
				delaySend: Pseq([1] ++ (0 ! 11), inf).asStream,
				revDrywet: \hold,
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
			(atk: 0.0, bankName: 'HATS', cloudsSend: 0.0, decay: 1.0, delaySend: 0.61, distAmount: 0.39, distDrive: 0.0, dur: 0.33, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.06, phaseOffset: -0.25, rate: 3.35, rateMod: 0.5, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.0, revTime: 0.92, reverbSend: 0.14, speed: 3.0, startPos: 0.0, tempo: 114.01, variant: 1.0, volume: 0.3, volumeMod: 1.0),
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
			(atk: 0.0, bankName: 'CLAPS', cloudsSend: 0.09, decay: 0.57, delaySend: 0.17, distAmount: 0.5, distDrive: 0.0, dur: Rest(1.0), legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.07, phaseOffset: 0.75, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.39, revTime: 0.95, reverbSend: 0.0, speed: 0.5, startPos: 0.0, tempo: 114.01, variant: 2.0, volume: 0.57, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \unit,
				mul: \unit,
				duration: \offbeat,
				decay: \gate_every3,
				distAmount: \gate_every5,
				// delaySend: \gate_every5,
				delaySend: Pseq([1] ++ (0 ! 14), inf).asStream,
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
	delay: (feedback: 0.68, filterFreq: 7041.93, spread: 1.5, time: 0.35),
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
	lfo1: (freq: 0.93332344293594), // plaits 0 timbre
	lfo2: (freq: 1), // plaits 0 morph
	lfo3: (freq: 6), // plaits 0 decay
	lfo4: (freq: 0.33333333333333, shape: 4), // plaits 0 pitch
	lfo5: (freq: 0.98000001907349), // plaits 0 volume
	lfo7: (freq: 1.2, shape: 2), // plaits 1 timbre
	lfo8: (freq: 1.56), // plaits 1 morph
	lfo9: (freq: 0.16666666666667), // plaits 1 decay
	lfo10: (freq: 1.2, shape: 3), // plaits 1 pitch
	lfo11: (freq: 1.2), // plaits 1 volume
	lfo12: (freq: 1.0), // plaits 1 harm
	lfo14: (freq: 0.16666666666667), // plaits 2 morph
	lfo17: (freq: 0.2), // plaits 2 volume
	lfo19: (freq: 0.083333333333333), // sample 0 rate
	lfo20: (freq: 3.8411104679108), // sample 0 volume
	lfo21: (freq: 0.083333333333333), // sample 1 rate
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

