// n = NetAddr("localhost", 3333);
~ws.().sendMsg('/foo', 440, 0.8, 0.25);


([0.1, 0.1, 0.1] ++ (3 ! 5)).flatten


s.options.blockSize // s.sampleRate

s.options.collect{|o| o.postln;}


s.options.dump

s.options.memSize

// controlPeriod = blockSize / sampleRate
// controlPeriod = 128 / 48000 = 0.00267 seconds

// duration * legato >= safetyFactor * controlPeriod
// duration >= (safetyFactor * controlPeriod) / legato

  With safetyFactor = 3:
  duration >= (3 * 0.00267) / 0.1
  duration >= 0.08 seconds  // more aggressive minimum

// sound example
(
SynthDef(\help_sinegrain,
	{ arg out=0, freq=440, sustain=0.05, amp=0.1;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2, amp), doneAction: Done.freeSelf);
		Out.ar(out, SinOsc.ar(freq, 0, env))
}).add;
)


b.stop;

(
var a;
// a = Pgeom(1, 0.9, 70).loop.asStream;
a = Pseq([
	// (0.5 ! 4),
	(1 ! 2),
	Pgeom(1, 0.9, 50),
	Pgeom(0.02, 1.1, 30),
	// Pwrand([0.7, Rest(0.7)], [0.9, 0.1].normalizeSum),
], inf).flatten.asStream;

b= {
	a.do { |val|
		Synth(\help_sinegrain, [\freq, 440]);
		val.postln;
		val.wait;
	}
}.fork;
)

b.stop;

(
{
	var harm = 0.5;
	var timbre = 0.5;
	var morph = 0.5;
	var trigger = Impulse.kr(8);
	var timbMod = MouseY.kr(-1,1);
	MiPlaits.ar(47, 1, harm, timbre, morph, trigger, timb_mod: timbMod, decay: 0.4)
}.play
)

[2388, 1668]/2

s.addr

Platform.systemExtensionDir

Platform.userExtensionDir

Quarks.gui

CrossoverDistortion.ar

"e" ! 8 ++ 'e-5'

1 ! 1 ++ (0.5)

~br1.(5,8) ++ (Rest(1) ! 8)

[0.1, 0.2, 0.1, 0.05, 0.8] ++ (0.0 ! 12)

([8, 4, 8, 4, 8, 2]/4 ! 64).flatten ++ ([8, 4, 8, 4, 8, 2]/2 ! 64).flatten ++ ([8, 4, 8, 4, 8, 2] ! 64).flatten



// Fading spike

(
~fadeOut = { |fadeTime = 2|
	s.defaultGroup.set(\fadeTime, fadeTime, \fadeGate, 0);
	("Fading out over " ++ fadeTime ++ " seconds").postln;
};

~fadeOut.(2)
)

Decimator.ar

s.queryAllNodes;  // This will show all running synths and their parameters

// Replace 1001 with an actual synth ID from queryAllNodes
s.sendMsg('/n_set', 1156, 'fadeGate', 0);

(
// Test with a simple synth first
(
{
	var fadeGate = \fadeGate.kr(1);
	var fadeEnv = EnvGen.kr(Env.asr(0, 1, 2), fadeGate);
	var sig = SinOsc.ar(rand(400, 440)) * 0.1 * fadeEnv;
	fadeEnv.poll(1, "fadeEnv");
	sig ! 2;
}.play;
)
)

s.defaultGroup.se


MiClouds




(
~br1 = { | o = 1, p = 4 |
	(o / p * (0..p - 1)).floor.differentiate.asInteger.min(1)[0] = if (o <= 0) { 0 } { 1 };
	// Note: the if (o <= 0) statement covers the case when we want 0 beats
	// in the pattern
};
//
(0..12) do: { | i | postf("bresenham improved. i: %, rhythm: %\n", i, ~br1.(i, 8)) };
)t(\fadeGate, 0);






(

// ~cloudsBus = Bus.audio(s, 2);
// ~delayBus = Bus.audio(s, 2);

// ~cloudsFX = Synth(\globalClouds, [\out, 0], addAction: \addToTail);
// b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01-44_1.aiff");
//
// ~delayFX = Synth(\globalFilterDelay, [\out, 0], addAction: \addToTail);

(  // basic granulation
x = {
	var buffer = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01-44_1.aiff");
	var input = PlayBuf.ar(1, buffer, 1, loop: 1)!2;

	var dens = LFNoise1.kr(0.3).range(0.3, 0.45);

	Out.ar(~cloudsBus, input);
	// Out.ar(~delayBus, input);
	// Out.ar(0, LeakDC.ar(input) * 0.2);
	// MiClouds.ar(input, 0, 0, 0, dens, 0.5, drywet: 1, mode: 0);

}.play
)
)

(
[
	"cloudsSends",
	~plaits.synths[0].cloudsSend,
	~plaits.synths[1].cloudsSend,
	~plaits.synths[2].cloudsSend,
].postln;
)

~cloudsFX.set(\freeze, 1)   // freeze internal buffer
~cloudsFX.set(\freeze, 0)
~cloudsFX.set(\mode, 0)
~cloudsFX.set(\mode, 1)
~cloudsFX.set(\mode, 2)
~cloudsFX.set(\mode, 3)
~cloudsFX.set(\density, 1.0.rand)
~cloudsFX.set(\position, 1.0.rand)
~cloudsFX.set(\size, 1.0.rand)
~cloudsFX.set(\blend, 1.0.rand)
~cloudsFX.set(\spread, 1.0.rand)

~cloudsFX.set(\pitch, rrand(-48, 48))

~cloudsFX.set(\reverb, 1.0.rand)
~cloudsFX.set(\feedback, 0.5.rand)

1.0.rand

x.free;

// Test if the synth is actually running
~cloudsFX.isPlaying  // should return true

// Test with more obvious parameters
~cloudsFX.set(\density, 0.8, \position, 0.8, \size, 0.8, \blend, 1.0);

~cloudsFX

~cloudsBus

~cloudsBus


(
var td = NetAddr("127.0.0.1", 10000);  // your TD port
// A bundle with two messages:
td.sendBundle(0.0, [
	["/bundleTest/one", 123, "abc"],
	["/bundleTest/two", 4.56]
]);
)



// PATTERNS /////////////////////////////////////
(
p = Pbind(
	// \degree, Pwhite(-4, 11, inf),
	// \pan, Env(#[-1, 1, -1], #[2, 2], \sin),
	// \pan, Env.sine(1).range(-1.0, 1.0),
	// \pan, Pn(Pif(Ptime(inf) <= 4.0, Env(#[-1, 1, -1], #[2, 2], \sin)), inf),
	// \pan, Pn(Pif(Ptime(inf) <= 4.0, Env.sine(4.0).range(-1.0, 1.0)), inf),
	// \dur, Pn(Pif(Ptime(inf) <= 8.0, Env.sine(8.0).range(0.05, 0.5)), inf),
	\dur, ~sinePattern.(),
	// \dur, 0.125
).play;

)

p.stop;


~sinePattern = { |dur=8.0, lo=0.05, hi=0.5, repeats=inf|
	Pn(
		Pif(Ptime(inf) <= dur, Env.sine(dur).range(lo, hi)),
		repeats
	)
};

Env.sine(1, 1).linlin(0, 1, -1, 1).test.plot;

Env.sine(1).range(-1.0, 1.0).test.plot;

Env.linen(0.1, 0.2, 0.1, 0.6).test.plot;
Env.linen(1, 2, 3, 0.6).test.plot;
Env.linen(1, 2, 3, 0.6, \sine).test.plot;
Env.linen(1, 2, 3, 0.6, \welch).test.plot;
Env.linen(1, 2, 3, 0.6, -3).test.plot;
Env.linen(1, 2, 3, 0.6, -3).test.plot;
Env.linen(1, 2, 3, 0.6, [[\sine, \welch, \lin, \exp]]).plot;

// Scale sine envelope to -1 to 1
Env.sine(1) * 2 - 1

(
(1..12).do { |i|
	[i, ~sineAtBeat.(i, 32, 0.05, 0.5)].postln;
}
)

(
~visSender.stop;
~visSender = Routine {
	inf.do { |i|
		var v = ~sineAtBeat.(~tempoClock.beats, 64, 0.15, 0.5);
		// [i, v].postln;
		~td.().sendMsg("/plaits/lfo", v);
		(1/60).wait;  // smooth visual updates
	}
}.play(AppClock);       // UI/OSC clock is fine here
)

'e' ! 5 ++ 2

(2 ! 4) ++ (4 ! 4)

0.2 ! 19 ++ 0.5

Pseq([1,2,3,4]).asStream

Pdrop(3, ~sinePattern.(64, 0.1, 0.2)).asStream



(
p = Pstutter(4, Pdrop(3, ~sinePattern.(64.0, 0.05, 0.5)));
q = p.asStream.nextN(50).postln
)


(
p = Pdrop(3, Pseq([1,2,3,4],inf));
q = p.asStream.nextN(20).postln;
)

~filterWithRests.(~sinePattern.(8.0, 0.05, 0.5), 4).asStream


