////////////////////////////////////////////////////////////////////////////////
// LFO infrastructure — buses, synths, reporter, VDMX relay
// Requires: ~lfoGroup (Group), \lfo and \lfoReporter SynthDefs
////////////////////////////////////////////////////////////////////////////////

// Clean up previous if re-running
if (~lfoBuses.notNil) {
	~lfoBuses.do { |b| b.timbre.free; b.morph.free; b.decay.free; b.pitch.free; b.volume.free };
};
if (~sampleLfoBuses.notNil) {
	~sampleLfoBuses.do { |b| b.rate.free; b.volume.free };
};
if (~lfoReporter.notNil) { ~lfoReporter.free };
~lfoReporterFunc.free;

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
~lfoReporterFunc = OSCFunc({ |msg|
	var bundle = Array.new(21);
	3.do { |i|
		var inst = ~dreads.synths[i];
		var offset = 3 + (i * 5);
		bundle = bundle.add(["/plaits/" ++ i ++ "/lfo/timbre", msg[offset]     * (inst.timbMod ? 0)]);
		bundle = bundle.add(["/plaits/" ++ i ++ "/lfo/morph",  msg[offset + 1] * (inst.morphMod ? 0)]);
		bundle = bundle.add(["/plaits/" ++ i ++ "/lfo/decay",  msg[offset + 2] * (inst.decayMod ? 0)]);
		bundle = bundle.add(["/plaits/" ++ i ++ "/lfo/pitch",  msg[offset + 3] * (inst.pitchMod ? 0)]);
		bundle = bundle.add(["/plaits/" ++ i ++ "/lfo/volume", msg[offset + 4] * (inst.volumeMod ? 0)]);
	};
	3.do { |i|
		var samp = ~dreads.samples[i];
		var offset = 18 + (i * 2);
		bundle = bundle.add(["/samples/" ++ i ++ "/lfo/rate",   msg[offset]     * (samp.rateMod ? 0)]);
		bundle = bundle.add(["/samples/" ++ i ++ "/lfo/volume", msg[offset + 1] * (samp.volumeMod ? 0)]);
	};
	~vis.().sendBundle(nil, *bundle);
}, '/lfoValues');
