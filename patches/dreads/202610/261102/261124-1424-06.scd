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
			(amDepth: 0.0, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.13, decay: 0.43, decayMod: 0.36, delaySend: 0.12, distAmount: 0.0, distDrive: 0.02, droneMode: 0.0, dur: 0.75, engine: 9.0, fmMod: 0.29, harm: 0.09, harmMod: 0.0, legato: 7.28, lpgColour: 0.16, morph: 0.61, morphMod: 0.19, mul: 0.5, mute: 1.0, phaseOffset: 0.75, pitch: 60.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.88, revDrywet: 0.1, revFreeze: 0.0, revHp: 0.83, revTime: 0.43, reverbSend: 0.03, sendToPhones: 0.0, speed: 1.0, stereoMode: 0.0, tempo: 85.0, timbMod: 0.0, timbre: 0.37, volume: 1.17, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: Pseq([Rest(0.25), 0.25, 0.75, 0.75, 0.5, 0.5, Rest(0.5)], inf).asStream,

				// duration: Pseq([Rest(0.25), 0.25, 0.75, 0.75, 0.5, 0.5, Rest(0.5)], inf).asStream,

				// duration: Pseq([Rest(0.25), 0.25, 0.75, 0.75, 0.5, 0.5, Rest(0.5)], inf).asStream,
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
				delaySend: \hold,
				cloudsSend: \hold,
				revDrywet: \hold,
				harm: \hold,
				pitch: Pseq([12, -3, 7, 0, 12, 5, -5, -3, -7, -3, -12, -5, -5, -3, 3], inf).asStream,

				// pitch: Pseq([12, -3, 7, 0, 12, 5, -5, -3, -7, -3, -12, -5, -5, -3, 3], inf).asStream,

				// pitch: Pseq([12, -3, 7, 0, 12, 5, -5, -3, -7, -3, -12, -5, -5, -3, 3], inf).asStream,
				morph: \hold,
				timbre: \hold,
				distAmount: \hold,
				amDepth: Pseq([0.51, 0.92, 0.33, 0.35, 0.7, 0.77, 0.53, 0.42, 0.81, 0.31, 0.53, 0.1, 0.09, 0.78], inf).asStream,

				// amDepth: Pseq([0.51, 0.92, 0.33, 0.35, 0.7, 0.77, 0.53, 0.42, 0.81, 0.31, 0.53, 0.1, 0.09, 0.78], inf).asStream,

				// amDepth: Pseq([0.51, 0.92, 0.33, 0.35, 0.7, 0.77, 0.53, 0.42, 0.81, 0.31, 0.53, 0.1, 0.09, 0.78], inf).asStream,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.0, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.11, decay: 0.4, decayMod: 0.0, delaySend: 0.14, distAmount: 0.28, distDrive: 0.19, droneMode: 0.0, dur: Rest(0.75), engine: 8.0, fmMod: -0.25, harm: 0.11, harmMod: 0.0, legato: 8.77, lpgColour: 0.75, morph: 0.03, morphMod: 0.11, mul: 0.5, mute: 1.0, phaseOffset: 0.75, pitch: 65.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.49, revDrywet: 1.0, revFreeze: 0.0, revHp: 0.84, revTime: 0.57, reverbSend: 0.17, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 85.0, timbMod: 0.0, timbre: 0.44, volume: 0.28, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: Pseq((1 ! 20) ++ [1, 1, 2] ++ (1 ! 7), inf).asStream,
				duration: Pseq([0.5, 0.75, Rest(0.75), 0.5, Rest(0.75), 1.0, 1.0], inf).asStream,

				// duration: Pseq([0.5, 0.75, Rest(0.75), 0.5, Rest(0.75), 1.0, 1.0], inf).asStream,

				// duration: Pseq([0.5, 0.75, Rest(0.75), 0.5, Rest(0.75), 1.0, 1.0], inf).asStream,
				pitch: \hold,
				delaySend: \hold,

				// delaySend: Pseq([1] ++ (0 ! 9), inf).asStream,
				harm: \hold,

				// harm: Pfunc { if ((~dreads.synths[0].divStep ? 0) % ~p1cycle >= (~p1cycle - 4)) { 0.87 } { 0.64 } }.asStream,
				revHp: \sine,
				revDrywet: \hold,
				div: \unit,
				revDamp: \sweep_slow,
				amDepth: Pseq([0.02, 0.62, 0.53, 0.53, 0.82], inf).asStream,

				// amDepth: Pseq([0.02, 0.62, 0.53, 0.53, 0.82], inf).asStream,

				// amDepth: Pseq([0.02, 0.62, 0.53, 0.53, 0.82], inf).asStream,
				amRing: Pseq([0.81, 0.44, 0.85, 0.75, 0.15, 0.23, 0.59, 0.64, 0.3, 0.69, 0.73, 0.08, 0.22], inf).asStream,

				// amRing: Pseq([0.81, 0.44, 0.85, 0.75, 0.15, 0.23, 0.59, 0.64, 0.3, 0.69, 0.73, 0.08, 0.22], inf).asStream,

				// amRing: Pseq([0.81, 0.44, 0.85, 0.75, 0.15, 0.23, 0.59, 0.64, 0.3, 0.69, 0.73, 0.08, 0.22], inf).asStream,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.07, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.07, amRingMod: 0.0, amWave: 2.0, cloudsSend: 0.25, decay: 0.21, decayMod: 0.0, delaySend: 0.05, distAmount: 0.29, distDrive: 0.03, droneMode: 0.0, dur: 0.5, engine: 21.0, fmMod: -0.03, harm: 0.48, harmMod: 0.46, legato: 6.42, lpgColour: 0.57, morph: 0.23, morphMod: 0.49, mul: 0.5, mute: 1.0, phaseOffset: -0.25, pitch: 57.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.86, revDrywet: 0.35, revFreeze: 0.0, revHp: 0.53, revTime: 0.52, reverbSend: 0.21, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 85.0, timbMod: 0.0, timbre: 0.49, volume: 0.17, volumeMod: 0.76),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: Pseq([1, 1/4, 1], inf).asStream,
				div: Pseq((1 ! 31) ++ [1/2] ++ (1 ! 31) ++ [1/4], inf).asStream,
				duration: Pseq([0.5, 0.25, 0.75, Rest(0.25), 0.5, 1.0, 0.5, 1.0, 0.25, Rest(1.0), 0.5, 0.25, 0.25, 0.5, 0.5], inf).asStream,
				pitch: Pseq([5, -5, -5, 7], inf).asStream,
				delaySend: \hold,
				revDrywet: \hold,
				decay: Pseq([0.78, 0.75, 0.22, 0.58, 0.76, 0.78, 0.86, 0.17, 0.96, 0.6, 0.34, 0.09, 0.06, 0.48], inf).asStream,
				revTime: \hold,
				lpgColour: Pseq([0.07, 0.08, 0.03, 0.36], inf).asStream,
				fmMod: Pseq([0.68, 0.91, 0.5, 0.05, 0.66, 0.86, 0.76, 0.69, 0.67, 0.54, 0.29, 0.47, 0.39], inf).asStream,
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
			(atk: 0.1, bankName: 'msp-loops-msp', cloudsSend: 0.2, decay: 0.34, delaySend: 0.11, distAmount: 0.13, distDrive: 0.21, dur: 0.25, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.4, phaseOffset: -0.25, rate: 1.74, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.48, revFreeze: 0.0, revHp: 0.22, revTime: 0.34, reverbSend: 0.06, speed: 4.0, startPos: 0.55, tempo: 85.0, variant: 0.0, volume: 1.05, volumeMod: 0.28),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: Pseq([1, 1, 0.66666666666667, 0.66666666666667, 0.5, 0.66666666666667, 1, 2, 0.66666666666667, 2, 2, 2, 1.5, 1.5, 1], inf).asStream,
				mul: \unit,
				duration: \unit,
				startPos: \hold,

				// startPos: Pseq([0.77, 0.79, 0.95, 0.5, 0.46, 0.56, 0.13, 0.1, 0.6, 0.03, 0.15, 0.44, 0.37, 0.2, 0.6, 0.27], inf).asStream,

				// startPos: Pseq([0.77, 0.79, 0.95, 0.5, 0.46, 0.56, 0.13, 0.1, 0.6, 0.03, 0.15, 0.44, 0.37, 0.2, 0.6, 0.27], inf).asStream,

				// startPos: Pseq([0.77, 0.79, 0.95, 0.5, 0.46, 0.56, 0.13, 0.1, 0.6, 0.03, 0.15, 0.44, 0.37, 0.2, 0.6, 0.27], inf).asStream,
				distAmount: \hold,
				decay: \hold,
				atk: Pseq([0.57, 0.47, 0.83, 0.47], inf).asStream,

				// atk: Pseq([0.25, 0.95, 0.94, 0.34, 0.69, 0.7, 0.51, 0.73, 0.15, 0.99], inf).asStream,

				// atk: Pseq([0.25, 0.95, 0.94, 0.34, 0.69, 0.7, 0.51, 0.73, 0.15, 0.99], inf).asStream,

				// atk: Pseq([0.25, 0.95, 0.94, 0.34, 0.69, 0.7, 0.51, 0.73, 0.15, 0.99], inf).asStream,
				panDur: \hold,

				// panDur: Pseq([0.05, 0.71, 0.14, 0.02, 0.91, 0.55, 0.6, 1.0, 0.14, 0.33, 0.56, 0.04], inf).asStream,

				// panDur: Pseq([0.05, 0.71, 0.14, 0.02, 0.91, 0.55, 0.6, 1.0, 0.14, 0.33, 0.56, 0.04], inf).asStream,

				// panDur: Pseq([0.05, 0.71, 0.14, 0.02, 0.91, 0.55, 0.6, 1.0, 0.14, 0.33, 0.56, 0.04], inf).asStream,
				revDrywet: \sine_slow,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.28, bankName: 'msp-pad', cloudsSend: 0.05, decay: 0.18, delaySend: 0.02, distAmount: 0.11, distDrive: 0.19, dur: 1.0, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.09, phaseOffset: 0.75, rate: 3.7, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.07, revFreeze: 0.0, revHp: 0.19, revTime: 0.43, reverbSend: 0.13, speed: 1.0, startPos: 0.33, tempo: 85.0, variant: 0.0, volume: 0.73, volumeMod: 0.14),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				// div: Pseq((1 ! 23) ++ [1/4], inf).asStream,
				rate: \hold,
				mul: \unit,
				// duration: \offbeat,
				duration: Pseq([Rest(1), 1], inf).asStream,
				decay: \hold,

				// decay: Pseq([0.98, 0.22, 0.78, 0.46, 0.43, 0.55, 0.31, 0.81], inf).asStream,

				// decay: Pseq([0.98, 0.22, 0.78, 0.46, 0.43, 0.55, 0.31, 0.81], inf).asStream,

				// decay: Pseq([0.98, 0.22, 0.78, 0.46, 0.43, 0.55, 0.31, 0.81], inf).asStream,
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
				panDur: \hold,

				// panDur: Pseq([0.62, 0.33, 0.92, 0.84, 0.76, 0.13, 0.02, 0.42, 0.55, 0.86, 0.33, 0.35, 0.41, 0.33, 0.81], inf).asStream,

				// panDur: Pseq([0.62, 0.33, 0.92, 0.84, 0.76, 0.13, 0.02, 0.42, 0.55, 0.86, 0.33, 0.35, 0.41, 0.33, 0.81], inf).asStream,

				// panDur: Pseq([0.62, 0.33, 0.92, 0.84, 0.76, 0.13, 0.02, 0.42, 0.55, 0.86, 0.33, 0.35, 0.41, 0.33, 0.81], inf).asStream,
				startPos: Pseq([0.13, 0.9, 0.36, 0.19, 0.74, 0.33, 0.34, 0.64], inf).asStream,
				atk: Pseq([0.22, 0.87, 0.7, 0.39, 0.99, 0.26, 0.08, 0.28, 0.28, 0.77, 0.03, 0.93], inf).asStream,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.09, bankName: 'msp-loops-msp', cloudsSend: 0.06, decay: 0.19, delaySend: 0.17, distAmount: 0.29, distDrive: 0.26, dur: 1.0, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.62, phaseOffset: 0.0, rate: 1.99, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.26, revFreeze: 0.0, revHp: 0.33, revTime: 0.51, reverbSend: 0.05, speed: 1.0, startPos: 0.36, tempo: 85.0, variant: 1.0, volume: 0.47, volumeMod: 1.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \hold,

				// rate: Pseq([1, 1, 1, 0.5, 1, 2, 0.5, 0.66666666666667, 2], inf).asStream,
				mul: \unit,
				duration: \backbeat,
				delaySend: \hold,
				variant: Prand((0..10), inf).asStream,
				decay: Pseq([0.57, 0.62, 0.23, 0.97, 0.64], inf).asStream,

				// decay: Pseq([0.35, 0.13, 0.51, 0.08, 0.02, 0.03], inf).asStream,

				// decay: Pseq([0.42, 0.08, 0.69, 0.56, 0.62, 0.42, 0.16, 0.91, 0.18], inf).asStream,

				// decay: Pseq([0.42, 0.08, 0.69, 0.56, 0.62, 0.42, 0.16, 0.91, 0.18], inf).asStream,

				// decay: Pseq([0.42, 0.08, 0.69, 0.56, 0.62, 0.42, 0.16, 0.91, 0.18], inf).asStream,
				startPos: \hold,

				// startPos: Pseq([0.65, 0.1, 0.6, 0.35, 0.87, 0.28, 0.33, 0.19, 0.3, 0.04], inf).asStream,

				// startPos: Pseq([0.74, 0.56, 0.35, 0.67, 0.99, 0.57, 0.13, 0.96, 0.42, 0.4, 0.35, 0.69, 0.55, 0.84, 0.29], inf).asStream,

				// startPos: Pseq([0.74, 0.56, 0.35, 0.67, 0.99, 0.57, 0.13, 0.96, 0.42, 0.4, 0.35, 0.69, 0.55, 0.84, 0.29], inf).asStream,

				// startPos: Pseq([0.74, 0.56, 0.35, 0.67, 0.99, 0.57, 0.13, 0.96, 0.42, 0.4, 0.35, 0.69, 0.55, 0.84, 0.29], inf).asStream,
				panDur: Pseq([0.62, 0.68, 0.35, 0.64, 0.16, 0.13, 0.98, 0.05, 0.31, 0.96, 0.78, 0.64, 0.2, 0.58], inf).asStream,

				// panDur: Pseq([0.92, 0.84, 0.92, 0.84, 0.64, 0.34, 0.18, 0.52, 0.83, 0.54, 0.36, 0.0, 0.2, 0.21, 0.77, 0.04], inf).asStream,

				// panDur: Pseq([0.16, 0.75, 0.02, 0.96, 0.98, 0.4, 0.51, 0.18], inf).asStream,

				// panDur: Pseq([0.16, 0.75, 0.02, 0.96, 0.98, 0.4, 0.51, 0.18], inf).asStream,

				// panDur: Pseq([0.16, 0.75, 0.02, 0.96, 0.98, 0.4, 0.51, 0.18], inf).asStream,
				revDrywet: \hold,
				atk: \hold,

				// atk: Pseq([0.95, 0.41, 0.27, 0.14, 0.8, 0.98, 0.06], inf).asStream,
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
	lfo1: (freq: 1.2791406273842), // plaits 0 timbre
	lfo2: (freq: 1.8708977997303, shape: 1, base: true), // plaits 0 morph
	lfo3: (freq: 0.20855243802071), // plaits 0 decay
	lfo4: (freq: 0.56003596782684, shape: 1), // plaits 0 pitch
	lfo5: (freq: 0.47706388235092), // plaits 0 volume
	lfo6: (freq: 2.2724624872208, base: true), // plaits 0 harm
	lfo7: (freq: 1.4507929384708, shape: 2), // plaits 1 timbre
	lfo8: (freq: 1.3809558153152), // plaits 1 morph
	lfo9: (freq: 0.23757263422012, shape: 2), // plaits 1 decay
	lfo10: (freq: 0.99480583071709), // plaits 1 pitch
	lfo11: (freq: 0.25725224614143, shape: 1, base: true), // plaits 1 volume
	lfo12: (freq: 0.13481176495552), // plaits 1 harm
	lfo13: (freq: 0.27679101228714, shape: 1), // plaits 2 timbre
	lfo14: (freq: 0.65238898396492, shape: 3), // plaits 2 morph
	lfo15: (freq: 1.4908600747585, shape: 1, base: true), // plaits 2 decay
	lfo16: (freq: 0.49765327572823, shape: 1, base: true), // plaits 2 pitch
	lfo17: (freq: 0.72471606135368, shape: 4), // plaits 2 volume
	lfo18: (freq: 0.14124295115471, shape: 1), // plaits 2 harm
	lfo19: (freq: 0.89372578859329, shape: 3), // sample 0 rate
	lfo20: (freq: 0.27165615558624, shape: 1, base: true), // sample 0 volume
	lfo21: (freq: 3.8196214437485, base: true), // sample 1 rate
	lfo22: (freq: 3.6193225681782, base: true), // sample 1 volume
	lfo23: (freq: 2.9553014934063, base: true), // sample 2 rate
	lfo24: (freq: 0.48495954275131, shape: 4), // sample 2 volume
	lfo25: (freq: 0.57565829157829, shape: 1), // plaits 0 amRing
	lfo26: (freq: 3.4901169836521, shape: 1, base: true), // plaits 1 amRing
	lfo27: (freq: 0.15417809486389), // plaits 2 amRing
	lfo28: (freq: 2.6382062733173, shape: 1, base: true), // plaits 0 amDepth
	lfo29: (freq: 1.4856490135193, shape: 1), // plaits 1 amDepth
	lfo30: (freq: 3.840579777956, base: true), // plaits 2 amDepth
	lfo31: (freq: 0.41781109571457, shape: 1), // plaits 0 amRatio
	lfo32: (freq: 0.80048188567162), // plaits 1 amRatio
	lfo33: (freq: 1.4479538202286, shape: 1), // plaits 2 amRatio
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

