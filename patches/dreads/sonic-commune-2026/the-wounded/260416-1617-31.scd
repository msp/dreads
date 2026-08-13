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
			(cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.27, distDrive: 0.0, droneMode: 1.0, dur: 1.0, engine: 2.0, fmMod: 0.07, harm: 0.14, legato: 0.05, lpgColour: 0.5, morph: 0.46, morphMod: 0.16, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 45.32, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 104.86, timbMod: 0.0, timbre: 0.49, volume: 0.75),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				morph: \updown,
				// timbre: \hold,
				// distAmount: \gate_every16,
			div: \unit,
			duration: \unit,
			distAmount: \sine_slow,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.1, decay: 0.89, delaySend: 0.14, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 2.0, engine: 2.0, fmMod: -0.03, harm: 0.66, legato: 9.0, lpgColour: 0.5, morph: 0.53, morphMod: 0.51, mul: 0.5, mute: 0.0, phaseOffset: 0.5, pitch: 45.0, revDamp: 0.55, revDrywet: 0.07, revFreeze: 0.0, revHp: 0.61, revTime: 1.06, reverbSend: 0.0, sendToPhones: 0.0, speed: 0.5, stereoMode: 1.0, tempo: 104.86, timbMod: 0.67, timbre: 0.6, volume: 0.45),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// duration: \hold,
				duration: \four_floor,
				// duration: Pseq([Rest(1/4), 1/4], inf).asStream,
				div: \unit,
				pitch: \hold,
				timbre: \gate_every8,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.0, decay: 0.35, delaySend: 0.0, distAmount: 0.02, distDrive: 0.0, droneMode: 0.0, dur: Rest(0.25), engine: 0.0, fmMod: 0.01, harm: 0.38, legato: 4.0, lpgColour: 0.5, morph: 0.18, morphMod: 0.2, mul: 0.5, mute: 1.0, phaseOffset: 0.0, pitch: 50.0, revDamp: 0.4, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.53, revTime: 0.53, reverbSend: 0.52, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 104.86, timbMod: 0.21, timbre: 0.67, volume: 1.26),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \eucl_7_16,
				delaySend: \gate_every8,
				div: \unit,
				distAmount: \gate_every8,
				reverbSend: \gate_every8,
				revDrywet: \gate_every8,
				pitch: \scale_maj,
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
			(atk: 0.0, bankName: 'CLAPS', cloudsSend: 0.0, decay: 0.19, delaySend: 0.43, distAmount: 0.0, distDrive: 0.0, dur: 1.5, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.05, revDamp: 0.55, revDrywet: 0.4, revFreeze: 0.0, revHp: 0.33, revTime: 0.48, reverbSend: 0.2, speed: 0.5, startPos: 0.0, tempo: 104.86, variant: 2.0, volume: 0.69),
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
			(atk: 0.45, bankName: 'default', cloudsSend: 0.0, decay: 0.67, delaySend: 0.16, distAmount: 0.0, distDrive: 0.0, dur: 0.25, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, revDamp: 0.73, revDrywet: 0.35, revFreeze: 0.0, revHp: 0.36, revTime: 0.5, reverbSend: 0.0, speed: 4.0, startPos: 0.0, tempo: 104.86, variant: 0.0, volume: 0.14),
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
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 104.86, variant: 0.0, volume: 0.0),
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
	clouds: (
		blend: 0.5,
		density: 0.7,
		feedback: 0.0,
		freeze: 0.0,
		inGain: 1.0,
		lofi: 0.0,
		mix: 1.0,
		mode: 3.0,
		pitch: 0.5,
		position: 0.5,
		reverb: 0.24,
		size: 0.5,
		spread: 0.5,
		texture: 0.5,
		volume: 1.0
	),
	delay: (
		feedback: 0.48,
		filterFreq: 5880.91,
		spread: 1.5,
		time: 0.72
	),
	reverb: (
		damp: 0.27,
		diffuse: 0.63,
		freeze: 0.0,
		hp: 0.35,
		time: 0.74
	)
),
	// $PRESET_FX_END
);

~states = Pseq([\a, \b, \c, \d], inf).asStream;
~state = ~states.next;
~playCount = 0;

~tempoClock.tempo = ~dreads.synths[0].tempo/60;

// $LFO_SOURCES_START
~dreads.lfoSources = (
	lfo2: (freq: 0.5),
	lfo3: (freq: 1),
	lfo7: (freq: 0.5),
	lfo8: (freq: 1),
	lfo12: (freq: 0.5),
	lfo13: (freq: 1)
);
// $LFO_SOURCES_END

~applyPatch.();
)
// 