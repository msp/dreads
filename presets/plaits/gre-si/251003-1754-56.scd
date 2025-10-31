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
			decay: 0.07,
			delaySend: 0.15,
			distAmount: 0.15,
			distDrive: 0.0,
			dur: 40.0,
			engine: 14.0,
			fmMod: 0.0,
			harm: 0.49,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.82,
			morphMod: 0.4,
			mul: 0.5,
			pitch: 53.73,
			revDamp: 0.08,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.0,
			revTime: 0.67,
			reverbSend: 0.29,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.0,
			timbre: 0.51,
			volume: 1.24
		),
			// $PRESET_SCALARS_END
			(
				timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
				decay: Pseq([0.1, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
				morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
				harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
				lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
				engine: Pseq(["e", "e", "e-5", "e", "e", "e-6"], inf).asStream,
				duration: Pseq([0.5,1,2,3,4,5], inf).asStream,
				div: Pseq([1/4, 2, 0.5, 1/8, 2], inf).asStream
				// duration: Pseq([
				// 	0.7,
				// 	Rest(0.7),
				// 	Rest(0.7),
				// 	Rest(0.7),
				// ], inf).asStream,
				// div: Pseq([1], inf).asStream
			)
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.1,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(0.7),
			engine: 13.0,
			fmMod: 0.0,
			harm: 0.56,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.6,
			morphMod: 0.8,
			mul: 0.5,
			pitch: 57.95,
			revDamp: 0.24,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.0,
			revTime: 0.73,
			reverbSend: 0.45,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.7,
			timbre: 0.73,
			volume: 0.95
		),
			// $PRESET_SCALARS_END
			(
				engine: Pseq([
					Pwrand(["e+4", "e"],     [0.2, 0.8].normalizeSum),
					"e+5",
					"e",
					"e",
					"e-6"
				], inf).asStream,
				duration: Pseq([
					0.7,
					Rest(0.7),
					Rest(0.7),
					Rest(0.7),
				], inf).asStream,
				div: Pseq([1], inf).asStream
/*				duration: Pseq([
				(1 ! 2),
				Rest(8),
				// Pgeom(1, 0.9, 20),
				// Pgeom(0.02, 1.1, 10),
				Rest(8),
				Pgauss(1.0, 0.3, 20),
				], inf).flatten.asStream,*/
			)
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.2,
			delaySend: 0.52,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 0.7,
			engine: 2.0,
			fmMod: 0.0,
			harm: 0.64,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.54,
			morphMod: 1.0,
			mul: 0.5,
			pitch: 56.03,
			revDamp: 0.35,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.14,
			revTime: 0.89,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 1.0,
			timbre: 0.47,
			volume: 0.86
		),
			// $PRESET_SCALARS_END
			(
/*				duration: Pseq([
					0.5,
					Rest(1.0),
					Rest(1.0),
					Pwrand([Rest(4), 1], [0.5, 0.5].normalizeSum),
				], inf).asStream,
				div: Pseq([3], inf).asStream*/
				duration: Pseq([
					0.7,
					Rest(1.4),
					Rest(1.4),
					Pwrand([Rest(2.8), 1.4], [0.5, 0.5].normalizeSum),
				], inf).asStream,
				div: Pseq([2], inf).asStream
			)
		)
	],
	// Samples array
	[],
	// Global FX settings
	// $PRESET_FX_START
(
	clouds: (
		blend: 0.31,
		density: 0.2,
		feedback: 0.14,
		freeze: 1.0,
		inGain: 1.0,
		lofi: 0.0,
		mix: 1.0,
		mode: 3.0,
		pitch: 25.99,
		position: 0.03,
		reverb: 0.1,
		size: 0.75,
		spread: 0.5,
		texture: 0.92,
		volume: 0.21
	),
	delay: (
		feedback: 0.96,
		filterFreq: 7545.34,
		spread: 1.5,
		time: 0.07
	),
	reverb: (
		damp: 0.2,
		diffuse: 0.63,
		freeze: 0.0,
		hp: 0.3,
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