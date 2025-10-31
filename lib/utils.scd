////////////////////////////////////////////////////////////////////////////////
// Utility Functions
////////////////////////////////////////////////////////////////////////////////

(

// Bipolar modulation function for UI parameter mapping
//
// Gradually introduce the sequence values until they are full at uiValue = max/2.
// After max/2, gradually pull them towards max.
//
// For normalized 0-1 parameters (default max=1.0):
//   Neutral sequence = 0.5, you can pass Pseq([0.5], inf).asStream for "UI only mode"
// For time parameters (e.g., max=60.0):
//   Neutral sequence = 30.0, you can pass Pseq([30.0], inf).asStream for "UI only mode"
~modulateBipolar = { |seqValue, uiValue, max=1.0|
	var midpoint = max / 2;
	var output;

	if (uiValue <= midpoint) {
		// Gradually introduce sequence: at 0 output=0, at midpoint output=seqValue
		output = seqValue * (uiValue / midpoint);
	} {
		// Pull from seqValue towards max
		var blend = (uiValue - midpoint) / midpoint;  // 0 at midpoint, 1 at max
		output = seqValue + (blend * (max - seqValue));
	};

	// ['modulateBipolar:', seqValue, uiValue.round(0.0001), max, output.round(0.0001)].postln;

	output;
};

// TODO: Update to support non-normalized parameters when LFOs are added to samples
// Add max parameter and pass through: ~modulateLayered = { |seqValue, lfoValue, uiValue, lfoAmount=0.3, max=1.0|
~modulateLayered = { |seqValue, lfoValue, uiValue, lfoAmount=0.3|
	// First combine sequence + LFO
	var combinedMod = seqValue + ((lfoValue - 0.5) * lfoAmount);
	combinedMod = combinedMod.clip(0, 1);

	// Then apply existing bipolar logic with UI
	~modulateBipolar.(combinedMod, uiValue);
};

// Duration calculation with safety bounds
~setDuration = { |seqValue, divSeqValue|
	var output = 1;
	divSeqValue = divSeqValue.max(0.001);
	output = seqValue / divSeqValue;
	output = output.clip(0.001, 500);

	// ['~setDuration:', output.round(0.0001)].postln;

	output;
};

// Engine selection with expression evaluation
~setEngine = { |seqExpr, currentEngine=0|
	// Replace "e" placeholder with current engine value in the expression
	var engines = (0..15);
	var expr = seqExpr.asString.replace("e", currentEngine.asString);
	var output = engines.wrapAt(expr.interpret);

	// ['~setEngine:', seqExpr, expr, output].postln;

	output;
};

// Generic multiply: sequence value multiplies base value
~multiply = { |seqValue, baseValue|
	baseValue * seqValue;
};

// Generic add: sequence value adds to base value
~add = { |seqValue, baseValue|
	baseValue + seqValue;
};


// Fade out by reducing reverb time to kill MiVerb internal feedback
~fadeOutReverb = { |fadeTime = 2|
	// plaits reverbs
	s.defaultGroup.set(\revTime, 0.9);
	// global reverb
	s.defaultGroup.set(\time, 0.9);
	("Stopping reverb feedback..").postln;
};

~activatePhones = { | value = false|
	[("~activatePhones"), value].postln;
	~sendToPhones = value;
};

~sinePattern = { |dur=8.0, lo=0.05, hi=0.5, repeats=inf|
	Pn(
		Pif(Ptime(inf) <= dur, Env.sine(dur).range(lo, hi)),
		repeats
	)
};

// Smooth 0..1 sine mapped to [lo, hi], driven by beats
~sineAtBeat = { |beats, cycleBeats = 16.0, lo = 0.05, hi = 0.5|
	var phase = (beats.asFloat / cycleBeats).frac;      // 0..1
	var u     = (phase * 2pi).cos.neg * 0.5 + 0.5;      // 0.5 - 0.5*cos(...), in 0..1
	lo + u * (hi - lo)
};

~sineAtBeatWithPhase = { |beats, cycleBeats = 16.0, lo = 0.05, hi = 0.5, phaseOffset = 0|
	var phase = ((beats.asFloat / cycleBeats) + phaseOffset).frac;
	var u = (phase * 2pi).cos.neg * 0.5 + 0.5;
	u.linlin(0, 1, lo, hi);
};

~filterWithRests = { |pattern, every=4|
	var counter = 0;
	Pif(
		Pfunc({ (counter = counter + 1) % every == 1 }),
		pattern,
		Rest()
	)
};

// Load a single sample buffer for a given instance index
~loadSampleBuffer = { |instanceIndex, filepath|
	var bufferKey = ("sample_" ++ instanceIndex).asSymbol;

	// Free old buffer if exists
	if (~sampleBuffers[bufferKey].notNil) {
		~sampleBuffers[bufferKey].free;
	};

	// Load new buffer
	("Loading sample " ++ instanceIndex ++ ": " ++ filepath).postln;
	~sampleBuffers[bufferKey] = Buffer.read(s, filepath, action: {
		("Sample loaded: " ++ filepath).postln;
	});

	// Update instance path in preset
	~plaits.samples[instanceIndex].samplePath = filepath;
};

// Load all sample buffers from current preset
~loadAllSampleBuffers = {
	~plaits.samples.do { |sampleInstance, idx|
		var samplePath = sampleInstance.samplePath;
		if (samplePath.notNil) {
			~loadSampleBuffer.(idx, samplePath);
		};
	};
};

// Custom event type for one-shot sample playback
// Never sends gate=0, synth is expected to free itself via doneAction
Event.addEventType(\oneShotSample, {
	var server = ~server ?? { Server.default };

	["oneShotSample event at", thisThread.beats, "dur =", ~dur, "decay =", ~decay].postln;

	// Build the synth - based on standard 'note' event type
	// but without storing the node for later gate-off
	if (~bufnum.notNil) {
		Synth(
			~instrument,
			[
				\out, ~out,
				\bufnum, ~bufnum,
				\numChannels, ~numChannels,
				\mul, ~mul,
				\rate, ~rate,
				\startPos, ~startPos,
				\panDur, ~panDur,
				\atk, ~atk,
				\decay, ~decay,
				\gate, 1,
				\volume, ~volume,
				\cloudsSend, ~cloudsSend,
				\delaySend, ~delaySend,
				\reverbSend, ~reverbSend
			],
			~group ?? { server.defaultGroup },
			\addToHead
		);
	};

	// Return the delta time for the pattern to wait
	["oneShotSample returning delta:", ~dur].postln;
	~dur;
});

)