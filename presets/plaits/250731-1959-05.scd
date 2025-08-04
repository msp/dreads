////////////////////////////////////////////////////////////////////////////////
// Plaits State - Data structures and synth instance definitions
////////////////////////////////////////////////////////////////////////////////
(
~plaits = [
	// $PLAITS1
	(
		// $PRESET_SCALARS_START
		pitch: 34.52, harm: 0.65, timbre: 0.31, morph: 0.42,
		decay: 0.59, engine: 13.0, fm_mod: 0.82, lpg_colour: 0.5,
		timb_mod: 0.3, morph_mod: 0.4, mul: 0.5, volume: 1.5,
		tempo: 145.0, dur: Rest(0.33333333333333), legato: 9.0, rev_drywet: 0.21,
		rev_time: 0.3, rev_damp: 0.8, rev_hp: 0.7, rev_freeze: 0.0,
		stereoMode: 0.0, dist_drive: 0.0, dist_amount: 0.0,
		delay_send: 0.0,
		reverb_send: 0.0,
		// $PRESET_SCALARS_END
		sequences: (
			timbre: Pseq([0.5], inf).asStream,
			// timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
			decay: Pseq([0.5], inf).asStream,
			// decay: Pseq([0.5, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
			morph: Pseq([0.5], inf).asStream,
			// morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
			harm: Pseq([0.5], inf).asStream,
			// harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
			fm_mod: Pseq([0.5], inf).asStream,
			delay_send: Pseq([0.5], inf).asStream,
			reverb_send: Pseq([0.5], inf).asStream,
			lpg_colour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", "e"] , inf).asStream,
			duration: Pseq([0.33, Rest(0.33), 0.33, Rest(0.33), 0.33, Rest(0.33), Rest(0.33), Rest(0.33)] ++ (Rest(1) ! 7) ++ (1), inf).asStream,
			div: Pseq([3], inf).asStream
		)
	),
	// $PLAITS2
	(
		// $PRESET_SCALARS_START
		pitch: 57.7, harm: 0.8, timbre: 0.65, morph: 0.69,
		decay: 0.5, engine: 0.0, fm_mod: -0.65, lpg_colour: 0.5,
		timb_mod: 0.57, morph_mod: 0.8, mul: 0.5, volume: 1.42,
		tempo: 165.0, dur: Rest(0.33333333333333), legato: 2.0, rev_drywet: 0.4,
		rev_time: 0.59, rev_damp: 0.64, rev_hp: 0.29, rev_freeze: 0.0,
		stereoMode: 1.0, dist_drive: 0.0, dist_amount: 0.0,
		delay_send: 0.5,
		reverb_send: 0.0,
		// $PRESET_SCALARS_END
		sequences: (
			timbre: Pseq([0.5], inf).asStream,
			decay: Pseq([0.1, 0.2, 0.1, 0.05, 0.9] ++ (0.0 ! 12), inf).asStream,
			morph: Pseq([0.5], inf).asStream,
			harm: Pseq([0.5], inf).asStream,
			fm_mod: Pseq([0.5], inf).asStream,
			delay_send: Pseq([0.0, 0.0, 0.1, 0.0, 0.7] ++ (0.0 ! 12), inf).asStream,
			reverb_send: Pseq([0.5], inf).asStream,
			lpg_colour: Pseq([0.5], inf).asStream,
			engine: Pseq(["e", "e", "e+6", "e", "e+2", "e"] , inf).asStream,
			duration: Pseq([0.33, Rest(0.33), 0.33, Rest(0.33), 0.33, Rest(0.33), Rest(0.33), Rest(0.33)] ++ (Rest(1) ! 4) ++ [Rest(0.33), 0.33, Rest(0.33), Rest(0.33)], inf).asStream,
			div: Pseq([3], inf).asStream
		)
	),
	// $PLAITS3
	(
		// $PRESET_SCALARS_START
		pitch: 50.71, harm: 0.34, timbre: 0.39, morph: 0.26,
		decay: 0.59, engine: 14.0, fm_mod: 0.01, lpg_colour: 0.5,
		timb_mod: 0.77, morph_mod: 0.75, mul: 0.5, volume: 0.8,
		tempo: 165.0, dur: Rest(0.33333333333333), legato: 9.0, rev_drywet: 0.21,
		rev_time: 0.3, rev_damp: 0.8, rev_hp: 0.7, rev_freeze: 0.0,
		stereoMode: 1.0, dist_drive: 0.0, dist_amount: 0.0,
		delay_send: 0.0,
		reverb_send: 0.0,
		// $PRESET_SCALARS_END
		sequences: (
			timbre: Pseq([0.5], inf).asStream,
			decay: Pseq([0.5], inf).asStream,
			morph: Pseq([0.5], inf).asStream,
			harm: Pseq([0.5], inf).asStream,
			fm_mod: Pseq([0.5], inf).asStream,
			delay_send: Pseq([0.5], inf).asStream,
			reverb_send: Pseq([0.5], inf).asStream,
			lpg_colour: Pseq([0.5], inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", "e"] , inf).asStream,
			duration: Pseq([0.33, Rest(0.33), 0.33, Rest(0.33), 0.33, Rest(0.33), Rest(0.33), Rest(0.33)] ++ (Rest(1) ! 8), inf).asStream,
			div: Pseq([3], inf).asStream
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