//////////////////////////////////////////////////////////////////////////////
// Plaits Sequence Definitions
//////////////////////////////////////////////////////////////////////////////

(
x = Pdef(\plaitsSequence,
	Ppar(
		~plaits.collect { |instance, instanceIndex|
			Pbind(
				\instrument, \plaits,
				\delayBus, ~delayBus,
				\reverbBus, ~reverbBus,
				\pitch, Pfunc { |event|
					// ["--->", ~state, ~plaits[instanceIndex].engine, ~playCount].postln;
					if (instanceIndex == 0) {
						~playCount = ~playCount + 1;
						if (~playCount % 16 == 0) {
							~state = ~states.next;
							// "Completed 16 steps".postln;
						};
					};

					~plaits[instanceIndex].pitch;
				},
				\dur, Pfunc { |event|
					~plaits[instanceIndex].dur = ~setDuration.(
						~plaits[instanceIndex].sequences.duration.next,
						~plaits[instanceIndex].sequences.div.next
					);
					~plaits[instanceIndex].dur;
				},
				\decay, Pfunc { |event|
					// ~modulateBipolar.(~plaits[instanceIndex].sequences.decay.next, ~plaits[instanceIndex].decay)
					~modulateLayered.(
						~plaits[instanceIndex].sequences.decay.next,
						~decayLFO.next,
						~plaits[instanceIndex].decay,
						0.3 // LFO Amount
					);
				},
				\harm, Pfunc { |event|
					~modulateBipolar.(~plaits[instanceIndex].sequences.harm.next, ~plaits[instanceIndex].harm);
				},
				\timbre, Pfunc { |event|
					// ~modulateBipolar.(~plaits[instanceIndex].sequences.timbre.next, ~plaits[instanceIndex].timbre)
					// ~modulateBipolar.(~timbreLFO.next, ~plaits[instanceIndex].timbre)
					~modulateLayered.(
						~plaits[instanceIndex].sequences.timbre.next,
						~timbreLFO.next,
						~plaits[instanceIndex].timbre,
						~plaits[instanceIndex].timb_mod
					);
				},
				\morph, Pfunc { |event|
					// ~modulateBipolar.(~plaits[instanceIndex].sequences.morph.next, ~plaits[instanceIndex].morph)
					~modulateLayered.(
						~plaits[instanceIndex].sequences.morph.next,
						~morphLFO.next,
						~plaits[instanceIndex].morph,
						~plaits[instanceIndex].morph_mod
					);
				},
				\fm_mod, Pfunc { |event|
					~modulateBipolar.(~plaits[instanceIndex].sequences.fm_mod.next, ~plaits[instanceIndex].fm_mod);
				},
				\lpg_colour, Pfunc { |event|
					~modulateBipolar.(~plaits[instanceIndex].sequences.lpg_colour.next, ~plaits[instanceIndex].lpg_colour);
				},
				\legato, Pfunc { |event| ~plaits[instanceIndex].legato },
				\engine, Pfunc { |event|
					~setEngine.(~plaits[instanceIndex].sequences.engine.next, instanceIndex);
				},
				\mul, Pfunc { |event| ~plaits[instanceIndex].mul },
				\rev_drywet, Pfunc { |event| ~plaits[instanceIndex].rev_drywet },
				\rev_time, Pfunc { |event| ~plaits[instanceIndex].rev_time },
				\rev_damp, Pfunc { |event| ~plaits[instanceIndex].rev_damp },
				\rev_hp, Pfunc { |event| ~plaits[instanceIndex].rev_hp },
				\rev_freeze, Pfunc { |event| ~plaits[instanceIndex].rev_freeze },
				\delay_send, Pfunc { |event| ~plaits[instanceIndex].delay_send },
				\reverb_send, Pfunc { |event| ~plaits[instanceIndex].reverb_send },
				\volume, Pfunc { |event| ~plaits[instanceIndex].volume },
				\out, Pseq([0], inf),
			)
		}
	)
);
)