//////////////////////////////////////////////////////////////////////////////
// Mutable Instruments Plaits
//
//
// When timbre is a literal/scalar, modulations.timbre_patched = false, allowing timb_mod to work.
// When timbre is an argument, modulations.timbre_patched = true, likely disabling timb_mod.
//
// The UGen assumes if you're modulating timbre via control rate, you don't want the internal timb_mod as well.

// You have two options:
//
// 1. Use literal timbre values when you want timb_mod to work (only useful for modulating internal env gen [1])
// 2. Use control-rate timbre arguments but implement modulation yourself
//
// [1] See "Controls: F. Attenuvertors": "https://pichenettes.github.io/mutable-instruments-documentation/modules/plaits/manual/"
//
/////////////////////////////////////////////////////////////////////////////
(
SynthDef(\plaits,
	{
		arg out=0, pitch=40, engine=1, harm=0.5, timbre=0.5, morph=0.5, speed=6, level=1.0, decay=0.5, fm_mod=0.0, lpg_colour=0.5, mul=0.5, gate=1.0, rev_drywet=0.25, rev_time=0.3, rev_damp=0.8, rev_hp=0.7, rev_freeze=0, volume=0.7;

		/*
		var trig = Select.kr(trigger, [
			0.0,
			Impulse.kr(speed)
		]);
		*/

		// var timb_mod = MouseY.kr(-1,1);

		// doing this client side now
		// var l_timbre = (timbre + LFTri.kr(freq: speed/10, mul: timb_mod)).clip(0, 1);
		// var l_morph = (morph + LFTri.kr(freq: speed/10, mul: morph_mod)).clip(0, 1);

		var sig = MiPlaits.ar(
			pitch: pitch.clip(0, 127),
			engine: engine.clip(0, 15),
			harm: harm.clip(0, 1),
			// timbre: 0.5,
			timbre: timbre.clip(0, 1),
			morph: morph.clip(0, 1),
			trigger: gate,
			// trigger: Impulse.kr(speed),
			// level: level,
			decay: decay.clip(0, 1),
			fm_mod: fm_mod.clip(-1, 1),
			// Can't use these with non Scalar timbre / morph
			// timb_mod: timb_mod,
			// morph_mod: morph_mod,
			lpg_colour: lpg_colour.clip(0, 1),
			mul: mul
		);

		var env = Linen.kr(gate, doneAction: Done.freeSelf);

		// Sanitize to kill denormals, infs, and NaNs - crucial for engine switching!
		sig = sig.sanitize;

		sig = MiVerb.ar(
			(sig * env).tanh,
			time: rev_time.clip(0, 1.25),
			drywet: rev_drywet.clip(0, 1),
			damp: rev_damp.clip(0, 1),
			hp: rev_hp.clip(0, 1),
			// freeze: TRand.kr(-1, 1, Dust.kr(0.7)),
			freeze: rev_freeze.clip(0, 1),
			// freeze: 1,
			diff: 0.625,
			mul: volume.clip(0, 2.0),
			add: 0.0
		);

		Out.ar(out, LeakDC.ar(sig.tanh));
		// Out.ar(0, sig[0] ! 2);
}).add;
)