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
			decay: 0.1,
			delaySend: 0.8,
			distAmount: 0.0,
			distDrive: 0.55,
			dur: 0.35,
			engine: 8.0,
			fmMod: -0.32,
			harm: 0.48,
			legato: 0.4,
			lpgColour: 0.5,
			morph: 0.89,
			morphMod: 0.76,
			mul: 0.5,
			pitch: 93.51,
			revDamp: 0.47,
			revDrywet: 0.32,
			revFreeze: 0.0,
			revHp: 0.3,
			revTime: 0.33,
			reverbSend: 0.2,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.69,
			timbre: 0.72,
			volume: 1.21
		),
		// $PRESET_SCALARS_END
		(
			decay: Pseq([0.5, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
			div: Pseq([2], inf).asStream,
			duration: Pseq([
				0.7,
				Pwrand([0.7, Rest(0.7)], [0.9, 0.1].normalizeSum),
				0.7,
				Pwrand([0.7, Rest(1.4)], [0.95, 0.05].normalizeSum),
				0.7,
				Pwrand([1.4, 0.7], [0.6, 0.4].normalizeSum),
			], inf).asStream,
			engine: Pseq(["e", "e", "e-5", "e", "e", "e-6"], inf).asStream,
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
			decay: 0.24,
			delaySend: 0.5,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 0.7,
			engine: 11.0,
			fmMod: 0.5,
			harm: 0.75,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.08,
			morphMod: 0.65,
			mul: 0.5,
			pitch: 80.38,
			revDamp: 0.77,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.3,
			revTime: 0.36,
			reverbSend: 0.0,
			stereoMode: 0.0,
			tempo: 165.0,
			timbMod: 0.94,
			timbre: 0.26,
			volume: 0.75
		),
		// $PRESET_SCALARS_END
		(
			delaySend: Pseq(0.0 ! 29 ++ (0.9), inf).asStream,
			div: Pseq([2], inf).asStream,
			duration: Pseq([
				Pwrand([0.7, Rest(0.7)], [0.9, 0.1].normalizeSum),
				0.7,
				Pwrand([0.7, Rest(1.4)], [0.95, 0.05].normalizeSum),
				0.7,
				Pwrand([1.4, 0.7], [0.6, 0.4].normalizeSum),
			], inf).asStream,
			engine: Pseq(["e+1", "e+1", "e", "e", "e", "e-6"], inf).asStream,
			fmMod: Pseq(0.0 ! 14 ++ (1.0), inf).asStream,
			lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream
		)
	),
	
	// $PLAITS3
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			decay: 0.44,
			delaySend: 0.15,
			distAmount: 0.01,
			distDrive: 1.5,
			dur: Rest(1.4),
			engine: 13.0,
			fmMod: 0.3,
			harm: 0.28,
			legato: 1.0,
			lpgColour: 0.5,
			morph: 0.87,
			morphMod: 0.0,
			mul: 0.5,
			pitch: 33.51,
			revDamp: 0.77,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.3,
			revTime: 0.0,
			reverbSend: 0.0,
			stereoMode: 0.0,
			tempo: 165.0,
			timbMod: 1.0,
			timbre: 0.48,
			volume: 1.4
		),
		// $PRESET_SCALARS_END
		(
			delaySend: Pseq([
				0.85,
				0.0,
				0.0,
				0.0,
				0.0,
				0.0,
				0.0,
				0.0,
			], inf).asStream,
			div: Pseq([0.5], inf).asStream,
			duration: Pseq([
				0.7,
				Rest(0.7),
				Rest(0.7),
				Rest(0.7),
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
		delay: (
			feedback: 0.4,
			filterFreq: 6000,
			spread: 1.5,
			time: 0.25
		),
		reverb: (
			damp: 0.2,
			diffuse: 0.625,
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

~timbreLFO = ~lfoSine.(0.01);
~morphLFO = ~lfoSine.(4);
~decayLFO = ~lfoSine.(1);
~tempoClock.tempo = ~plaits.synths[0].tempo/60;

~pushStateToUI.();
)