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

"e" ! 8 ++ 'e-5'


