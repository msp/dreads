// Pattern control functions
x.play(~tempoClock)

x.stop;

~currentPresetTemplate.postln;

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

~loadRandomPreset.()

~fadeOutReverb.();

~voiceGroup.freeAll;

~fxGroup.freeAll;




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





