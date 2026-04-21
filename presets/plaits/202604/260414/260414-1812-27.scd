////////////////////////////////////////////////////////////////////////////////
// Plaits State - Template-based default preset with global FX
////////////////////////////////////////////////////////////////////////////////
(
~plaits = ~presetFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 0.5, engine: 13.0, fmMod: 0.47, harm: 0.52, legato: 0.05, lpgColour: 0.5, morph: 0.76, morphMod: 0.16, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 35.27, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 120.0, timbMod: 0.0, timbre: 0.76, volume: 1.3),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// duration: \hold,
				duration: \eucl_5_8,
				// duration: Pseq([1/2], inf).asStream,
			div: \unit,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.1, decay: 0.48, delaySend: 0.14, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 0.5, engine: 15.0, fmMod: 0.0, harm: 0.66, legato: 9.0, lpgColour: 0.5, morph: 0.23, morphMod: 0.51, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 93.78, revDamp: 0.8, revDrywet: 0.24, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 120.0, timbMod: 0.67, timbre: 0.72, volume: 0.41),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// duration: \hold,
				duration: \offbeat,
				// duration: Pseq([Rest(1/4), 1/4], inf).asStream,
			div: \unit,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.0, decay: 0.64, delaySend: 0.41, distAmount: 0.21, distDrive: 0.0, droneMode: 0.0, dur: 0.5, engine: 2.0, fmMod: 0.0, harm: 0.83, legato: 4.0, lpgColour: 0.5, morph: 0.64, morphMod: 0.2, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 60.0, revDamp: 0.4, revDrywet: 0.89, revFreeze: 0.0, revHp: 0.53, revTime: 1.04, reverbSend: 0.6, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 120.0, timbMod: 0.46, timbre: 0.67, volume: 0.31),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \eucl_3_8,
				delaySend: \gate_every8,
			div: \unit,
			distAmount: \gate_every8,
			reverbSend: \gate_every8,
			revDrywet: \gate_every8,
			pitch: \scale_pent,
			)
			// $PRESET_SEQUENCES_END
		)
	],
	// Samples array
	[
		// $SAMPLE1
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.0, bankName: 'CLAPS', cloudsSend: 0.0, decay: 0.19, delaySend: 0.43, distAmount: 0.0, distDrive: 0.0, dur: Rest(0.5), legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.05, revDamp: 0.55, revDrywet: 0.4, revFreeze: 0.0, revHp: 0.33, revTime: 0.48, reverbSend: 0.2, speed: 0.5, startPos: 0.0, tempo: 120.0, variant: 2.0, volume: 0.0),
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
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.45, bankName: 'default', cloudsSend: 0.0, decay: 0.67, delaySend: 0.16, distAmount: 0.0, distDrive: 0.0, dur: 0.25, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, revDamp: 0.73, revDrywet: 0.35, revFreeze: 0.0, revHp: 0.36, revTime: 0.5, reverbSend: 0.0, speed: 4.0, startPos: 0.0, tempo: 120.0, variant: 0.0, volume: 0.92),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \unit,
				mul: \unit,
				duration: \unit,
			atk: \sine_slow,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 120.0, variant: 0.0, volume: 0.0),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \unit,
				mul: \unit,
				duration: \unit,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
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
		filterFreq: 3979.03,
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
~lfoSine = { |freq=0.2|
	var phase = 0;
	Pfunc {
		phase = phase + (freq * 2 * pi / 120); // adjust for your tempo
		(sin(phase) * 0.5) + 0.5; // unipolar 0-1
	}.asStream;
};

~timbreLFO = ~lfoSine.(1/8);
~morphLFO = ~lfoSine.(1/2);
~decayLFO = ~lfoSine.(1);
~tempoClock.tempo = ~plaits.synths[0].tempo/60;

~pushStateToUI.();
)
// 