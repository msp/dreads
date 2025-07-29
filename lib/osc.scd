//////////////////////////////////////////////////////////////////////////////
// Plaits OSC Setup - Dynamic OSC listener creation for all instances
//////////////////////////////////////////////////////////////////////////////
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

	// Special case: start/stop
	OSCdef.new(
		("plaitsStart" ++ instanceNum).asSymbol,
		{
			arg msg, time, addr, port;
			var value = msg[1];
			msg.postln;
			if (value == 1.0,
				{ x.play(~tempoClock) },
				{ x.stop }
			);
		},
		("/plaits/" ++ instanceNum ++ "/start").asString
	);

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
			[paramKey, value].postln;
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

// Push current state values to UI
~pushStateToUI = {
	~ui = NetAddr("127.0.0.1", 8080);

	~plaits.do { |instance, instanceIndex|
		var instanceNum = instanceIndex + 1;

		// Send all parameter values to UI
		instance.keys.select({ |key| key != \sequences }).do { |paramKey|
			var value = instance[paramKey];
			var path = "/plaits/" ++ instanceNum ++ "/" ++ paramKey;
			// ["Sending:", path, value].postln;
			~ui.sendMsg(path, value);
		};
	};
	"Plaits state pushed to UI!".postln;
};

// Catch-all OSCdef for debugging unhandled addresses
OSCdef.new(
	\catchAll,
	{
		arg msg, time, addr, port;
		["UNHANDLED OSC:", msg].postln;
	},
	nil  // matches any address - this will catch all unmatched messages
);

~pushStateToUI.value;
)