////////////////////////////////////////////////////////////////////////////////
// FM Patch Preview Preset
// PLAITS1 configured for clean FM auditioning — load this, then run fm-patches.scd
////////////////////////////////////////////////////////////////////////////////
(
~p1cycle = 128;   // PLAITS1 stumble period in steps; PLAITS1's div and PLAITS2's harm window both derive from this

~dreads = ~patchFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.0, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.53, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 10.0, engine: 13.0, fmMod: 1.0, harm: 0.83, harmMod: 0.0, legato: 8.0, lpgColour: 0.5, morph: 0.72, morphMod: 0.32, mul: 0.5, mute: 1.0, phaseOffset: 0.5, pitch: 30.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.88, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.83, revTime: 0.82, reverbSend: 0.0, sendToPhones: 0.0, speed: 0.1, stereoMode: 0.0, tempo: 152.66, timbMod: 0.39, timbre: 0.96, volume: 1.21, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \four_floor,
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
			(amDepth: 0.0, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.04, decayMod: 0.0, delaySend: 0.18, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 2.53, engine: 19.0, fmMod: 1.0, harm: 0.55, harmMod: 0.0, legato: 1.0, lpgColour: 0.5, morph: 0.11, morphMod: 0.78, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 40.0, pitchMod: 0.0, releaseTime: 0.1, revDamp: 0.78, revDrywet: 0.14, revFreeze: 0.0, revHp: 0.84, revTime: 0.9, reverbSend: 0.0, sendToPhones: 0.0, speed: 0.1, stereoMode: 1.0, tempo: 152.66, timbMod: 0.71, timbre: 0.84, volume: 0.38, volumeMod: 0.08),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: Pseq((2 ! 79) ++ [1], inf).asStream,
				div: Pseq((2 ! 79) ++ [2], inf).asStream,
				// duration: \dense_burst,
				duration: \gauss,

				// duration: Pseq([
				// 1/4, 1/4, 1/4, 1/4, Rest(1),
				// 1/4, 1/4, 1/4, 1/4, Rest(1),
				// 1/4, Rest(1/4), 1/4, 1/4, Rest(1),
				// 1/4, 1/4, 1/4, 1/4, 1,
				// 1/4, 1/4, 1/4, 1/4, Rest(1),
				// 1/4, 1/4, 1/4, 1/4, Rest(1),
				// 1/4, 1/4, Rest(1/4), 1/4, Rest(1),
				// 1/4, 1/4, 1/4, 1/4, 1,
				// 1/4, 1/4, 1/4, 1/4, Rest(1),
				// 1/4, 1/4, 1/4, 1/4, Rest(1),
				// 1/4, 1/4, 1/4, Rest(1/4), Rest(1),
				// 1/4, 1/4, 1/4, 1/4, 1,
				// 1/4, 1/4, 1/4, 1/4, Rest(1),
				// 1/4, 1/4, 1/4, 1/4, Rest(1),
				// 1/4, 1/4, 1/4, 1/4, Rest(1),
				// // 1/4, 1/4, 1/4, 1/4, 2
				// 1/4, 1/4, 1/4, 1/4, 1
				// ], inf).asStream,
				pitch: Pseq(
					(~chords[\min13] ! 18)
					// (~chords[\maj7] ! 2)
				, inf).asStream,
				delaySend: Pseq([1] ++ (0 ! 23), inf).asStream,
				// 0.24
				// 0.53 (main)
				// 0.73
				harm: Pseq((0.53 ! 160), inf).asStream,
				// harm: Pseq((0.53 ! 150) ++ (0.73 ! 10), inf).asStream,
				// harm: Pfunc { if ((~dreads.synths[0].divStep ? 0) % ~p1cycle >= (~p1cycle - 4)) { 0.64 } { 0.87 } }.asStream,
				revHp: \sine,
				revDrywet: \sine_slow,
				distAmount: \saw,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.07, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.07, amRingMod: 0.0, amWave: 2.0, cloudsSend: 0.03, decay: 0.37, decayMod: 0.0, delaySend: 0.16, distAmount: 0.11, distDrive: 0.0, droneMode: 0.0, dur: 7.99, engine: 19.0, fmMod: -0.02, harm: 0.78, harmMod: 0.0, legato: 9.0, lpgColour: 0.5, morph: 0.27, morphMod: 0.58, mul: 0.5, mute: 0.0, phaseOffset: -0.25, pitch: 56.35, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.86, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.53, revTime: 0.43, reverbSend: 0.0, sendToPhones: 0.0, speed: 0.25, stereoMode: 1.0, tempo: 152.66, timbMod: 0.73, timbre: 0.88, volume: 0.78, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: Pseq((1 ! 31) ++ [1/2] ++ (1 ! 31) ++ [1/4], inf).asStream,
				// div: Pseq((1 ! 15) ++ (2 ! 5), inf).asStream,
				div: Pxrand([0.25, 0.5, 1, 2, 3, 4], inf).asStream,
				duration: \gauss,
				pitch: \hold,
				delaySend: \gate_every16,
				revDrywet: \hold,
				decay: \hold,
				revTime: \gate_prob05,
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
			(atk: 0.36, bankName: 'HATS', cloudsSend: 0.0, decay: 0.2, delaySend: 0.0, distAmount: 0.21, distDrive: 0.0, dur: Rest(0.5), legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.09, phaseOffset: -0.25, rate: 1.94, rateMod: 0.7, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.0, revTime: 0.92, reverbSend: 0.0, speed: 2.0, startPos: 0.0, tempo: 152.66, variant: 0.0, volume: 0.52, volumeMod: 1.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \hold,
				mul: \unit,
				duration: \dense_burst,
				startPos: \hold,
				distAmount: \gate_every3,
				decay: \sweep_slow,
				atk: \sine,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.0, bankName: 'CLAPS', cloudsSend: 0.12, decay: 0.61, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.01, phaseOffset: 0.5, rate: 1.93, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.02, revFreeze: 0.0, revHp: 0.19, revTime: 0.63, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 152.66, variant: 2.0, volume: 0.67, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				// div: Pseq((1 ! 23) ++ [1/4], inf).asStream,
				rate: \unit,
				mul: \unit,
				// duration: \offbeat,
				duration: \four_floor,

				// duration: Pseq([Rest(1), 1], inf).asStream,
				decay: \gate_every16,
				distAmount: \hold,
				delaySend: \gate_every32,
				// div: \unit,
				// clap accent: double-time flam into PLAITS1's stumble (last 4 steps of ~p1cycle), else straight.
				// Swap 2 → 1/2 for a heavier, dragged emphasis instead of a roll.
				// div: Pfunc { 4 }.asStream,
				// div: Pfunc { if ((~dreads.synths[0].divStep ? 0) % ~p1cycle >= (~p1cycle - 4)) { 8 } { 1 } }.asStream,
				// mirror PLAITS1's stumble exactly: same rule, reading PLAITS1's shared counter so the clap
				// trips in lockstep with it (match phaseOffset to PLAITS1's 0.75 for dead-coincident hits).
				// div: Pfunc { if ((~dreads.synths[0].divStep ? 0) % ~p1cycle == (~p1cycle - 1)) { 1/2 } { 1 } }.asStream,
				// Move WITH PLAITS1: an identical, self-advancing div (same ~p1cycle stumble). Same
				// duration + div + speed keeps the two locked; the phaseOffset gap just fixes the clap's
				// offbeat position, preserved through every stumble. (Lockstep needs speed 1.0 to match PLAITS1.)
				div: \unit,

				// div: \unit,   // own rhythm; PLAITS1 nudges this voice at each stumble (see PLAITS1 div),
				cloudsSend: \gate_every16,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.14, bankName: 'msp-pad', cloudsSend: 0.09, decay: 0.48, delaySend: 0.32, distAmount: 0.14, distDrive: 0.0, dur: Rest(2.0), legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.03, phaseOffset: 0.0, rate: 2.15, rateMod: 0.04, revDamp: 0.8, revDrywet: 0.68, revFreeze: 0.0, revHp: 0.8, revTime: 0.76, reverbSend: 0.49, speed: 0.5, startPos: 0.0, tempo: 152.66, variant: 0.0, volume: 0.36, volumeMod: 0.0),
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
	clouds: (blend: 0.26, density: 0.93, feedback: 0.41, freeze: 0.0, inGain: 1.0, lofi: 0.0, mix: 1.0, mode: 3.0, pitch: 1.92, position: 0.69, reverb: 0.43, size: 0.27, spread: 0.5, texture: 0.59, volume: 0.54),
	delay: (feedback: 0.6, filterFreq: 4058.91, spread: 1.5, time: 0.14),
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
	lfo7: (freq: 4.6654090881348, shape: 4, width: 0.28535902500153), // plaits 1 timbre
	lfo8: (freq: 0.90773159265518, shape: 4), // plaits 1 morph
	lfo11: (freq: 2.8699998855591, shape: 1), // plaits 1 volume
	lfo13: (freq: 5.3631162643433), // plaits 2 timbre
	lfo14: (freq: 1.0182120800018), // plaits 2 morph
	lfo15: (freq: 1.1282004117966), // plaits 2 decay
	lfo16: (freq: 0.33333333333333, shape: 4), // plaits 2 pitch
	lfo17: (freq: 0.050000000745058), // plaits 2 volume
	lfo18: (freq: 1.6529215574265), // plaits 2 harm
	lfo19: (freq: 0.20000000298023), // sample 0 rate
	lfo20: (freq: 3.8411104679108), // sample 0 volume
	lfo21: (freq: 0.083333333333333), // sample 1 rate
	lfo22: (freq: 4.7915077209473), // sample 1 volume
	lfo23: (shape: 4), // sample 2 rate
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