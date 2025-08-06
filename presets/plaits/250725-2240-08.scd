////////////////////////////////////////////////////////////////////////////////
// Plaits State - Data structures and synth instance definitions
////////////////////////////////////////////////////////////////////////////////
(
~plaits = [
	// $PLAITS1
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			pitch: 42,
			harm: 0.42,
			timbre: 0.38,
			morph: 0.53,
			decay: 0.62,
			engine: 11,
			fm_mod: 0.85,
			timb_mod: 0.6,
			morph_mod: 0.75,
			mul: 0.7,
			volume: 0.9,
			dur: 0.59,
			rev_drywet: 0.28,
			rev_time: 0.56,
			rev_damp: 0.78,
			rev_hp: 0.61,
			delay_send: 0.1
		),
		// $PRESET_SCALARS_END
		(
			timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
			decay: Pseq([0.5, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
			morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
			harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
			lpg_colour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
			engine: Pseq(["e", "e", "e-5", "e", "e", "e-6"], inf).asStream,
			duration: Pseq([
				0.7,
				Pwrand([0.7, Rest(0.7)], [0.9, 0.1].normalizeSum),
				0.7,
				Pwrand([0.7, Rest(1.4)], [0.95, 0.05].normalizeSum),
				0.7,
				Pwrand([1.4, 0.7], [0.6, 0.4].normalizeSum),
			] / 2, inf).asStream,
			div: Pseq([1, 1, 1, 1], inf).asStream
		)
	),
	
	// $PLAITS2
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			engine: 6.0,
			timb_mod: 0.6,
			morph_mod: 0.4,
			volume: 0.0,
			dur: 0.35,
			rev_drywet: 0.28,
			rev_time: 0.56,
			rev_damp: 0.78,
			rev_hp: 0.61,
			delay_send: 0.1
		),
		// $PRESET_SCALARS_END
		(
			duration: Pseq([
				0.7,
				Rest(0.7),
				Rest(0.7),
				Rest(0.7),
			], inf).asStream,
			div: Pseq([0.5], inf).asStream
		)
	),
	
	// $PLAITS3
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			engine: 6.0,
			timb_mod: 0.6,
			morph_mod: 0.4,
			volume: 0.0,
			dur: 0.35,
			rev_drywet: 0.28,
			rev_time: 0.56,
			rev_damp: 0.78,
			rev_hp: 0.61,
			delay_send: 0.1
		),
		// $PRESET_SCALARS_END
		(
			duration: Pseq([
				0.7,
				Rest(0.7),
				Rest(0.7),
				Rest(0.7),
			], inf).asStream,
			div: Pseq([0.5], inf).asStream
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