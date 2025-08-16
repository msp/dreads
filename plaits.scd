////////////////////////////////////////////////////////////////////////////////
//
// PLAITS - Mutable Instruments Plaits playground for Supercollider
//
// 1. Execute the setup block
// 2. Execute the play block
//
// You can then manipulate and re-execute any of the dependend files
// e.g. state.scd or sequences.scd whilst the patterns are playing
// or load the Open Stage Control UI.
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// (1) SETUP
////////////////////////////////////////////////////////////////////////////////
(
// Increase buffer size to reduce late messages
s.options.blockSize = 128;
s.options.numBuffers = 2048;
s.options.memSize = 8192 * 16;
s.freeAll;

// Capture base path for reliable preset operations
~basePath = Document.current.dir;
~currentPresetTemplate = (~basePath ++ "/presets/plaits/default.scd").standardizePath;

(Document.current.dir ++ "/lib/globals.scd").load;
(Document.current.dir ++ "/lib/presets.scd").load;
(Document.current.dir ++ "/presets/plaits/default.scd").load;
(Document.current.dir ++ "/lib/utils.scd").load;

s.waitForBoot {
	(Document.current.dir ++ "/lib/synthdefs.scd").load;
	(Document.current.dir ++ "/lib/osc.scd").load;
};
)

////////////////////////////////////////////////////////////////////////////////
// (2) PLAY
////////////////////////////////////////////////////////////////////////////////
(
// Start global effects
~cloudsFX = Synth(\globalClouds, [\out, 0], addAction: \addToTail);

~delayFX = Synth(\globalFilterDelay, [\out, 0], addAction: \addToTail);

~reverbFX = Synth(\globalReverb, [\out, 0], addAction: \addToTail);

(Document.current.dir ++ "/lib/sequencer.scd").load;
)