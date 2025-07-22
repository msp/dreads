//////////////////////////////////////////////////////////////////////////////
// Plaits OSC Setup - Dynamic OSC listener creation for all instances
//////////////////////////////////////////////////////////////////////////////
(
OSCdef.freeAll;
s.defaultGroup.freeAll;

// Create OSC listeners for all instances and parameters
~plaits.do { |instance, instanceIndex|
	var instanceNum = instanceIndex + 1; // Convert to 1-based for OSC paths

	// Special case: start/stop
	OSCdef.new(
		("plaitsStart" ++ instanceNum).asSymbol,
		{
			arg msg, time, addr, port;
			var value = msg[1];
			msg.postln;
			if (value == 1.0,
				{ x.play },
				{ x.stop }
			);
		},
		("/plaits/" ++ instanceNum ++ "/start").asString
	);

	// Generic parameter handling - OSC keys match data structure keys
	instance.keys.select({ |key| key != \pattern }).do { |paramKey|
		OSCdef.new(
			("plaits" ++ instanceNum ++ paramKey).asSymbol,
			{
				arg msg, time, addr, port;
				var value = msg[1];
				msg.round(0.001).postln;

				// Special handling for speed (affects global tempo clock)
				if (paramKey == 'speed') {
					~plaits[instanceIndex].speed = value;
					~tempoClock.tempo = (value.max(0.1))/60;
				} {
					// Generic parameter update
					~plaits[instanceIndex][paramKey] = value;
				};
			},
			("/plaits/" ++ instanceNum ++ "/" ++ paramKey).asString
		);
	};
};
)