////////////////////////////////////////////////////////////////////////////////
// Global FX synths — clouds, delay, reverb
// Requires: ~fxGroup (Group), ~recordingMode, FX SynthDefs
////////////////////////////////////////////////////////////////////////////////

~fx = ();

~fx.clouds = Synth(\globalClouds, [\out, if (~recordingMode) { 16 } { 0 }], ~fxGroup, \addToTail);

~fx.delay = Synth(\globalFilterDelay, [\out, if (~recordingMode) { 12 } { 0 }], ~fxGroup, \addToTail);

~fx.reverb = Synth(\globalReverb, [\out, if (~recordingMode) { 14 } { 0 }], ~fxGroup, \addToTail);
