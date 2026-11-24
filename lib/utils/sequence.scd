////////////////////////////////////////////////////////////////////////////////
// Sequence & Param Value Resolution
//
// Turn sequence expressions and UI/LFO inputs into concrete per-note values:
// duration/engine/variant resolution, lazy sequence lookup+caching, bipolar/
// layered modulation, and value combinators. Split out of utils.scd.
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

// Merge user sequences into ~sequenceLibrary, warn on clashes, refresh UI
~mergeUserSequences = { |userPatterns|
	// Remove previous user entries so renames/deletions are clean
	if (~userSequenceKeys.notNil) {
		~userSequenceKeys.do { |key| ~sequenceLibrary.removeAt(key) };
	};
	// Warn on clashes with built-in sequences
	userPatterns.keysValuesDo { |key, val|
		if (~sequenceLibrary[key].notNil) {
			("WARNING: user sequence '" ++ key ++ "' overrides built-in sequence").postln;
		};
	};
	~userSequenceKeys = userPatterns.keys.asArray;
	~sequenceLibrary.putAll(userPatterns);
	["Merged", userPatterns.size, "user sequences"].postln;
	~pushStateToUI.();
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
	var engines = (0..23);
	var expr = seqExpr.asString.replace("e", currentEngine.asString);
	var output = engines.wrapAt(expr.interpret);

	// ['~setEngine:', seqExpr, expr, output].postln;

	output;
};

// Variant selection with expression evaluation (mirrors ~setEngine)
// Uses "v" as placeholder for current variant value
// e.g. Pseq(["v", "v", "v-5", "v+3"], inf)
~setVariant = { |seqExpr, currentVariant=0, numVariants=1|
	var expr = seqExpr.asString.replace("v", currentVariant.asString);
	var output = expr.interpret.asInteger.wrap(0, numVariants - 1);
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

// Resolve sequence value with lazy loading and caching
// If value is a Symbol, look it up in ~sequenceLibrary and cache the stream
// If value is already a stream, use it directly
~getSequenceValue = { |instance, instanceIdx, instanceType, paramKey|
	var value = instance.sequences[paramKey];
	var cacheKey, cached, stream, pattern;

	if(value.isKindOf(Symbol)) {
		// Build cache key: "plaits_0_duration" or "samples_1_rate"
		cacheKey = (instanceType.asString ++ "_" ++ instanceIdx.asString ++ "_" ++ paramKey.asString).asSymbol;
		cached = ~sequenceStreamCache[cacheKey];

		// Check if we have a cached stream and the symbol hasn't changed
		// Use .and {} for short-circuit evaluation (&& doesn't short-circuit in SC!)
		if(cached.notNil.and { cached.symbol == value }) {
			stream = cached.stream;
		} {
			// Symbol changed or first time - resolve from library
			pattern = ~sequenceLibrary[value];
			if(pattern.notNil) {
				stream = pattern.pattern.asStream;
				~sequenceStreamCache[cacheKey] = (symbol: value, stream: stream);
			} {
				("Sequence '" ++ value ++ "' not found in library").warn;
				^0.5;  // Return neutral value
			};
		};
		stream.next;
	} {
		// Inline sequence with source (from dice/randomisation)
		if (value.isKindOf(Dictionary) and: { value[\stream].notNil }) {
			value[\stream].next;
		} {
			// Direct stream - just call .next
			value.next;
		};
	};
};

// Named wrapper for ADDITIVE params (pitch, sample variant — combined via ~add). Calls
// ~getSequenceValue normally (so the stream cache stays consistent), then coerces \hold → 0:
// \hold ("no sequence") stores 0.5, the no-op only for bipolar params; additive params need 0.
// Point future additive params here. See docs/sequence-hold-neutral.md.
~getSequenceValueAdditive = { |instance, instanceIdx, instanceType, paramKey|
	var value = ~getSequenceValue.(instance, instanceIdx, instanceType, paramKey);
	if(instance.sequences[paramKey] == \hold) { 0 } { value };
};

)
