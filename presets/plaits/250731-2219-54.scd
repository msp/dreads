////////////////////////////////////////////////////////////////////////////////
// Plaits State - Data structures and synth instance definitions
////////////////////////////////////////////////////////////////////////////////
(
~plaits = [
	// $PLAITS1
	(
		// $PRESET_SCALARS_START
		pitch: 127.0, harm: 0.41, timbre: 0.7, morph: 0.05,
		decay: 0.6, engine: 15.0, fm_mod: 0.25, lpg_colour: 0.5,
		timb_mod: 1.0, morph_mod: 1.0, mul: 0.7, volume: 0.7,
		tempo: 165.0, dur: 0.35, legato: 9.0, rev_drywet: 0.3,
		rev_time: 0.25, rev_damp: 0.78, rev_hp: 0.61, rev_freeze: 0.0,
		delay_send: 0.0,
		reverb_send: 0.0,
		// $PRESET_SCALARS_END
		sequences: (
			// timbre: Pseq([0.5], inf).asStream,
			timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
			// decay: Pseq([0.5], inf).asStream,
			decay: Pseq([0.5, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
			morph: Pseq([0.5], inf).asStream,
			// morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
			// harm: Pseq([0.5], inf).asStream,
			harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
			fm_mod: Pseq([0.5], inf).asStream,
			// lpg_colour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
			lpg_colour: Pseq([0.5], inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", "e+11"] , inf).asStream,
			duration: Pseq(
				[
					Rest(0.7),
					0.7,
					Rest(0.7),
					// Pwrand([0.7, Rest(0.7)], [0.9, 0.1].normalizeSum),
					Pwrand([Rest(0.7), 0.7], [0.1, 0.9].normalizeSum),
					// Rest(0.7),
					// Pwrand([0.7, Rest(1.4)], [0.95, 0.05].normalizeSum),
					// Rest(0.7),
					// 0.7,
					// Rest(0.7 * rrand(9, 13))
					// Rest(0.7 * 11)
			], inf).asStream,
			div: Pseq([2], inf).asStream
		)
	),
	// $PLAITS2
	(
		// $PRESET_SCALARS_START
		pitch: 33.36, harm: 0.5, timbre: 0.28, morph: 0.87,
		decay: 0.59, engine: 13.0, fm_mod: 0.7, lpg_colour: 0.5,
		timb_mod: 0.6, morph_mod: 0.4, mul: 0.5, volume: 2.0,
		tempo: 165.0, dur: Rest(1.4), legato: 9.0, rev_drywet: 0.0,
		rev_time: 0.56, rev_damp: 0.78, rev_hp: 0.61, rev_freeze: 0.0,
		delay_send: 0.0,
		reverb_send: 0.0,
		// $PRESET_SCALARS_END
		sequences: (
			timbre: Pseq([0.5], inf).asStream,
			decay: Pseq([0.5, 0.1], inf).asStream,
			morph: Pseq([
				Pwrand([0.1, 0.5, 0.9], [0.4, 0.2, 0.2].normalizeSum),
				0.1,
				0.1,
				0.1,
				0.1,
				0.05
			], inf).asStream,
			harm: Pseq([0.5], inf).asStream,
			fm_mod: Pseq([0.5], inf).asStream,
			lpg_colour: Pseq([0.5], inf).asStream,
			engine: Pseq([
				"e", "e", "e", "e", "e", "e+1",
			] , inf).asStream,
			duration: Pseq(
				[
					0.7,
					Rest(0.7),
					Rest(0.7),
					Pwrand([Rest(0.7), 0.7], [0.5, 0.5].normalizeSum),
					Rest(0.7),
					Pwrand([Rest(0.7), 0.7], [0.6, 0.4].normalizeSum),
			], inf).asStream,
			div: Pseq([0.5], inf).asStream
		)
	),
	// $PLAITS3
	(
		// $PRESET_SCALARS_START
		pitch: 49.0, harm: 0.48, timbre: 0.39, morph: 0.75,
		decay: 0.5, engine: 6.0, fm_mod: 0.0, lpg_colour: 0.5,
		timb_mod: 0.6, morph_mod: 0.4, mul: 0.5, volume: 1.15,
		tempo: 165.0, dur: 1.4, legato: 9.0, rev_drywet: 0.28,
		rev_time: 0.56, rev_damp: 0.78, rev_hp: 0.61, rev_freeze: 0.0,
		delay_send: 0.1,
		reverb_send: 0.5,
		// $PRESET_SCALARS_END
		sequences: (
			timbre: Pseq([0.5], inf).asStream,
			decay: Pseq([0.5], inf).asStream,
			morph: Pseq([0.5], inf).asStream,
			harm: Pseq([0.5], inf).asStream,
			fm_mod: Pseq([0.5], inf).asStream,
			lpg_colour: Pseq([0.5], inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", "e+9"] , inf).asStream,
			duration: Pseq(
				[
					0.7,
					Rest(0.7),
					Rest(0.7),
					// Rest(0.7),
					Pwrand([Rest(1.4), 0.7], [0.5, 0.5].normalizeSum),
			], inf).asStream,
			div: Pseq([0.25], inf).asStream
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