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
	// Per-instance LFO buses
	// Plaits: timbre, morph, decay, pitch, volume × 3 instances
	~lfoBuses = Array.fill(3, {
		(timbre: Bus.control(s, 1), morph: Bus.control(s, 1), decay: Bus.control(s, 1),
		 pitch: Bus.control(s, 1), volume: Bus.control(s, 1))
	});
	// Samples: rate, volume × 3 instances
	~sampleLfoBuses = Array.fill(3, {
		(rate: Bus.control(s, 1), volume: Bus.control(s, 1))
	});

	// Node order: lfoGroup → voiceGroup → fxGroup
	// (LFOs write buses before voices read them; voices write FX sends before FX read them)
	~lfoGroup   = Group.new(s);
	~voiceGroup = Group.new(~lfoGroup, \addAfter);
	~droneSynths = Array.fill(~plaits.synths.size, { nil });
	~fxGroup = Group.new(~voiceGroup, \addAfter);

	// Per-instance LFO synths (frequencies overridden per preset)
	~lfoSynths = ~lfoBuses.collect { |buses|
		(
			timbre: Synth(\lfo, [\out, buses.timbre, \freq, 0.125], ~lfoGroup),
			morph:  Synth(\lfo, [\out, buses.morph,  \freq, 0.125], ~lfoGroup),
			decay:  Synth(\lfo, [\out, buses.decay,  \freq, 0.125], ~lfoGroup),
			pitch:  Synth(\lfo, [\out, buses.pitch,  \freq, 0.125], ~lfoGroup),
			volume: Synth(\lfo, [\out, buses.volume, \freq, 0.125], ~lfoGroup)
		)
	};
	~sampleLfoSynths = ~sampleLfoBuses.collect { |buses|
		(
			rate:   Synth(\lfo, [\out, buses.rate,   \freq, 0.125], ~lfoGroup),
			volume: Synth(\lfo, [\out, buses.volume, \freq, 0.125], ~lfoGroup)
		)
	};

	// Reporter relays all bus values to sclang for VDMX forwarding
	~lfoReporter = Synth(\lfoReporter, [
		\timbreBus0, ~lfoBuses[0].timbre, \morphBus0, ~lfoBuses[0].morph,
		\decayBus0, ~lfoBuses[0].decay, \pitchBus0, ~lfoBuses[0].pitch, \volumeBus0, ~lfoBuses[0].volume,
		\timbreBus1, ~lfoBuses[1].timbre, \morphBus1, ~lfoBuses[1].morph,
		\decayBus1, ~lfoBuses[1].decay, \pitchBus1, ~lfoBuses[1].pitch, \volumeBus1, ~lfoBuses[1].volume,
		\timbreBus2, ~lfoBuses[2].timbre, \morphBus2, ~lfoBuses[2].morph,
		\decayBus2, ~lfoBuses[2].decay, \pitchBus2, ~lfoBuses[2].pitch, \volumeBus2, ~lfoBuses[2].volume,
		\sRateBus0, ~sampleLfoBuses[0].rate, \sVolumeBus0, ~sampleLfoBuses[0].volume,
		\sRateBus1, ~sampleLfoBuses[1].rate, \sVolumeBus1, ~sampleLfoBuses[1].volume,
		\sRateBus2, ~sampleLfoBuses[2].rate, \sVolumeBus2, ~sampleLfoBuses[2].volume,
	], ~lfoGroup);

	// Relay LFO values from server to VDMX via OSC, scaled by per-instance mod depth
	~lfoReporterFunc.free;
	~lfoReporterFunc = OSCFunc({ |msg|
		var bundle = Array.new(21);
		3.do { |i|
			var inst = ~plaits.synths[i];
			var offset = 3 + (i * 5);
			bundle = bundle.add(["/plaits/" ++ i ++ "/lfo/timbre", msg[offset]     * (inst.timbMod ? 0)]);
			bundle = bundle.add(["/plaits/" ++ i ++ "/lfo/morph",  msg[offset + 1] * (inst.morphMod ? 0)]);
			bundle = bundle.add(["/plaits/" ++ i ++ "/lfo/decay",  msg[offset + 2] * (inst.decayMod ? 0)]);
			bundle = bundle.add(["/plaits/" ++ i ++ "/lfo/pitch",  msg[offset + 3] * (inst.pitchMod ? 0)]);
			bundle = bundle.add(["/plaits/" ++ i ++ "/lfo/volume", msg[offset + 4] * (inst.volumeMod ? 0)]);
		};
		3.do { |i|
			var samp = ~plaits.samples[i];
			var offset = 18 + (i * 2);
			bundle = bundle.add(["/samples/" ++ i ++ "/lfo/rate",   msg[offset]     * (samp.rateMod ? 0)]);
			bundle = bundle.add(["/samples/" ++ i ++ "/lfo/volume", msg[offset + 1] * (samp.volumeMod ? 0)]);
		};
		~vis.().sendBundle(nil, *bundle);
	}, '/lfoValues');

	~cloudsFX = Synth(\globalClouds, [\out, if (~recordingMode) { 16 } { 0 }], ~fxGroup, \addToTail);

	~delayFX = Synth(\globalFilterDelay, [\out, if (~recordingMode) { 12 } { 0 }], ~fxGroup, \addToTail);

	~reverbFX = Synth(\globalReverb, [\out, if (~recordingMode) { 14 } { 0 }], ~fxGroup, \addToTail);

	(Document.current.dir ++ "/lib/sequencer.scd").load;
)