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

// Duration calculation with safety bounds
~setDuration = { |seqValue, divSeqValue, uiValue|
	var output = 1;
	uiValue = uiValue.clip(0.8, 1.4);
	divSeqValue = divSeqValue.max(0.001);
	uiValue = uiValue.max(0.001);
	output = seqValue / divSeqValue / uiValue;
	output = output.clip(0.001, 100);

	// ['~setDuration:', uiValue.round(0.0001), output.round(0.0001)].postln;

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
)