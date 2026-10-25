////////////////////////////////////////////////////////////////////////////////
// FM Patch Preview Preset
// PLAITS1 configured for clean FM auditioning — load this, then run fm-patches.scd
////////////////////////////////////////////////////////////////////////////////
(
~p1cycle = 32 * 16;

~dreads = ~patchFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.0, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.53, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 0.25, engine: 13.0, fmMod: 1.0, harm: 0.67, harmMod: 0.0, legato: 8.0, lpgColour: 0.5, morph: 0.58, morphMod: 0.62, mul: 0.5, mute: 0.0, phaseOffset: 0.25, pitch: 29.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.88, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.83, revTime: 0.82, reverbSend: 0.0, sendToPhones: 0.0, speed: 2.0, stereoMode: 0.0, tempo: 125.0, timbMod: 0.39, timbre: 0.96, volume: 1.51, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \eucl_3_8,
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
						// shift = [1/4, 1/4, 1/4, 1/4, 1].wrapAt(i);
						shift = 1/2;
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
			(amDepth: 0.0, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.12, decayMod: 0.0, delaySend: 0.26, distAmount: 0.11, distDrive: 0.1, droneMode: 0.0, dur: 0.75, engine: 4.0, fmMod: 0.07, harm: 0.6, harmMod: 0.0, legato: 1.0, lpgColour: 0.03, morph: 0.61, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: -0.5, pitch: 43.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.78, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.84, revTime: 1.12, reverbSend: 0.09, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 125.0, timbMod: 0.0, timbre: 0.16, volume: 0.59, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: Pseq((2 ! 79) ++ [1], inf).asStream,
				div: Pseq((2 ! 79) ++ [2], inf).asStream,
				// duration: \dense_burst,
				duration: \tresillo,

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
					(~chords[\add11] ! 18)
				, inf).asStream,
				delaySend: \gate_every5,

				// delaySend: Pseq([1] ++ (0 ! 23), inf).asStream,
				// 0.24
				// 0.53 (main)
				// 0.73
				harm: \hold,

				// harm: Pseq((0.53 ! 160), inf).asStream,
				// harm: Pseq((0.53 ! 150) ++ (0.73 ! 10), inf).asStream,
				// harm: Pfunc { if ((~dreads.synths[0].divStep ? 0) % ~p1cycle >= (~p1cycle - 4)) { 0.64 } { 0.87 } }.asStream,
				revHp: \sine,
				revDrywet: \hold,
				distAmount: \sweep_slow,
				revTime: \sine_slow,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.07, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.07, amRingMod: 0.0, amWave: 2.0, cloudsSend: 0.03, decay: 0.37, decayMod: 0.0, delaySend: 0.32, distAmount: 0.07, distDrive: 0.0, droneMode: 1.0, dur: 2.46, engine: 19.0, fmMod: -0.02, harm: 0.92, harmMod: 0.0, legato: 9.0, lpgColour: 0.5, morph: 0.45, morphMod: 0.59, mul: 0.5, mute: 1.0, phaseOffset: -0.25, pitch: 56.35, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.86, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.53, revTime: 0.43, reverbSend: 0.0, sendToPhones: 0.0, speed: 0.25, stereoMode: 1.0, tempo: 125.0, timbMod: 0.61, timbre: 0.85, volume: 0.39, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: Pseq((1 ! 31) ++ [1/2] ++ (1 ! 31) ++ [1/4], inf).asStream,
				div: Pseq((1 ! 15) ++ (2 ! 5), inf).asStream,
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
			(atk: 0.0, bankName: 'HATS', cloudsSend: 0.0, decay: 0.08, delaySend: 0.26, distAmount: 0.0, distDrive: 0.0, dur: 0.5, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.06, phaseOffset: 0.25, rate: 3.87, rateMod: 0.0, revDamp: 0.49, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.65, revTime: 0.2, reverbSend: 0.0, speed: 2.0, startPos: 0.21, tempo: 125.0, variant: 3.0, volume: 1.24, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \hold,
				mul: \unit,
				duration: \tresillo,
				startPos: \hold,
				distAmount: \gate_every3,
				decay: \hold,
				atk: \hold,
				delaySend: \gate_every5,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.0, bankName: 'CLAPS', cloudsSend: 0.0, decay: 0.1, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 0.25, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.1, phaseOffset: 0.25, rate: 1.82, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.19, revTime: 0.63, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 125.0, variant: 1.0, volume: 0.4, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				// div: Pseq((1 ! 23) ++ [1/4], inf).asStream,
				rate: \unit,
				mul: \unit,
				// duration: \offbeat,
				duration: \eucl_5_16,

				// duration: Pseq([Rest(1), 1], inf).asStream,
				decay: \hold,
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
			(atk: 0.03, bankName: 'msp-iris-hits', cloudsSend: 0.0, decay: 0.06, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 0.5, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.03, phaseOffset: 0.25, rate: 3.95, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.33, revTime: 0.76, reverbSend: 0.0, speed: 2.0, startPos: 0.0, tempo: 125.0, variant: 14.0, volume: 0.83, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \hold,
				mul: \unit,
				duration: \tresillo,
				delaySend: \gate_every5,
				// variant: Prand((0..10), inf).asStream,
				decay: \hold,
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
	delay: (feedback: 0.43, filterFreq: 226.69, spread: 1.5, time: 0.49),
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
	lfo2: (freq: 2.8499732017517), // plaits 0 morph
	lfo3: (freq: 0.16666666666667), // plaits 0 decay
	lfo4: (freq: 1.2, shape: 3), // plaits 0 pitch
	lfo5: (freq: 1.2), // plaits 0 volume
	lfo6: (freq: 1.0), // plaits 0 harm
	lfo7: (freq: 4.6654090881348, shape: 4, width: 0.28535902500153), // plaits 1 timbre
	lfo8: (freq: 0.90773159265518, shape: 4), // plaits 1 morph
	lfo11: (freq: 2.8699998855591, shape: 1), // plaits 1 volume
	lfo13: (freq: 5.3631162643433, shape: 1), // plaits 2 timbre
	lfo14: (freq: 0.93000000715256), // plaits 2 morph
	lfo15: (freq: 1.1282004117966), // plaits 2 decay
	lfo16: (freq: 0.33333333333333, shape: 4), // plaits 2 pitch
	lfo17: (freq: 0.050000000745058), // plaits 2 volume
	lfo18: (freq: 1.6529215574265), // plaits 2 harm
	lfo19: (freq: 0.20000000298023), // sample 0 rate
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