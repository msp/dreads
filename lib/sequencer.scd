//////////////////////////////////////////////////////////////////////////////
// Plaits Sequence Definitions
//////////////////////////////////////////////////////////////////////////////

(
/*~tdKeys = [
\pitch, \engine, \harm, \timbre, \morph, \decay, \fmMod, \lpgColour,
\mul, \revDrywet, \revTime, \revDamp, \revHp, \revFreeze,
\delaySend, \reverbSend, \cloudsSend, \distDrive, \distAmount,
\stereoMode, \volume, \out, \dur, \legato
];*/
~tdKeys = [
	\pitch, \engine, \harm, \timbre
];

~sendEventToTD = { |idx, ev|
	var msg = ["/plaits/state", idx];
	~tdKeys.do { |k| var v = ev[k]; if(v.notNil) { msg = msg ++ [k.asString, v] } };
	["~sendEventToTD", msg].postln;
	~td.().sendMsg(*msg);
};

~noteCounter = Array.fill(~plaits.synths.size, 0);



x = Pdef(\plaitsSequence,
	Ppar(
		~plaits.synths.collect { |instance, i|
			Pcollect({ |ev|
				var d       = ev[\dur];
				var isRest  = d.isKindOf(Rest);
				var durVal  = isRest.if({ d.value }, { d });  // numeric seconds

				if (isRest.not) {
					// tick only on real notes
					~noteCounter[i] = (~noteCounter[i] ? 0) + 1;

					// ["event", ~noteCounter[i], durVal].postln;

					~td.().sendMsg("/plaits/state", i,
						"note",   ~noteCounter[i],
						"pitch",  ev[\pitch],
						"engine", ev[\engine],
						"harm",   ev[\harm],          // <- fixed typo
						"timbre", ev[\timbre],
						"decay",  ev[\decay],
						"dur",    durVal,
						"volume", (ev[\volume] ?? ev[\mul] ?? 0.0)
					);
				}{
					// Optional: tell TD about a rest (uncomment if you want it)
					// ~td.().sendMsg("/plaits/rest", i, "dur", durVal);
				};

				ev
			},

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
						~plaits.synths[i].timbMod
					);
				},
				\morph, Pfunc { |event|
					// ~modulateBipolar.(~plaits.synths[i].sequences.morph.next, ~plaits.synths[i].morph)
					~modulateLayered.(
						~plaits.synths[i].sequences.morph.next,
						~morphLFO.next,
						~plaits.synths[i].morph,
						~plaits.synths[i].morphMod
					);
				},
				\fmMod, Pfunc { |event|
					~modulateBipolar.(~plaits.synths[i].sequences.fmMod.next, ~plaits.synths[i].fmMod);
				},
				\lpgColour, Pfunc { |event|
					~modulateBipolar.(~plaits.synths[i].sequences.lpgColour.next, ~plaits.synths[i].lpgColour);
				},
				\legato, Pfunc { |event| ~plaits.synths[i].legato },
				\engine, Pfunc { |event|
					~setEngine.(~plaits.synths[i].sequences.engine.next, i);
				},
				\mul, Pfunc { |event| ~plaits.synths[i].mul },
				\revDrywet, Pfunc { |event| ~plaits.synths[i].revDrywet },
				\revTime, Pfunc { |event|
					var out = ~modulateBipolar.(~plaits.synths[i].sequences.revTime.next, ~plaits.synths[i].revTime);
					// ["revTime", out].postln;

					out
				},
				\revDamp, Pfunc { |event| ~plaits.synths[i].revDamp },
				\revHp, Pfunc { |event| ~plaits.synths[i].revHp },
				\revFreeze, Pfunc { |event| ~plaits.synths[i].revFreeze },
				\delaySend, Pfunc { |event|
					~modulateBipolar.(~plaits.synths[i].sequences.delaySend.next, ~plaits.synths[i].delaySend);
				},
				\reverbSend, Pfunc { |event|
					~modulateBipolar.(~plaits.synths[i].sequences.reverbSend.next, ~plaits.synths[i].reverbSend);
				},
				\cloudsSend, Pfunc { |event|
					~modulateBipolar.(~plaits.synths[i].sequences.cloudsSend.next, ~plaits.synths[i].cloudsSend);
				},
				\distDrive, Pfunc { |event| ~plaits.synths[i].distDrive },
				\distAmount, Pfunc { |event| ~plaits.synths[i].distAmount },
				\stereoMode, Pfunc { |event| ~plaits.synths[i].stereoMode },
				\volume, Pfunc { |event| ~plaits.synths[i].volume },
				\out, Pseq([0], inf),
			))
		}
	)
);
)
