(
{
	var harm = 0.5;
    var timbre = 0.5;
    var morph = 0.5;
    var trigger = Impulse.kr(8);
	var timb_mod = MouseY.kr(-1,1);
    MiPlaits.ar(47, 1, harm, timbre, morph, trigger, timb_mod: timb_mod, decay: 0.4)
}.play
)

Platform.systemExtensionDir

Quarks.gui

CrossoverDistortion.ar

"e" ! 8 ++ 'e-5'

1 ! 1 ++ (0.5)

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

s.defaultGroup.set(\fadeGate, 0);