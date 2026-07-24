//////////////////////////////////////////////////////////////////////////////
// Sequence Pattern Library
// Tagged patterns for use in sequencer via ~sequenceLibrary[name].pattern
// Tags: \rhythm (beat fractions + Rests), \shape (0-1 continuous),
//       \accent (0-1 centered ~0.5), \timing (multiplier ratios), \all
//////////////////////////////////////////////////////////////////////////////

// ~euclidean.(3, 8)

(
// Euclidean rhythm generator (Bjorklund): k hits distributed evenly across n steps
// Uses group-merging algorithm: start with k [1]s and (n-k) [0]s,
// repeatedly pair front groups with back groups until one type remains.
~euclidean = { |k, n|
	var a, b, newA, sz;
	if (k >= n) { 1 ! n } {
		if (k <= 0) { 0 ! n } {
			a = Array.fill(k, { [1] });
			b = Array.fill(n - k, { [0] });
			while { b.size > 1 } {
				sz = a.size.min(b.size);
				newA = Array.fill(sz, { |i| a[i] ++ b[i] });
				if (a.size > sz) {
					b = a.copyRange(sz, a.size - 1);
				} {
					if (b.size > sz) {
						b = b.copyRange(sz, b.size - 1);
					} {
						b = [];
					};
				};
				a = newA;
			};
			(a ++ b).flat;
		};
	};
};

// Euclidean rhythm as Pseq with Rests
~euclideanSeq = { |k, n|
	var step = 4/n;
	Pseq(~euclidean.(k, n).collect { |v| if(v == 1) { step } { Rest(step) } }, inf);
};

~sequenceLibrary = (

	// ---- constants (always visible) ----
	hold: (pattern: Pseq([0.5], inf), tag: \all),  // neutral midpoint for modulation params
	unit: (pattern: Pseq([1.0], inf), tag: \all),  // 1 beat = 1 quarter note

	// ---- rhythm: beat fractions with Rests, for duration ----

	// Euclidean rhythms
	eucl_3_8:  (pattern: ~euclideanSeq.(3, 8),  tag: \rhythm),
	eucl_5_8:  (pattern: ~euclideanSeq.(5, 8),  tag: \rhythm),
	eucl_3_4:  (pattern: ~euclideanSeq.(3, 4),  tag: \rhythm),
	eucl_5_16: (pattern: ~euclideanSeq.(5, 16), tag: \rhythm),
	eucl_7_16: (pattern: ~euclideanSeq.(7, 16), tag: \rhythm),
	eucl_7_12: (pattern: ~euclideanSeq.(7, 12), tag: \rhythm),
	eucl_2_5:  (pattern: ~euclideanSeq.(2, 5),  tag: \rhythm),
	eucl_3_7:  (pattern: ~euclideanSeq.(3, 7),  tag: \rhythm),
	eucl_4_7:  (pattern: ~euclideanSeq.(4, 7),  tag: \rhythm),
	eucl_5_12: (pattern: ~euclideanSeq.(5, 12), tag: \rhythm),

	// Straight rhythms
	str8_eighth:  (pattern: Pseq([1/2], inf), tag: \rhythm),
	str8_16th:    (pattern: Pseq([1/4], inf), tag: \rhythm),

	// Sparse/dense rhythms
	sprs_half:    (pattern: Pseq([1/2, Rest(1/2), Rest(1/2), Rest(1/2)], inf), tag: \rhythm),
	sprs_quarter: (pattern: Pseq([1, Rest(1), Rest(1)], inf), tag: \rhythm),
	sprs_dotted:  (pattern: Pseq([3/4, Rest(1/4), Rest(1)], inf), tag: \rhythm),
	dense_burst:    (pattern: Pseq([1/4, 1/4, 1/4, 1/4, Rest(1)], inf), tag: \rhythm),

	// Syncopated rhythms
	sync_1:  (pattern: Pseq([Rest(1/2), 1/2, 1, Rest(1/2), 1/2], inf), tag: \rhythm),
	sync_2:  (pattern: Pseq([1, Rest(1/2), 1/2, Rest(1/2), 1/2, 1], inf), tag: \rhythm),
	offbeat:       (pattern: Pseq([Rest(1/2), 1/2], inf), tag: \rhythm),

	// Classic drum-machine style
	four_floor:    (pattern: Pseq([1], inf), tag: \rhythm),
	backbeat:      (pattern: Pseq([Rest(1), 1, Rest(1), 1], inf), tag: \rhythm),
	tresillo:      (pattern: Pseq([3/2, 3/2, 1], inf), tag: \rhythm),           // 3+3+2 eighths, = E(3,8)
	son_clave:     (pattern: Pseq([3/4, 3/4, 1, 1/2, 1], inf), tag: \rhythm),  // 3-2 son clave (16th grid)
	bossa_nova:    (pattern: Pseq([3/4, 3/4, 1, 3/4, 3/4], inf), tag: \rhythm), // bossa nova clave (16th grid)
	habanera:      (pattern: Pseq([3/2, 1/2, 1, 1], inf), tag: \rhythm),       // dotted-eighth+16th+quarter+quarter

	// Probabilistic rhythms
	prob_sparse:   (pattern: Pseq([Pwrand([1/2, Rest(1/2)], [0.3, 0.7].normalizeSum)], inf), tag: \rhythm),
	prob_dense:    (pattern: Pseq([Pwrand([1/2, Rest(1/2)], [0.7, 0.3].normalizeSum)], inf), tag: \rhythm),
	prob_varied:   (pattern: Pseq([
		1/2,
		Rest(1/2),
		Rest(1/2),
		Pwrand([Rest(1/2), 1/2], [0.9, 0.1].normalizeSum),
	], inf), tag: \rhythm),

	// ---- shape: continuous 0-1 movement, for timbre/morph/harm/decay/FX ----

	// Waveforms
	sine:          (pattern: Pseq((0, 0.04166 .. 1.0).collect { |x| sin(x * 2pi) * 0.5 + 0.5 }, inf), tag: \shape),
	sine_slow:     (pattern: Pseq((0, 0.02083 .. 1.0).collect { |x| sin(x * 2pi) * 0.5 + 0.5 }, inf), tag: \shape),
	triangle:      (pattern: Pseq((1..12).collect { |i| if(i <= 6) { i / 6.0 } { (12 - i) / 6.0 } }, inf), tag: \shape),
	ramp_up:       (pattern: Pseq((1..8).collect { |i| i / 8.0 }, inf), tag: \shape),
	ramp_down:     (pattern: Pseq((1..8).collect { |i| 1.0 - (i / 8.0) }, inf), tag: \shape),
	saw:           (pattern: Pseq([0.0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0, 0.0], inf), tag: \shape),

	// Stepped
	steps_4:       (pattern: Pseq([0.25, 0.5, 0.75, 1.0], inf), tag: \shape),
	steps_8:       (pattern: Pseq([0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0], inf), tag: \shape),
	steps_down_4:  (pattern: Pseq([1.0, 0.75, 0.5, 0.25], inf), tag: \shape),
	plateau:       (pattern: Pseq([0.2, 0.2, 0.8, 0.8, 0.8, 0.2], inf), tag: \shape),

	// Smooth sweeps
	sweep:         (pattern: Pseries(0.0, 0.05, inf).fold(0, 1), tag: \shape),
	sweep_slow:    (pattern: Pseries(0.0, 0.02, inf).fold(0, 1), tag: \shape),
	bounce:        (pattern: Pseq([1.0, 0.7, 0.4, 0.2, 0.4, 0.7], inf), tag: \shape),
	updown:        (pattern: Pseq([0.1, 0.3, 0.5, 0.7, 0.9, 0.7, 0.5, 0.3], inf), tag: \shape),

	// Random/noise
	random:        (pattern: Pwhite(0.0, 1.0, inf), tag: \shape),
	rndm_narrow: (pattern: Pwhite(0.3, 0.7, inf), tag: \shape),
	rndm_walk:   (pattern: Pbrown(0.0, 1.0, 0.1, inf), tag: \shape),
	rndm_walk_slow: (pattern: Pbrown(0.0, 1.0, 0.05, inf), tag: \shape),

	// Textural
	glitch:        (pattern: Pseq(0.2 ! 19 ++ [0.8], inf), tag: \shape),
	wobble:        (pattern: Pseq(0.5 ! 5 ++ [0.3], inf), tag: \shape),
	flutter:       (pattern: Pseq([0.4, 0.6, 0.45, 0.55, 0.42, 0.58], inf), tag: \shape),
	cycle5:        (pattern: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf), tag: \shape),

	// Legacy names (backward compat with existing patches)
	gauss:         (pattern: Pwhite(0.3, 0.7, inf), tag: \shape),    // → rndm_narrow
	sparse:        (pattern: Pseq([0.1, 0.5, 0.9], inf), tag: \shape),
	dense:         (pattern: Pseq([0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0], inf), tag: \shape),
	euclid:        (pattern: Pseq([1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0].normalize(0, 1), inf), tag: \shape),
	ramp:          (pattern: Pseq([0.1, 0.2, 0.4, 1.0], inf), tag: \shape),

	// ---- accent: 0-1 centered ~0.5 with periodic emphasis, for volume/mul/sends ----

	acnt_downbeat:  (pattern: Pseq([0.9, 0.4, 0.4, 0.4], inf), tag: \accent),
	acnt_backbeat:  (pattern: Pseq([0.4, 0.8, 0.4, 0.8], inf), tag: \accent),
	acnt_one:       (pattern: Pseq([1.0, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5], inf), tag: \accent),
	acnt_sparse:    (pattern: Pseq(0.5 ! 7 ++ [0.9], inf), tag: \accent),
	acnt_2_and_4:   (pattern: Pseq([0.4, 0.9, 0.4, 0.9], inf), tag: \accent),
	swell_4:          (pattern: Pseq([0.3, 0.5, 0.7, 0.9], inf), tag: \accent),
	swell_8:          (pattern: Pseq([0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0], inf), tag: \accent),
	swell_fade:       (pattern: Pseq([0.9, 0.7, 0.5, 0.3], inf), tag: \accent),
	gate_alternate:   (pattern: Pseq([1, 0], inf), tag: \accent),
	gate_stutter:     (pattern: Pseq([1, 1, 0, 0], inf), tag: \accent),
	gate_every3:      (pattern: Pseq([1, 0, 0], inf), tag: \accent),
	gate_every4:      (pattern: Pseq([1, 0, 0, 0], inf), tag: \accent),
	gate_every5:      (pattern: Pseq([1, 0, 0, 0, 0], inf), tag: \accent),
	gate_every8:      (pattern: Pseq([1, 0, 0, 0, 0, 0, 0, 0], inf), tag: \accent),
	gate_every16:     (pattern: Pseq([1] ++ (0 ! 15), inf), tag: \accent),
	gate_every32:     (pattern: Pseq([1] ++ (0 ! 31), inf), tag: \accent),
	gate_every64:     (pattern: Pseq([1] ++ (0 ! 63), inf), tag: \accent),
	gate_burst:       (pattern: Pseq([1, 1, 0, 0, 0, 0], inf), tag: \accent),
	gate_tail:        (pattern: Pseq([0, 0, 0, 1], inf), tag: \accent),
	gate_inv4:        (pattern: Pseq([0, 1, 1, 1], inf), tag: \accent),
	gate_inv8:        (pattern: Pseq([0, 1, 1, 1, 1, 1, 1, 1], inf), tag: \accent),
	gate_prob05:      (pattern: Pwrand([1, 0], [0.05, 0.95], inf), tag: \accent),
	gate_prob20:      (pattern: Pwrand([1, 0], [0.2, 0.8], inf), tag: \accent),
	gate_prob50:      (pattern: Pwrand([1, 0], [0.5, 0.5], inf), tag: \accent),
	gate_prob80:      (pattern: Pwrand([1, 0], [0.8, 0.2], inf), tag: \accent),
	dyn_pp_ff:   (pattern: Pseq([0.3, 0.3, 0.3, 0.3, 0.8, 0.8, 0.8, 0.8], inf), tag: \accent),
	dyn_cresc:   (pattern: Pseq([0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9], inf), tag: \accent),

	// ---- timing: multiplier ratios, for div/rate/speed ----

	half:          (pattern: Pseq([0.5], inf), tag: \timing),
	double:        (pattern: Pseq([2], inf), tag: \timing),
	triplet:       (pattern: Pseq([2/3], inf), tag: \timing),
	dotted:        (pattern: Pseq([3/2], inf), tag: \timing),
	shuffle:       (pattern: Pseq([2/3, 1/3], inf), tag: \timing),
	swing:         (pattern: Pseq([0.6, 0.4], inf), tag: \timing),
	accel:         (pattern: Pseq([1.0, 0.9, 0.8, 0.7, 0.6, 0.5], inf), tag: \timing),
	decel:         (pattern: Pseq([0.5, 0.6, 0.7, 0.8, 0.9, 1.0], inf), tag: \timing),
	alt_half_dbl:  (pattern: Pseq([0.5, 2], inf), tag: \timing),
	alt_trip_dot:  (pattern: Pseq([2/3, 3/2], inf), tag: \timing),
	poly_3_over_4: (pattern: Pseq([4/3, 4/3, 4/3], inf), tag: \timing),
	poly_5_over_4: (pattern: Pseq([4/5, 4/5, 4/5, 4/5, 4/5], inf), tag: \timing),

	// ---- pitch: semitone offsets from base pitch (additive) ----

	// Intervals
	oct_up:        (pattern: Pseq([0, 12], inf), tag: \pitch),
	oct_down:      (pattern: Pseq([0, -12], inf), tag: \pitch),
	oct_updown:    (pattern: Pseq([0, 12, 0, -12], inf), tag: \pitch),
	fifth:         (pattern: Pseq([0, 7], inf), tag: \pitch),
	fourth:        (pattern: Pseq([0, 5], inf), tag: \pitch),
	triad_maj:     (pattern: Pseq([0, 4, 7], inf), tag: \pitch),
	triad_min:     (pattern: Pseq([0, 3, 7], inf), tag: \pitch),
	triad_maj_inv: (pattern: Pseq([0, 4, 7, 12, 7, 4], inf), tag: \pitch),
	triad_min_inv: (pattern: Pseq([0, 3, 7, 12, 7, 3], inf), tag: \pitch),

	// Scales (ascending)
	scale_maj:     (pattern: Pseq([0, 2, 4, 5, 7, 9, 11, 12], inf), tag: \pitch),
	scale_min:     (pattern: Pseq([0, 2, 3, 5, 7, 8, 10, 12], inf), tag: \pitch),
	scale_pent:    (pattern: Pseq([0, 2, 4, 7, 9, 12], inf), tag: \pitch),
	scale_chrom:   (pattern: Pseq([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], inf), tag: \pitch),

	// Random pitch
	rndm_oct:      (pattern: Pwhite(-12, 12, inf), tag: \pitch),
	rndm_fifth:    (pattern: Pwhite(-7, 7, inf), tag: \pitch),
	rndm_semi:     (pattern: Pwhite(-2, 2, inf), tag: \pitch),
	walk_semi:     (pattern: Pbrown(-12, 12, 1, inf), tag: \pitch),
	walk_third:    (pattern: Pbrown(-12, 12, 4, inf), tag: \pitch),

	// Legacy names (backward compat with existing patches)
	rhythm1:       (pattern: Pseq([1, 2, 1, 1, 2], inf), tag: \timing),
	rhythm2:       (pattern: Pseq([1, 2, 0.5, 1, 2], inf), tag: \timing),
	steps:         (pattern: Pseq([0.25, 0.5, 0.75, 1.0], inf), tag: \shape),  // → steps_4
);
)