////////////////////////////////////////////////////////////////////////////////
// Pattern Utilities
//
// Pure pattern combinators: ganged shared streams, rest-masking, run-length
// structure, gates, and periodic rest filtering. Split out of utils.scd.
// Loaded from the tail of utils.scd.
////////////////////////////////////////////////////////////////////////////////

(

// Share one live stream across voices locked to the same timing: the first voice to
// fire each beat advances it, the rest mirror — so they read one sequence, not N drifting.
// Wrap any random pattern (Prand, Pwhite, Pbrown…) you want ganged; use it via `.asStream`.
~gang = { |pattern|
	var stream = pattern.asStream, at = -1e9, now = 0;
	Pfunc {
		var b = thisThread.beats;
		if (b != at) { at = b; now = stream.next };
		now;
	};
};

// Rest a duration stream wherever a parallel 0/1 mask yields non-zero (1 = rest, 0 = play).
// Both advance in step, so mask position aligns with the voice's other sequences; the rest
// keeps its duration (silent step) so timing holds. Any pattern works as the mask.
~mask = { |pattern, pMask|
    var s = pattern.asStream, m = pMask.asStream;
    Pfunc { var v = s.next; if (m.next > 0) { Rest(v) } { v } };
};

// Emit runs: values[i] held for lengths[i] steps, cycling forever. Each length may be a scalar
// (fixed run) or a list (the run resizes one lap at a time); values can be anything, arrays
// included (chords). Drives any per-cycle structure — gates, one-shots, chord cadences — that
// must stay locked to one period. e.g. ~runs.([23, 1], [0, 1]) = a hit every 24 steps.
~runs = { |lengths, values|
    Pdup(
        Ppatlace(lengths.collect { |l| Pseq(l.asArray, inf) }, inf),
        Pseq(values, inf)
    )
};

// Repeating rest-mask for ~mask (1=rest 0=play): `rest` silent steps then `play` sounding ones,
// forever. Rest block first, so at load index 0 is silent. play/rest take scalars or lists —
// a list makes that run breathe cycle to cycle. Resize live to change the on/off window.
~gate = { |play = 12, rest = 12| ~runs.([rest, play], [1, 0]) };

~filterWithRests = { |pattern, every=4|
	var counter = 0;
	Pif(
		Pfunc({ (counter = counter + 1) % every == 1 }),
		pattern,
		Rest()
	)
};

)
