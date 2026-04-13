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
		(
			cloudsSend: 0.0,
			decay: 0.5,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 1.0,
			engine: 13.0,
			fmMod: 0.47,
			harm: 0.5,
			legato: 0.05,
			lpgColour: 0.5,
			morph: 0.39,
			morphMod: 0.0,
			mul: 0.5,
			phaseOffset: 0.0,
			pitch: 35.27,
			revDamp: 0.8,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 1.0,
			stereoMode: 1.0,
			tempo: 120.0,
			timbMod: 0.0,
			timbre: 0.76,
			volume: 1.28
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// duration: \hold,
				duration: \four_floor,
				// duration: Pseq([1/2], inf).asStream,
			div: \unit,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.1,
			decay: 0.48,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(0.5),
			engine: 15.0,
			fmMod: 0.0,
			harm: 0.66,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.16,
			morphMod: 0.66,
			mul: 0.5,
			phaseOffset: 0.0,
			pitch: 93.78,
			revDamp: 0.8,
			revDrywet: 0.16,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 1.0,
			stereoMode: 1.0,
			tempo: 120.0,
			timbMod: 0.67,
			timbre: 0.37,
			volume: 0.44
		),
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
		(
			cloudsSend: 0.0,
			decay: 0.29,
			delaySend: 0.23,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 1.0,
			engine: 2.0,
			fmMod: 0.0,
			harm: 0.86,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.21,
			morphMod: 0.2,
			mul: 0.5,
			phaseOffset: 0.0,
			pitch: 24.08,
			revDamp: 0.4,
			revDrywet: 0.67,
			revFreeze: 0.0,
			revHp: 0.4,
			revTime: 0.37,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 1.0,
			stereoMode: 1.0,
			tempo: 120.0,
			timbMod: 0.46,
			timbre: 0.37,
			volume: 0.48
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \backbeat,
				delaySend: \gate_stutter,
			div: \unit,
			)
			// $PRESET_SEQUENCES_END
		)
	],
	// Samples array
	[
		// $SAMPLE1
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.0,
			bankName: 'CLAPS',
			cloudsSend: 0.0,
			decay: 0.19,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 2.0,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.5,
			phaseOffset: 0.0,
			rate: 1.05,
			revDamp: 0.55,
			revDrywet: 0.4,
			revFreeze: 0.0,
			revHp: 0.33,
			revTime: 0.48,
			reverbSend: 0.2,
			speed: 1.0,
			startPos: 0.0,
			tempo: 120.0,
			variant: 2.0,
			volume: 0.33
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				duration: Pseq([2], inf).asStream,
				reverbSend: \gate_every4,
				div: \unit,
				rate: \unit,
				mul: \unit,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.5,
			bankName: 'default',
			cloudsSend: 0.0,
			decay: 0.5,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 1.0,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.5,
			phaseOffset: 0.0,
			rate: 1.0,
			revDamp: 0.8,
			revDrywet: 0.25,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			speed: 1.0,
			startPos: 0.0,
			tempo: 120.0,
			variant: 0.0,
			volume: 0.0
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \unit,
				mul: \unit,
				duration: \unit,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.5,
			bankName: 'default',
			cloudsSend: 0.0,
			decay: 0.5,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 1.0,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.5,
			phaseOffset: 0.0,
			rate: 1.0,
			revDamp: 0.8,
			revDrywet: 0.25,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			speed: 1.0,
			startPos: 0.0,
			tempo: 120.0,
			variant: 0.0,
			volume: 0.0
		),
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
		filterFreq: 6270.54,
		spread: 1.5,
		time: 0.72
	),
	reverb: (
		damp: 0.27,
		diffuse: 0.56,
		freeze: 0.0,
		hp: 0.41,
		time: 0.4
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