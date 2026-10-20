////////////////////////////////////////////////////////////////////////////////
// FM Patch Preview Preset
// PLAITS1 configured for clean FM auditioning — load this, then run fm-patches.scd
////////////////////////////////////////////////////////////////////////////////
(
~p1cycle = 32;

~dreads = ~patchFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.0, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.53, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 0.5, engine: 13.0, fmMod: 1.0, harm: 0.84, harmMod: 0.0, legato: 8.0, lpgColour: 0.5, morph: 0.63, morphMod: 0.43, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 30.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.88, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.83, revTime: 0.82, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 0.0, tempo: 85.0, timbMod: 0.03, timbre: 0.96, volume: 1.42, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// duration: \dense_burst,
				duration: \kik_half_time3,

				// duration: Pseq([
				// 1/4, 1/4, 1/4, 1/4, Rest(1),
				// 1/4, 1/4, 1/4, 1/4, Rest(1),
				// 1/4, 1/4, 1/4, 1/4, Rest(1),
				// 1/4, 1/4, 1/4, 1/4, Rest(1),
				// // Rest(2),
				// 1/4, 1/4, 1/4, 1/4, Rest(1),
				// ], inf).asStream,
				// div: Pseq((1 ! 11) ++ [1/2], inf).asStream,
				// Stumble every ~p1cycle steps (set below), recording its step on the voice so PLAITS2
				// can react. ~p1cycle is the single source of truth for the period — PLAITS2 derives from it.
				div: Pfunc {
					var i = (~dreads.synths[0].divStep ? -1) + 1;
					var shift;
					~dreads.synths[0].divStep = i;
					if (i % ~p1cycle == (~p1cycle - 1)) {
						// Halving a step adds one step-length; which step the stumble lands on rotates through
						// dense_burst [¼,¼,¼,¼,1], so match followers' nudge to it (a fixed value drifts every
						// 5th stumble, when the stumble hits the 1-beat rest). Mirrors dense_burst's lengths.
						shift = [1/4, 1/4, 1/4, 1/4, 1].wrapAt(i);
						~dreads.samples[1].nudgeOffset = shift;   // clap shifts with PLAITS1
						// ~dreads.synths[1].nudgeOffset = shift;    // PLAITS2 shifts with PLAITS1
						// ~dreads.synths[2].nudgeOffset = shift;    // PLAITS3 shifts with PLAITS1
						1/2
					} { 1 };
				}.asStream,
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
			(amDepth: 0.0, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.14, decayMod: 0.0, delaySend: 0.1, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 0.25, engine: 19.0, fmMod: -0.02, harm: 0.56, harmMod: 0.0, legato: 15.0, lpgColour: 0.5, morph: 0.0, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: 0.75, pitch: 40.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.82, revDrywet: 0.21, revFreeze: 0.0, revHp: 0.84, revTime: 0.25, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 85.0, timbMod: 0.54, timbre: 0.69, volume: 1.13, volumeMod: 1.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: Pseq([1/2, 1, 1/2, 1, 1/2, 1], inf).asStream,
				duration: \dense_burst,
				pitch: \hold,
				delaySend: Pseq([1] ++ (0 ! 19), inf).asStream,
				harm: Pfunc { if ((~dreads.synths[0].divStep ? 0) % ~p1cycle >= (~p1cycle - 4)) { 0.87 } { 0.64 } }.asStream,
				revHp: \sine,
				revDrywet: \sine_slow,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.07, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.07, amRingMod: 0.0, amWave: 2.0, cloudsSend: 0.15, decay: 0.31, decayMod: 0.1, delaySend: 0.3, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(0.25), engine: 0.0, fmMod: 0.0, harm: 0.64, harmMod: 0.0, legato: 9.0, lpgColour: 0.26, morph: 0.77, morphMod: 0.83, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 43.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.71, revDrywet: 0.15, revFreeze: 0.0, revHp: 0.55, revTime: 0.8, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 85.0, timbMod: 0.25, timbre: 0.37, volume: 1.0, volumeMod: 0.34),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: Pseq((1 ! 15) ++ (2 ! 5) ++ (1 ! 15) ++ (1/2 ! 5), inf).asStream,
				// duration: \dense_burst,
				// duration: Prand([
				// 	1/4, 1/4, 1/4, 1/4, Rest(1),
				// 	1/4, 1/4, 1/4, 1/4, Rest(1),
				// 	1/4, 1/4, 1/4, 1/4, Rest(1),
				// 	1/4, 1/4, 1/4, 1/4, Rest(1),
				// 	// Rest(2),
				// 	1/4, 1/4, 1/4, 1/4, Rest(1),
				// ], inf).asStream,
				duration: Prand([
					Pseq([1/4,       1/4,       1/4,      1/4,    Rest(1)]),
					Pseq([1/4,       Rest(1/2),           1/4,    Rest(1)]),
					Pseq([1/4,       Rest(1/4), 1/4,      1/4,    1      ]),
					Pseq([Rest(1/4), 1/4,       1/4,      1/4,    Rest(1)]),
					Pseq([Rest(2)])
				], inf).asStream,
				//
				// Pitch sequence
				//
				// pitch: \triad_min_inv,
				//
				// Accidental chord!
				//
				// pitch: Pseq([
				// 	[0, 4, 9],
				// 	[0, 4, 7],
				// 	// [-4,0, 4]
				// ], inf).asStream,
				// pitch: Pseq([
				// 	// [0,4,7],
				// 	~chords[\min13]
				// ], inf).asStream,
				pitch: Pseq(
					(~chords[\min13] ! 18) ++
					(~chords[\maj7] ! 2)
				, inf).asStream,
				//
				// Pitch math
				//
				// pitch: Pseq(Scale.choose(7, 12).degrees + 12, inf).asStream,
				//
				// Requires re-exec of patch
				//
				// pitch: {
				// 	var deg = Pseq(~scale.degrees, inf).asStream;
				// 	Pfunc {
				// 		deg.next + [0,13,48].choose
				// 	}
				// }.value.asStream,
				//
				// Realtime change if ~sclae is reassigned
				//
				// pitch: {
				// 	var i = -1;
				// 	Pfunc {
				// 		i = i + 1;
				// 		// ~scale.degrees.wrapAt(i) + [0,12,48].choose
				// 		~scale.degrees.wrapAt(i)
				// 	}
				// }.value.asStream,
				delaySend: \gate_every16,
				revDrywet: \gate_inv8,
				decay: \hold,
				revTime: \gate_prob05,
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
			(atk: 0.0, bankName: 'HATS', cloudsSend: 0.0, decay: 0.82, delaySend: 0.0, distAmount: 0.21, distDrive: 0.0, dur: 0.25, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.09, phaseOffset: 0.0, rate: 2.63, rateMod: 0.78, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.0, revTime: 0.92, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 85.0, variant: 0.0, volume: 0.92, volumeMod: 1.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \hold,
				mul: \unit,
				duration: \dense_burst,
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
			(atk: 0.0, bankName: 'CLAPS', cloudsSend: 0.0, decay: 0.22, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.05, phaseOffset: 0.0, rate: 1.09, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.1, revFreeze: 0.0, revHp: 0.74, revTime: 0.63, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 85.0, variant: 2.0, volume: 1.08, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				// div: Pseq((1 ! 15) ++ [1/4], inf).asStream,
				rate: \unit,
				mul: \unit,
				// duration: \offbeat,
				duration: \four_floor,

				// duration: Pseq([Rest(1), 1], inf).asStream,
				decay: \hold,
				distAmount: \hold,
				delaySend: \gate_every16,
				div: \unit,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.14, bankName: 'msp-iris-hits', cloudsSend: 0.0, decay: 0.48, delaySend: 0.32, distAmount: 0.14, distDrive: 0.0, dur: Rest(1.0), legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.03, phaseOffset: 0.0, rate: 2.15, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.37, revFreeze: 0.0, revHp: 0.33, revTime: 0.76, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 85.0, variant: 1.0, volume: 0.64, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \unit,
				mul: \unit,
				duration: \backbeat,
				delaySend: \gate_every5,
				variant: Prand((0..10), inf).asStream,
				decay: \sine,
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
	clouds: (blend: 0.26, density: 0.09, feedback: 0.64, freeze: 0.0, inGain: 1.0, lofi: 0.0, mix: 1.0, mode: 3.0, pitch: 48.0, position: 0.2, reverb: 0.49, size: 0.93, spread: 0.5, texture: 0.86, volume: 0.51),
	delay: (feedback: 0.38, filterFreq: 2335.71, spread: 1.5, time: 0.71),
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
	lfo7: (freq: 3.6091804504395), // plaits 1 timbre
	lfo8: (freq: 0.16666666666667), // plaits 1 morph
	lfo11: (freq: 2.8699998855591, shape: 1), // plaits 1 volume
	lfo13: (freq: 0.66307765245438, shape: 4), // plaits 2 timbre
	lfo14: (freq: 0.27710354328156), // plaits 2 morph
	lfo15: (freq: 1.1282004117966), // plaits 2 decay
	lfo16: (freq: 0.33333333333333, shape: 4), // plaits 2 pitch
	lfo17: (freq: 3.3555388450623, shape: 2), // plaits 2 volume
	lfo18: (freq: 1.6529215574265), // plaits 2 harm
	lfo19: (freq: 0.46420365571976), // sample 0 rate
	lfo20: (freq: 3.8411104679108), // sample 0 volume
	lfo21: (freq: 0.083333333333333), // sample 1 rate
	lfo22: (freq: 4.7915077209473), // sample 1 volume
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

