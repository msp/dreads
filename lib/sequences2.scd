//////////////////////////////////////////////////////////////////////////////
// Plaits Sequence Definitions
//////////////////////////////////////////////////////////////////////////////

(
x = Pdef(\plaitsSequence,
	Ppar([
		/// Plaits 1 /////////////////////////////////////////////////////////////////
		Pbind(
			\instrument, \plaits,
			\pitch, Pfunc { |event|
				// ["--->", ~state, ~plaits[0].engine, ~playCount].postln;
				~playCount = ~playCount + 1;

				if (~playCount % 16 == 0) {
					~state = ~states.next;
					// "Completed 16 steps".postln;
				};

				~plaits[0].dur = ~setDuration.(
					~plaits[0].sequences.duration.next,
					~plaits[0].sequences.div.next
				);

				~plaits[0].pitch ;
			},
			\dur, Pfunc { |event|
				~plaits[0].dur
			},
			\decay, Pfunc { |event|
				// ~modulateBipolar.(~plaits[0].sequences.decay.next, ~plaits[0].decay)
				~modulateLayered.(
					~plaits[0].sequences.decay.next,
					~decayLFO.next,
					~plaits[0].decay,
					0.3 // LFO Amount
				)

			},
			\harm, Pfunc { |event|
				~modulateBipolar.(~plaits[0].sequences.harm.next, ~plaits[0].harm)
			},
			\timbre, Pfunc { |event|
				// ~modulateBipolar.(~plaits[0].sequences.timbre.next, ~plaits[0].timbre)
				// ~modulateBipolar.(~timbreLFO.next, ~plaits[0].timbre)
				~modulateLayered.(
					~plaits[0].sequences.timbre.next,
					~timbreLFO.next,
					~plaits[0].timbre,
					~plaits[0].timb_mod
				)
			},
			\morph, Pfunc { |event|
				// ~modulateBipolar.(~plaits[0].sequences.morph.next, ~plaits[0].morph)
				~modulateLayered.(
					~plaits[0].sequences.morph.next,
					~morphLFO.next,
					~plaits[0].morph,
					~plaits[0].morph_mod
				)
			},
			\fm_mod, Pfunc { |event|
				~modulateBipolar.(~plaits[0].sequences.fm_mod.next, ~plaits[0].fm_mod)
			},
			\lpg_colour, Pfunc { |event|
				~modulateBipolar.(~plaits[0].sequences.lpg_colour.next, ~plaits[0].lpg_colour)
			},
			\legato, Pfunc { |event| ~plaits[0].legato },
			\engine, Pfunc { |event|
				~setEngine.(~plaits[0].sequences.engine.next)
			},
			\mul, Pfunc { |event| ~plaits[0].mul },
			\rev_drywet, Pfunc { |event| ~plaits[0].rev_drywet },
			\rev_time, Pfunc { |event| ~plaits[0].rev_time },
			\rev_damp, Pfunc { |event| ~plaits[0].rev_damp },
			\rev_hp, Pfunc { |event| ~plaits[0].rev_hp },
			\rev_freeze, Pfunc { |event| ~plaits[0].rev_freeze },
			\delay_send, Pfunc { |event| ~plaits[0].delay_send },
			\reverb_send, Pfunc { |event| ~plaits[0].reverb_send },
			\volume, Pfunc { |event| ~plaits[0].volume },
			\out, Pseq(
				[
					0
					// 0,1,2,3,4,5
			], inf),
		),
		/// Plaits 2 (kick) //////////////////////////////////////////////////////////
		// Pbind(
		// 	\instrument, \plaits,
		// 	\dur, Pfunc { |event|
		// 		~plaits[0].dur
		// 	},
		// 	\pitch, 36,
		// 	\harm, 0.55,
		// 	\timbre, 0.8,
		// 	\morph, Pseq(
		// 		[0.4, 0.1, 0.2, 0.1, 0.4, 0.1, 0.1, 0.05, Pseq([0.5, 0.3, 0.1])
		// 	] * 0.5, inf),
		// 	\engine, Pseq([13,13,13,13, 13,13,13,13], inf),
		// 	// \decay, 0.2,
		// 	\mul, 0.0,
		// 	\out, 0
		//
		// ),
		/// Plaits 3 (hats / claps) //////////////////////////////////////////////////
		// Pbind(
		// 	\instrument, \plaits,
		// 	\dur, Pseq([
		// 		Prand([2, Rest(2)]),
		// 		2,
		// 		Rest(2),
		// 		Rest(2),
		// 		Pwrand([1.0, Rest(1)], [0.8, 0.2].normalizeSum)
		// 	]/3, inf),
		// 	\pitch, Pseq([45, 45, 45, 45, 30], inf),
		// 	\harm, Pseq([0.1, 0.6, 0.7, 0.8, 0.4], inf),
		// 	\timbre, Pseq([0.9, 0.6, 0.7, 0.8, 0.2], inf),
		// 	\morph, Pseq([0.1, 0.01, 0.1, 0.1, 0.15], inf),
		// 	\decay, 0.3, //only effects first sound!
		// 	\engine, Pseq([
		// 		// Prand([9, 10, 15]), //9 is the accent
		// 		9,
		// 		15, 15,
		// 		Prand([14, 15]),
		// 		Pwrand([14, 10], [0.8, 0.2].normalizeSum),
		// 	], inf),
		// 	// \mul, Pseq([1.05, 0.45, 0.45, 0.45, 1.2] -0.3, inf),
		// 	\mul, 0.0,
		// 	\out, 0
		// ),
		// More hats! /////////////////////////////////////////
		// Pbind(
		// 	\instrument, \plaits,
		// 	\dur, Pseq([
		// 		Rest(1),
		// 		Prand([Rest(1), 1, 1, 1]),
		// 		1
		// 	], inf) / Pseq([3, 3, 3, 1.5], inf),
		// 	// \dur, Pseq([Rest(1/1.5), 1/1.5 ] / 3, inf),
		// 	\pitch, Pseq([65, 45, 55, 45, 30], inf),
		// 	\harm, Pseq([0.1, 0.6, 0.7, 0.8, 0.4], inf),
		// 	\timbre, Pseq([0.9, 0.6, 0.7, 0.8, 0.2], inf),
		// 	\morph, Pseq([0.1, 0.01, 0.1, 0.1, 0.15] * 2, inf),
		// 	\decay, 0.05,
		// 	\engine, Pseq([
		// 		15
		// 	], inf),
		// 	// \mul, Pseq([0.01], inf),
		// 	\mul, 0.0,
		// 	\out, 0
		// ),
		/// Plaits 3 (chords) ////////////////////////////////////////////////////////
		// Pbind(
		// 	\instrument, \plaits,
		// 	\dur, Pseq([2.5, Rest(0.5), Rest(1.5)]/ (1.5/16), inf),
		// 	\pitch, Pseq([[88, 95, 102]] - 30, inf),
		// 	\harm, Pseq([0.2], inf),
		// 	\timbre, Pseq([0.2], inf),
		// 	\morph, Pseq([0.5] * 2, inf),
		// 	\decay, 1.0,
		// 	\engine, Pseq([8, 9], inf),
		// 	\reverb_time, 1.1,
		// 	\drywet, 0.75,
		// 	// \mul, Pseq([0.1, 0.3], inf),
		// 	\mul, 0.0,
		// 	\out, 0
		// )
	])
).play(~tempoClock);

// Pattern control functions
// x.play;
// x.stop;
)