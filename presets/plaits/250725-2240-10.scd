////////////////////////////////////////////////////////////////////////////////
// Plaits State - Data structures and synth instance definitions
////////////////////////////////////////////////////////////////////////////////
(
~plaits = [
	// $PLAITS1
	(
		// $PRESET_SCALARS_START
		pitch: 36.68, harm: 0.64, timbre: 0.05, morph: 0.0,
		decay: 1.0, engine: 0.0, fm_mod: -0.68, lpg_colour: 0.5,
		timb_mod: 0.89, morph_mod: 1.0, mul: 0.7, volume: 0.9,
		tempo: 15.0, dur: 2.41, legato: 18.0, rev_drywet: 0.3,
		rev_time: 0.97, rev_damp: 0.78, rev_hp: 0.25, rev_freeze: 0.0,
		stereoMode: 1.0, dist_drive: 0.0, dist_amount: 0.00,
		delay_send: 0.3,
		reverb_send: 0.0,
		// $PRESET_SCALARS_END
		sequences: (
			// timbre: Pseq([0.5], inf).asStream,
			timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
			// decay: Pseq([0.5], inf).asStream,
			decay: Pseq([0.5, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
			// morph: Pseq([0.5], inf).asStream,
			morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
			// harm: Pseq([0.5], inf).asStream,
			harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
			fm_mod: Pseq([0.5], inf).asStream,
			delay_send: Pseq([0.5], inf).asStream,
			reverb_send: Pseq([0.5], inf).asStream,
			lpg_colour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
			// lpg_colour: Pseq([0.5], inf).asStream,
			// engine: Pseq([
			// 	"e",
			// 	Pwrand([2,11], [0.9, 0.1].normalizeSum),
			// 	"e",
			// 	"e",
			// 	Pwrand(["e", 2], [0.8, 0.2].normalizeSum),
			// 	"e+2",
			// 	"e",
			// 	0,
			// ], inf).asStream,
			engine: Pseq(["e", "e", "e-5", "e", "e", "e-6"] , inf).asStream,
			// duration: (
			// 	Pseq([
			// 		Rest(1.0),
			// 		Pwrand([0.5, Rest(0.5)], [0.9, 0.1].normalizeSum),
			// 		Pwrand([1.0, Rest(1.0)], [0.2, 0.8].normalizeSum),
			// 		Rest(0.5),
			// 		1.5
			// 		// ], inf) / Pseq(1.5 ! 15 ++ 1.5, inf)
			// 	], inf)
			// ).asStream,
			// duration: Pseq(0.7 ! 5 ++ (0.7 * 2), inf).asStream,
			duration: Pwhite(1.0, 3.0, inf).asStream,
			// duration: Pseq(
			// 	[
			// 		0.7,
			// 		Pwrand([0.7, Rest(0.7)], [0.9, 0.1].normalizeSum),
			// 		0.7,
			// 		Pwrand([0.7, Rest(1.4)], [0.95, 0.05].normalizeSum),
			// 		0.7,
			// 		Pwrand([1.4, 0.7], [0.6, 0.4].normalizeSum),
			// ], inf).asStream,
			div: Pseq([1], inf).asStream
		)
	),
	// $PLAITS2
	(
		// $PRESET_SCALARS_START
		pitch: 28.25, harm: 0.48, timbre: 0.39, morph: 0.3,
		decay: 0.59, engine: 10.0, fm_mod: 0.0, lpg_colour: 0.5,
		timb_mod: 0.6, morph_mod: 0.4, mul: 0.5, volume: 1.17,
		tempo: 165.0, dur: 1.4, legato: 9.0, rev_drywet: 0.3,
		rev_time: 1.08, rev_damp: 0.78, rev_hp: 0.25, rev_freeze: 0.0,
		delay_send: 0.3,
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
			duration: Pseq(
				[
					0.7,
					Rest(0.7),
					Rest(0.7),
					Rest(0.7),
				], inf).asStream,
			div: Pseq([0.5], inf).asStream
		)
	),
	// $PLAITS3
	(
		// $PRESET_SCALARS_START
		pitch: 123.66, harm: 0.48, timbre: 0.39, morph: 0.3,
		decay: 0.59, engine: 10.0, fm_mod: 0.0, lpg_colour: 0.5,
		timb_mod: 0.6, morph_mod: 0.4, mul: 0.5, volume: 1.51,
		tempo: 165.0, dur: 1.4, legato: 9.0, rev_drywet: 0.3,
		rev_time: 1.08, rev_damp: 0.78, rev_hp: 0.25, rev_freeze: 0.0,
		delay_send: 0.3,
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
			duration: Pseq(
				[
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