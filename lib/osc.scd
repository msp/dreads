//////////////////////////////////////////////////////////////////////////////
// Plaits OSC Setup - Dynamic OSC listener creation for all instances
//////////////////////////////////////////////////////////////////////////////

OSCFunc.trace(true, hideStatusMsg: true); // Turn posting on
OSCFunc.trace(false); // Turn posting off

(
OSCdef.freeAll;
s.defaultGroup.freeAll;

OSCdef.new(
	\startStop,
	{
		arg msg, time, addr, port;
		var value = msg[1];
		msg.postln;
		if (value == 1.0,
			{ x.play(~tempoClock) },
			{ x.stop }
		);
	},
	"/plaits/start"
);

// Create OSC listeners for all instances and parameters
~plaits.do { |instance, instanceIndex|
	var instanceNum = instanceIndex + 1; // Convert to 1-based for OSC paths

	["binding plaits ------------------->", instanceIndex].postln;
	// Generic parameter handling - OSC keys match data structure keys
	instance.keys.select({ |key| key != \pattern }).do { |paramKey|
		// ["binding key", paramKey].postln;
		OSCdef.new(
			("plaits" ++ instanceNum ++ paramKey).asSymbol,
			{
				arg msg, time, addr, port;
				var value = msg[1];
				msg.round(0.001).postln;

				// Special handling for tempo (affects global tempo clock)
				if (paramKey == 'tempo') {
					~plaits[instanceIndex].tempo = value;
					~tempoClock.tempo = (value.max(0.1))/60;
				} {
					// Generic parameter update
					~plaits[instanceIndex][paramKey] = value;
				};
			},
			"/plaits/" ++ instanceNum ++ "/" ++ paramKey.asString
		);
	};
};

// Delay Effect OSC Handlers
[\delayTime, \feedback, \filterFreq, \spread].do { |paramKey|
	['binding delay->', paramKey].postln;
	OSCdef.new(
		("delay" ++ paramKey).asSymbol,
		{
			arg msg, time, addr, port;
			var value = msg[1];
			["dly", paramKey, value].postln;
			if (~delayFX.notNil) {
				~delayFX.set(paramKey, value);
				// ["Set", paramKey, "to", value].postln;
			} {
				"ERROR: ~delayFX is nil!".postln;
			};
		},
		"/delay/" ++ paramKey.asString
	);
};

// Global Reverb Effect OSC Handlers
[\time, \damp, \hp, \diffuse, \freeze].do { |paramKey|
	['binding reverb->', paramKey].postln;
	OSCdef.new(
		("reverb" ++ paramKey).asSymbol,
		{
			arg msg, time, addr, port;
			var value = msg[1];
			["rvb", paramKey, value].postln;
			if (~reverbFX.notNil) {
				~reverbFX.set(paramKey, value);
			} {
				"ERROR: ~reverbFX is nil!".postln;
			};
		},
		"/reverb/" ++ paramKey.asString
	);
};

OSCdef.new(
	\loadPreset.asSymbol,
	{
		arg msg, time, addr, port;
		var value = msg[1];
		["loadPreset", value].postln;
		~loadPreset.(value.asString)
	},
	"/loadPreset"
);

OSCdef.new(
	\savePreset.asSymbol,
	{
		arg msg, time, addr, port;
		var value = msg[1];
		["savePreset", value].postln;
		~savePreset.()
	},
	"/savePreset"
);

OSCdef.new(
	\savePresetAs.asSymbol,
	{
		arg msg, time, addr, port;
		var value = msg[1];
		["savePresetAs", value].postln;
		~savePresetAs.()
	},
	"/savePresetAs"
);

// Push current state values to UI
~pushStateToUI = {
	var ui = ~ui.();

	~plaits.do { |instance, instanceIndex|
		var instanceNum = instanceIndex + 1;

		// Send all parameter values to UI
		instance.keys.select({ |key| key != \sequences }).do { |paramKey|
			var value = instance[paramKey];
			var path = "/plaits/" ++ instanceNum ++ "/" ++ paramKey;
			// ["Sending:", path, value].postln;
			ui.sendMsg(path, value);
		};
	};
	"Plaits state pushed to UI!".postln;
};

// Debug OSCFunc for catching missed messages
OSCFunc({ |msg, time, addr, port|
	var path = msg[0];
	// Only show messages that might be typos in our namespaces
	if (path.asString.contains("/plaits") ||
	    path.asString.contains("/delay") ||
	    path.asString.contains("/reverb") ||
	    path.asString.contains("/preset")) {
		["POSSIBLE TYPO:", msg].postln;
	};
});

~pushStateToUI.value;
)