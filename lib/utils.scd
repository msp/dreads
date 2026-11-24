////////////////////////////////////////////////////////////////////////////////
// Utility Functions
////////////////////////////////////////////////////////////////////////////////

(

// Fade out by reducing reverb time to kill MiVerb internal feedback
~fadeOutReverb = { |fadeTime = 2|
	// plaits insert reverbs
	~voiceGroup.set(\revTime, 0.9);
	// global reverb
	~fx.reverb.set(\time, 0.9);
	("Stopping reverb feedback..").postln;
};

~activatePhones = { | value = false|
	[("~activatePhones"), value].postln;
	~sendToPhones = value;
};

~sinePattern = { |dur=8.0, lo=0.05, hi=0.5, repeats=inf|
	Pn(
		Pif(Ptime(inf) <= dur, Env.sine(dur).range(lo, hi)),
		repeats
	)
};

// Smooth 0..1 sine mapped to [lo, hi], driven by beats
~sineAtBeat = { |beats, cycleBeats = 16.0, lo = 0.05, hi = 0.5|
	var phase = (beats.asFloat / cycleBeats).frac;      // 0..1
	var u     = (phase * 2pi).cos.neg * 0.5 + 0.5;      // 0.5 - 0.5*cos(...), in 0..1
	lo + u * (hi - lo)
};

~sineAtBeatWithPhase = { |beats, cycleBeats = 16.0, lo = 0.05, hi = 0.5, phaseOffset = 0|
	var phase = ((beats.asFloat / cycleBeats) + phaseOffset).frac;
	var u = (phase * 2pi).cos.neg * 0.5 + 0.5;
	u.linlin(0, 1, lo, hi);
};



// Orchestrator: apply LFO state then push UI — replaces ~pushStateToUI.() in patch footers
// Note: during initial SETUP boot, ~applyLFOState is nil (defined later in lfo.scd during RUN).
// nil.() is a silent no-op in SC — lfo.scd calls ~applyLFOState.() itself after creating sources.
~applyPatch = {
	~applyLFOState.();
	~pushStateToUI.();
	// Fire the patch's declared OSC cues to VDMX (preset/scene switches not mapped to a
	// Dreads param). Runs on both UI load and file-execute since both call ~applyPatch.
	// A [\wait, seconds] entry pauses before the next cue — a dev-time workaround for VDMX
	// global-preset load latency; for a show, prefer baking full state into one preset.
	Routine({
		(~dreads.oscCues ? []).do { |cue|
			if (cue[0] == \wait) { cue[1].wait } { ~vis.().sendMsg(*cue) };
		};
	}).play;
};


// Broadcast a plaits voice's mute state to the visualiser (0-based, visual-out convention),
// so VDMX can clear/gate FX for a muted voice (the LFO reporter freezes muted voices).
~pushMuteToVis = { |i| ~vis.().sendMsg("/plaits/" ++ i ++ "/mute", ~dreads.synths[i].mute ? 0) };

// Custom event type for one-shot sample playback
// Never sends gate=0, synth is expected to free itself via doneAction
Event.addEventType(\oneShotSample, {
	var server = ~server ?? { Server.default };

	// ["oneShotSample event at", thisThread.beats, "dur =", ~dur].postln;

	// Build the synth - based on standard 'note' event type
	// but without storing the node for later gate-off
	if (~bufnum.notNil) {
		server.makeBundle(server.latency, {
			Synth(
				~instrument,
				[
					\out, ~out,
					\bufnum, ~bufnum,
					\mul, ~mul,
					\rate, ~rate,
					\startPos, ~startPos,
					\panDur, ~panDur,
					\atk, ~atk,
					\decay, ~decay,
					\gate, 1,
					\volume, ~volume,
					\cloudsSend, ~cloudsSend,
					\delaySend, ~delaySend,
					\reverbSend, ~reverbSend,
					\distDrive, ~distDrive,
					\distAmount, ~distAmount,
					\revDrywet, ~revDrywet,
					\revTime, ~revTime,
					\revDamp, ~revDamp,
					\revHp, ~revHp,
					\revFreeze, ~revFreeze,
					\rateLFO, ~rateLFO,
					\rateMod, ~rateMod,
					\volumeLFO, ~volumeLFO,
					\volumeMod, ~volumeMod
				],
				~group ?? { server.defaultGroup },
				\addToHead
			);
		});
	};

	// Return the delta time for the pattern to wait
	// ["oneShotSample returning delta:", ~dur].postln;
	~dur;
});

// Load sub-modules
(Document.current.dir ++ "/lib/utils/sequence.scd").load;
(Document.current.dir ++ "/lib/utils/patterns.scd").load;
(Document.current.dir ++ "/lib/utils/drone.scd").load;
(Document.current.dir ++ "/lib/utils/samples.scd").load;
(Document.current.dir ++ "/lib/utils/randomise.scd").load;
(Document.current.dir ++ "/lib/utils/fm.scd").load;
// (Document.current.dir ++ "/tempo.scd").load;
(Document.current.dir ++ "/lib/utils/tempo.scd").load;

)