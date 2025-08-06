////////////////////////////////////////////////////////////////////////////////
// Plaits State - Data structures and synth instance definitions
////////////////////////////////////////////////////////////////////////////////
(
~plaits = [
	// $PLAITS1
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			pitch: 18.22,
			harm: 0.6,
			timbre: 0.77,
			morph: 0.74,
			decay: 1.0,
			engine: 8.0,
			fm_mod: -0.45,
			timb_mod: 0.51,
			morph_mod: 0.7,
			mul: 0.7,
			volume: 1.32,
			tempo: 15.0,
			dur: 0.7,
			legato: 18.0,
			rev_drywet: 0.28,
			rev_time: 1.15,
			rev_damp: 0.36,
			rev_hp: 0.45,
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
			div: Pseq([1], inf).asStream
		)
	),
	
	// $PLAITS2
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			pitch: 18.22,
			harm: 0.6,
			timbre: 0.77,
			morph: 0.74,
			decay: 1.0,
			engine: 8.0,
			fm_mod: -0.45,
			timb_mod: 0.51,
			morph_mod: 0.7,
			mul: 0.7,
			volume: 0.0,
			tempo: 85.0,
			dur: 0.7,
			legato: 18.0,
			rev_drywet: 0.28,
			rev_time: 1.15,
			rev_damp: 0.36,
			rev_hp: 0.45,
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
			pitch: 18.22,
			harm: 0.6,
			timbre: 0.77,
			morph: 0.74,
			decay: 1.0,
			engine: 8.0,
			fm_mod: -0.45,
			timb_mod: 0.51,
			morph_mod: 0.7,
			mul: 0.7,
			volume: 0.0,
			tempo: 85.0,
			dur: 0.7,
			legato: 18.0,
			rev_drywet: 0.28,
			rev_time: 1.15,
			rev_damp: 0.36,
			rev_hp: 0.45,
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