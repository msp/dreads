//////////////////////////////////////////////////////////////////////////////
// Mutable Instruments SynthDefs
//////////////////////////////////////////////////////////////////////////////
(
SynthDef(\plaits,
	{
		arg out=0, pitch=40, engine=6, harm=0.5, timbre=0.5, morph=0.5, speed=6, level=1.0, decay=0.5, fm_mod=0.0, timb_mod=0.0, morph_mod=0.0, lpg_colour=0.5, mul=0.5, gate=1.0, drywet=0.25, reverb_time=0.3;

		/*
		var trig = Select.kr(trigger, [
			0.0,
			Impulse.kr(speed)
		]);
		*/

		// var timb_mod = MouseY.kr(-1,1);

		var l_timbre = (timbre + LFTri.kr(freq: speed/100, mul: timb_mod)).clip(0, 1);
		var l_morph = (morph + LFTri.kr(freq: speed/100, mul: morph_mod)).clip(0, 1);

		var sig = MiPlaits.ar(
			pitch: pitch.clip(0, 127),
			engine: engine.clip(0, 15),
			harm: harm.clip(0, 1),
			timbre: l_timbre,
			morph: l_morph,
			trigger: gate,
			// trigger: Impulse.kr(speed),
			// level: level,
			decay: decay.clip(0, 1),
			fm_mod: fm_mod.clip(-1, 1),
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
			time: reverb_time.clip(0, 1),
			drywet: drywet.clip(0, 1),
			damp: 0.8,
			hp: 0.7,
			freeze: TRand.kr(-1, 1, Dust.kr(0.7)),
			// freeze: 1,
			diff: 0.625,
			mul: 1.1,
			add: 0.0
		);

		Out.ar(out, LeakDC.ar(sig.tanh));
		// Out.ar(0, sig[0] ! 2);
}).add;
)