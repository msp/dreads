////////////////////////////////////////////////////////////////////////////////
// Plaits State - Data structures and synth instance definitions
////////////////////////////////////////////////////////////////////////////////
(
~plaits = [
	// plaits/1
	(
		pitch: 49, harm: 0.48, timbre: 0.44, morph: 0.43,
		decay: 0.59, engine: 6, fm_mod: 0.0, lpg_colour: 0.5,
		timb_mod: 0.0, morph_mod: 0.0, mul: 0.5,
		speed: 1, dur: 0.5, pattern: nil,
		sequences: (
			timbre: Pseq([0.5], inf).asStream,
			decay: Pseq([0.4, 0.2, Pseq([0.6, 0.1, 0.8] / 6)] / 3, inf).asStream,
			morph: Pseq(0.7 ! 19 ++ 0.5, inf).asStream,
			harm: Pseq([0.5], inf).asStream,
			fm_mod: Pseq([0.5], inf).asStream,
			lpg_colour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
			engine: Pseq([
				"e",
				Pwrand([2,11], [0.9, 0.1].normalizeSum),
				"e",
				"e",
				Pwrand(["e", 2], [0.8, 0.2].normalizeSum),
				"e+2",
				"e",
				0,
			], inf).asStream,
			// engine: Pseq([0,1,2,3,4,5], inf).asStream,
			duration: (
				Pseq([
					Rest(1.0),
					Pwrand([0.5, Rest(0.5)], [0.9, 0.1].normalizeSum),
					Pwrand([1.0, Rest(1.0)], [0.2, 0.8].normalizeSum),
					Rest(0.5),
					1.5
				], inf) / Pseq(1.5 ! 15 ++ 1.5, inf)
			).asStream,
			percDuration: Prand([0.5, Rest(0.5), Rest(0.5), Rest(0.5)], inf).asStream,
			div: Pseq([1], inf).asStream
		)
	),
	// plaits/2
	(
		pitch: 51, harm: 0.19, timbre: 0.74, morph: 0.07,
		decay: 0.59, engine: 6, fm_mod: 0.0, lpg_colour: 0.5,
		timb_mod: 0.0, morph_mod: 0.0, mul: 0.3,
		speed: 1, dur: 0.5, pattern: nil,
		sequences: ()
	),
	// plaits/3
	(
		pitch: 45, harm: 0.3, timbre: 0.6, morph: 0.2,
		decay: 0.4, engine: 2, fm_mod: 0.1, lpg_colour: 0.3,
		timb_mod: 0.0, morph_mod: 0.0, mul: 0.7,
		speed: 1.2, dur: 0.5, pattern: nil,
		sequences: ()
	)
];

~states = Pseq([\a, \b, \c, \d], inf).asStream;
~state = ~states.next;
)