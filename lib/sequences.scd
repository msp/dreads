//////////////////////////////////////////////////////////////////////////////
// Plaits Sequence Definitions
//////////////////////////////////////////////////////////////////////////////

(
// Global tempo clock and playback state
~tempoClock = TempoClock.new(165/60);
~playCount = 0;

// Main sequence definition
x = Pdef(\plaitsSequence,
	Ppar([
		Pbind(
			\instrument, \plaits,
			// \pitch, Pfunc({ Scale.bhairav.degrees.copyRange(0, 2).choose.midiratio }),
			// \pitch, Pseq([40, 30], inf),
			// \pitch, Pseq(~scale, inf) + 60,
			\pitch, Pfunc { |event|
				// ["--->", ~state, ~plaits[0].engine, ~playCount].postln;

				~playCount = ~playCount + 1;

				if (~playCount % 16 == 0) {
					~state = ~states.next;
					// "Completed 16 steps".postln;
				};

				~plaits[0].dur = ~setDuration.(~plaits[0].sequences.duration.next, ~plaits[0].sequences.div.next, ~plaits[0].speed);

				~plaits[0].pitch ;
			},
			// \dur, 1,
			\dur, Pfunc { |event|
				// ~setDuration.(~durationSeq.next, ~divSeq.next, ~speed)
				~plaits[0].dur
			},
			// \dur, Pseq([0.1, Rest(0.4), 0.2]/[0.5, 0.5, 1, 0.25], inf),
			// \decay, Pseq([0.4, 0.2, Pseq([0.6, 0.1, 0.8] / 1.5)] / 1, inf),
			\decay, Pfunc { |event|
				~modulateBipolar.(~plaits[0].sequences.decay.next, ~plaits[0].decay)
			},
			// \harm, Pseq([0.5, 0.2, 0.1, 0.6]/1, inf),
			\harm, Pfunc { |event|
				~modulateBipolar.(~plaits[0].sequences.harm.next, ~plaits[0].harm)
			},
			\timbre, Pfunc { |event|
				~modulateBipolar.(~plaits[0].sequences.timbre.next, ~plaits[0].timbre)
			},
			// \morph, Pseq([0.5, Pseq([0.3, 1])]/2, inf),
			\morph, Pfunc { |event|
				~modulateBipolar.(~plaits[0].sequences.morph.next, ~plaits[0].morph)
			},
			\fm_mod, Pfunc { |event|
				~modulateBipolar.(~plaits[0].sequences.fm_mod.next, ~plaits[0].fm_mod)
			},
			// \lpg_colour, Pseq([0.1, 0.2, 0.4, 1], inf),
			\lpg_colour, Pfunc { |event|
				~modulateBipolar.(~plaits[0].sequences.lpg_colour.next, ~plaits[0].lpg_colour)
			},
			\timb_mod, ~plaits[0].timb_mod,
			\morph_mod, ~plaits[0].morph_mod,
			// \engine, Pseq([~e], inf),
			\engine, Pfunc { |event|
				~setEngine.(~plaits[0].sequences.engine.next)
			},
			\mul, ~plaits[0].mul,
			\out, Pseq(
				[
					0
					// 0,1,2,3,4,5
			], inf),
		),
		Pbind(
			\instrument, \plaits,
			// \dur, 0.5,
			// \dur, Prand([0.5, Rest(0.5), Rest(0.5), Rest(0.5)]/~durDiv, inf),
			\dur, Pfunc { |event|
				// ~setDuration.(~percDurationSeq.next, ~divSeq.next, ~speed)
				~plaits[0].dur
			},
			\pitch, 36,
			\harm, 0.55,
			\timbre, 0.8,
			// \morph, 0.5,
			\morph, Pseq(
				[0.4, 0.1, 0.2, 0.1, 0.4, 0.1, 0.1, 0.05, Pseq([0.5, 0.3, 0.1])
			] * 0.5, inf),
			\engine, Pseq([13,13,13,13, 13,13,13,13], inf),
			// \decay, 0.2,
			\mul, 0.6,
			\out, 0
			// \out, Pseq([0,1,2,3,4,5], inf)
		),
		// hats / claps ////////////////////////////////////
		Pbind(
			\instrument, \plaits,
			\dur, Pseq([
				Prand([2, Rest(2)]),
				2,
				Rest(2),
				Rest(2),
				Pwrand([1.0, Rest(1)], [0.8, 0.2].normalizeSum)
			]/3, inf),
			\pitch, Pseq([45, 45, 45, 45, 30], inf),
			\harm, Pseq([0.1, 0.6, 0.7, 0.8, 0.4], inf),
			\timbre, Pseq([0.9, 0.6, 0.7, 0.8, 0.2], inf),
			\morph, Pseq([0.1, 0.01, 0.1, 0.1, 0.15], inf),
			\decay, 0.3, //only effects first sound!
			\engine, Pseq([
				// Prand([9, 10, 15]), //9 is the accent
				9,
				15, 15,
				Prand([14, 15]),
				Pwrand([14, 10], [0.8, 0.2].normalizeSum),
			], inf),
			\mul, Pseq([1.05, 0.45, 0.45, 0.45, 1.2] -0.3, inf),
			\out, 0
		),
		// More hats! /////////////////////////////////////////
		Pbind(
			\instrument, \plaits,
			\dur, Pseq([
				Rest(1),
				Prand([Rest(1), 1, 1, 1]),
				1
			], inf) / Pseq([3, 3, 3, 1.5], inf),
			// \dur, Pseq([Rest(1/1.5), 1/1.5 ] / 3, inf),
			\pitch, Pseq([65, 45, 55, 45, 30], inf),
			\harm, Pseq([0.1, 0.6, 0.7, 0.8, 0.4], inf),
			\timbre, Pseq([0.9, 0.6, 0.7, 0.8, 0.2], inf),
			\morph, Pseq([0.1, 0.01, 0.1, 0.1, 0.15] * 2, inf),
			\decay, 0.05,
			\engine, Pseq([
				15
			], inf),
			\mul, Pseq([0.01], inf),
			\out, 0
		),
		// The one /////////////////////////////////////////
		Pbind(
			\instrument, \plaits,
			// \dur, Pseq([Rest(1/1.5), 1/1.5 ] / 3, inf),
			\dur, Pseq([2.5, Rest(0.5), Rest(1.5)]/ (1.5/16), inf),
			\pitch, Pseq([[88, 95, 102]] - 30, inf),
			\harm, Pseq([0.2], inf),
			\timbre, Pseq([0.2], inf),
			\morph, Pseq([0.5] * 2, inf),
			\decay, 1.0,
			\engine, Pseq([8, 9], inf),
			\reverb_time, 1.1,
			\drywet, 0.75,
			\mul, Pseq([0.1, 0.3], inf),
			\out, 0
		)
	])
).play(~tempoClock);

// Pattern control functions
// x.play;
// x.stop;
)