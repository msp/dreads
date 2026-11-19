////////////////////////////////////////////////////////////////////////////////
// FM Patch Preview Preset
// PLAITS1 configured for clean FM auditioning — load this, then run fm-patches.scd
////////////////////////////////////////////////////////////////////////////////
(
~p1cycle = 32 * 8000  ;   // PLAITS1 stumble period in steps; PLAITS1's div and PLAITS2's harm window both derive from this

~dreads = ~patchFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.0, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.61, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(0.25), engine: 13.0, fmMod: 0.5, harm: 0.7, harmMod: 0.0, legato: 8.0, lpgColour: 0.5, morph: 0.65, morphMod: 0.39, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 30.0, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.88, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.83, revTime: 0.82, reverbSend: 0.06, sendToPhones: 0.0, speed: 1.0, stereoMode: 0.0, tempo: 85.0, timbMod: 0.03, timbre: 0.21, volume: 0.95, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// duration: \kik_half_time,
				duration: Pseq([
					Pwrand([Rest(1/4), 1/4], [0.1, 0.9].normalizeSum),
					Rest(1/2),
					1/2,
					Rest(1/4),
					// Rest(1/4),
					Pwrand([Rest(1/4), 1/4], [0.8, 0.2].normalizeSum),
					Pwrand([Rest(1/4), 1/4], [0.9, 0.1].normalizeSum),
				] , inf).asStream,
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
						// 1/2
						1 // make 1/2 to shift
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
			(amDepth: 0.0, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.0, amRingMod: 0.0, amWave: 0.0, cloudsSend: 0.0, decay: 0.19, decayMod: 0.0, delaySend: 0.19, distAmount: 0.08, distDrive: 0.0, droneMode: 0.0, dur: 8.0, engine: 19.0, fmMod: -0.02, harm: 0.08, harmMod: 0.0, legato: 15.0, lpgColour: 0.5, morph: 0.15, morphMod: 0.69, mul: 0.5, mute: 0.0, phaseOffset: 1.0, pitch: 28.33, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.58, revDrywet: 0.53, revFreeze: 0.0, revHp: 0.64, revTime: 0.94, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 85.0, timbMod: 0.63, timbre: 0.7, volume: 1.23, volumeMod: 0.1),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// duration: \offbeat,
				pitch: Pseq([~chords[\minor7]], inf).asStream,
				delaySend: Pseq([1] ++ (0 ! 9), inf).asStream,
				// harm: Pfunc { if ((~dreads.synths[0].divStep ? 0) % ~p1cycle >= (~p1cycle - 4)) { 0.87 } { 0.64 } }.asStream,
				// mul: Pfunc { if ((~dreads.synths[0].divStep ? 0) % ~p1cycle >= (~p1cycle - 4)) { 0.3 } { 0.5 } }.asStream,
				revHp: \sine,
				revDrywet: \hold,
				div: Pseq([1/8], inf).asStream,
				duration: \unit,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(amDepth: 0.07, amDepthMod: 0.0, amFixedHz: 0.0, amRatio: 1.0, amRatioMod: 0.0, amRing: 0.07, amRingMod: 0.0, amWave: 2.0, cloudsSend: 0.0, decay: 0.19, decayMod: 0.0, delaySend: 0.26, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 0.5, engine: 15.0, fmMod: -0.02, harm: 0.78, harmMod: 0.0, legato: 9.0, lpgColour: 0.5, morph: 0.2, morphMod: 0.15, mul: 0.5, mute: 0.0, phaseOffset: -0.25, pitch: 83.85, pitchMod: 0.0, releaseTime: 1.0, revDamp: 0.41, revDrywet: 0.52, revFreeze: 0.0, revHp: 0.35, revTime: 0.43, reverbSend: 0.09, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 85.0, timbMod: 0.61, timbre: 0.27, volume: 0.25, volumeMod: 0.1),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: Pseq([1, 1/4, 1], inf).asStream,
				// div: Pseq((1 ! 31) ++ [1/2] ++ (1 ! 31) ++ [1/4], inf).asStream,
				duration: \offbeat,
				pitch: \triad_min_inv,
				delaySend: \gate_every16,
				revDrywet: \hold,
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
			(atk: 0.22, bankName: 'HATS', cloudsSend: 0.12, decay: 0.49, delaySend: 0.0, distAmount: 0.15, distDrive: 0.27, dur: 2.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.1, phaseOffset: -0.25, rate: 0.34, rateMod: 0.78, revDamp: 0.8, revDrywet: 0.44, revFreeze: 0.0, revHp: 0.53, revTime: 0.31, reverbSend: 0.16, speed: 1.0, startPos: 0.15, tempo: 85.0, variant: 4.0, volume: 0.19, volumeMod: 1.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: Pseq((2 ! 6) ++ (1/2 ! 3) ++ (1 ! 6) ++ [4], inf).asStream,
				rate: \hold,
				mul: \unit,
				duration: \unit,
				startPos: \hold,
				distAmount: \hold,
				decay: \sine,
				revDrywet: \sweep_slow,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.0, bankName: 'msp-breaks157', cloudsSend: 0.0, decay: 0.07, delaySend: 0.0, distAmount: 0.13, distDrive: 0.24, dur: Rest(1.0), legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.17, phaseOffset: 0.5, rate: 1.06, rateMod: 0.0, revDamp: 0.38, revDrywet: 0.17, revFreeze: 0.0, revHp: 0.37, revTime: 0.21, reverbSend: 0.05, speed: 1.0, startPos: 0.48, tempo: 85.0, variant: 0.0, volume: 1.53, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				// div: Pseq((1 ! 23) ++ [1/4], inf).asStream,
				rate: \hold,
				mul: \unit,
				// duration: \offbeat,
				duration: Pseq([
					Pseq([Rest(1), 1], 31),
					Pseq([1, 1], 1),
					Pseq([Rest(1), Rest(1)], 1)
				], inf).asStream,
				div: Pseq((1 ! 8), inf).asStream,
				decay: \hold,
				distAmount: \hold,
				delaySend: \hold,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.09, bankName: 'msp-form-msp1', cloudsSend: 0.16, decay: 0.81, delaySend: 0.11, distAmount: 0.06, distDrive: 0.03, dur: Rest(1.0), legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.15, phaseOffset: 0.0, rate: 0.67, rateMod: 0.0, revDamp: 0.46, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.82, revTime: 0.23, reverbSend: 0.18, speed: 1.0, startPos: 0.06, tempo: 85.0, variant: 0.0, volume: 1.07, volumeMod: 0.83),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: Pseq((1 ! 15) ++ [1/2], inf).asStream,
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
	lfo19: (freq: 1.2999999523163, shape: 1), // sample 0 rate
	lfo20: (freq: 1.479759812355), // sample 0 volume
	lfo21: (freq: 0.49073496460915, shape: 4, base: true), // sample 1 rate
	lfo22: (freq: 0.019999999552965), // sample 1 volume
	lfo23: (freq: 0.058616054058075, shape: 1), // sample 2 rate
	lfo24: (freq: 0.13489186763763, base: true), // sample 2 volume
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

