// Pattern control functions
x.play(~tempoClock)

x.stop;

~tempoClock.tempo = 175/60;

~currentPatchTemplate.postln;

~pushStateToUI.()

(1-5)
(1-5).mod(16)

~dreads.synths[0].seqCache;


//////////////// DELAYS TEST ///////////////////////////////////
~tempoDelay.(\eighth);                       // -> seconds for 1/8 at current tempo
~tempoDelayLR.(\eighth, \dottedEighth);      // -> [time, spread]
~setTempoDelay.(\quarter, \dottedEighth);  // applies to live synth + UI
~setTempoDelay.(\quarter, \sixteenth);  // applies to live synth + UI


//////////////// LFO TEST //////////////////////////////////////

// Freq
~dreads.synths[0][\timbMod]
~dreads.synths[0].lfo[\morph].name;


~lfoTweak.(\plaits, 0, \morph, \freq, 0.5);
~lfoTweak.(\plaits, 0, \morph, \shape, 2);


~lfoTweak.(\plaits, 0, \morph, (freq: 2, shape: \tri, width: 0.3, mod: 0.1));
~lfoTweak.(\plaits, 0, \pitch, (freq: 3, shape: \sine, mod: 0.8));
~lfoTweak.(\plaits, 0, \timbre, (freq: 5, shape: \sine, mod: 0.1));

~lfo.sources[\lfo2][\freq];



~lfoTweak.(\plaits, 2, \timbre, \freq, 1.5);
~lfoTweak.(\sample, 0, \rate, \freq, 0.5);

// Shape (0=sine, 1=tri, 2=saw, 3=square, 4=noise, 5=gaussian)
~lfoTweak.(\plaits, 1, \morph, \shape, 3);

// Width (gaussian only, 0.01–1.0)
~lfoTweak.(\plaits, 0, \decay, \shape, 5);
~lfoTweak.(\plaits, 0, \decay, \width, 0.1);

// Relative rates from a base
~base = 0.5;
~lfoTweak.(\plaits, 0, \timbre, \freq, ~base);
~lfoTweak.(\plaits, 0, \morph, \freq, ~base * 1.08);
~lfoTweak.(\plaits, 0, \pitch, \freq, ~base / 3);

n = NetAddr("127.0.0.1", 57120);
n.sendMsg("/plaits/1/lfo/timbre/freq", 1/8);
n.sendMsg("/plaits/1/lfo/timbre/base", 0);
n.sendMsg("/dreads/lfoBase", 0.3);


//////////////// RANDOM TEST ///////////////////////////////////
// Scalar randomization:
~randomize.(2)           // plaits 1, tonal + mod

~randomize.(3, \tonal)   // just sound character (engine, harm, timbre, morph, decay, pitch...)

~randomize.(3, \color) //randomizes harm, timbre, morph, decay, lpgColour, and fmMod — keeps engine and pitch untouched.

~randomize.(3, \full)    // everything including effects sends
~randomizeAll.()         // all unmuted modules
~randomizeAll.(\full)    // all unmuted, with effects

// Random sequence generation:
~randomSeq.(\myRhythm3, \user, 8)   // 8-step rhythm with rests
~randomSeq.(\myMelody, \pitch, 6)    // 6 intervals from common pool
~randomSeq.(\myShape, \shape, 12)    // 12 random 0-1 values

~diceSeq.(1, \duration)

~diceSeq.(1, \decay)

~diceSeq.(1, \delaySend)

//////////////// PATCHES //////////////

~savePatch.();

~savePatchAs.();

~loadPatch.("default")

~loadPatch.("/Users/Shared/GitHub/mutable-sc/patches/dreads/250731-2001-54.scd".asSymbol)

~loadPatch.("250725-2240-08")

// jazzy beat
~loadPatch.("250731-2219-54")

~loadPatch.("250731-2001-54")

~loadPatch.("250730-1243-01")

~loadPatch.("250725-2240-04")

~loadPatch.("250725-2240-10")

~loadPatch.(~currentPatchTemplate)

~loadRandomPatch.()

~fadeOutReverb.();

~voiceGroup.freeAll;

~fxGroup.freeAll;

(
~currentPatchTemplate.postln;
~loadAdjacentPatch.(-1);
)

Safety.disable

Safety.enable

s.sampleRate

// Nudge plaits 1 forward (delay next event by 0.25 beats)
NetAddr("127.0.0.1", 57120).sendMsg("/plaits/1/nudgeForward", 1)

NetAddr("127.0.0.1", 57120).sendMsg("/plaits/1/nudgeBack", -1)

NetAddr("127.0.0.1", 57120).sendMsg("/plaits/2/nudge", 1)

// SAMPLER TEST ////////////

// Check sample library loaded
~sampleLibrary.banks.postln;

(
~dreads.samples.postln;
~dreads.samples[0].postln;
~dreads.samples[0].sequences.postln;
)

~listSampleBanks.()

(
~dreads.samples[0].bankName.postln;
~dreads.samples[0].variant.postln;
)

(
(Document.current.dir ++ "/lib/globals.scd").load;
~defaultSampleScalars.postln;  // Check if bankName is now there
)


// Test next variant on sample 1
~cycleSampleVariant.(0, 1);

// Test prev variant on sample 1
~cycleSampleVariant.(0, -1);

// Check current state
["bank:", ~dreads.samples[0].bankName, "variant:", ~dreads.samples[0].variant].postln;

(
~delayBus.postln;
~delayBus.index.postln;

~reverbBus.postln;
~reverbBus.index.postln;

~cloudsBus.postln;
~cloudsBus.index.postln;
)

~fx.delay = Synth(\filterDelay, [\out, 0], addAction: \addToTail);


// ~fx.delay.set(\pan, 1.0);

// The spread parameter controls the timing difference:
// - spread = 1.0: Both sides same timing (less ping-pong)
// - spread = 1.3: Right side 30% longer (classic ping-pong)
// - spread = 1.5: Right side 50% longer (wider ping-pong)
//
// After reloading the synthdef, you can control it with:
~fx.delay.set(\spread, 1.5);  // Wider ping-pong
~fx.delay.set(\spread, 1.0);  // Subtle ping-pong

~fx.delay.set(\filterFreq, 2000);

~fx.delay.set(\delayTime, 0.25);
~fx.delay.set(\delayTime, 0.75);

~fx.delay.set(\feedback, 0.75);

~fx.delay.set(\mix, 0.7);

//////////////// FM BROWSER //////////////
~fm.(1, 2)
~fm.(2, 4)
~fm.(3, 5)

~fmFwd.(1)
~fmBack.(1)

~fmBank.(1, 2)
~fmList.(1)
~fmList.(1, 2)

// DRONE MODE TEST ////////////

// 1. Enable drone on plaits 1 — should hear continuous tone
~dreads.synths[0].droneMode = 1;
~dreads.synths[0].droneMode = 0;

~startDrone.(0);
~stopDrone.(0);

~dreads.synths[1].droneMode = 1;
~dreads.synths[1].droneMode = 0;

~startDrone.(1);
~stopDrone.(1);

~dreads.synths[2].droneMode = 1;
~dreads.synths[2].droneMode = 0;

~startDrone.(2);
~stopDrone.(2);

// 2. Tweak params on live drone
~drones[0].set(\pitch, 55);
~drones[0].set(\timbre, 0.3);
~drones[0].set(\morph, 0.7);
~drones[0].set(\engine, 8);
~drones[0].set(\harm, 0.2);

// 3. Mute/unmute drone
~drones[0].set(\mul, 0);
~drones[0].set(\mul, ~dreads.synths[0].mul);

// 4. Stop drone, resume sequencer
~dreads.synths[0].droneMode = 0; ~stopDrone.(0);

~dreads.synths[1].droneMode = 0;
~stopDrone.(1);

// 5. Test via OSC (same as UI would send)
NetAddr("127.0.0.1", 57120).sendMsg("/plaits/1/droneMode", 1);
NetAddr("127.0.0.1", 57120).sendMsg("/plaits/1/pitch", 60);
NetAddr("127.0.0.1", 57120).sendMsg("/plaits/1/timbre", 0.2);
NetAddr("127.0.0.1", 57120).sendMsg("/plaits/1/mute", 1);
NetAddr("127.0.0.1", 57120).sendMsg("/plaits/1/mute", 0);
NetAddr("127.0.0.1", 57120).sendMsg("/plaits/1/droneMode", 0);

// 6. Check drone state
~drones.postln;
~dreads.synths.collect(_.droneMode).postln;


~dreads.synths[2].pitchMod = 0;






