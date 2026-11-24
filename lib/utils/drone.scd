////////////////////////////////////////////////////////////////////////////////
// Drone Mode
//
// Persistent per-voice drone synth lifecycle: args, LFO bus mapping, start/
// update/stop. Split out of utils.scd. Loaded from the tail of utils.scd.
////////////////////////////////////////////////////////////////////////////////

(

// Settable [key, val, …] args for a drone: instance scalars that are \plaitsDrone controls,
// minus ~synthArgSpecials. mul is derived from mute. Shared by ~startDrone and ~updateDrone.
~droneArgs = { |i|
	var instance = ~dreads.synths[i];
	var droneControls = SynthDescLib.global.at(\plaitsDrone).controls.collect { |c| c.name };
	var args = [\mul, if (instance.mute == 1) { 0 } { instance.mul }];
	instance.keys.do { |key|
		if (droneControls.includes(key) and: { ~synthArgSpecials.includes(key).not }) {
			args = args ++ [key, instance[key]];
		};
	};
	args;
};

~mapDroneLFOBuses = { |i|
	~plaitsLFOParams.do { |param|
		~drones[i].map((param ++ "LFO").asSymbol, ~dreads.synths[i].lfo[param].bus);
	};
};

// Create a drone, releasing any existing one (→ Env.asr crossfade on an engine change).
~startDrone = { |i|
	if (~drones.notNil and: { ~drones[i].notNil }) {
		~drones[i].release;
		~drones[i] = nil;
	};

	~drones[i] = Synth(\plaitsDrone,
		[\out, ~voiceOutBus.(\plaits, i)] ++ ~droneArgs.(i),
		~voiceGroup, \addToHead);
	~mapDroneLFOBuses.(i);

	["Drone started for plaits", i].postln;
};

// Reapply params to a running drone in place — no re-trigger, so a same-engine variation
// switches seamlessly. Falls back to ~startDrone if none is running.
~updateDrone = { |i|
	if (~drones.notNil and: { ~drones[i].notNil }) {
		~drones[i].set(*~droneArgs.(i));
		~mapDroneLFOBuses.(i);
		["Drone updated (reused) for plaits", i].postln;
	} {
		~startDrone.(i);
	};
};

// Stop a persistent drone synth for a plaits instance
~stopDrone = { |i|
	if (~drones.notNil and: { ~drones[i].notNil }) {
		~drones[i].release;
		~drones[i] = nil;
		["Drone stopped for plaits", i].postln;
	};
};

)
