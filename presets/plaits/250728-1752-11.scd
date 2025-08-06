 ////////////////////////////////////////////////////////////////////////////////
// Plaits State - Data structures and synth instance definitions
////////////////////////////////////////////////////////////////////////////////
(
~plaits = [
	// $PLAITS1
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			decay: 0.3,
			delay_send: 0.37,
			dur: 0.7,
			engine: 0.0,
			fm_mod: -0.07,
			harm: 0.72,
			legato: 9.0,
			morph: 0.29,
			morph_mod: 0.88,
			rev_drywet: 0.11,
			rev_time: 1.03,
			timb_mod: 0.43,
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
			lpg_colour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
			morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
			timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream
		)
	),
	
	// $PLAITS2
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			decay: 0.23,
			dist_drive: 0.3,
			dur: 0.35,
			engine: 13.0,
			fm_mod: -0.07,
			harm: 0.8,
			legato: 9.0,
			morph: 0.25,
			morph_mod: 0.88,
			pitch: 36.45,
			rev_drywet: 0.18,
			rev_time: 1.03,
			stereoMode: 0.0,
			timb_mod: 0.43,
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
			decay: 0.83,
			delay_send: 0.66,
			dur: 2.8,
			engine: 5.0,
			fm_mod: -0.07,
			harm: 0.75,
			legato: 22.0,
			morph: 0.66,
			morph_mod: 0.88,
			pitch: 37.0,
			rev_damp: 0.49,
			rev_drywet: 0.51,
			rev_time: 1.03,
			timb_mod: 0.96,
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
];

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
~tempoClock.tempo = ~plaits[0].tempo/60;

~pushStateToUI.();
)