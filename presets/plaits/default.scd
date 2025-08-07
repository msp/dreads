////////////////////////////////////////////////////////////////////////////////
// Plaits State - Template-based default preset with global FX
////////////////////////////////////////////////////////////////////////////////
(
~plaits = ~presetFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(
				decay: 0.5,
				delay_send: 0.1,
				dist_amount: 0.0,
				dist_drive: 0.0,
				dur: 0.7,
				engine: 1.0,
				fm_mod: 0.0,
				harm: 0.48,
				legato: 9.0,
				lpg_colour: 0.5,
				morph: 0.43,
				morph_mod: 0.4,
				mul: 0.5,
				pitch: 49.0,
				rev_damp: 0.8,
				rev_drywet: 0.25,
				rev_freeze: 0.0,
				rev_hp: 0.7,
				rev_time: 0.3,
				reverb_send: 0.1,
				stereoMode: 1.0,
				tempo: 165.0,
				timb_mod: 0.3,
				timbre: 0.44,
				volume: 1.28
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
				], inf).asStream,
				div: Pseq([1, 2, 1, 1, 2], inf).asStream
			)
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(
				decay: 0.8,
				delay_send: 0.4,
				dist_amount: 0.0,
				dist_drive: 0.0,
				dur: Rest(1.4),
				engine: 6.0,
				fm_mod: 0.0,
				harm: 0.48,
				legato: 9.0,
				lpg_colour: 0.5,
				morph: 0.43,
				morph_mod: 0.8,
				mul: 0.5,
				pitch: 49.0,
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
				volume: 1.0
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
				decay: 0.59,
				delay_send: 0.0,
				dist_amount: 0.0,
				dist_drive: 0.0,
				dur: Rest(1.4),
				engine: 2.0,
				fm_mod: 0.0,
				harm: 0.48,
				legato: 9.0,
				lpg_colour: 0.5,
				morph: 0.43,
				morph_mod: 0.4,
				mul: 0.5,
				pitch: 49.0,
				rev_damp: 0.4,
				rev_drywet: 0.7,
				rev_freeze: 0.0,
				rev_hp: 0.4,
				rev_time: 0.9,
				reverb_send: 0.0,
				stereoMode: 1.0,
				tempo: 165.0,
				timb_mod: 0.7,
				timbre: 0.44,
				volume: 0.9
			),
			// $PRESET_SCALARS_END
			(
				duration: Pseq([
					0.7,
					Rest(0.7),
					Rest(0.7),
					Pwrand([Rest(1.4), 0.7], [0.5, 0.5].normalizeSum),
				], inf).asStream,
				div: Pseq([0.5], inf).asStream
			)
		)
	],
	// Global FX settings
	// $PRESET_FX_START
	(
		delay: (
			feedback: 0.5,
			filter_freq: 6000.0,
			spread: 1.5,
			time: 0.25
		),
		reverb: (
			damp: 0.6,
			diffuse: 0.63,
			freeze: 0.0,
			hp: 0.3,
			time: 0.4
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