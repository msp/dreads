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
			delay_send: 0.0,
			dist_amount: 0.0,
			dist_drive: 0.0,
			dur: Rest(0.33333333333333),
			engine: 13.0,
			fm_mod: 0.82,
			harm: 0.65,
			legato: 9.0,
			lpg_colour: 0.5,
			morph: 0.42,
			morph_mod: 0.4,
			mul: 0.5,
			pitch: 34.52,
			rev_damp: 0.8,
			rev_drywet: 0.21,
			rev_freeze: 0.0,
			rev_hp: 0.7,
			rev_time: 0.3,
			reverb_send: 0.0,
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
			dist_amount: 0.0,
			dist_drive: 0.0,
			dur: Rest(0.33333333333333),
			engine: 0.0,
			fm_mod: -0.65,
			harm: 0.8,
			legato: 2.0,
			lpg_colour: 0.5,
			morph: 0.69,
			morph_mod: 0.8,
			mul: 0.5,
			pitch: 57.7,
			rev_damp: 0.64,
			rev_drywet: 0.4,
			rev_freeze: 0.0,
			rev_hp: 0.29,
			rev_time: 0.59,
			reverb_send: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
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
			delay_send: 0.0,
			dist_amount: 0.0,
			dist_drive: 0.0,
			dur: Rest(0.33333333333333),
			engine: 14.0,
			fm_mod: 0.01,
			harm: 0.34,
			legato: 9.0,
			lpg_colour: 0.5,
			morph: 0.26,
			morph_mod: 0.75,
			mul: 0.5,
			pitch: 50.71,
			rev_damp: 0.8,
			rev_drywet: 0.21,
			rev_freeze: 0.0,
			rev_hp: 0.7,
			rev_time: 0.3,
			reverb_send: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
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
	],
	// Global FX settings
	// $PRESET_FX_START
	(
		delay: (
			feedback: 0.4,
			filter_freq: 6000,
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