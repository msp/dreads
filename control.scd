// Pattern control functions
x.play(~tempoClock)

x.stop;

~tempoClock.tempo = 175/60;

~currentPresetTemplate.postln;

~pushStateToUI.()

//////////////// RANDOM TEST //////////////
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

//////////////// PRESETS //////////////

~savePreset.();

~savePresetAs.();

~loadPreset.("default")

~loadPreset.("/Users/Shared/GitHub/mutable-sc/presets/plaits/250731-2001-54.scd".asSymbol)

~loadPreset.("250725-2240-08")

// jazzy beat
~loadPreset.("250731-2219-54")

~loadPreset.("250731-2001-54")

~loadPreset.("250730-1243-01")

~loadPreset.("250725-2240-04")

~loadPreset.("250725-2240-10")

~loadPreset.(~currentPresetTemplate)

~loadRandomPreset.()

~fadeOutReverb.();

~voiceGroup.freeAll;

~fxGroup.freeAll;

(
~currentPresetTemplate.postln;
~loadAdjacentPreset.(-1);
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
~plaits.samples.postln;
~plaits.samples[0].postln;
~plaits.samples[0].sequences.postln;
)

~listSampleBanks.()

(
~plaits.samples[0].bankName.postln;
~plaits.samples[0].variant.postln;
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
["bank:", ~plaits.samples[0].bankName, "variant:", ~plaits.samples[0].variant].postln;

(
~delayBus.postln;
~delayBus.index.postln;

~reverbBus.postln;
~reverbBus.index.postln;

~cloudsBus.postln;
~cloudsBus.index.postln;
)

~delayFX = Synth(\filterDelay, [\out, 0], addAction: \addToTail);


// ~delayFX.set(\pan, 1.0);

// The spread parameter controls the timing difference:
// - spread = 1.0: Both sides same timing (less ping-pong)
// - spread = 1.3: Right side 30% longer (classic ping-pong)
// - spread = 1.5: Right side 50% longer (wider ping-pong)
//
// After reloading the synthdef, you can control it with:
~delayFX.set(\spread, 1.5);  // Wider ping-pong
~delayFX.set(\spread, 1.0);  // Subtle ping-pong

~delayFX.set(\filterFreq, 2000);

~delayFX.set(\delayTime, 0.25);
~delayFX.set(\delayTime, 0.75);

~delayFX.set(\feedback, 0.75);

~delayFX.set(\mix, 0.7);

// DRONE MODE TEST ////////////

// 1. Enable drone on plaits 1 — should hear continuous tone
~plaits.synths[0].droneMode = 1;
~plaits.synths[0].droneMode = 0;

~startDrone.(0);
~stopDrone.(0);

~plaits.synths[1].droneMode = 1;
~plaits.synths[1].droneMode = 0;

~startDrone.(1);
~stopDrone.(1);

~plaits.synths[2].droneMode = 1;
~plaits.synths[2].droneMode = 0;

~startDrone.(2);
~stopDrone.(2);

// 2. Tweak params on live drone
~droneSynths[0].set(\pitch, 55);
~droneSynths[0].set(\timbre, 0.3);
~droneSynths[0].set(\morph, 0.7);
~droneSynths[0].set(\engine, 8);
~droneSynths[0].set(\harm, 0.2);

// 3. Mute/unmute drone
~droneSynths[0].set(\mul, 0);
~droneSynths[0].set(\mul, ~plaits.synths[0].mul);

// 4. Stop drone, resume sequencer
~plaits.synths[0].droneMode = 0; ~stopDrone.(0);

~plaits.synths[1].droneMode = 0;
~stopDrone.(1);

// 5. Test via OSC (same as UI would send)
NetAddr("127.0.0.1", 57120).sendMsg("/plaits/1/droneMode", 1);
NetAddr("127.0.0.1", 57120).sendMsg("/plaits/1/pitch", 60);
NetAddr("127.0.0.1", 57120).sendMsg("/plaits/1/timbre", 0.2);
NetAddr("127.0.0.1", 57120).sendMsg("/plaits/1/mute", 1);
NetAddr("127.0.0.1", 57120).sendMsg("/plaits/1/mute", 0);
NetAddr("127.0.0.1", 57120).sendMsg("/plaits/1/droneMode", 0);

// 6. Check drone state
~droneSynths.postln;
~plaits.synths.collect(_.droneMode).postln;






