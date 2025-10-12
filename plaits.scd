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
// Set to true for multichannel output, false for stereo
~using6_1 = false;

// Increase buffer size to reduce late messages
s.options.blockSize = 128;
s.options.numBuffers = 2048;
s.options.memSize = 8192 * 16;
s.options.numOutputBusChannels = if(~using6_1, 8, 2);
s.freeAll;

// Capture base path for reliable preset operations
~basePath = Document.current.dir;
~currentPresetTemplate = (~basePath ++ "/presets/plaits/default.scd").standardizePath;

(Document.current.dir ++ "/lib/globals.scd").load;
(Document.current.dir ++ "/lib/utils.scd").load;
(Document.current.dir ++ "/lib/presets.scd").load;
(Document.current.dir ++ "/presets/plaits/default.scd").load;

s.waitForBoot {
	(Document.current.dir ++ "/lib/synthdefs.scd").load;
	(Document.current.dir ++ "/lib/osc.scd").load;
};
)

////////////////////////////////////////////////////////////////////////////////
// (2) PLAY
////////////////////////////////////////////////////////////////////////////////
(
~voiceGroup = Group.new(s);
~fxGroup = Group.new(s, \addAfter, ~voiceGroup);

~cloudsFX = Synth(\globalClouds, [\out, 0], ~fxGroup, \addToTail);

~delayFX = Synth(\globalFilterDelay, [\out, 0], ~fxGroup, \addToTail);

~reverbFX = Synth(\globalReverb, [\out, 0], ~fxGroup, \addToTail);

(Document.current.dir ++ "/lib/sequencer.scd").load;
)