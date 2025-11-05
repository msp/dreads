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
	~ws.().sendMsg(*msg);
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
						"tempo",  ~plaits.synths[0].tempo,
						"pitch",  ev[\pitch],
						"engine", ev[\engine],
						"harm",   ev[\harm],
						"timbre", ev[\timbre],
						"decay",  ev[\decay],
						"morph",  ev[\morph],
						"dur",    durVal,
						"volume", (ev[\volume] ?? ev[\mul] ?? 0.0)
					);

					if (~plaits.synths[i].sendToPhones == 1.0) {
						~ws.().sendMsg("/plaits/state", i,
							"note",   ~noteCounter[i],
							"tempo",  ~plaits.synths[0].tempo,
							"pitch",  ev[\pitch],
							"engine", ev[\engine],
							"harm",   ev[\harm],
							"timbre", ev[\timbre],
							"decay",  ev[\decay],
							"morph",  ev[\morph],
							"dur",    durVal,
							"volume", (ev[\volume] ?? ev[\mul] ?? 0.0)
						);
					}
				}{
					// Optional: tell TD about a rest (uncomment if you want it)
					// ~td.().sendMsg("/plaits/rest", i, "dur", durVal);
				};

				ev
			},

			Pbind(
				\instrument, \plaits,
				\group, ~voiceGroup,
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

					// var v = ~sineAtBeat.(~tempoClock.beats, 64, 0.15, 0.5);
					// ~plaits.synths[i].dur = ~setDuration.(v, ~plaits.synths[i].sequences.div.next);
					// ~plaits.synths[i].dur = v;
					// ~plaits.synths[i].dur;

					~plaits.synths[i].dur = ~setDuration.(
						~plaits.synths[i].sequences.duration.next,
						~plaits.synths[i].sequences.div.next
					);
					// ["dur----------------------------", ~plaits.synths[i].dur].postln;
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
					~setEngine.(~plaits.synths[i].sequences.engine.next, ~plaits.synths[i].engine);
				},
				\mul, Pfunc { |event| ~modulateBipolar.(~plaits.synths[i].sequences.mul.next, ~plaits.synths[i].mul); },
				\revDrywet, Pfunc { |event|
					~modulateBipolar.(~plaits.synths[i].sequences.revDrywet.next, ~plaits.synths[i].revDrywet);
				},
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
				\volume, Pfunc { |event| ~modulateBipolar.(~plaits.synths[i].sequences.volume.next, ~plaits.synths[i].volume); },
				\out, Pseq([0,1,2,3], inf),
			))
		} ++
		// Sample instances (use lookups for live coding)
		~plaits.samples.collect { |instance, i|
			Pbind(
				\type, \oneShotSample,  // Custom event type: never sends gate=0
				\instrument, \panningSamplePlayer,
				\group, ~voiceGroup,
				// Calculate variant once per event (evaluated first, then reused)
				\sampleVariant, Pfunc {
					var variantSeq = ~plaits.samples[i].sequences.variant.next;
					var variantBase = ~plaits.samples[i].variant;
					~add.(variantSeq, variantBase);
				},
				// Get sample duration for scaling normalized values
				\sampleDuration, Pfunc { |event|
					var bankName = ~plaits.samples[i].bankName;
					var variant = event[\sampleVariant];
					var metadata, duration;

					if (bankName.notNil) {
						metadata = ~sampleLibrary.metadata[bankName];
						if (metadata.notNil && metadata[variant].notNil) {
							duration = metadata[variant].duration;
						};
					};

					duration ?? 1.0;  // Fallback to 1.0 second if not found
				},
				\bufnum, Pfunc { |event|
					var bankName = ~plaits.samples[i].bankName;
					var buffer = ~getSampleBuffer.(bankName, event[\sampleVariant]);
					buffer ?? 0;
				},
				\numChannels, Pfunc { |event|
					var bankName = ~plaits.samples[i].bankName;
					var buffer = ~getSampleBuffer.(bankName, event[\sampleVariant]);
					if (buffer.notNil) { buffer.numChannels } { 1 };
				},
				\dur, Pfunc {
					var durSeq = ~plaits.samples[i].sequences.duration.next;
					var divSeq = ~plaits.samples[i].sequences.div.next;
					~plaits.samples[i].dur = ~setDuration.(durSeq, divSeq);
					// if (i == 0) { ["Sample", i, "durSeq:", durSeq, "divSeq:", divSeq, "final dur:", ~plaits.samples[i].dur].postln; };
					~plaits.samples[i].dur;
				},
				\mul, Pfunc {
				var baseMul = ~plaits.samples[i].mul;
				var result = ~modulateBipolar.(~plaits.samples[i].sequences.mul.next, baseMul);
					// if (i == 0) { ["Sample", i, "mul:", baseMul, "->", result].postln; };
				result;
			},
				\rate, Pfunc {
					var rateSeq = ~plaits.samples[i].sequences.rate.next;
					var baseRate = ~plaits.samples[i].rate;
					var result = ~multiply.(rateSeq, baseRate);
					// if (i == 0) { ["Sample", i, "rateSeq:", rateSeq, "baseRate:", baseRate, "->", result].postln; };
					result;
				},
				\startPos, Pfunc { |event|
					var bankName = ~plaits.samples[i].bankName;
					var buffer = ~getSampleBuffer.(bankName, event[\sampleVariant]);
					var duration = event[\sampleDuration];
					// UI and sequence are normalized 0-1, scale to sample duration
					var normalized = ~modulateBipolar.(
						~plaits.samples[i].sequences.startPos.next,
						~plaits.samples[i].startPos
					);
					var seconds = normalized * duration;  // Scale to actual sample length
					var frames = ~secondsToFrames.(seconds, buffer);
					if (i == 0) { ["Sample startPos - norm:", normalized, "seconds:", seconds, "frames:", frames].postln; };
					frames;
				},
				\atk, Pfunc { |event|
					var duration = event[\sampleDuration];
					// Normalized 0-1, scale to duration/2 (attack shouldn't exceed half the sample)
					var normalized = ~modulateBipolar.(
						~plaits.samples[i].sequences.atk.next,
						~plaits.samples[i].atk
					);
					normalized * (duration / 2);
				},
				\decay, Pfunc { |event|
					var duration = event[\sampleDuration];
					// Normalized 0-1, scale to duration*2 (allow longer decay than sample)
					var normalized = ~modulateBipolar.(
						~plaits.samples[i].sequences.decay.next,
						~plaits.samples[i].decay
					);
					normalized * (duration * 2);
				},
				\panDur, Pfunc { |event|
					var duration = event[\sampleDuration];
					// Normalized 0-1, scale to duration*2
					var normalized = ~modulateBipolar.(
						~plaits.samples[i].sequences.panDur.next,
						~plaits.samples[i].panDur
					);
					// if (i == 0) { ["Sample panDur - norm:", normalized, "duration:", duration, "->", normalized * (duration * 2), "seconds"].postln; };
					normalized * (duration * 2);
				},
				\volume, Pfunc {
				var vol = ~plaits.samples[i].volume;
					// if (i == 0) { ["Sample", i, "volume:", vol].postln; };
				vol;
			},
				\cloudsSend, Pfunc { ~modulateBipolar.(~plaits.samples[i].sequences.cloudsSend.next, ~plaits.samples[i].cloudsSend) },
				\delaySend, Pfunc { ~modulateBipolar.(~plaits.samples[i].sequences.delaySend.next, ~plaits.samples[i].delaySend) },
				\reverbSend, Pfunc { ~modulateBipolar.(~plaits.samples[i].sequences.reverbSend.next, ~plaits.samples[i].reverbSend) },
				\distDrive, Pfunc { |event| ~plaits.samples[i].distDrive },
				\distAmount, Pfunc { |event| ~plaits.samples[i].distAmount },
				\revDrywet, Pfunc { |event|
					~modulateBipolar.(~plaits.samples[i].sequences.revDrywet.next, ~plaits.samples[i].revDrywet);
				},
				\revTime, Pfunc { |event|
					~modulateBipolar.(~plaits.samples[i].sequences.revTime.next, ~plaits.samples[i].revTime);
				},
				\revDamp, Pfunc { |event| ~plaits.samples[i].revDamp },
				\revHp, Pfunc { |event| ~plaits.samples[i].revHp },
				\revFreeze, Pfunc { |event| ~plaits.samples[i].revFreeze },
				\out, Pseq([0,1,2,3], inf),
			)
		}
	)
);
)