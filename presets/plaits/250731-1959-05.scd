////////////////////////////////////////////////////////////////////////////////
// Plaits State - Data structures and synth instance definitions
////////////////////////////////////////////////////////////////////////////////
(
~plaits = [
	// $PLAITS1
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			decay: 0.59,
			dur: Rest(0.33333333333333),
			engine: 13.0,
			fm_mod: 0.82,
			harm: 0.65,
			legato: 9.0,
			morph: 0.42,
			morph_mod: 0.4,
			pitch: 34.52,
			rev_drywet: 0.21,
			rev_time: 0.3,
			stereoMode: 0.0,
			tempo: 145.0,
			timb_mod: 0.3,
			timbre: 0.31,
			volume: 1.5
		),
		// $PRESET_SCALARS_END
		(
			div: Pseq([3], inf).asStream,
			duration: Pseq([0.33, Rest(0.33), 0.33, Rest(0.33), 0.33, Rest(0.33), Rest(0.33), Rest(0.33)] ++ (Rest(1) ! 7) ++ (1), inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", "e"], inf).asStream,
			lpg_colour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream
		)
	),
	
	// $PLAITS2
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			decay: 0.5,
			delay_send: 0.5,
			dur: Rest(0.33333333333333),
			engine: 0.0,
			fm_mod: -0.65,
			harm: 0.8,
			legato: 2.0,
			morph: 0.69,
			morph_mod: 0.8,
			pitch: 57.7,
			rev_damp: 0.64,
			rev_drywet: 0.4,
			rev_hp: 0.29,
			rev_time: 0.59,
			timb_mod: 0.57,
			timbre: 0.65,
			volume: 1.42
		),
		// $PRESET_SCALARS_END
		(
			decay: Pseq([0.1, 0.2, 0.1, 0.05, 0.9] ++ (0.0 ! 12), inf).asStream,
			delay_send: Pseq([0.0, 0.0, 0.1, 0.0, 0.7] ++ (0.0 ! 12), inf).asStream,
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
			dur: Rest(0.33333333333333),
			engine: 14.0,
			fm_mod: 0.01,
			harm: 0.34,
			legato: 9.0,
			morph: 0.26,
			morph_mod: 0.75,
			pitch: 50.71,
			rev_drywet: 0.21,
			rev_time: 0.3,
			timb_mod: 0.77,
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