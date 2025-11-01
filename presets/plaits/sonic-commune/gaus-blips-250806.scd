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
			cloudsSend: 1.0,
			decay: 0.32,
			delaySend: 0.42,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 0.33,
			engine: 4.0,
			fmMod: 0.34,
			harm: 0.03,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.12,
			morphMod: 1.0,
			mul: 0.5,
			pitch: 67.06,
			revDamp: 0.15,
			revDrywet: 0.2,
			revFreeze: 0.0,
			revHp: 0.29,
			revTime: 0.93,
			reverbSend: 0.75,
			stereoMode: 1.0,
			tempo: 85.0,
			timbMod: 1.0,
			timbre: 0.43,
			volume: 0.0
		),
		// $PRESET_SCALARS_END
		(
			timbre: Pgauss(0.0, 1.0, inf).asStream,
			decay: Pgauss(0.0, 0.01, inf).asStream,
			morph: Pgbrown(1.0, 1.0, 1.0, inf).asStream,
			harm: Pgauss(0.0, 1.0, inf).asStream,
			// lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
			engine: Pseq(["e", "e", "e+5", "e", "e", "e+4"], inf).asStream,
			duration: Pgauss(0.01, 1.0, inf).asStream,
			// div: Pseq([1, 3, 1, 1, 2], inf).asStream,
			reverbSend: Pgauss(0.0, 0.2, inf).asStream,
			// revTime: Pwhite(1.0, 1.2, inf).asStream,
		)
	),
	
	// $PLAITS2
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.41,
			delaySend: 0.57,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 11.96,
			engine: 13.0,
			fmMod: 0.0,
			harm: 0.81,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.78,
			morphMod: 0.8,
			mul: 0.5,
			pitch: 26.04,
			revDamp: 0.8,
			revDrywet: 0.25,
			revFreeze: 0.0,
			revHp: 0.25,
			revTime: 0.56,
			reverbSend: 0.1,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.7,
			timbre: 0.44,
			volume: 0.0
		),
		// $PRESET_SCALARS_END
		(
			duration: Pgauss(1.0, 10.0, inf).asStream,
			div: Pseq([0.5], inf).asStream
		)
	),
	
	// $PLAITS3
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.77,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 9.68,
			engine: 15.0,
			fmMod: 0.0,
			harm: 0.48,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 1.0,
			morphMod: 1.0,
			mul: 0.5,
			pitch: 35.19,
			revDamp: 0.58,
			revDrywet: 0.58,
			revFreeze: 0.0,
			revHp: 0.45,
			revTime: 0.56,
			reverbSend: 0.74,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 1.0,
			timbre: 0.44,
			volume: 0.16
		),
		// $PRESET_SCALARS_END
		(
			duration: Pwhite(5.0, 10.0, inf).asStream,
			// div: Pseq([0.5], inf).asStream,
			revTime: Pwhite(0.4, 1.1, inf).asStream,
		)
	)
	],
	// Samples array
	[
		// $SAMPLE1
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(
			),
			// $PRESET_SAMPLE_SCALARS_END
			(
			)
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(
			),
			// $PRESET_SAMPLE_SCALARS_END
			(
			)
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(
			),
			// $PRESET_SAMPLE_SCALARS_END
			(
			)
		)
	],
	// Global FX settings
	// $PRESET_FX_START
(
	clouds: (
		blend: 0.72,
		density: 1.0,
		feedback: 0.64,
		freeze: 1.0,
		inGain: 1.0,
		lofi: 0.0,
		mix: 1.0,
		mode: 3.0,
		pitch: 13.46,
		position: 0.86,
		reverb: 0.52,
		size: 0.53,
		spread: 0.5,
		texture: 0.7,
		volume: 0.0
	),
	delay: (
		feedback: 0.91,
		filterFreq: 4055.84,
		spread: 1.5,
		time: 0.23
	),
	reverb: (
		damp: 0.05,
		diffuse: 0.63,
		freeze: 0.0,
		hp: 0.56,
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