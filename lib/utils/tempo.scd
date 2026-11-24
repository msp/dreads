////////////////////////////////////////////////////////////////////////////////
// Tempo-locked helpers — musical divisions, tempo-locked delay times
////////////////////////////////////////////////////////////////////////////////

// Musical division → beat multiplier (1.0 = quarter note)
~musicalDivisions = (
	whole: 4, half: 2, quarter: 1, eighth: 0.5, sixteenth: 0.25, thirtysecond: 0.125,
	dottedHalf: 3, dottedQuarter: 1.5, dottedEighth: 0.75, dottedSixteenth: 0.375,
	halfTriplet: 4/3, quarterTriplet: 2/3, eighthTriplet: 1/3, sixteenthTriplet: 1/6
);

// Resolve a symbol or numeric multiplier to seconds at the current tempo
~tempoDelay = { |division = \sixteenth, clock|
	var d = if (division.isKindOf(Symbol)) { ~musicalDivisions[division] } { division };
	(clock ? TempoClock.default).beatDur * d;
};

// Returns [time, spread] where spread = rightDiv / leftDiv
// so the L channel lands on leftDiv and R lands on rightDiv
~tempoDelayLR = { |leftDiv = \eighth, rightDiv = \dottedEighth, clock|
	var bd = (clock ? TempoClock.default).beatDur;
	var l = if (leftDiv.isKindOf(Symbol))  { ~musicalDivisions[leftDiv]  } { leftDiv  };
	var r = if (rightDiv.isKindOf(Symbol)) { ~musicalDivisions[rightDiv] } { rightDiv };
	[bd * l, r / l];
};

// Apply tempo-locked time + spread to the live delay FX synth and persist
// Examples:
//   ~setTempoDelay.(\eighth, \dottedEighth);   // classic ping-pong
//   ~setTempoDelay.(\quarter, \quarterTriplet); // polyrhythmic
~setTempoDelay = { |leftDiv = \eighth, rightDiv = \dottedEighth|
	var ts = ~tempoDelayLR.(leftDiv, rightDiv);
	var time = ts[0], spread = ts[1];
	if (~fx.notNil and: { ~fx.delay.notNil }) {
		~fx.delay.set(\time, time, \spread, spread);
	};
	if (~dreads.notNil and: { ~dreads.fx.notNil and: { ~dreads.fx.delay.notNil } }) {
		~dreads.fx.delay.time = time;
		~dreads.fx.delay.spread = spread;
	};
	if (~pushStateToUI.notNil) { ~pushStateToUI.() };
	[time, spread];
};
