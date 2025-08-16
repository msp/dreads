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
~setupPlaitsOSC = {
	~plaits.synths.do { |instance, instanceIndex|
		var instanceNum = instanceIndex + 1; // Convert to 1-based for OSC paths

		["binding plaits ------------------->", instanceIndex].postln;
		// Generic parameter handling - OSC keys match data structure keys
		instance.keys.select({ |key| key != \sequences }).do { |paramKey|
			// ["binding key", paramKey].postln;
			OSCdef.new(
				("plaits" ++ instanceNum ++ paramKey).asSymbol,
				{
					arg msg, time, addr, port;
					var value = msg[1];
					msg.round(0.001).postln;

					// Special handling for tempo (affects global tempo clock)
					if (paramKey == 'tempo') {
						~plaits.synths[instanceIndex][paramKey] = value;
						~tempoClock.tempo = (value.max(0.1))/60;
					} {
						// Generic parameter update
						~plaits.synths[instanceIndex][paramKey] = value;
					};
				},
				"/plaits/" ++ instanceNum ++ "/" ++ paramKey.asString
			);
		};
	};
};

// Delay Effect OSC Handlers
[\time, \feedback, \filterFreq, \spread].do { |paramKey|
	['binding fx/delay->', paramKey].postln;
	OSCdef.new(
		("fx_delay_" ++ paramKey).asSymbol,
		{
			arg msg, time, addr, port;
			var value = msg[1];
			var synthParam = ("fx_delay_" ++ paramKey).asSymbol;
			["fx/delay", paramKey, value].postln;

			// Update preset FX settings (nested structure)
			~plaits.fx.delay[paramKey] = value;

			// Send to synth using clean parameter names
			if (~delayFX.notNil) {
				~delayFX.set(paramKey, value);
			} {
				"ERROR: ~delayFX is nil!".postln;
			};
		},
		"/fx/delay/" ++ paramKey.asString
	);
};

// Global Reverb Effect OSC Handlers
[\time, \damp, \hp, \diffuse, \freeze].do { |paramKey|
	['binding fx/reverb->', paramKey].postln;
	OSCdef.new(
		("fx_reverb_" ++ paramKey).asSymbol,
		{
			arg msg, time, addr, port;
			var value = msg[1];
			var synthParam = ("fx_reverb_" ++ paramKey).asSymbol;
			["fx/reverb", paramKey, value].postln;

			// Update preset FX settings (nested structure)
			~plaits.fx.reverb[paramKey] = value;

			// Send to synth using clean parameter names
			if (~reverbFX.notNil) {
				~reverbFX.set(paramKey, value);
			} {
				"ERROR: ~reverbFX is nil!".postln;
			};
		},
		"/fx/reverb/" ++ paramKey.asString
	);
};

// Global Clouds Effect OSC Handlers
[\blend, \density, \freeze, \pitch, \position, \size, \texture, \reverb, \feedback, \spread, \inGain, \mode, \lofi, \volume].do { |paramKey|
	['binding fx/clouds->', paramKey].postln;
	OSCdef.new(
		("fx_clouds_" ++ paramKey).asSymbol,
		{
			arg msg, time, addr, port;
			var value = msg[1];
			var synthParam = ("fx_clouds_" ++ paramKey).asSymbol;
			["fx/clouds", paramKey, value].postln;

			// Update preset FX settings (nested structure)
			~plaits.fx.clouds[paramKey] = value;

			// Send to synth using clean parameter names
			if (~cloudsFX.notNil) {
				~cloudsFX.set(paramKey, value);
			} {
				"ERROR: ~cloudsFX is nil!".postln;
			};
		},
		"/fx/clouds/" ++ paramKey.asString
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

OSCdef.new(
	\fadeOutReverb,
	{
		arg msg, time, addr, port;
		var value = msg[1];
		"fadeOutReverb".postln;
		~fadeOutReverb.()
	},
	"/fadeOutReverb"
);

// Push current state values to UI
~pushStateToUI = {
	var ui, plaitsArray, fxSettings;

	ui = ~ui.();

	// Get current synth and FX data with fallback for compatibility
	if (~plaits.isKindOf(Dictionary)) {
		plaitsArray = ~plaits.synths;
		fxSettings = ~plaits.fx ?? ();
	} {
		plaitsArray = ~plaits; // Old array format fallback
		fxSettings = ();
	};

	// Send synth instance parameters
	plaitsArray.do { |instance, instanceIndex|
		var instanceNum = instanceIndex + 1;

		// Send all parameter values to UI
		instance.keys.select({ |key| key != \sequences }).do { |paramKey|
			var value = instance[paramKey];
			var path = "/plaits/" ++ instanceNum ++ "/" ++ paramKey;
			["Sending:", path, value].postln;
			ui.sendMsg(path, value);
		};
	};

	// Send global FX parameters (nested structure)
	fxSettings.keysValuesDo { |category, categoryParams|
		categoryParams.keysValuesDo { |param, value|
			var path = "/fx/" ++ category ++ "/" ++ param;
			["Sending:", path, value].postln;
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
	    path.asString.contains("/clouds") ||
	    path.asString.contains("/preset")) {
		["POSSIBLE TYPO:", msg].postln;
	};
});

// Setup OSC for plaits instances (called after preset structure is loaded)
~setupPlaitsOSC.();

~pushStateToUI.value;
)