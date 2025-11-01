 ////////////////////////////////////////////////////////////////////////////////
// Plaits State - Data structures and synth instance definitions
////////////////////////////////////////////////////////////////////////////////
(
~plaits = ~presetFactory.(
	// Synth instances array
	[
	// $PLAITS1
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.3,
			delaySend: 0.37,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 0.35,
			engine: 0.0,
			fmMod: -0.07,
			harm: 0.72,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.29,
			morphMod: 0.88,
			mul: 0.5,
			pitch: 49.0,
			revDamp: 0.8,
			revDrywet: 0.11,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 1.03,
			reverbSend: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.43,
			timbre: 0.32,
			volume: 1.55
		),
		// $PRESET_SCALARS_END
		(
			decay: Pseq([0.5, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
			div: Pseq([1], inf).asStream,
			duration: Pseq([
				0.7,
				Pwrand([0.7, Rest(0.7)], [0.9, 0.1].normalizeSum),
				0.7,
				Pwrand([0.7, Rest(1.4)], [0.95, 0.05].normalizeSum),
				0.7,
				Pwrand([1.4, 0.7], [0.6, 0.4].normalizeSum),
			] / 2, inf).asStream,
			engine: Pseq(["e", "e", "e+2", "e", "e", "e-2"], inf).asStream,
			harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
			lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
			morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
			timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream
		)
	),
	
	// $PLAITS2
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.23,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.3,
			dur: Rest(0.35),
			engine: 13.0,
			fmMod: -0.07,
			harm: 0.8,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.25,
			morphMod: 0.88,
			mul: 0.5,
			pitch: 36.45,
			revDamp: 0.8,
			revDrywet: 0.18,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 1.03,
			reverbSend: 0.0,
			stereoMode: 0.0,
			tempo: 165.0,
			timbMod: 0.43,
			timbre: 0.75,
			volume: 1.28
		),
		// $PRESET_SCALARS_END
		(
			div: Pseq([2], inf).asStream,
			duration: Pseq([
				0.7,
				Rest(0.7),
				Rest(0.7),
				Rest(0.7),
			], inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", "e"], inf).asStream
		)
	),
	
	// $PLAITS3
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.83,
			delaySend: 0.62,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(2.8),
			engine: 5.0,
			fmMod: -0.07,
			harm: 0.75,
			legato: 22.0,
			lpgColour: 0.5,
			morph: 0.66,
			morphMod: 0.88,
			mul: 0.5,
			pitch: 37.0,
			revDamp: 0.49,
			revDrywet: 0.51,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 1.03,
			reverbSend: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.96,
			timbre: 0.82,
			volume: 0.83
		),
		// $PRESET_SCALARS_END
		(
			div: Pseq([0.5], inf).asStream,
			duration: Pseq([
				1.4,
				Rest(1.4),
				Rest(1.4),
				Rest(1.4),
			], inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", "e"], inf).asStream
		)
	)
	],
	// Samples array
	[
		// $SAMPLE1
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(
			),
			// $PRESET_SAMPLE_SCALARS_END
			(
			)
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(
			),
			// $PRESET_SAMPLE_SCALARS_END
			(
			)
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(
			),
			// $PRESET_SAMPLE_SCALARS_END
			(
			)
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
		reverb: 0.0,
		size: 0.5,
		spread: 0.5,
		texture: 0.5,
		volume: 1.0
	),
	delay: (
		feedback: 0.4,
		filterFreq: 6000.0,
		spread: 1.5,
		time: 0.26
	),
	reverb: (
		damp: 0.2,
		diffuse: 0.63,
		freeze: 0.0,
		hp: 0.3,
		time: 0.2
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

~timbreLFO = ~lfoSine.(3);
~morphLFO = ~lfoSine.(4);
~decayLFO = ~lfoSine.(1);
~tempoClock.tempo = ~plaits.synths[0].tempo/60;

~pushStateToUI.();
)