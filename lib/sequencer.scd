//////////////////////////////////////////////////////////////////////////////
// Plaits Sequence Definitions
//////////////////////////////////////////////////////////////////////////////

(
x = Pdef(\plaitsSequence,
	Ppar(
		~plaits.synths.collect { |instance, i|
			Pbind(
				\instrument, \plaits,
				\delayBus, ~delayBus,
				\reverbBus, ~reverbBus,
				\pitch, Pfunc { |event|
					// ["--->", ~state, ~plaits.synths[i].engine, ~playCount].postln;
					if (i == 0) {
						~playCount = ~playCount + 1;
						if (~playCount % 16 == 0) {
							~state = ~states.next;
							// "Completed 16 steps".postln;
						};
					};

					~plaits.synths[i].pitch;
				},
				\dur, Pfunc { |event|
					~plaits.synths[i].dur = ~setDuration.(
						~plaits.synths[i].sequences.duration.next,
						~plaits.synths[i].sequences.div.next
					);
					~plaits.synths[i].dur;
				},
				\decay, Pfunc { |event|
					// ~modulateBipolar.(~plaits.synths[i].sequences.decay.next, ~plaits.synths[i].decay)
					~modulateLayered.(
						~plaits.synths[i].sequences.decay.next,
						~decayLFO.next,
						~plaits.synths[i].decay,
						0.3 // LFO Amount
					);
				},
				\harm, Pfunc { |event|
					~modulateBipolar.(~plaits.synths[i].sequences.harm.next, ~plaits.synths[i].harm);
				},
				\timbre, Pfunc { |event|
					// ~modulateBipolar.(~plaits.synths[i].sequences.timbre.next, ~plaits.synths[i].timbre)
					// ~modulateBipolar.(~timbreLFO.next, ~plaits.synths[i].timbre)
					~modulateLayered.(
						~plaits.synths[i].sequences.timbre.next,
						~timbreLFO.next,
						~plaits.synths[i].timbre,
						~plaits.synths[i].timb_mod
					);
				},
				\morph, Pfunc { |event|
					// ~modulateBipolar.(~plaits.synths[i].sequences.morph.next, ~plaits.synths[i].morph)
					~modulateLayered.(
						~plaits.synths[i].sequences.morph.next,
						~morphLFO.next,
						~plaits.synths[i].morph,
						~plaits.synths[i].morph_mod
					);
				},
				\fm_mod, Pfunc { |event|
					~modulateBipolar.(~plaits.synths[i].sequences.fm_mod.next, ~plaits.synths[i].fm_mod);
				},
				\lpg_colour, Pfunc { |event|
					~modulateBipolar.(~plaits.synths[i].sequences.lpg_colour.next, ~plaits.synths[i].lpg_colour);
				},
				\legato, Pfunc { |event| ~plaits.synths[i].legato },
				\engine, Pfunc { |event|
					~setEngine.(~plaits.synths[i].sequences.engine.next, i);
				},
				\mul, Pfunc { |event| ~plaits.synths[i].mul },
				\rev_drywet, Pfunc { |event| ~plaits.synths[i].rev_drywet },
				\rev_time, Pfunc { |event|
					var out = ~modulateBipolar.(~plaits.synths[i].sequences.rev_time.next, ~plaits.synths[i].rev_time);
					// ["rev_time", out].postln;

					out
				},
				\rev_damp, Pfunc { |event| ~plaits.synths[i].rev_damp },
				\rev_hp, Pfunc { |event| ~plaits.synths[i].rev_hp },
				\rev_freeze, Pfunc { |event| ~plaits.synths[i].rev_freeze },
				\delay_send, Pfunc { |event|
					~modulateBipolar.(~plaits.synths[i].sequences.delay_send.next, ~plaits.synths[i].delay_send);
				},
				\reverb_send, Pfunc { |event|
					~modulateBipolar.(~plaits.synths[i].sequences.reverb_send.next, ~plaits.synths[i].reverb_send);
				},
				\dist_drive, Pfunc { |event| ~plaits.synths[i].dist_drive },
				\dist_amount, Pfunc { |event| ~plaits.synths[i].dist_amount },
				\stereoMode, Pfunc { |event| ~plaits.synths[i].stereoMode },
				\volume, Pfunc { |event| ~plaits.synths[i].volume },
				\out, Pseq([0], inf),
			)
		}
	)
);
)