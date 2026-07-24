// Proof that \dur = 1 = 1 quarter note on TempoClock
//
// At 60 BPM (1 beat/sec), count the posts per second:
//   - If dur=1 is a quarter note → 1 event/sec (60 quarter notes/min)
//   - If dur=1 were a whole note → 0.25 events/sec
//   - If dur=1 were an eighth    → 2 events/sec
//
// Run this and count: you should see exactly 1 post per second.

(
t = TempoClock.new(60/60); // 60 BPM = 1 beat/sec

Pbind(
	\instrument, \default,
	\dur, 1,
	\note, 0,
	\amp, 0.3,
).collect { |event|
	("tick at " ++ thisThread.beats.round(0.01) ++ " beats").postln;
	event;
}.play(t);

"Expect ticks at 0, 1, 2, 3... (one per second at 60 BPM = quarter notes)".postln;
)
