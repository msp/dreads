////////////////////////////////////////////////////////////////////////////////
// SPEAKER TESTER
////////////////////////////////////////////////////////////////////////////////

(
t = Pbind(
    \instrument, \samplePlayer,
    \bufnum, Pseq(
		[
			~sampleLibrary.banks[\numbers][1],
			~sampleLibrary.banks[\numbers][2],
			~sampleLibrary.banks[\numbers][3],
			~sampleLibrary.banks[\numbers][4],
			~sampleLibrary.banks[\numbers][5],
			~sampleLibrary.banks[\numbers][6],
	], inf),
    \dur, 1,
    \panDur, 10,
    \atk, 0.1,
    \rel, 1.0,
    \amp, 0.2,
	// \out, Pseq(~outputBuses, inf),
	\out, Pseq([0,1,2,3,4,5], inf),
).play;
)

t.stop;