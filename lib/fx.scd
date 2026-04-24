////////////////////////////////////////////////////////////////////////////////
// Global FX synths — clouds, delay, reverb
// Requires: ~fxGroup (Group), ~recordingMode, FX SynthDefs
////////////////////////////////////////////////////////////////////////////////

~cloudsFX = Synth(\globalClouds, [\out, if (~recordingMode) { 16 } { 0 }], ~fxGroup, \addToTail);

~delayFX = Synth(\globalFilterDelay, [\out, if (~recordingMode) { 12 } { 0 }], ~fxGroup, \addToTail);

~reverbFX = Synth(\globalReverb, [\out, if (~recordingMode) { 14 } { 0 }], ~fxGroup, \addToTail);
