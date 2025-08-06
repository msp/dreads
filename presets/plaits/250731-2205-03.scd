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
			dur: 0.35,
			engine: 3.0,
			fm_mod: 0.25,
			harm: 0.4,
			legato: 9.0,
			morph: 0.21,
			morph_mod: 0.75,
			mul: 0.7,
			pitch: 42.0,
			rev_damp: 0.78,
			rev_drywet: 0.28,
			rev_hp: 0.61,
			rev_time: 0.56,
			timb_mod: 0.6,
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
			delay_send: 0.3,
			dur: Rest(1.4),
			engine: 13.0,
			fm_mod: 0.7,
			legato: 9.0,
			morph: 0.87,
			morph_mod: 0.4,
			pitch: 33.36,
			rev_hp: 0.61,
			rev_time: 0.56,
			timb_mod: 0.6,
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
			delay_send: 0.1,
			dur: Rest(1.4),
			engine: 6.0,
			harm: 0.48,
			legato: 9.0,
			morph: 0.3,
			morph_mod: 0.4,
			rev_damp: 0.78,
			rev_drywet: 0.28,
			rev_hp: 0.61,
			rev_time: 0.56,
			timb_mod: 0.6,
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