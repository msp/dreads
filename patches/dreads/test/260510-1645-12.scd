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
			(cloudsSend: 0.0, decay: 0.5, decayMod: 0.0, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 1.0, dur: 2.0, engine: 6.0, fmMod: 0.47, harm: 0.25, legato: 0.05, lpgColour: 0.5, morph: 0.75, morphMod: 0.0, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 58.0, pitchMod: 0.0, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.08, sendToPhones: 0.0, speed: 0.5, stereoMode: 1.0, tempo: 120.0, timbMod: 0.0, timbre: 0.29, volume: 0.76, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				timbre: \hold,

				// timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
				decay: \gate_burst,

				// decay: Pseq([0.64, 0.69, 0.73, 0.09, 0.9, 0.56, 0.19, 0.2], inf).asStream,

				// decay: Pseq([0.64, 0.69, 0.73, 0.09, 0.9, 0.56, 0.19, 0.2], inf).asStream,

				// decay: Pseq([0.47, 0.75, 0.73, 0.47, 0.2, 0.91, 0.1, 0.36, 0.68, 0.31, 0.08, 0.43, 0.54, 0.16, 0.78, 0.02], inf).asStream,

				// decay: Pseq([0.47, 0.75, 0.73, 0.47, 0.2, 0.91, 0.1, 0.36, 0.68, 0.31, 0.08, 0.43, 0.54, 0.16, 0.78, 0.02], inf).asStream,

				// decay: Pseq([0.5, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
				// decay: \gauss,
				morph: \hold,

				// morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
				harm: \hold,

				// harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
				lpgColour: \hold,

				// lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
				// engine: Pseq(["e", "e", "e-5", "e", "e", "e-6"], inf).asStream,
				// duration: \gauss,

				duration: \four_floor,

				// duration: Pseq([1.0, 0.75, 1.0, 0.25, 0.5, Rest(0.75), 0.5, Rest(0.75), Rest(0.25), 0.75], inf).asStream,

				// duration: Pseq([0.5, 0.75, 0.25, Rest(0.5), Rest(0.5), Rest(0.75), Rest(1.0), 0.5, Rest(1.0), Rest(0.75), 0.25, Rest(0.25), Rest(0.25), 1.0, 1.0], inf).asStream,

				// duration: Pseq([Rest(0.5), 1.0, 1.0, 0.25, 0.75, Rest(0.25), Rest(1.0), Rest(1.0), Rest(1.0), 0.75, Rest(0.5)], inf).asStream,

				// duration: Pseq([1, Rest(1), Rest(1), 1, Rest(1), 1, Rest(1)], inf).asStream,

				// duration: Pseq([
				// 0.7,
				// Pwrand([0.7, Rest(0.7)], [0.9, 0.1].normalizeSum),
				// 0.7,
				// Pwrand([0.7, Rest(1.4)], [0.95, 0.05].normalizeSum),
				// 0.7,
				// Pwrand([1.4, 0.7], [0.6, 0.4].normalizeSum),
				// ], inf).asStream,
				div: \unit,

				// div: Pseq([1, 2, 1, 1, 2], inf).asStream,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.19, decay: 0.17, decayMod: 0.3, delaySend: 0.19, distAmount: 0.0, distDrive: 0.0, droneMode: 1.0, dur: 2.0, engine: 20.0, fmMod: 0.0, harm: 0.05, legato: 9.0, lpgColour: 0.5, morph: 0.78, morphMod: 0.31, mul: 0.5, mute: 1.0, phaseOffset: 0.0, pitch: 44.19, pitchMod: 0.0, revDamp: 0.8, revDrywet: 0.46, revFreeze: 0.0, revHp: 0.7, revTime: 0.6, reverbSend: 0.61, sendToPhones: 0.0, speed: 0.5, stereoMode: 1.0, tempo: 120.0, timbMod: 0.57, timbre: 0.75, volume: 0.43, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \backbeat,

				// duration: Pseq([
				// 0.7,
				// Rest(0.7),
				// Rest(0.7),
				// Rest(0.7),
				// ], inf).asStream,
				div: \unit,

				// div: Pseq([0.5], inf).asStream,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.0, decay: 0.25, decayMod: 0.1, delaySend: 0.29, distAmount: 0.04, distDrive: 0.0, droneMode: 1.0, dur: 4.0, engine: 18.0, fmMod: -0.04, harm: 0.17, legato: 9.0, lpgColour: 0.5, morph: 0.44, morphMod: 0.24, mul: 0.5, mute: 1.0, phaseOffset: 0.0, pitch: 39.0, pitchMod: 1.0, revDamp: 0.4, revDrywet: 0.2, revFreeze: 0.0, revHp: 0.4, revTime: 0.88, reverbSend: 0.28, sendToPhones: 0.0, speed: 0.25, stereoMode: 1.0, tempo: 120.0, timbMod: 0.13, timbre: 0.83, volume: 0.71, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \backbeat,

				// duration: Pseq([1.0, Rest(0.25), 0.75, Rest(0.5), 1.0, Rest(0.75), 0.5, 1.0], inf).asStream,

				// duration: Pseq([1.0, Rest(0.25), 0.75, Rest(0.5), 1.0, Rest(0.75), 0.5, 1.0], inf).asStream,

				// duration: Pseq([
				// 0.7,
				// Rest(0.7),
				// Rest(0.7),
				// Pwrand([Rest(1.4), 0.7], [0.5, 0.5].normalizeSum),
				// ], inf).asStream,
				div: Pseq([0.5], inf).asStream,
				cloudsSend: \swell_4,
				delaySend: \gate_every8,
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
			(atk: 0.0, bankName: 'CLAPS', cloudsSend: 0.0, decay: 0.39, delaySend: 0.22, distAmount: 0.0, distDrive: 0.0, dur: 8.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.05, rateMod: 0.0, revDamp: 0.55, revDrywet: 0.4, revFreeze: 0.0, revHp: 0.33, revTime: 0.48, reverbSend: 0.2, speed: 0.25, startPos: 0.0, tempo: 120.0, variant: 2.0, volume: 0.33, volumeMod: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
			div: \unit,
			rate: \unit,
			mul: \unit,
			duration: \unit,
			reverbSend: \gate_every4,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 120.0, variant: 0.0, volume: 0.0, volumeMod: 0.0),
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
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 120.0, variant: 0.0, volume: 0.0, volumeMod: 0.0),
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
	clouds: (blend: 0.5, density: 0.7, feedback: 0.35, freeze: 0.0, inGain: 1.0, lofi: 0.0, mix: 1.0, mode: 3.0, pitch: 0.5, position: 0.5, reverb: 0.24, size: 0.5, spread: 0.5, texture: 0.5, volume: 0.99),
	delay: (feedback: 0.48, filterFreq: 2212.03, spread: 1.5, time: 0.5),
	reverb: (damp: 0.27, diffuse: 0.56, freeze: 0.0, hp: 0.41, time: 0.36)
),
	// $PRESET_FX_END
);

~states = Pseq([\a, \b, \c, \d], inf).asStream;
~state = ~states.next;
~playCount = 0;

~tempoClock.tempo = ~dreads.synths[0].tempo/60;

// $LFO_SOURCES_START
~dreads.lfoSources = (
	lfo1: (freq: 4.0), // plaits 0 timbre
	lfo2: (freq: 1.6, shape: 1), // plaits 0 morph
	lfo3: (freq: 0.8, shape: 1), // plaits 0 decay
	lfo4: (freq: 2.4), // plaits 0 pitch
	lfo5: (freq: 0.8, shape: 1), // plaits 0 volume
	lfo7: (freq: 0.5), // plaits 1 morph
	lfo8: (freq: 0), // plaits 1 decay
	lfo9: (freq: 0), // plaits 1 pitch
	lfo10: (freq: 0), // plaits 1 volume
	lfo11: (freq: 2.5), // plaits 2 timbre
	lfo12: (freq: 0.0625), // plaits 2 morph
	lfo13: (freq: 0.0), // plaits 2 decay
	lfo14: (freq: 0, shape: 5, width: 0.5), // plaits 2 pitch
);
// $LFO_SOURCES_END

~applyPatch.();
)
