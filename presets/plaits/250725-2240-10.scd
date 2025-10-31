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
			decay: 1.0,
			delaySend: 0.3,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 2.41,
			engine: 0.0,
			fmMod: -0.68,
			harm: 0.64,
			legato: 18.0,
			lpgColour: 0.5,
			morph: 0.0,
			morphMod: 1.0,
			mul: 0.7,
			pitch: 36.68,
			revDamp: 0.8,
			revDrywet: 0.3,
			revFreeze: 0.0,
			revHp: 0.25,
			revTime: 0.97,
			reverbSend: 0.0,
			stereoMode: 1.0,
			tempo: 15.0,
			timbMod: 0.89,
			timbre: 0.05,
			volume: 0.9
		),
		// $PRESET_SCALARS_END
		(
			decay: Pseq([0.5, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
			div: Pseq([1], inf).asStream,
			duration: Pwhite(1.0, 3.0, inf).asStream,
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
			decay: 0.59,
			delaySend: 0.3,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 1.4,
			engine: 10.0,
			fmMod: 0.0,
			harm: 0.48,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.3,
			morphMod: 0.4,
			mul: 0.5,
			pitch: 28.25,
			revDamp: 0.8,
			revDrywet: 0.3,
			revFreeze: 0.0,
			revHp: 0.25,
			revTime: 1.08,
			reverbSend: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.6,
			timbre: 0.39,
			volume: 1.17
		),
		// $PRESET_SCALARS_END
		(
			div: Pseq([0.5], inf).asStream,
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
			decay: 0.59,
			delaySend: 0.3,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 1.4,
			engine: 10.0,
			fmMod: 0.0,
			harm: 0.48,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.3,
			morphMod: 0.4,
			mul: 0.5,
			pitch: 123.66,
			revDamp: 0.8,
			revDrywet: 0.3,
			revFreeze: 0.0,
			revHp: 0.25,
			revTime: 1.08,
			reverbSend: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.6,
			timbre: 0.39,
			volume: 1.51
		),
		// $PRESET_SCALARS_END
		(
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