////////////////////////////////////////////////////////////////////////////////
// Plaits State - Template-based default preset
////////////////////////////////////////////////////////////////////////////////
(
~plaits = ~presetFactory.(
	// Synth instances array
	[
	// $PLAITS1
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			decay: 0.21,
			delay_send: 0.0,
			dist_amount: 0.0,
			dist_drive: 0.0,
			dur: 0.04,
			engine: 4.0,
			fm_mod: -0.05,
			harm: 0.84,
			legato: 9.0,
			lpg_colour: 0.5,
			morph: 0.37,
			morph_mod: 1.0,
			mul: 0.5,
			pitch: 17.37,
			rev_damp: 0.15,
			rev_drywet: 0.2,
			rev_freeze: 0.0,
			rev_hp: 0.29,
			rev_time: 0.93,
			reverb_send: 0.0,
			stereoMode: 1.0,
			tempo: 85.0,
			timb_mod: 1.0,
			timbre: 0.8,
			volume: 1.58
		),
		// $PRESET_SCALARS_END
		(
			timbre: Pgauss(0.0, 1.0, inf).asStream,
			decay: Pgauss(0.0, 0.01, inf).asStream,
			morph: Pgbrown(1.0, 1.0, 1.0, inf).asStream,
			harm: Pgauss(0.0, 1.0, inf).asStream,
			// lpg_colour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
			engine: Pseq(["e", "e", "e+5", "e", "e", "e+4"], inf).asStream,
			duration: Pgauss(0.01, 1.0, inf).asStream,
			// div: Pseq([1, 3, 1, 1, 2], inf).asStream,
			reverb_send: Pgauss(0.0, 0.2, inf).asStream,
			// rev_time: Pwhite(1.0, 1.2, inf).asStream,
		)
	),
	
	// $PLAITS2
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			decay: 0.1,
			delay_send: 0.4,
			dist_amount: 0.0,
			dist_drive: 0.0,
			dur: 23.26,
			engine: 13.0,
			fm_mod: 0.0,
			harm: 0.48,
			legato: 9.0,
			lpg_colour: 0.5,
			morph: 0.43,
			morph_mod: 0.8,
			mul: 0.5,
			pitch: 26.04,
			rev_damp: 0.8,
			rev_drywet: 0.25,
			rev_freeze: 0.0,
			rev_hp: 0.7,
			rev_time: 0.3,
			reverb_send: 0.1,
			stereoMode: 1.0,
			tempo: 165.0,
			timb_mod: 0.7,
			timbre: 0.44,
			volume: 1.53
		),
		// $PRESET_SCALARS_END
		(
			duration: Pgauss(1.0, 10.0, inf).asStream,
			div: Pseq([0.5], inf).asStream
		)
	),
	
	// $PLAITS3
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			decay: 0.77,
			delay_send: 0.0,
			dist_amount: 0.0,
			dist_drive: 0.0,
			dur: 7.25,
			engine: 15.0,
			fm_mod: 0.0,
			harm: 0.48,
			legato: 9.0,
			lpg_colour: 0.5,
			morph: 1.0,
			morph_mod: 1.0,
			mul: 0.5,
			pitch: 35.19,
			rev_damp: 0.58,
			rev_drywet: 0.58,
			rev_freeze: 0.0,
			rev_hp: 0.45,
			rev_time: 0.56,
			reverb_send: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timb_mod: 1.0,
			timbre: 0.44,
			volume: 1.34
		),
		// $PRESET_SCALARS_END
		(
			duration: Pwhite(5.0, 10.0, inf).asStream,
			// div: Pseq([0.5], inf).asStream,
			rev_time: Pwhite(0.4, 1.1, inf).asStream,
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