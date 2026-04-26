////////////////////////////////////////////////////////////////////////////////
// LFO infrastructure — buses, synths, reporter, VDMX relay
// Requires: ~lfoGroup (Group), \lfo and \lfoReporter SynthDefs
////////////////////////////////////////////////////////////////////////////////

// Clean up previous if re-running
if (~lfo.notNil) {
	if (~lfo.buses.notNil) {
		if (~lfo.buses.synths.notNil) {
			~lfo.buses.synths.do { |b| b.timbre.free; b.morph.free; b.decay.free; b.pitch.free; b.volume.free };
		};
		if (~lfo.buses.samples.notNil) {
			~lfo.buses.samples.do { |b| b.rate.free; b.volume.free };
		};
	};
	if (~lfo.reporter.notNil) { ~lfo.reporter.free };
	if (~lfo.reporterFunc.notNil) { ~lfo.reporterFunc.free };
};

// Initialize ~lfo namespace
~lfo = (buses: (synths: nil, samples: nil));

// Per-instance LFO buses
// Plaits: timbre, morph, decay, pitch, volume × 3 instances
~lfo.buses.synths = Array.fill(3, {
	(timbre: Bus.control(s, 1), morph: Bus.control(s, 1), decay: Bus.control(s, 1),
	 pitch: Bus.control(s, 1), volume: Bus.control(s, 1))
});
// Samples: rate, volume × 3 instances
~lfo.buses.samples = Array.fill(3, {
	(rate: Bus.control(s, 1), volume: Bus.control(s, 1))
});

// Per-instance LFO synths (frequencies overridden per preset)
~lfo.synths = ~lfo.buses.synths.collect { |buses|
	(
		timbre: Synth(\lfo, [\out, buses.timbre, \freq, 0.125], ~lfoGroup),
		morph:  Synth(\lfo, [\out, buses.morph,  \freq, 0.125], ~lfoGroup),
		decay:  Synth(\lfo, [\out, buses.decay,  \freq, 0.125], ~lfoGroup),
		pitch:  Synth(\lfo, [\out, buses.pitch,  \freq, 0.125], ~lfoGroup),
		volume: Synth(\lfo, [\out, buses.volume, \freq, 0.125], ~lfoGroup)
	)
};
~lfo.samples = ~lfo.buses.samples.collect { |buses|
	(
		rate:   Synth(\lfo, [\out, buses.rate,   \freq, 0.125], ~lfoGroup),
		volume: Synth(\lfo, [\out, buses.volume, \freq, 0.125], ~lfoGroup)
	)
};

// Reporter relays all bus values to sclang for VDMX forwarding
~lfo.reporter = Synth(\lfoReporter, [
	\timbreBus0, ~lfo.buses.synths[0].timbre, \morphBus0, ~lfo.buses.synths[0].morph,
	\decayBus0, ~lfo.buses.synths[0].decay, \pitchBus0, ~lfo.buses.synths[0].pitch, \volumeBus0, ~lfo.buses.synths[0].volume,
	\timbreBus1, ~lfo.buses.synths[1].timbre, \morphBus1, ~lfo.buses.synths[1].morph,
	\decayBus1, ~lfo.buses.synths[1].decay, \pitchBus1, ~lfo.buses.synths[1].pitch, \volumeBus1, ~lfo.buses.synths[1].volume,
	\timbreBus2, ~lfo.buses.synths[2].timbre, \morphBus2, ~lfo.buses.synths[2].morph,
	\decayBus2, ~lfo.buses.synths[2].decay, \pitchBus2, ~lfo.buses.synths[2].pitch, \volumeBus2, ~lfo.buses.synths[2].volume,
	\sRateBus0, ~lfo.buses.samples[0].rate, \sVolumeBus0, ~lfo.buses.samples[0].volume,
	\sRateBus1, ~lfo.buses.samples[1].rate, \sVolumeBus1, ~lfo.buses.samples[1].volume,
	\sRateBus2, ~lfo.buses.samples[2].rate, \sVolumeBus2, ~lfo.buses.samples[2].volume,
], ~lfoGroup);

// Relay LFO values from server to VDMX via OSC, scaled by per-instance mod depth
~lfo.reporterFunc = OSCFunc({ |msg|
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
