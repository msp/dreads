//////////////////////////////////////////////////////////////////////////////
// Mutable Instruments Plaits
//
//
// When timbre is a literal/scalar, modulations.timbre_patched = false, allowing timbMod to work.
// When timbre is an argument, modulations.timbre_patched = true, likely disabling timbMod.
//
// The UGen assumes if you're modulating timbre via control rate, you don't want the internal timbMod as well.

// You have two options:
//
// 1. Use literal timbre values when you want timbMod to work (only useful for modulating internal env gen [1])
// 2. Use control-rate timbre arguments but implement modulation yourself
//
// [1] See "Controls: F. Attenuvertors": "https://pichenettes.github.io/mutable-instruments-documentation/modules/plaits/manual/"
//
/////////////////////////////////////////////////////////////////////////////
(
SynthDef(\plaits,
	{
		arg out=0, pitch=40, engine=1, harm=0.5, timbre=0.5, morph=0.5, speed=6, level=1.0, decay=0.5, fmMod=0.0, lpgColour=0.5, mul=0.5, gate=1.0, revDrywet=0.25, revTime=0.3, revDamp=0.8, revHp=0.7, revFreeze=0, volume=0.7, cloudsSend=0.0, delaySend=0.0, reverbSend=0.0, distDrive=0.0, distAmount=0.0, stereoMode=1;

		var cleanSig, distSig;
		// , fadeTime=2.0, fadeGate=1;
		// var fadeEnv = EnvGen.kr(Env.asr(0, 1, fadeTime), fadeGate, doneAction: 2);

		/*
		var trig = Select.kr(trigger, [
		0.0,
		Impulse.kr(speed)
		]);
		*/

		// var timbMod = MouseY.kr(-1,1);

		// doing this client side now
		// var l_timbre = (timbre + LFTri.kr(freq: speed/10, mul: timbMod)).clip(0, 1);
		// var l_morph = (morph + LFTri.kr(freq: speed/10, mul: morphMod)).clip(0, 1);

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
			fm_mod: fmMod.clip(-1, 1),
			// Can't use these with non Scalar timbre / morph
			// timb_mod: timbMod,
			// morph_mod: morphMod,
			lpg_colour: lpgColour.clip(0, 1),
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
		distSig = CrossoverDistortion.ar(sig, distDrive.clip(0.1, 2.0), 0.5);
		sig = (cleanSig * (1 - distAmount.clip(0, 1))) + (distSig * distAmount.clip(0, 1));


		// Sanitize to kill denormals, infs, and NaNs - crucial for engine switching!
		sig = sig.sanitize;

		sig = MiVerb.ar(
			(sig * env).tanh,
			time: revTime.clip(0, 1.25),
			drywet: revDrywet.clip(0, 1),
			damp: revDamp.clip(0, 1),
			hp: revHp.clip(0, 1),
			// freeze: TRand.kr(-1, 1, Dust.kr(0.7)),
			freeze: revFreeze.clip(0, 1),
			diff: 0.625,
			mul: volume.clip(0, 2.0),
			add: 0.0
		);

		Out.ar(~cloudsBus, sig * cloudsSend);
		Out.ar(~delayBus, sig * delaySend);
		Out.ar(~reverbBus, sig * reverbSend);

		Out.ar(out, LeakDC.ar(sig.tanh));
}).add;

// Filter Delay Send Effect
SynthDef(\globalFilterDelay, {
	arg out=0, time=0.25, feedback=0.3, filterFreq=2000,
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
	filteredL = LPF.ar(delayedL, filterFreq);
	filteredR = LPF.ar(delayedR, filterFreq);
	LocalOut.ar([filteredL, filteredR]);

	// Output 100% wet (mix=1.0) since it's a send effect
	output = [filteredL, filteredR] * mix * env;

	// Distribute to all speaker pairs in multi-channel setups
	if (~numSpeakers > 2) {
		(~numSpeakers / 2).do { |i|
			Out.ar(i * 2, output);
		};
	} {
		Out.ar(out, output);
	};
}).add;

// Global MiVerb Send Effect
SynthDef(\globalReverb, {
	arg out=0, time=0.5, damp=0.5, hp=0.25, diffuse=0.625, freeze=0,
	mix=1.0, gate=1;

	var input = In.ar(~reverbBus, 2);
	var env = EnvGen.kr(Env.asr(0.01, 1, 2), gate, doneAction: 2);

	var reverb = MiVerb.ar(
		input,
		time: time.clip(0, 1.25),
		drywet: 1.0, // Always 100% wet for send effect
		damp: damp.clip(0, 1),
		hp: hp.clip(0, 1),
		freeze: freeze.clip(0, 1),
		diff: diffuse.clip(0, 1),
		mul: mix.clip(0, 2.0)
	);

	var output = LeakDC.ar(reverb * env);

	// Distribute to all speaker pairs in multi-channel setups
	if (~numSpeakers > 2) {
		(~numSpeakers / 2).do { |i|
			Out.ar(i * 2, output);
		};
	} {
		Out.ar(out, output);
	};
}).add;

// Global MiClouds Send Effect
SynthDef(\globalClouds, {
	arg out=0, position=0.0, size=0.0, density=0.5, texture=0.5,
	pitch=0.0, blend=0.5, freeze=0, inGain = 1.0, spread=0.5, reverb=0.0, feedback=0.0, mix=1.0, gate=1, mode=3, lofi=0.0, volume=1.0;

	// var input = InFeedback.ar(~cloudsBus, 2);
	var input = In.ar(~cloudsBus, 2);
	var env = EnvGen.kr(Env.asr(0.01, 1, 2), gate, doneAction: 2);
	var dens = LFNoise1.kr(0.3).range(0.3, 0.45);

	var clouds = MiClouds.ar(
		input,
		pit: pitch.clip(-48, 48),
		pos: position.clip(0, 1),
		size: size.clip(0, 1),
		dens: density.clip(0, 1),
		tex: texture.clip(0, 1),
		drywet: 1,
		in_gain: inGain.clip(0.125, 8),
		spread: spread.clip(0, 1),
		rvb: reverb.clip(0, 1),
		fb: feedback.clip(0, 1),
		freeze: freeze.clip(0, 1),
		mode: mode.clip(0, 3),
		lofi: lofi.clip(0, 1),
		mul: volume.clip(0, 1)
	);

	// clouds = PitchShift.ar(input, 0.2, LFNoise1.kr(0.3).range(0.0, 2.00), 0.0, 0.5) * 0.8;

	// Ring modulation - very audible effect:
	// clouds = clouds * SinOsc.ar(200) * 0.5 + clouds;

	var output = LeakDC.ar(clouds * env * mix.clip(0, 2.0));

	// Distribute to all speaker pairs in multi-channel setups
	if (~numSpeakers > 2) {
		(~numSpeakers / 2).do { |i|
			Out.ar(i * 2, output);
		};
	} {
		Out.ar(out, output);
	};
}).add;

SynthDef(\panningSamplePlayer, {
	|out=0, bufnum=0, numChannels=1, mul=1, rate=1, startPos=0, panDur=5,
	atk=0.01, decay=0.1, gate=1, volume=0.7,
	cloudsSend=0.0, delaySend=0.0, reverbSend=0.0,
	distDrive=0.0, distAmount=0.0,
	revDrywet=0.25, revTime=0.3, revDamp=0.8, revHp=0.7, revFreeze=0|

	var sig, env, pan, monoPlay, cleanSig, distSig;

	// Pan from -1 to 1 over panDur
	pan = Line.kr(-1, 1, panDur);
	env = EnvGen.kr(Env.perc(atk, decay), gate, doneAction: Done.freeSelf);

	// Always read as mono (works for both mono and stereo buffers)
	monoPlay = PlayBuf.ar(
		numChannels: 1,
		bufnum: bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: startPos,
		doneAction: 0
	);

	// Pan and convert to stereo
	sig = Pan2.ar(monoPlay, pan);

	sig = sig * mul;

	// Distortion (same as plaits)
	cleanSig = sig;
	distSig = CrossoverDistortion.ar(sig, distDrive.clip(0.1, 2.0), 0.5);
	sig = (cleanSig * (1 - distAmount.clip(0, 1))) + (distSig * distAmount.clip(0, 1));

	// Sanitize to kill denormals, infs, and NaNs
	sig = sig.sanitize;

	// MiVerb insert effect (same as plaits - apply env at input)
	sig = MiVerb.ar(
		(sig * env).tanh,
		time: revTime.clip(0, 1.25),
		drywet: revDrywet.clip(0, 1),
		damp: revDamp.clip(0, 1),
		hp: revHp.clip(0, 1),
		freeze: revFreeze.clip(0, 1),
		diff: 0.625,
		mul: volume.clip(0, 2.0),
		add: 0.0
	);

	// Send to FX buses
	Out.ar(~cloudsBus, sig * cloudsSend);
	Out.ar(~delayBus, sig * delaySend);
	Out.ar(~reverbBus, sig * reverbSend);

	Out.ar(out, LeakDC.ar(sig.tanh));
}).add;

SynthDef(\samplePlayer, {
    |out=0, bufnum=0, amp=1, rate=1, startPos=0, atk=0.01, rel=0.1, gate=1|

    var sig, env;

    env = EnvGen.kr(Env.asr(atk, 1, rel), gate, doneAction: 2);

    sig = PlayBuf.ar(
        numChannels: 1,
        bufnum: bufnum,
        rate: rate * BufRateScale.kr(bufnum),
		startPos: startPos,
        doneAction: 0
    );

    sig = sig * env * amp;
    Out.ar(out, sig);
}).add;

)
