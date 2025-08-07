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
		arg out=0, delayBus=0, reverbBus=0, pitch=40, engine=1, harm=0.5, timbre=0.5, morph=0.5, speed=6, level=1.0, decay=0.5, fm_mod=0.0, lpg_colour=0.5, mul=0.5, gate=1.0, rev_drywet=0.25, rev_time=0.3, rev_damp=0.8, rev_hp=0.7, rev_freeze=0, volume=0.7, delay_send=0.0, reverb_send=0.0, dist_drive=0.0, dist_amount=0.0, stereoMode=1;

		var cleanSig, distSig;
		// , fadeTime=2.0, fadeGate=1;
		// var fadeEnv = EnvGen.kr(Env.asr(0, 1, fadeTime), fadeGate, doneAction: 2);

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

		// Stereo mode selection: 0=mono (left only), 1=stereo
		sig = Select.ar(stereoMode.clip(0, 1), [
			sig[0] ! 2,  // Mono: duplicate left channel to both sides
			sig          // Stereo: keep original stereo signal
		]);

		// Tube-style asymmetric distortion with wet/dry mix
		// var cleanSig = sig;
		// var drive = distDrive.clip(1, 8);
		// var distSig = sig * drive;
		// distSig = distSig + (distSig.squared * 0.1); // Add harmonics
		// distSig = distSig.softclip;
		// distSig = distSig / drive; // Compensate gain
		//
		// // Mix clean and distorted signals
		// sig = (cleanSig * (1 - distAmount.clip(0, 1))) + (distSig * distAmount.clip(0, 1));
		cleanSig = sig;
		distSig = CrossoverDistortion.ar(sig, dist_drive.clip(0.1, 2.0), 0.5);
		sig = (cleanSig * (1 - dist_amount.clip(0, 1))) + (distSig * dist_amount.clip(0, 1));


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

		Out.ar(~delayBus, sig * delay_send);
		Out.ar(~reverbBus, sig * reverb_send);

		Out.ar(out, LeakDC.ar(sig.tanh));
		// Out.ar(0, sig[0] ! 2);
}).add;

// Filter Delay Send Effect
SynthDef(\globalFilterDelay, {
	arg out=0, time=0.25, feedback=0.3, filter_freq=2000,
	mix=1.0, gate=1, spread=1.5;

	var maxDelayTime = 4;
	var input = In.ar(~delayBus, 2);
	var delayedL, delayedR, filteredL, filteredR, output;
	var env = EnvGen.kr(Env.asr(0.01, 1, 1), gate, doneAction: 2);

	// Initialize filtered signals for ping-pong feedback loop
	#filteredL, filteredR = LocalIn.ar(2);

	// Ping-pong delay: L gets input + R feedback, R gets input + L feedback
	delayedL = DelayL.ar(input.sum + (filteredR * feedback), maxDelayTime, time);
	delayedR = DelayL.ar(input.sum + (filteredL * feedback), maxDelayTime, time * spread);

	// Filter the delayed signals (tape-style)
	filteredL = LPF.ar(delayedL, filter_freq);
	filteredR = LPF.ar(delayedR, filter_freq);
	LocalOut.ar([filteredL, filteredR]);

	// Output 100% wet (mix=1.0) since it's a send effect
	output = [filteredL, filteredR] * mix * env;

	Out.ar(out, output);
}).add;

// Global MiVerb Send Effect
SynthDef(\globalReverb, {
	arg out=0, time=0.5, damp=0.5, hp=0.25, diffuse=0.625, freeze=0,
	mix=1.0, gate=1;

	var input = In.ar(~reverbBus, 2);
	var env = EnvGen.kr(Env.asr(0.01, 1, 2), gate, doneAction: 2);
	var reverb;

	reverb = MiVerb.ar(
		input,
		time: time.clip(0, 1.25),
		drywet: 1.0, // Always 100% wet for send effect
		damp: damp.clip(0, 1),
		hp: hp.clip(0, 1),
		freeze: freeze.clip(0, 1),
		diff: diffuse.clip(0, 1),
		mul: mix.clip(0, 2.0)
	);
	Out.ar(out, LeakDC.ar(reverb * env));
}).add;

)
