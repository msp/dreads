////////////////////////////////////////////////////////////////////////////////
// FM Patch Preview Preset
// PLAITS1 configured for clean FM auditioning — load this, then run fm-patches.scd
////////////////////////////////////////////////////////////////////////////////
(
~p1cycle = 32 * 3;   // PLAITS1 stumble period in steps; PLAITS1's div and PLAITS2's harm window both derive from this
// ~div = (1 ! 20) ++ [1, 1, 2] ++ (3 ! 7);
// Ganged across both voices — one shared live stream, locked timing (see ~gang in utils).
// ~div = ~gang.(Pseq((1/8 ! 5) ++ [ Pxrand([1, 2, 3, 1/4], 1) ], inf));
// ~div = ~gang.(Pseq((1/8 ! 5) ++ [ Pxrand([1], 15) ], inf));
~div = ~gang.(
	Pselect(
		// { 0.6.coin }, // keep each with N% chance → thinned
		{ 1.0.coin },
		// Pseq((1/8 ! 5) ++ [ Pxrand([1], 15) ], inf)
		Pseq((1/2 ! 15) ++ [ Pxrand([1/2, 1, 2], 5) ], inf)
    )
);
~duration = ~gang.(
	~mask.(
		Pseed(
			2718,
			// (Pbrown(0.1, 0.6, 0.1, inf) + Pbrown(0.0, 0.1, 0.05, inf)
			(
				// Pbrown(0.1, 2.6, 0.9, inf) + Pbrown(0.0, 0.1, 0.05, inf)
				// Pbrown(0.1, 1.6, 0.2, inf) + Pbrown(0.0, 0.1, 0.05, inf)
				Pbrown(0.1, 0.6, 0.1, inf) + Pbrown(0.0, 0.1, 0.05, inf)
			)
		),
		// Pseq([0] ++ (1 ! 11) ++ (0 ! 12), inf)   // 0=play 1=rest: step 1 plays, 2–12 rest, 13–24 play
		// Pseq( (0 ! 24) ++ (1 ! 24), inf)
		Pseq( (0 ! 24) ++ (1 ! 24), inf)
		// Pseq([0] ++ (1 ! 11) ++ (0 ! 12), inf) // step 1 throws delay, rest 2–12, swell at 24 fires
	)
);

// ~duration = ~gang.(
// 	~mask.(
// 		Pseed(2718, (Pbrown(0.1, 1.6, 0.2, inf) + Pbrown(0.0, 0.1, 0.05, inf))),
// 		Pseq([0] ++ (1 ! 11) ++ (0 ! 12), inf)   // play 1, rest 2–12, play 13–24
// 	)
// );
~dreads = ~patchFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.0, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.48, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(1.0121901273727), engine: 13.0, fmMod: 0.89, harm: 0.84, harmMod: 0.0, legato: 8.0, lpgColour: 0.5, morph: 0.79, morphMod: 0.88, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 28.87, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.88, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.83, revTime: 0.82, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 0.0, tempo: 170.0, timbMod: 0.03, timbre: 0.96, volume: 0.98, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: ~div.asStream,
				// duration: \gauss,
				duration: ~duration.asStream,
				// div: Pseq((1 ! 11) ++ [1/2], inf).asStream,
				// Stumble every ~p1cycle steps (set below), recording its step on the voice so PLAITS2
				// can react. ~p1cycle is the single source of truth for the period — PLAITS2 derives from it.
/*				div: Pfunc {
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
						1/2
					} { 1 };
				}.asStream,*/
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
			(amDepth: 0.0, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.01, decay: 0.47, decayMod: 0.68, delaySend: 0.07, distAmount: 0.38, distDrive: 0.0, droneMode: 0.0, dur: Rest(1.0121901273727), engine: 19.0, fmMod: -0.02, harm: 0.14, harmMod: 0.0, legato: 15.0, lpgColour: 0.5, morph: 0.01, morphMod: 0.8, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 53.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.59, revDrywet: 0.5, revFreeze: 0.0, revHp: 0.84, revTime: 1.11, reverbSend: 0.13, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 170.0, timbMod: 0.07, timbre: 0.46, volume: 0.58, volumeMod: 0.1),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: ~div.asStream,
				// duration: \gauss,
				duration: ~duration.asStream,
				// pitch: \hold,
				pitch: (
					Pseq((0 ! 20) ++ (5 ! 2), inf)
					// Pseq([0], inf) // root walk underneath
					// Pseq([0, 3, 5, 7], inf) // root walk underneath
					// Pbrown(0, 12, 6, inf).round(1) // root walk underneath
					// Pbrown(0, 6, 6, inf).round(1) // root walk underneath
					+ Pseq((~chords[\major7] ! 22) ++ (~chords[\minor7] ! 2), inf)
				).asStream,
				delaySend: Pseq([1] ++ (0 ! 23), inf).asStream,
				distAmount: Pseq((0 ! 23) ++ [1], inf).asStream,
				revDrywet: Pseq((0 ! 23) ++ [1], inf).asStream,
				// delaySend: Pseq([1] ++ (0 ! 23), inf).asStream,
				harm: Pfunc { if ((~dreads.synths[0].divStep ? 0) % ~p1cycle >= (~p1cycle - 4)) { 0.87 } { 0.64 } }.asStream,
				mul: Pfunc { if ((~dreads.synths[0].divStep ? 0) % ~p1cycle >= (~p1cycle - 4)) { 0.05 } { 0.5 } }.asStream,
				revHp: \sine_slow,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.07, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.07, amRingMod: 0.0, amWave: 2.0, cloudsSend: 0.0, decay: 0.13, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(1.0121901273727), engine: 19.0, fmMod: -0.02, harm: 0.7, harmMod: 0.0, legato: 9.0, lpgColour: 0.5, morph: 0.29, morphMod: 0.54, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 41.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.5, revDrywet: 0.05, revFreeze: 0.0, revHp: 0.53, revTime: 0.59, reverbSend: 0.09, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 170.0, timbMod: 0.29, timbre: 0.37, volume: 0.46, volumeMod: 0.88),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: Pseq([1, 1/4, 1], inf).asStream,
				// div: Pseq((1 ! 31) ++ [1/2] ++ (1 ! 31) ++ [1/4], inf).asStream,
				// duration: \gauss,
				// duration: (Pbrown(0.2, 0.6, 0.1, inf) + Pbrown(0.0, 0.1, 0.05, inf)).asStream,
				// duration: Pseed(2718, (Pbrown(0.2, 0.6, 0.1, inf) + Pbrown(0.0, 0.1, 0.05, inf))).asStream,
				duration: ~duration.asStream,
				div: ~div.asStream,
				// pitch: \triad_min_inv,
				// pitch: Pxrand([0, 3, 7, 12, 7, 3], inf).asStream,
				pitch: Pwrand([0, 3, 7, 12], [0.8, 0.6, 0.4, 0.2].normalizeSum, inf).asStream,
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
			(atk: 0.0, bankName: 'CLAPS', cloudsSend: 0.0, decay: 0.29, delaySend: 0.0, distAmount: 0.21, distDrive: 0.0, dur: Rest(1.0121901273727), legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.01, phaseOffset: 0.0, rate: 1.59, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.32, revFreeze: 0.0, revHp: 0.0, revTime: 0.92, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 170.0, variant: 2.0, volume: 0.7, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				duration: ~duration.asStream,
				div: ~div.asStream,
				rate: \hold,
				mul: \unit,
				startPos: \hold,
				// distAmount: \gate_every3,
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
			(atk: 0.0, bankName: 'CLAPS', cloudsSend: 0.0, decay: 0.16, delaySend: 0.37, distAmount: 0.0, distDrive: 0.0, dur: Rest(1.117181634903), legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.01, phaseOffset: 0.75, rate: 2.07, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.31, revFreeze: 0.0, revHp: 0.19, revTime: 0.63, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 170.0, variant: 2.0, volume: 0.48, volumeMod: 1.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				rate: \unit,
				mul: \unit,
				// duration: Pseq([Rest(1), 1], inf).asStream,
				duration: ~duration.asStream,
				div: ~div.asStream,
				decay: \hold,
				distAmount: \hold,
				delaySend: \gate_every16,
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

				// div: \unit,   // own rhythm; PLAITS1 nudges this voice at each stumble (see PLAITS1 div),
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.14, bankName: 'msp-iris-hits', cloudsSend: 0.0, decay: 0.48, delaySend: 0.32, distAmount: 0.14, distDrive: 0.0, dur: Rest(1.0), legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.03, phaseOffset: 0.0, rate: 2.15, rateMod: 0.0, revDamp: 0.53, revDrywet: 0.37, revFreeze: 0.0, revHp: 0.89, revTime: 1.11, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 170.0, variant: 1.0, volume: 0.84, volumeMod: 0.0),
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
	clouds: (blend: 0.26, density: 0.93, feedback: 0.41, freeze: 0.0, inGain: 1.0, lofi: 0.0, mix: 1.0, mode: 3.0, pitch: 1.92, position: 0.69, reverb: 0.55, size: 0.27, spread: 0.5, texture: 0.59, volume: 0.73),
	delay: (feedback: 0.5, filterFreq: 4219.3, spread: 1.5, time: 0.27),
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
	lfo7: (freq: 1.3369700908661, base: true), // plaits 1 timbre
	lfo8: (freq: 0.16666666666667, shape: 4, base: true), // plaits 1 morph
	lfo9: (freq: 3.6820259094238, shape: 4, base: true), // plaits 1 decay
	lfo11: (freq: 2.8699998855591, shape: 1), // plaits 1 volume
	lfo13: (freq: 0.82041555643082, shape: 1), // plaits 2 timbre
	lfo14: (freq: 1), // plaits 2 morph
	lfo15: (freq: 1.1282004117966), // plaits 2 decay
	lfo16: (freq: 0.33333333333333, shape: 4), // plaits 2 pitch
	lfo17: (freq: 1.0807181596756), // plaits 2 volume
	lfo18: (freq: 1.6529215574265), // plaits 2 harm
	lfo19: (freq: 0.46420365571976), // sample 0 rate
	lfo20: (freq: 3.8411104679108), // sample 0 volume
	lfo21: (freq: 0.083333333333333), // sample 1 rate
	lfo22: (freq: 4.7915077209473), // sample 1 volume
);
~base = 0.27000001072884;
// $LFO_SOURCES_END

// ~base = 0.5;
// ~dreads.lfoSources[\lfo1].freq = ~base + 0.04;
// ~dreads.lfoSources[\lfo4].freq = ~base + 0.03;
// ~dreads.lfoSources[\lfo5].freq = ~base;
// ~dreads.lfoSources[\lfo5].freq = ~base/5;

~applyPatch.();
)

