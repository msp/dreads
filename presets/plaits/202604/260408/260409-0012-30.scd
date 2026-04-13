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
			decay: 0.27,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 5.0,
			engine: 13.0,
			fmMod: 0.91,
			harm: 0.77,
			legato: 0.05,
			lpgColour: 0.5,
			morph: 0.07,
			morphMod: 0.74,
			mul: 0.5,
			phaseOffset: 0.0,
			pitch: 39.31,
			revDamp: 0.8,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 0.1,
			stereoMode: 1.0,
			tempo: 242.7,
			timbMod: 0.36,
			timbre: 0.3,
			volume: 0.87
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: Pseq([0.5], inf).asStream,
				// duration: \hold,
				duration: \str8_16th,
				distAmount: \gate_tail,
			delaySend: \gate_every4,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.24,
			decay: 1.0,
			delaySend: 0.26,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(8.0),
			engine: 0.0,
			fmMod: 0.08,
			harm: 0.23,
			legato: 45.0,
			lpgColour: 0.5,
			morph: 0.74,
			morphMod: 0.56,
			mul: 0.5,
			phaseOffset: 0.0,
			pitch: 51.0,
			revDamp: 0.8,
			revDrywet: 0.72,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.83,
			reverbSend: 0.46,
			sendToPhones: 0.0,
			speed: 1.0,
			stereoMode: 1.0,
			tempo: 242.7,
			timbMod: 0.56,
			timbre: 0.48,
			volume: 0.48
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// duration: \hold,
				duration: Pseq([1, Rest(1), Rest(1), 1, Rest(1), 1, Rest(1), 1, Rest(1), 1, Rest(1), Rest(1), 1, Rest(1), 1, Rest(1)], inf).asStream,
				reverbSend: \gate_every4,
				delaySend: \gate_tail,
				fmMod: \triangle,
				div: Pseq([1/8], inf).asStream,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.0,
			decay: 0.69,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 5.0,
			engine: 6.0,
			fmMod: 0.0,
			harm: 0.58,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.61,
			morphMod: 0.2,
			mul: 0.5,
			phaseOffset: -0.25,
			pitch: 58.25,
			revDamp: 0.4,
			revDrywet: 0.19,
			revFreeze: 0.0,
			revHp: 0.4,
			revTime: 0.37,
			reverbSend: 0.12,
			sendToPhones: 0.0,
			speed: 0.1,
			stereoMode: 1.0,
			tempo: 242.7,
			timbMod: 0.46,
			timbre: 0.37,
			volume: 0.72
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: Pseq([0.5], inf).asStream,
				duration: \str8_16th,
				delaySend: \gate_stutter,
				decay: \sine_slow,
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
			atk: 0.62,
			bankName: 'CLAPS',
			cloudsSend: 0.0,
			decay: 0.19,
			delaySend: 0.52,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 24.0,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.5,
			phaseOffset: 0.5,
			rate: 1.05,
			revDamp: 0.55,
			revDrywet: 0.56,
			revFreeze: 0.0,
			revHp: 0.33,
			revTime: 0.64,
			reverbSend: 0.53,
			speed: 0.25,
			startPos: 0.0,
			tempo: 242.7,
			variant: 2.0,
			volume: 0.52
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				duration: \sprs_dotted,
				div: Pseq([1/8], inf).asStream,
				reverbSend: \hold,
			delaySend: \gate_every4,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.63,
			bankName: 'halfmastv6',
			cloudsSend: 0.0,
			decay: 0.69,
			delaySend: 0.42,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(8.0),
			legato: 0.7,
			mul: 1.0,
			panDur: 0.26,
			phaseOffset: 0.0,
			rate: 1.1,
			revDamp: 0.27,
			revDrywet: 0.16,
			revFreeze: 0.0,
			revHp: 0.52,
			revTime: 0.77,
			reverbSend: 0.14,
			speed: 1.0,
			startPos: 0.0,
			tempo: 242.7,
			variant: 3.0,
			volume: 0.16
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				startPos: \sweep_slow,
				atk: \gauss,
				decay: \updown,
				duration: Pseq([1, Rest(1), Rest(1), 1, Rest(1)], inf).asStream,
				div: Pseq([1/8], inf).asStream,
			    variant: Pseq([4, 5, 6], inf).asStream,
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
			dur: 10.0,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.5,
			phaseOffset: 0.25,
			rate: 4.4,
			revDamp: 0.8,
			revDrywet: 0.5,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			speed: 0.1,
			startPos: 0.0,
			tempo: 242.7,
			variant: 0.0,
			volume: 0.42
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				delaySend: \gate_prob50,
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
		feedback: 0.46,
		freeze: 0.0,
		inGain: 1.0,
		lofi: 0.0,
		mix: 1.0,
		mode: 3.0,
		pitch: 0.5,
		position: 0.31,
		reverb: 0.53,
		size: 0.5,
		spread: 0.5,
		texture: 0.5,
		volume: 0.6
	),
	delay: (
		feedback: 0.9,
		filterFreq: 6817.51,
		spread: 0.76,
		time: 0.28
	),
	reverb: (
		damp: 0.18,
		diffuse: 0.56,
		freeze: 0.0,
		hp: 0.28,
		time: 0.85
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
