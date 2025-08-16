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
