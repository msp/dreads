////////////////////////////////////////////////////////////////////////////////
// FM Patch Preview Preset
// PLAITS1 configured for clean FM auditioning — load this, then run fm-patches.scd
////////////////////////////////////////////////////////////////////////////////
(
~p1cycle = 256;   // PLAITS1 stumble period in steps; PLAITS1's div and PLAITS2's harm window both derive from this

~dreads = ~patchFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.0, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.53, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 1.0, engine: 13.0, fmMod: 1.0, harm: 0.8, harmMod: 0.0, legato: 8.0, lpgColour: 0.5, morph: 0.49, morphMod: 0.45, mul: 0.5, mute: 0.0, phaseOffset: 0.75, pitch: 25.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.88, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.83, revTime: 0.82, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 0.0, tempo: 119.0, timbMod: 0.03, timbre: 0.22, volume: 1.09, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \son_clave,
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
						~dreads.synths[1].nudgeOffset = shift;    // PLAITS2 shifts with PLAITS1
						1/2
					} { 1 };
				}.asStream,
				delaySend: \hold,
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
			(amDepth: 0.35, amDepthMod: 0.74, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.47, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.77, decay: 0.18, decayMod: 0.0, delaySend: 0.35, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 0.5, engine: 2.0, fmMod: -0.18, harm: 0.2, harmMod: 0.0, legato: 15.0, lpgColour: 0.07, morph: 0.81, morphMod: 0.04, mul: 0.5, mute: 0.0, phaseOffset: 0.75, pitch: 74.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.75, revDrywet: 0.23, revFreeze: 0.0, revHp: 0.73, revTime: 1.02, reverbSend: 0.0, sendToPhones: 0.0, speed: 0.5, stereoMode: 1.0, tempo: 119.0, timbMod: 0.18, timbre: 0.96, volume: 0.28, volumeMod: 1.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: \unit,
				div: Pseq((1 ! 15) ++ [1/4] ++ (1 ! 15) ++ [1/2], inf).asStream,
				duration: \dense_burst,
				pitch: \hold,
				delaySend: \gate_every5,
				// harm rises for the last 4 steps before PLAITS1's stumble, then drops back — reads
				// PLAITS1's recorded phase and derives the period from ~p1cycle, so PLAITS2's own rhythm
				// stays straight and the two never need hand-syncing. (Change the 4 for a longer/shorter lift.)
				harm: \hold,

				// harm: Pfunc { if ((~dreads.synths[0].divStep ? 0) % ~p1cycle >= (~p1cycle - 4)) { 0.87 } { 0.64 } }.asStream,
				// 0.64 for 8 beats, then 0.87 for 4 beats, repeating (12-beat loop)
				// harm: Pfunc {
				// 	var pos = ~tempoClock.beats % 12;
				// 	if (pos < 8) { 0.64 } { 0.87 };
				// }.asStream,
				revHp: \sine,
				revDrywet: \sine_slow,
				amRatio: \gate_every5,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.07, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.07, amRingMod: 0.26, amWave: 2.0, cloudsSend: 0.0, decay: 0.36, decayMod: 0.0, delaySend: 0.0, distAmount: 0.07, distDrive: 0.0, droneMode: 1.0, dur: 1.0, engine: 22.0, fmMod: -0.03, harm: 0.41, harmMod: 0.0, legato: 9.0, lpgColour: 0.85, morph: 0.1, morphMod: 0.67, mul: 0.5, mute: 0.0, phaseOffset: -0.25, pitch: 50.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.56, revDrywet: 0.36, revFreeze: 0.0, revHp: 0.34, revTime: 0.98, reverbSend: 0.09, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 119.0, timbMod: 0.0, timbre: 0.06, volume: 0.63, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: Pseq([1, 1/4, 1], inf).asStream,
				// div: Pseq((1 ! 31) ++ [1/2] ++ (1 ! 31) ++ [1/4], inf).asStream,
				// duration: \dense_burst,
				pitch: \hold,
				// delaySend: \gate_every16,
				revDrywet: \hold,
				decay: \hold,
				revTime: \hold,
				// volume: Pseq([0.3, 0.15, 0.45, 0.17, 0.39, 0.33, 0.33, 0.68, 0.63, 0.84, 0.37, 0.44], inf).asStream,
				// fmMod: Pseq([0.37, 0.72, 0.84, 0.1, 0.19, 0.91], inf).asStream,
				div: \unit,
				duration: \unit,
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
			(atk: 0.68, bankName: 'HATS', cloudsSend: 0.0, decay: 0.26, delaySend: 0.2, distAmount: 0.21, distDrive: 0.0, dur: 0.5, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.09, phaseOffset: 0.25, rate: 4.26, rateMod: 0.78, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.0, revTime: 0.92, reverbSend: 0.11, speed: 2.0, startPos: 0.0, tempo: 119.0, variant: 1.0, volume: 0.45, volumeMod: 1.0),
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
			(atk: 0.0, bankName: 'CLAPS', cloudsSend: 0.0, decay: 0.16, delaySend: 0.37, distAmount: 0.0, distDrive: 0.0, dur: Rest(4.0), legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.01, phaseOffset: 0.75, rate: 2.07, rateMod: 0.0, revDamp: 0.48, revDrywet: 0.46, revFreeze: 0.0, revHp: 0.28, revTime: 1.09, reverbSend: 0.5, speed: 1.0, startPos: 0.0, tempo: 119.0, variant: 2.0, volume: 0.48, volumeMod: 1.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: Pseq((1 ! 23) ++ [1/4], inf).asStream,
				// div: Pseq([1/4], inf).asStream,
				rate: \unit,
				mul: \unit,
				duration: Pseq([Rest(4), 4], inf).asStream,
				decay: \hold,
				distAmount: \hold,
				delaySend: \gate_every5,
				div: \unit,
				reverbSend: \sweep_slow,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.0, bankName: 'msp-amencutup', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.38, distDrive: 0.0, dur: 0.5, legato: 30.7, mul: 1.0, mute: 0.0, panDur: 0.03, phaseOffset: 0.0, rate: 3.0, rateMod: 0.0, revDamp: 0.72, revDrywet: 0.16, revFreeze: 0.0, revHp: 0.5, revTime: 0.43, reverbSend: 0.0, speed: 2.0, startPos: 0.0, tempo: 119.0, variant: 0.0, volume: 1.08, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: Pseq((1 ! 6) ++ [1/4] ++ (4 ! 6) ++ [1/2], inf).asStream,
				rate: \unit,
				mul: \unit,
				duration: \backbeat,
				delaySend: \gate_every5,
				variant: Pseq((0..31), inf).asStream,
				decay: \sine_slow,
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
	clouds: (blend: 0.71, density: 0.2, feedback: 0.0, freeze: 0.0, inGain: 1.0, lofi: 0.0, mix: 1.0, mode: 3.0, pitch: 12.0, position: 0.69, reverb: 0.65, size: 0.8, spread: 0.5, texture: 0.26, volume: 0.45),
	delay: (feedback: 0.66, filterFreq: 3347.14, spread: 1.0, time: 0.75),
	reverb: (damp: 0.77, diffuse: 0.44, freeze: 0.0, hp: 0.52, time: 0.9)
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
	lfo7: (freq: 3.8663711547852), // plaits 1 timbre
	lfo8: (freq: 0.16666666666667), // plaits 1 morph
	lfo11: (freq: 2.8699998855591, shape: 1), // plaits 1 volume
	lfo13: (freq: 1.0, shape: 1, base: true), // plaits 2 timbre
	lfo14: (freq: 0.94999998807907, base: true), // plaits 2 morph
	lfo15: (freq: 1.1282004117966), // plaits 2 decay
	lfo16: (freq: 0.33333333333333, shape: 4), // plaits 2 pitch
	lfo17: (freq: 8.0478563308716, shape: 2), // plaits 2 volume
	lfo18: (freq: 1.6529215574265), // plaits 2 harm
	lfo19: (freq: 0.46420365571976), // sample 0 rate
	lfo20: (freq: 3.8411104679108), // sample 0 volume
	lfo21: (freq: 0.083333333333333), // sample 1 rate
	lfo22: (freq: 4.7915077209473), // sample 1 volume
	lfo23: (freq: 1.344375371933), // sample 2 rate
	lfo29: (freq: 0.20000000298023), // plaits 1 amDepth
	lfo32: (shape: 4), // plaits 1 amRatio
);
~base = 0.5;
// $LFO_SOURCES_END

// ~base = 0.5;
// ~dreads.lfoSources[\lfo1].freq = ~base + 0.04;
// ~dreads.lfoSources[\lfo4].freq = ~base + 0.03;
// ~dreads.lfoSources[\lfo5].freq = ~base;
// ~dreads.lfoSources[\lfo5].freq = ~base/5;

~applyPatch.();
)

