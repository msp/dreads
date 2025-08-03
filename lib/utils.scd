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
~setEngine = { |seqExpr, instanceIndex=0|
	// Replace "e" placeholder with actual current engine value in the expression
	var engines = (0..15);
	var expr = seqExpr.asString.replace("e", ~plaits[instanceIndex].engine.asString);
	var output = engines.wrapAt(expr.interpret);

	// ['~setEngine:', seqExpr, expr, output].postln;

	output;
};


// Fade out by reducing reverb time to kill MiVerb internal feedback
~fadeOutReverb = { |fadeTime = 2|
	// plaits reverbs
	s.defaultGroup.set(\rev_time, 0.9);
	// global reverb
	s.defaultGroup.set(\time, 0.9);
	("Stopping reverb feedback..").postln;
};

)