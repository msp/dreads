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
			decay: 0.59,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(0.33333333333333),
			engine: 13.0,
			fmMod: 0.82,
			harm: 0.65,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.42,
			morphMod: 0.4,
			mul: 0.5,
			pitch: 34.52,
			revDamp: 0.8,
			revDrywet: 0.21,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			stereoMode: 0.0,
			tempo: 145.0,
			timbMod: 0.3,
			timbre: 0.31,
			volume: 1.5
		),
		// $PRESET_SCALARS_END
		(
			div: Pseq([3], inf).asStream,
			duration: Pseq([0.33, Rest(0.33), 0.33, Rest(0.33), 0.33, Rest(0.33), Rest(0.33), Rest(0.33)] ++ (Rest(1) ! 7) ++ (1), inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", "e"], inf).asStream,
			lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream
		)
	),
	
	// $PLAITS2
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			decay: 0.5,
			delaySend: 0.5,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(0.33333333333333),
			engine: 0.0,
			fmMod: -0.65,
			harm: 0.8,
			legato: 2.0,
			lpgColour: 0.5,
			morph: 0.69,
			morphMod: 0.8,
			mul: 0.5,
			pitch: 57.7,
			revDamp: 0.64,
			revDrywet: 0.4,
			revFreeze: 0.0,
			revHp: 0.29,
			revTime: 0.59,
			reverbSend: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.57,
			timbre: 0.65,
			volume: 1.42
		),
		// $PRESET_SCALARS_END
		(
			decay: Pseq([0.1, 0.2, 0.1, 0.05, 0.9] ++ (0.0 ! 12), inf).asStream,
			delaySend: Pseq([0.0, 0.0, 0.1, 0.0, 0.7] ++ (0.0 ! 12), inf).asStream,
			div: Pseq([3], inf).asStream,
			duration: Pseq([0.33, Rest(0.33), 0.33, Rest(0.33), 0.33, Rest(0.33), Rest(0.33), Rest(0.33)] ++ (Rest(1) ! 4) ++ [Rest(0.33), 0.33, Rest(0.33), Rest(0.33)], inf).asStream,
			engine: Pseq(["e", "e", "e+6", "e", "e+2", "e"], inf).asStream
		)
	),
	
	// $PLAITS3
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			decay: 0.59,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(0.33333333333333),
			engine: 14.0,
			fmMod: 0.01,
			harm: 0.34,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.26,
			morphMod: 0.75,
			mul: 0.5,
			pitch: 50.71,
			revDamp: 0.8,
			revDrywet: 0.21,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.77,
			timbre: 0.39,
			volume: 0.8
		),
		// $PRESET_SCALARS_END
		(
			div: Pseq([3], inf).asStream,
			duration: Pseq([0.33, Rest(0.33), 0.33, Rest(0.33), 0.33, Rest(0.33), Rest(0.33), Rest(0.33)] ++ (Rest(1) ! 8), inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", "e"], inf).asStream
		)
	)
	],
	// Samples array
	[],
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

~timbreLFO = ~lfoSine.(3);
~morphLFO = ~lfoSine.(4);
~decayLFO = ~lfoSine.(1);
~tempoClock.tempo = ~plaits.synths[0].tempo/60;

~pushStateToUI.();
)