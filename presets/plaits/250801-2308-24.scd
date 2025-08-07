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
			decay: 0.48,
			delay_send: 0.0,
			dist_amount: 0.04,
			dist_drive: 0.3,
			dur: Rest(0.25),
			engine: 13.0,
			fm_mod: 0.49,
			harm: 0.83,
			legato: 0.7,
			lpg_colour: 0.5,
			morph: 0.22,
			morph_mod: 0.0,
			mul: 0.5,
			pitch: 34.47,
			rev_damp: 0.8,
			rev_drywet: 0.0,
			rev_freeze: 0.0,
			rev_hp: 0.7,
			rev_time: 1.25,
			reverb_send: 0.0,
			stereoMode: 0.0,
			tempo: 125.0,
			timb_mod: 0.0,
			timbre: 0.68,
			volume: 1.36
		),
		// $PRESET_SCALARS_END
		(
			div: Pseq(1 ! 63 ++ (1.0), inf).asStream,
			duration: Pseq([
				0.25,
				Rest(0.25),
				Pwrand([0.25, Rest(0.25)], [0.95, 0.05].normalizeSum),
				Rest(0.25),
				Rest(0.25),
				Pwrand([0.25, Rest(0.25)], [0.95, 0.05].normalizeSum),
				Rest(0.25),
				Pwrand([Rest(0.25), 0.25], [0.6, 0.4].normalizeSum),
			], inf).asStream,
			engine: Pseq(["e", "e+1", "e", "e", "e", "e"], inf).asStream,
			lpg_colour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
			morph: Pseq([
				0.3,
				0.2,
				0.5,
				0.5,
				0.5,
				0.6,
				0.5,
				0.2,
			], inf).asStream
		)
	),
	
	// $PLAITS2
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			decay: 0.18,
			delay_send: 0.0,
			dist_amount: 0.03,
			dist_drive: 0.1,
			dur: Rest(0.25),
			engine: 2.0,
			fm_mod: 0.0,
			harm: 0.86,
			legato: 0.1,
			lpg_colour: 0.5,
			morph: 0.24,
			morph_mod: 0.46,
			mul: 0.5,
			pitch: 58.5,
			rev_damp: 0.48,
			rev_drywet: 0.0,
			rev_freeze: 0.0,
			rev_hp: 0.39,
			rev_time: 0.0,
			reverb_send: 0.63,
			stereoMode: 1.0,
			tempo: 165.0,
			timb_mod: 1.0,
			timbre: 0.81,
			volume: 1.32
		),
		// $PRESET_SCALARS_END
		(
			div: Pseq(1 ! 127 ++ (0.5), inf).asStream,
			duration: Pseq([
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				0.25,
			], inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", 0], inf).asStream
		)
	),
	
	// $PLAITS3
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			decay: 0.53,
			delay_send: 0.0,
			dist_amount: 0.2,
			dist_drive: 0.4,
			dur: Rest(0.25),
			engine: 15.0,
			fm_mod: 0.0,
			harm: 0.48,
			legato: 4.0,
			lpg_colour: 0.5,
			morph: 0.23,
			morph_mod: 0.93,
			mul: 0.5,
			pitch: 49.0,
			rev_damp: 0.08,
			rev_drywet: 0.67,
			rev_freeze: 0.0,
			rev_hp: 0.69,
			rev_time: 0.9,
			reverb_send: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timb_mod: 0.7,
			timbre: 0.44,
			volume: 0.46
		),
		// $PRESET_SCALARS_END
		(
			div: Pseq(1 ! 63 ++ (0.5), inf).asStream,
			duration: Pseq([
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				0.25,
			], inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", "e-1"], inf).asStream
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