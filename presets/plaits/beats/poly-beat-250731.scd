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
			decay: 0.3,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 0.35,
			engine: 3.0,
			fmMod: 0.25,
			harm: 0.4,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.21,
			morphMod: 0.75,
			mul: 0.7,
			pitch: 42.0,
			revDamp: 0.78,
			revDrywet: 0.28,
			revFreeze: 0.0,
			revHp: 0.61,
			revTime: 0.56,
			reverbSend: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.6,
			timbre: 0.29,
			volume: 1.22
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
			engine: Pseq(["e", "e", "e+3", "e", "e", "e+6"], inf).asStream,
			harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
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
			dur: Rest(1.4),
			engine: 13.0,
			fmMod: 0.7,
			harm: 0.5,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.87,
			morphMod: 0.4,
			mul: 0.5,
			pitch: 33.36,
			revDamp: 0.8,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.61,
			revTime: 0.56,
			reverbSend: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.6,
			timbre: 0.28,
			volume: 2.0
		),
		// $PRESET_SCALARS_END
		(
			div: Pseq([0.5], inf).asStream,
			duration: Pseq([
				0.7,
				Rest(0.7),
				Rest(0.7),
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
			decay: 0.5,
			delaySend: 0.1,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(1.4),
			engine: 6.0,
			fmMod: 0.0,
			harm: 0.48,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.3,
			morphMod: 0.4,
			mul: 0.5,
			pitch: 49.0,
			revDamp: 0.78,
			revDrywet: 0.28,
			revFreeze: 0.0,
			revHp: 0.61,
			revTime: 0.56,
			reverbSend: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.6,
			timbre: 0.39,
			volume: 0.8
		),
		// $PRESET_SCALARS_END
		(
			div: Pseq([0.5], inf).asStream,
			duration: Pseq([
				0.7,
				Rest(0.7),
				Rest(0.7),
				Pwrand([Rest(1.4), 0.7], [0.5, 0.5].normalizeSum),
			], inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", "e+9"], inf).asStream
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