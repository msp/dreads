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
			dur: 0.25,
			engine: 13.0,
			fmMod: -0.44,
			harm: 0.52,
			legato: 0.05,
			lpgColour: 0.5,
			morph: 0.37,
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
			speed: 2.0,
			stereoMode: 1.0,
			tempo: 133.5,
			timbMod: 0.36,
			timbre: 0.06,
			volume: 0.79
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: Pseq([0.5], inf).asStream,
				// duration: \hold,
				duration: \str8_16th,
				distAmount: \gate_tail,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.24,
			decay: 0.98,
			delaySend: 0.26,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 8.0,
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
			tempo: 133.5,
			timbMod: 0.56,
			timbre: 0.48,
			volume: 0.6
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
			decay: 0.2,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 0.25,
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
			revDrywet: 0.25,
			revFreeze: 0.0,
			revHp: 0.4,
			revTime: 0.37,
			reverbSend: 0.23,
			sendToPhones: 0.0,
			speed: 2.0,
			stereoMode: 1.0,
			tempo: 133.5,
			timbMod: 0.46,
			timbre: 0.37,
			volume: 1.11
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
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(8.0),
			legato: 0.7,
			mul: 1.0,
			panDur: 0.5,
			phaseOffset: 0.5,
			rate: 1.05,
			revDamp: 0.55,
			revDrywet: 0.56,
			revFreeze: 0.0,
			revHp: 0.33,
			revTime: 0.33,
			reverbSend: 0.24,
			speed: 1.0,
			startPos: 0.0,
			tempo: 133.5,
			variant: 2.0,
			volume: 0.58
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				duration: \sprs_dotted,
				div: Pseq([1/8], inf).asStream,
				reverbSend: \hold,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.37,
			bankName: 'HATS',
			cloudsSend: 0.0,
			decay: 0.74,
			delaySend: 0.64,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 0.75,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.22,
			phaseOffset: 0.0,
			rate: 2.74,
			revDamp: 0.55,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.33,
			revTime: 0.77,
			reverbSend: 0.0,
			speed: 1.0,
			startPos: 0.0,
			tempo: 133.5,
			variant: 1.0,
			volume: 0.78
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				startPos: \sweep_slow,
				atk: \gauss,
				decay: \updown,
				duration: \son_clave,
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
			delaySend: 0.26,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 1.0,
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
			speed: 1.0,
			startPos: 0.0,
			tempo: 133.5,
			variant: 0.0,
			volume: 0.3
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
		feedback: 0.53,
		filterFreq: 6680.52,
		spread: 1.0,
		time: 0.22
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
