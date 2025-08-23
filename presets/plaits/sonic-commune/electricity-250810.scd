////////////////////////////////////////////////////////////////////////////////
// Plaits State - Template-based default preset
////////////////////////////////////////////////////////////////////////////////
(
~plaits = ~presetFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.5,
			decay: 0.13,
			delaySend: 0.13,
			distAmount: 0.16,
			distDrive: 0.0,
			dur: 8.68,
			engine: 2.0,
			fmMod: 0.34,
			harm: 0.85,
			legato: 0.8,
			lpgColour: 0.5,
			morph: 0.67,
			morphMod: 1.0,
			mul: 0.5,
			pitch: 42.14,
			revDamp: 0.15,
			revDrywet: 0.2,
			revFreeze: 0.0,
			revHp: 0.29,
			revTime: 0.93,
			reverbSend: 0.49,
			stereoMode: 1.0,
			tempo: 55.0,
			timbMod: 1.0,
			timbre: 0.66,
			volume: 1.44
		),
			// $PRESET_SCALARS_END
			(
				timbre: Pgauss(0.0, 1.0, inf).asStream,
				decay: Pgauss(0.0, 0.3, inf).asStream,
				morph: Pgbrown(1.0, 1.0, 1.0, inf).asStream,
				harm: Pgauss(0.0, 1.0, inf).asStream,
				// lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
				engine: Pseq(["e", "e", "e+6", "e", "e", "e+4"], inf).asStream,
				duration: Pgauss(1.0, 8.0, inf).asStream,
				div: Pseq([1.0], inf).asStream,
				reverbSend: Pgauss(0.0, 0.2, inf).asStream,
				// revTime: Pwhite(1.0, 1.2, inf).asStream,
			)
		),
		
		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.1,
			decay: 0.41,
			delaySend: 0.0,
			distAmount: 0.4,
			distDrive: 0.01,
			dur: 9.89,
			engine: 13.0,
			fmMod: 0.0,
			harm: 0.58,
			legato: 0.1,
			lpgColour: 0.5,
			morph: 1.0,
			morphMod: 0.8,
			mul: 0.7,
			pitch: 26.04,
			revDamp: 0.64,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.39,
			reverbSend: 0.6,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.7,
			timbre: 0.7,
			volume: 2.0
		),
			// $PRESET_SCALARS_END
			(
				duration: Pgauss(3.0, 4.0, inf).asStream,
				div: Pseq([0.5], inf).asStream
			)
		),
		
		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.3,
			decay: 0.77,
			delaySend: 0.19,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 7.58,
			engine: 15.0,
			fmMod: 0.0,
			harm: 0.76,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 1.0,
			morphMod: 1.0,
			mul: 0.5,
			pitch: 1.19,
			revDamp: 0.58,
			revDrywet: 0.58,
			revFreeze: 0.0,
			revHp: 0.45,
			revTime: 0.56,
			reverbSend: 0.74,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 1.0,
			timbre: 0.75,
			volume: 0.19
		),
			// $PRESET_SCALARS_END
			(
				duration: Pwhite(5.0, 10.0, inf).asStream,
				revTime: Pwhite(0.4, 1.1, inf).asStream,
			)
		)
	],
	// Global FX settings
	// $PRESET_FX_START
(
	clouds: (
		blend: 0.5,
		density: 0.7,
		feedback: 0.51,
		freeze: 0.0,
		inGain: 1.0,
		lofi: 0.0,
		mix: 1.0,
		mode: 3.0,
		pitch: 25.37,
		position: 0.69,
		reverb: 0.18,
		size: 0.21,
		spread: 0.5,
		texture: 0.91,
		volume: 0.0
	),
	delay: (
		feedback: 0.91,
		filterFreq: 6000.0,
		spread: 1.5,
		time: 0.23
	),
	reverb: (
		damp: 0.05,
		diffuse: 0.63,
		freeze: 0.0,
		hp: 0.2,
		time: 1.06
	)
),
	// $PRESET_FX_END
);

~states = Pseq([\a, \b, \c, \d], inf).asStream;
~state = ~states.next;
~playCount = 0;
~lfoSine = { |freq=0.2|
	var phase = 0;
	Pfunc {
		phase = phase + (freq * 2 * pi / 120); // adjust for your tempo
		(sin(phase) * 0.5) + 0.5; // unipolar 0-1
	}.asStream;
};

~timbreLFO = ~lfoSine.(3);
~morphLFO = ~lfoSine.(4);
~decayLFO = ~lfoSine.(1);
~tempoClock.tempo = ~plaits.synths[0].tempo/60;

~pushStateToUI.();
)