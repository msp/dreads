////////////////////////////////////////////////////////////////////////////////
// Dreads Patch with global FX
////////////////////////////////////////////////////////////////////////////////
(
~dreads = ~patchFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.0, decay: 0.5, decayMod: 0.3, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(0.25), engine: 13.0, fmMod: 0.47, harm: 0.62, legato: 0.05, lpgColour: 0.5, morph: 0.51, morphMod: 0.16, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 35.27, pitchMod: 0.0, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 120.0, timbMod: 0.0, timbre: 0.76, volume: 1.26, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// duration: \hold,
				duration: \eucl_7_16,
				// duration: Pseq([1/2], inf).asStream,
			div: \unit,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.1, decay: 0.48, decayMod: 0.3, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(0.5), engine: 15.0, fmMod: 0.0, harm: 0.66, legato: 9.0, lpgColour: 0.5, morph: 0.23, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 93.78, pitchMod: 0.0, revDamp: 0.8, revDrywet: 0.24, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 120.0, timbMod: 0.67, timbre: 0.72, volume: 0.49, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// duration: \hold,
				duration: \offbeat,
				// duration: Pseq([Rest(1/4), 1/4], inf).asStream,
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
			(cloudsSend: 0.0, decay: 0.29, decayMod: 0.3, delaySend: 0.41, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(0.25), engine: 2.0, fmMod: 0.0, harm: 0.86, legato: 4.0, lpgColour: 0.5, morph: 0.64, morphMod: 0.05, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 27.64, pitchMod: 0.0, revDamp: 0.4, revDrywet: 0.46, revFreeze: 0.0, revHp: 0.72, revTime: 1.04, reverbSend: 0.52, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 120.0, timbMod: 0.59, timbre: 0.48, volume: 1.05, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \eucl_7_16,
				delaySend: \gate_every8,
			div: \unit,
			distAmount: \gate_every8,
			reverbSend: \gate_every8,
			revDrywet: \gate_every8,
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
			(atk: 0.0, bankName: 'CLAPS', cloudsSend: 0.0, decay: 0.19, delaySend: 0.43, distAmount: 0.0, distDrive: 0.0, dur: 1.5, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.05, rateMod: 0.0, revDamp: 0.55, revDrywet: 0.4, revFreeze: 0.0, revHp: 0.33, revTime: 0.48, reverbSend: 0.2, speed: 0.5, startPos: 0.0, tempo: 120.0, variant: 2.0, volume: 1.01, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				duration: \sprs_dotted,

				// duration: Pseq([2], inf).asStream,
				reverbSend: \gate_every4,
				div: \unit,
				rate: \unit,
				mul: \unit,
			delaySend: \gate_every8,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.21, bankName: 'default', cloudsSend: 0.0, decay: 0.06, delaySend: 0.16, distAmount: 0.0, distDrive: 0.0, dur: 0.25, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.73, revDrywet: 0.35, revFreeze: 0.0, revHp: 0.36, revTime: 0.5, reverbSend: 0.0, speed: 4.0, startPos: 0.0, tempo: 120.0, variant: 0.0, volume: 0.92, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \unit,
				mul: \unit,
				duration: \unit,
			atk: \sine_slow,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.18, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 0.25, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.07, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 4.0, startPos: 0.0, tempo: 120.0, variant: 0.0, volume: 1.07, volumeMod: 0.0),
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
	clouds: (blend: 0.5, density: 0.7, feedback: 0.0, freeze: 0.0, inGain: 1.0, lofi: 0.0, mix: 1.0, mode: 3.0, pitch: 0.5, position: 0.5, reverb: 0.24, size: 0.5, spread: 0.5, texture: 0.5, volume: 1.0),
	delay: (feedback: 0.48, filterFreq: 3979.03, spread: 1.5, time: 0.72),
	reverb: (damp: 0.27, diffuse: 0.63, freeze: 0.0, hp: 0.35, time: 0.74)
),
	// $PRESET_FX_END
);

~states = Pseq([\a, \b, \c, \d], inf).asStream;
~state = ~states.next;
~playCount = 0;

~tempoClock.tempo = ~dreads.synths[0].tempo/60;

// $LFO_SOURCES_START
~dreads.lfoSources = (
	lfo2: (freq: 0.0333), // plaits 0 morph
	lfo3: (freq: 0.0667), // plaits 0 decay
	lfo7: (freq: 0.0333), // plaits 1 morph
	lfo8: (freq: 0.0667), // plaits 1 decay
	lfo12: (freq: 0.0333), // plaits 2 morph
	lfo13: (freq: 0.0667), // plaits 2 decay
);
// $LFO_SOURCES_END

~applyPatch.();
// --- livecoding area ---
~base = 0.3;
// Test
~lfoTweak.(\plaits, 2, \volume, (freq: ~base/7, shape: \sine, mod: 0.95));
~lfoTweak.(\plaits, 2, \decay, (freq: ~base, shape: \tri, width: 0.3, mod: 0.3));
~lfoTweak.(\plaits, 2, \morph, (freq: ~base*2, shape: \noise, width: 0.3, mod: 0.0));
~lfoTweak.(\plaits, 2, \pitch, (freq: 20, shape: \noise, mod: 0.9));
~lfoTweak.(\plaits, 2, \timbre, (freq: ~base, shape: \noise, mod: 0.3));

)
// 