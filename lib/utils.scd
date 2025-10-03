////////////////////////////////////////////////////////////////////////////////
// Utility Functions
////////////////////////////////////////////////////////////////////////////////

(

// Bipolar modulation function for UI parameter mapping
//
// Gradually introduce the sequence values until they are full at uiValue of 0.5.
// After 0.5, gradually pull them towards 1.
// You can pass a sequence of 0.5 values to use without a sequence so the UI knob
// acts as expected e.g. Pseq([0.5], inf).asStream
~modulateBipolar = { |seqValue, uiValue|
	var output = 0.5;

	uiValue = uiValue.clip(0, 1);  // Optional safety clamp

	if (uiValue <= 0.5) {
		output = seqValue * (uiValue * 2)
	} {
		output = seqValue + (((uiValue - 0.5) * 2) * (1 - seqValue))
	};

	// ['modulateBipolar:', seqValue, uiValue.round(0.0001), output.round(0.0001)].postln;

	output;
};

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

)