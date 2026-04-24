////////////////////////////////////////////////////////////////////////////////
//
// PLAITS - Mutable Instruments Plaits playground for Supercollider
//
// 1. Execute the SETUP block
// 2. Execute the RUN block
//
// You can then manipulate and re-execute most of the dependent files
// e.g. state.scd or sequences.scd whilst the patterns are playing
// or load the Open Stage Control UI.
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// (1) SETUP
////////////////////////////////////////////////////////////////////////////////
(
~numSpeakers = 2;
// ~numSpeakers = 6;
~recordingMode = true;

// s.options.device = "Loopback";

// Increase buffer size to reduce late messages
s.options.blockSize = 128;
s.options.numBuffers = 2048;
s.options.memSize = 8192 * 16;
s.options.numInputBusChannels = 0;
s.options.numOutputBusChannels = if (~recordingMode) { 18 } { ~numSpeakers };
s.options.recChannels = if (~recordingMode) { 18 } { ~numSpeakers };
if (~recordingMode) { Safety.disable };
s.freeAll;

// Capture base path for reliable preset operations
~basePath = Document.current.dir;
~currentPresetTemplate = (~basePath ++ "/presets/plaits/default.scd").standardizePath;

(Document.current.dir ++ "/lib/globals.scd").load;
(Document.current.dir ++ "/lib/sequence_library.scd").load;
(Document.current.dir ++ "/lib/utils.scd").load;
if (File.exists((Document.current.dir ++ "/lib/user_sequence_library.scd").standardizePath)) {
	(Document.current.dir ++ "/lib/user_sequence_library.scd").load;
};
(Document.current.dir ++ "/lib/presets.scd").load;

s.waitForBoot {
	// allocate this after server boot with known indicies, away from likely synthdef/hardware outputs
	~delayBus = Bus(\audio, 100, 2, s);
	~reverbBus = Bus(\audio, 102, 2, s);
	~cloudsBus = Bus(\audio, 104, 2, s);

	~loadSampleLibrary.();
	(Document.current.dir ++ "/presets/plaits/default.scd").load;
	(Document.current.dir ++ "/lib/synthdefs.scd").load;
	(Document.current.dir ++ "/lib/osc.scd").load;
};
)

////////////////////////////////////////////////////////////////////////////////
// (2) RUN
////////////////////////////////////////////////////////////////////////////////
(
	// Node order: lfoGroup → voiceGroup → fxGroup
	// (LFOs write buses before voices read them; voices write FX sends before FX read them)
	~lfoGroup   = Group.new(s);
	~voiceGroup = Group.new(~lfoGroup, \addAfter);
	~droneSynths = Array.fill(~plaits.synths.size, { nil });
	~fxGroup = Group.new(~voiceGroup, \addAfter);

	(Document.current.dir ++ "/lib/lfo.scd").load;
	(Document.current.dir ++ "/lib/fx.scd").load;
	(Document.current.dir ++ "/lib/sequencer.scd").load;
)