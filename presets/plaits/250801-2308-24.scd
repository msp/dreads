////////////////////////////////////////////////////////////////////////////////
// Plaits State - Data structures and synth instance definitions
////////////////////////////////////////////////////////////////////////////////
(
~plaits = [
	// $PLAITS1
	(
		// $PRESET_SCALARS_START
		pitch: 34.47, harm: 0.83, timbre: 0.68, morph: 0.22,
		decay: 0.48, engine: 13.0, fm_mod: 0.49, lpg_colour: 0.5,
		timb_mod: 0.0, morph_mod: 0.0, mul: 0.5, volume: 1.36,
		tempo: 125.0, dur: Rest(0.25), legato: 0.7, rev_drywet: 0.0,
		rev_time: 1.25, rev_damp: 0.8, rev_hp: 0.7, rev_freeze: 0.0,
		stereoMode: 0.0, dist_drive: 0.3, dist_amount: 0.04,
		delay_send: 0.0,
		reverb_send: 0.0,
		// $PRESET_SCALARS_END
		sequences: (
			timbre: Pseq([0.5], inf).asStream,
			// timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
			decay: Pseq([0.5], inf).asStream,
			// decay: Pseq([0.5, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
			morph: Pseq([
				0.3,
				0.2,
				0.5,
				0.5,
				0.5,
				0.6,
				0.5,
				0.2,
			], inf).asStream,
			// morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
			harm: Pseq([0.5], inf).asStream,
			// harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
			fm_mod: Pseq([0.5], inf).asStream,
			delay_send: Pseq([0.5], inf).asStream,
			reverb_send: Pseq([0.5], inf).asStream,
			lpg_colour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
			// lpg_colour: Pseq([0.5], inf).asStream,
			engine: Pseq(["e", "e+1", "e", "e", "e", "e"] , inf).asStream,
			duration: Pseq(
				[
					0.25,
					// 0.25,
					Rest(0.25),
					// Rest(0.25),
					Pwrand([0.25, Rest(0.25)], [0.95, 0.05].normalizeSum),
					// Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					// 0.25,
					Pwrand([0.25, Rest(0.25)], [0.95, 0.05].normalizeSum),
					Rest(0.25),
					// 0.25,
					Pwrand([Rest(0.25), 0.25], [0.6, 0.4].normalizeSum),
			], inf).asStream,
			// div: Pseq(1 ! 63 ++ (0.5), inf).asStream
			div: Pseq(1 ! 63 ++ (1.0), inf).asStream
		)
	),
	// $PLAITS2
	(
		// $PRESET_SCALARS_START
		pitch: 58.5, harm: 0.86, timbre: 0.81, morph: 0.24,
		decay: 0.18, engine: 2.0, fm_mod: 0.0, lpg_colour: 0.5,
		timb_mod: 1.0, morph_mod: 0.46, mul: 0.5, volume: 1.32,
		tempo: 165.0, dur: Rest(0.25), legato: 0.1, rev_drywet: 0.0,
		rev_time: 0.0, rev_damp: 0.48, rev_hp: 0.39, rev_freeze: 0.0,
		stereoMode: 1.0, dist_drive: 0.1, dist_amount: 0.03,
		delay_send: 0.0,
		reverb_send: 0.63,
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
			engine: Pseq(["e", "e", "e", "e", "e", 0] , inf).asStream,
			duration: Pseq(
				[
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					// 0.25,
					// Pwrand([0.25, Rest(0.25)], [0.55, 0.35].normalizeSum),
					Rest(0.25),
					Rest(0.25),
					0.25,
					// Pwrand([Rest(0.25), 0.25], [0.6, 0.4].normalizeSum),
			], inf).asStream,
			div: Pseq(1 ! 127 ++ (0.5), inf).asStream
		)
	),
	// $PLAITS3
	(
		// $PRESET_SCALARS_START
		pitch: 49.0, harm: 0.48, timbre: 0.44, morph: 0.23,
		decay: 0.53, engine: 15.0, fm_mod: 0.0, lpg_colour: 0.5,
		timb_mod: 0.7, morph_mod: 0.93, mul: 0.5, volume: 0.46,
		tempo: 165.0, dur: Rest(0.25), legato: 4.0, rev_drywet: 0.67,
		rev_time: 0.9, rev_damp: 0.08, rev_hp: 0.69, rev_freeze: 0.0,
		stereoMode: 1.0, dist_drive: 0.4, dist_amount: 0.2,
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
			engine: Pseq(["e", "e", "e", "e", "e", "e-1"] , inf).asStream,
			duration: Pseq(
				[
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					// 0.25,
					// Pwrand([0.25, Rest(0.25)], [0.55, 0.35].normalizeSum),
					Rest(0.25),
					Rest(0.25),
					0.25,
					// Pwrand([Rest(0.25), 0.25], [0.6, 0.4].normalizeSum),
			], inf).asStream,
			div: Pseq(1 ! 63 ++ (0.5), inf).asStream
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