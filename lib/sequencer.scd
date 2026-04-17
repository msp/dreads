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



// Clear stream cache so all sequence patterns start at position 0 on reload
~sequenceStreamCache = Dictionary.new;
x = Pdef(\plaitsSequence,
	Ppar(
		~plaits.synths.collect { |instance, i|
			Pseq([
			Pfuncn({ Rest(~plaits.synths[i].phaseOffset ? 0) }, 1),
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
				};

				// Forward sequencer modulation to drone synth.
				// SC's \type \set event only sends default keys (freq, amp, pan) so we
				// forward \plaitsDrone control names explicitly via .set here instead.
				if (~plaits.synths[i].droneMode == 1) {
					if (~droneSynths[i].notNil) {
						~droneSynths[i].set(
							\pitch, ev[\pitch], \engine, ev[\engine],
							\harm, ev[\harm], \timbre, ev[\timbre],
							\morph, ev[\morph], \decay, ev[\decay],
							\fmMod, ev[\fmMod], \lpgColour, ev[\lpgColour],
							\mul, ev[\mul], \volume, ev[\volume],
							\revDrywet, ev[\revDrywet], \revTime, ev[\revTime],
							\cloudsSend, ev[\cloudsSend], \delaySend, ev[\delaySend],
							\reverbSend, ev[\reverbSend],
							\distDrive, ev[\distDrive], \distAmount, ev[\distAmount]
						);
					};
				};

				ev
			},

			Pbind(
				\type, Pfunc { if (~plaits.synths[i].droneMode == 1) { \rest } { \note } },
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

					~add.(~getSequenceValue.(~plaits.synths[i], i, \plaits, \pitch), ~plaits.synths[i].pitch);
				},
				\dur, Pfunc { |event|

					// var v = ~sineAtBeat.(~tempoClock.beats, 64, 0.15, 0.5);
					// ~plaits.synths[i].dur = ~setDuration.(v, ~plaits.synths[i].sequences.div.next);
					// ~plaits.synths[i].dur = v;
					// ~plaits.synths[i].dur;

					var baseDur = ~setDuration.(
						~getSequenceValue.(~plaits.synths[i], i, \plaits, \duration),
						~getSequenceValue.(~plaits.synths[i], i, \plaits, \div)
					);
					var speed = ~plaits.synths[i].speed.clip(0.01, 100);
					var nudge = ~plaits.synths[i].nudgeOffset ? 0;
					var finalDur;
					~plaits.synths[i].nudgeOffset = 0;
					finalDur = (baseDur / speed + nudge).max(0.001);
					~plaits.synths[i].dur = finalDur;
						// ["plaits", i, "event at", thisThread.beats, "dur =", finalDur].postln;
					finalDur;
				},
				\decay, Pfunc { |event|
					// ~modulateBipolar.(~plaits.synths[i].sequences.decay.next, ~plaits.synths[i].decay)
					~modulateLayered.(
						~getSequenceValue.(~plaits.synths[i], i, \plaits, \decay),
						~decayLFO.next,
						~plaits.synths[i].decay,
						0.3 // LFO Amount
					);
				},
				\harm, Pfunc { |event|
					~modulateBipolar.(~getSequenceValue.(~plaits.synths[i], i, \plaits, \harm), ~plaits.synths[i].harm);
				},
				\timbre, Pfunc { |event|
					// ~modulateBipolar.(~plaits.synths[i].sequences.timbre.next, ~plaits.synths[i].timbre)
					// ~modulateBipolar.(~timbreLFO.next, ~plaits.synths[i].timbre)
					~modulateLayered.(
						~getSequenceValue.(~plaits.synths[i], i, \plaits, \timbre),
						~timbreLFO.next,
						~plaits.synths[i].timbre,
						~plaits.synths[i].timbMod
					);
				},
				\morph, Pfunc { |event|
					// ~modulateBipolar.(~plaits.synths[i].sequences.morph.next, ~plaits.synths[i].morph)
					~modulateLayered.(
						~getSequenceValue.(~plaits.synths[i], i, \plaits, \morph),
						~morphLFO.next,
						~plaits.synths[i].morph,
						~plaits.synths[i].morphMod
					);
				},
				\fmMod, Pfunc { |event|
					~modulateBipolar.(~getSequenceValue.(~plaits.synths[i], i, \plaits, \fmMod), ~plaits.synths[i].fmMod);
				},
				\lpgColour, Pfunc { |event|
					~modulateBipolar.(~getSequenceValue.(~plaits.synths[i], i, \plaits, \lpgColour), ~plaits.synths[i].lpgColour);
				},
				\legato, Pfunc { |event| ~plaits.synths[i].legato },
				\engine, Pfunc { |event|
					~setEngine.(~plaits.synths[i].sequences.engine.next, ~plaits.synths[i].engine);
				},
				\mul, Pfunc { |event|
					if (~plaits.synths[i].mute == 1) { 0 } {
						~modulateBipolar.(~getSequenceValue.(~plaits.synths[i], i, \plaits, \mul), ~plaits.synths[i].mul);
					};
				},
				\revDrywet, Pfunc { |event|
					~modulateBipolar.(~getSequenceValue.(~plaits.synths[i], i, \plaits, \revDrywet), ~plaits.synths[i].revDrywet);
				},
				\revTime, Pfunc { |event|
					var out = ~modulateBipolar.(~getSequenceValue.(~plaits.synths[i], i, \plaits, \revTime), ~plaits.synths[i].revTime);
					// ["revTime", out].postln;

					out
				},
				\revDamp, Pfunc { |event| ~plaits.synths[i].revDamp },
				\revHp, Pfunc { |event| ~plaits.synths[i].revHp },
				\revFreeze, Pfunc { |event| ~plaits.synths[i].revFreeze },
				\delaySend, Pfunc { |event|
					~modulateBipolar.(~getSequenceValue.(~plaits.synths[i], i, \plaits, \delaySend), ~plaits.synths[i].delaySend);
				},
				\reverbSend, Pfunc { |event|
					~modulateBipolar.(~getSequenceValue.(~plaits.synths[i], i, \plaits, \reverbSend), ~plaits.synths[i].reverbSend);
				},
				\cloudsSend, Pfunc { |event|
					~modulateBipolar.(~getSequenceValue.(~plaits.synths[i], i, \plaits, \cloudsSend), ~plaits.synths[i].cloudsSend);
				},
				\distDrive, Pfunc { |event|
					~modulateBipolar.(~getSequenceValue.(~plaits.synths[i], i, \plaits, \distDrive), ~plaits.synths[i].distDrive);
				},
				\distAmount, Pfunc { |event|
					~modulateBipolar.(~getSequenceValue.(~plaits.synths[i], i, \plaits, \distAmount), ~plaits.synths[i].distAmount);
				},
				\stereoMode, Pfunc { |event| ~plaits.synths[i].stereoMode },
				\volume, Pfunc { |event| ~modulateBipolar.(~getSequenceValue.(~plaits.synths[i], i, \plaits, \volume), ~plaits.synths[i].volume); },
				\out, Pfunc { ~voiceOutBus.(\plaits, i) },
			))
			])
		} ++
		// Sample instances (use lookups for live coding)
		~plaits.samples.collect { |instance, i|
			Pseq([
			Pfuncn({ Rest(~plaits.samples[i].phaseOffset ? 0) }, 1),
			Pbind(
				\type, \oneShotSample,  // Custom event type: never sends gate=0
				\instrument, \panningSamplePlayer,
				\group, ~voiceGroup,
				// Variant selection: two modes, both relative to base scalar, wrapped to bank size
			// Numeric: additive offset from base — Pseq([0, 2, -3], inf) with base 6 → 6, 8, 3
			// String:  "v" expression syntax  — Pseq(["v", "v+2", "v-3"], inf) with base 6 → 6, 8, 3
				\sampleVariant, Pfunc {
					var variantSeq = ~getSequenceValue.(~plaits.samples[i], i, \samples, \variant);
					var variantBase = ~plaits.samples[i].variant;
					var bankName = ~plaits.samples[i].bankName;
					var numVariants = (~sampleLibrary.banks[bankName] ? []).size.max(1);
					if (variantSeq.isKindOf(String) || variantSeq.isKindOf(Symbol)) {
						~setVariant.(variantSeq, variantBase, numVariants);
					} {
						~add.(variantSeq, variantBase).asInteger.wrap(0, numVariants - 1);
					};
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
					var durSeq = ~getSequenceValue.(~plaits.samples[i], i, \samples, \duration);
					var divSeq = ~getSequenceValue.(~plaits.samples[i], i, \samples, \div);
					var baseDur = ~setDuration.(durSeq, divSeq);
					var speed = ~plaits.samples[i].speed.clip(0.01, 100);
					var nudge = ~plaits.samples[i].nudgeOffset ? 0;
					var finalDur;
					~plaits.samples[i].nudgeOffset = 0;
					finalDur = (baseDur / speed + nudge).max(0.001);
					~plaits.samples[i].dur = finalDur;
					// ["sample", i, "event at", thisThread.beats, "dur =", finalDur].postln;
					finalDur;
				},
				\legato, Pfunc { |event| ~plaits.samples[i].legato },
				\mul, Pfunc {
				var baseMul, result;
				if (~plaits.samples[i].mute == 1) { 0 } {
					baseMul = ~plaits.samples[i].mul;
					result = ~modulateBipolar.(~getSequenceValue.(~plaits.samples[i], i, \samples, \mul), baseMul);
					result;
				};
			},
				\rate, Pfunc {
					var rateSeq = ~getSequenceValue.(~plaits.samples[i], i, \samples, \rate);
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
						~getSequenceValue.(~plaits.samples[i], i, \samples, \startPos),
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
						~getSequenceValue.(~plaits.samples[i], i, \samples, \atk),
						~plaits.samples[i].atk
					);
					normalized * (duration / 2);
				},
				\decay, Pfunc { |event|
					var duration = event[\sampleDuration];
					// Normalized 0-1, scale to duration*2 (allow longer decay than sample)
					var normalized = ~modulateBipolar.(
						~getSequenceValue.(~plaits.samples[i], i, \samples, \decay),
						~plaits.samples[i].decay
					);
					normalized * (duration * 2);
				},
				\panDur, Pfunc { |event|
					var duration = event[\sampleDuration];
					// Normalized 0-1, scale to duration*2
					var normalized = ~modulateBipolar.(
						~getSequenceValue.(~plaits.samples[i], i, \samples, \panDur),
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
				\cloudsSend, Pfunc { ~modulateBipolar.(~getSequenceValue.(~plaits.samples[i], i, \samples, \cloudsSend), ~plaits.samples[i].cloudsSend) },
				\delaySend, Pfunc { ~modulateBipolar.(~getSequenceValue.(~plaits.samples[i], i, \samples, \delaySend), ~plaits.samples[i].delaySend) },
				\reverbSend, Pfunc { ~modulateBipolar.(~getSequenceValue.(~plaits.samples[i], i, \samples, \reverbSend), ~plaits.samples[i].reverbSend) },
				\distDrive, Pfunc { |event| ~plaits.samples[i].distDrive },
				\distAmount, Pfunc { |event|
					~modulateBipolar.(~getSequenceValue.(~plaits.samples[i], i, \samples, \distAmount), ~plaits.samples[i].distAmount);
				},
				\revDrywet, Pfunc { |event|
					~modulateBipolar.(~getSequenceValue.(~plaits.samples[i], i, \samples, \revDrywet), ~plaits.samples[i].revDrywet);
				},
				\revTime, Pfunc { |event|
					~modulateBipolar.(~getSequenceValue.(~plaits.samples[i], i, \samples, \revTime), ~plaits.samples[i].revTime);
				},
				\revDamp, Pfunc { |event|
					~modulateBipolar.(~getSequenceValue.(~plaits.samples[i], i, \samples, \revDamp), ~plaits.samples[i].revDamp);
				},
				\revHp, Pfunc { |event|
					~modulateBipolar.(~getSequenceValue.(~plaits.samples[i], i, \samples, \revHp), ~plaits.samples[i].revHp);
				},
				\revFreeze, Pfunc { |event| ~plaits.samples[i].revFreeze },
				\out, Pfunc { ~voiceOutBus.(\samples, i) },
			)
			])
		}
	)
);
Pdef(\plaitsSequence).quant = 1;
)