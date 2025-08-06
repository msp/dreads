////////////////////////////////////////////////////////////////////////////////
// Plaits State - Data structures and synth instance definitions
////////////////////////////////////////////////////////////////////////////////
(
~plaits = [
	// $PLAITS1
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			decay: 0.1,
			delay_send: 0.8,
			dist_drive: 0.55,
			dur: 0.35,
			engine: 8.0,
			fm_mod: -0.32,
			harm: 0.48,
			legato: 0.4,
			morph: 0.89,
			morph_mod: 0.76,
			pitch: 93.51,
			rev_damp: 0.47,
			rev_drywet: 0.32,
			rev_hp: 0.3,
			rev_time: 0.33,
			reverb_send: 0.2,
			timb_mod: 0.69,
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
			lpg_colour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
			morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
			timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream
		)
	),
	
	// $PLAITS2
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			decay: 0.24,
			delay_send: 0.5,
			dur: 0.7,
			engine: 11.0,
			fm_mod: 0.5,
			harm: 0.75,
			legato: 9.0,
			morph: 0.08,
			morph_mod: 0.65,
			pitch: 80.38,
			rev_damp: 0.77,
			rev_hp: 0.3,
			rev_time: 0.36,
			stereoMode: 0.0,
			timb_mod: 0.94,
			timbre: 0.26,
			volume: 0.75
		),
		// $PRESET_SCALARS_END
		(
			delay_send: Pseq(0.0 ! 29 ++ (0.9), inf).asStream,
			div: Pseq([2], inf).asStream,
			duration: Pseq([
				Pwrand([0.7, Rest(0.7)], [0.9, 0.1].normalizeSum),
				0.7,
				Pwrand([0.7, Rest(1.4)], [0.95, 0.05].normalizeSum),
				0.7,
				Pwrand([1.4, 0.7], [0.6, 0.4].normalizeSum),
			], inf).asStream,
			engine: Pseq(["e+1", "e+1", "e", "e", "e", "e-6"], inf).asStream,
			fm_mod: Pseq(0.0 ! 14 ++ (1.0), inf).asStream,
			lpg_colour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream
		)
	),
	
	// $PLAITS3
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			decay: 0.44,
			delay_send: 0.15,
			dist_amount: 0.01,
			dist_drive: 1.5,
			dur: Rest(1.4),
			engine: 13.0,
			fm_mod: 0.3,
			harm: 0.28,
			legato: 1.0,
			morph: 0.87,
			morph_mod: 0.0,
			pitch: 33.51,
			rev_damp: 0.77,
			rev_hp: 0.3,
			rev_time: 0.0,
			stereoMode: 0.0,
			timb_mod: 1.0,
			timbre: 0.48,
			volume: 1.4
		),
		// $PRESET_SCALARS_END
		(
			delay_send: Pseq([
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

~timbreLFO = ~lfoSine.(0.01);
~morphLFO = ~lfoSine.(4);
~decayLFO = ~lfoSine.(1);
~tempoClock.tempo = ~plaits[0].tempo/60;

~pushStateToUI.();
)