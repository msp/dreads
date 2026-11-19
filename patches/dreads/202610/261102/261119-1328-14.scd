////////////////////////////////////////////////////////////////////////////////
// FM Patch Preview Preset
// PLAITS1 configured for clean FM auditioning — load this, then run fm-patches.scd
////////////////////////////////////////////////////////////////////////////////
(
~p1cycle = 32 * 3;   // PLAITS1 stumble period in steps; PLAITS1's div and PLAITS2's harm window both derive from this

~dreads = ~patchFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.0, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.53, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(0.25), engine: 13.0, fmMod: 1.0, harm: 0.83, harmMod: 0.0, legato: 8.0, lpgColour: 0.5, morph: 0.61, morphMod: 0.01, mul: 0.5, mute: 1.0, phaseOffset: 0.75, pitch: 30.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.88, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.83, revTime: 0.82, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 0.0, tempo: 85.0, timbMod: 0.03, timbre: 0.96, volume: 1.26, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \kik_half_time,
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
			(amDepth: 0.0, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.53, decayMod: 0.0, delaySend: 0.32, distAmount: 0.08, distDrive: 0.0, droneMode: 0.0, dur: Rest(1.0), engine: 19.0, fmMod: -0.02, harm: 0.55, harmMod: 0.0, legato: 15.0, lpgColour: 0.5, morph: 0.53, morphMod: 0.0, mul: 0.5, mute: 1.0, phaseOffset: 0.75, pitch: 40.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.82, revDrywet: 0.21, revFreeze: 0.0, revHp: 0.84, revTime: 1.11, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 85.0, timbMod: 0.0, timbre: 0.18, volume: 1.14, volumeMod: 0.1),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: Pseq((1 ! 20) ++ [1, 1, 2] ++ (1 ! 7), inf).asStream,
				duration: \dense_burst,
				pitch: \hold,
				delaySend: Pseq([1] ++ (0 ! 9), inf).asStream,
				harm: Pfunc { if ((~dreads.synths[0].divStep ? 0) % ~p1cycle >= (~p1cycle - 4)) { 0.87 } { 0.64 } }.asStream,
				mul: Pfunc { if ((~dreads.synths[0].divStep ? 0) % ~p1cycle >= (~p1cycle - 4)) { 0.3 } { 0.5 } }.asStream,
				revHp: \sine,
				revDrywet: \sine_slow,
				div: \unit,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.07, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.07, amRingMod: 0.0, amWave: 2.0, cloudsSend: 0.0, decay: 0.0, decayMod: 0.0, delaySend: 0.26, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 0.25, engine: 19.0, fmMod: -0.02, harm: 0.78, harmMod: 0.0, legato: 9.0, lpgColour: 0.5, morph: 0.35, morphMod: 0.15, mul: 0.5, mute: 1.0, phaseOffset: -0.25, pitch: 42.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.86, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.53, revTime: 0.43, reverbSend: 0.09, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 85.0, timbMod: 0.61, timbre: 0.65, volume: 0.56, volumeMod: 0.91),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: Pseq([1, 1/4, 1], inf).asStream,
				div: Pseq((1 ! 31) ++ [1/2] ++ (1 ! 31) ++ [1/4], inf).asStream,
				duration: \dense_burst,
				pitch: \triad_min_inv,
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
			(atk: 0.09, bankName: 'msp-form-msp1', cloudsSend: 0.12, decay: 0.21, delaySend: 0.16, distAmount: 0.11, distDrive: 0.27, dur: 0.25, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.1, phaseOffset: -0.25, rate: 2.14, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.4, revFreeze: 0.0, revHp: 0.0, revTime: 0.31, reverbSend: 0.15, speed: 4.0, startPos: 0.54, tempo: 85.0, variant: 0.0, volume: 0.55, volumeMod: 0.3),
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
			(atk: 0.14, bankName: 'hum', cloudsSend: 0.63, decay: 0.55, delaySend: 0.15, distAmount: 0.12, distDrive: 0.24, dur: 2.0, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.09, phaseOffset: 0.75, rate: 2.31, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.02, revFreeze: 0.0, revHp: 0.19, revTime: 0.56, reverbSend: 0.13, speed: 0.5, startPos: 0.4, tempo: 85.0, variant: 2.0, volume: 0.36, volumeMod: 1.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				// div: Pseq((1 ! 23) ++ [1/4], inf).asStream,
				rate: \hold,
				mul: \unit,
				// duration: \offbeat,
				duration: Pseq([Rest(1), 1], inf).asStream,
				decay: \hold,
				distAmount: \hold,
				delaySend: \hold,
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
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.1, bankName: 'halfmastv6', cloudsSend: 0.16, decay: 0.35, delaySend: 0.11, distAmount: 0.16, distDrive: 0.03, dur: Rest(1.0), legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.19, phaseOffset: 0.0, rate: 3.78, rateMod: 0.0, revDamp: 0.46, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.82, revTime: 0.23, reverbSend: 0.18, speed: 1.0, startPos: 0.37, tempo: 85.0, variant: 7.0, volume: 1.0, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \hold,
				mul: \unit,
				duration: \backbeat,
				delaySend: \hold,
				variant: Prand((0..10), inf).asStream,
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
	clouds: (blend: 0.26, density: 0.93, feedback: 0.41, freeze: 0.0, inGain: 1.0, lofi: 0.0, mix: 1.0, mode: 3.0, pitch: 1.92, position: 0.69, reverb: 0.55, size: 0.27, spread: 0.5, texture: 0.59, volume: 0.73),
	delay: (feedback: 0.62, filterFreq: 3799.41, spread: 1.5, time: 0.71),
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
	lfo13: (freq: 5.3631162643433, shape: 1), // plaits 2 timbre
	lfo14: (freq: 1), // plaits 2 morph
	lfo15: (freq: 1.1282004117966), // plaits 2 decay
	lfo16: (freq: 0.33333333333333, shape: 4), // plaits 2 pitch
	lfo17: (freq: 8.0478563308716, shape: 2), // plaits 2 volume
	lfo18: (freq: 1.6529215574265), // plaits 2 harm
	lfo19: (freq: 3.7116294503212, base: true), // sample 0 rate
	lfo20: (freq: 1.0327280461788, shape: 1, base: true), // sample 0 volume
	lfo21: (freq: 0.68988317251205, shape: 2, base: true), // sample 1 rate
	lfo22: (freq: 0.42312270998955, shape: 2), // sample 1 volume
	lfo23: (freq: 1.2524751722813, shape: 2, base: true), // sample 2 rate
	lfo24: (freq: 2.616741001606, shape: 4, base: true), // sample 2 volume
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

