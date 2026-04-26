////////////////////////////////////////////////////////////////////////////////
// Plaits State - Data structures and synth instance definitions
////////////////////////////////////////////////////////////////////////////////
(
~dreads = ~presetFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.0,
			decay: 0.27,
			delaySend: 0.0,
			distAmount: 0.11,
			distDrive: 0.3,
			dur: 4.0,
			engine: 2.0,
			fmMod: -0.33,
			harm: 0.6,
			legato: 0.9,
			lpgColour: 0.5,
			morph: 0.4,
			morphMod: 0.51,
			mul: 0.5,
			pitch: 52.02,
			revDamp: 0.0,
			revDrywet: 0.85,
			revFreeze: 0.0,
			revHp: 0.41,
			revTime: 1.03,
			reverbSend: 0.19,
			sendToPhones: 0.0,
			speed: 0.5,
			stereoMode: 0.0,
			tempo: 125.0,
			timbMod: 0.57,
			timbre: 1.0,
			volume: 0.07
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: Pseq(1/8 ! 63 ++ (1.0), inf).asStream,
				// div: Pseq(1/8 ! 64, inf).asStream,
				duration: Pseq([
					Rest(0.25),
					Rest(0.25),
					0.25,
					Pseq([0.25, Rest(0.25), 0.5], inf).asStream,
					// Rest(0.25),
					Pwrand([0.25, Rest(0.25)], [0.95, 0.05].normalizeSum),
					Rest(0.25),
					Rest(0.25),
					Pwrand([0.25, Rest(0.25)], [0.95, 0.05].normalizeSum),
					Rest(0.25),
					// Pwrand([Rest(0.25), 0.25], [0.6, 0.4].normalizeSum),
				], inf).asStream,
				// engine: Pseq(["e", "e+1", "e", "e", "e", "e"], inf).asStream,
				engine: Pseq(["e", "e", "e+6", "e", "e+2", "e"], inf).asStream,
				// lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
				// morph: Pseq([
				// 	1.0,
				// 	0.2,
				// 	0.5,
				// 	0.5,
				// 	0.5,
				// 	0.6,
				// 	0.5,
				// 	0.2,
				// ], inf).asStream,
				// distAmount: Pseq([0.8, 0.1, 0.3, 0.4], inf).asStream,
				distAmount: Pseq([
					Pseq([0.0, 0.3, 0.0, 0.0, 0.4, 0.0, 0.0, 0.0], 1),
					Pseq([0.0, 0.0, 0.1, 0.0, 0.1, 0.0, 0.0, 0.0], 1),
					Pseq([0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.0], 1)
				], inf).asStream,
				distDrive: Pseq([0.8, 0.3], inf).asStream,
				revDrywet: Pseq([0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], inf).asStream,
				delaySend: Pseq([
					Pseq([0.6, 0.0, 0.0, 0.0, 0.6, 0.0, 0.0, 0.0], 1),
					Pseq([0.0, 0.0, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0], 1),
					Pseq([0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.0], 1)
				], inf).asStream,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.04,
			delaySend: 0.31,
			distAmount: 0.0,
			distDrive: 0.1,
			dur: 2.0,
			engine: 0.0,
			fmMod: 0.01,
			harm: 0.31,
			legato: 1.0,
			lpgColour: 0.5,
			morph: 0.49,
			morphMod: 0.0,
			mul: 0.5,
			pitch: 46.0,
			revDamp: 0.0,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.35,
			revTime: 1.1,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 1.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.23,
			timbre: 0.38,
			volume: 0.63
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: Pseq([0.5], inf).asStream,
				duration: Pseq([Rest(1), 2], inf).asStream,
				// duration: \sparse,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.0,
			decay: 0.38,
			delaySend: 0.69,
			distAmount: 0.0,
			distDrive: 0.4,
			dur: 0.5,
			engine: 13.0,
			fmMod: 0.0,
			harm: 0.82,
			legato: 0.1,
			lpgColour: 0.5,
			morph: 0.42,
			morphMod: 0.0,
			mul: 0.5,
			pitch: 28.63,
			revDamp: 0.0,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.13,
			revTime: 0.9,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 0.5,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.0,
			timbre: 0.84,
			volume: 1.63
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: Pseq([0.5], inf).asStream,
				// div: Pseq(1/4 ! 63 ++ (0.5), inf).asStream,
				duration: Pseq([
					0.25,
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					// Rest(0.25),
					// Rest(0.25),
					// Rest(0.25),
					// Rest(0.25),
				], inf).asStream,
				engine: Pseq(["e", "e", "e", "e", "e"], inf).asStream
			)
			// $PRESET_SEQUENCES_END
		)
	],
	// Samples array
	[
		// $SAMPLE1
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.6,
			bankName: \halfmastv6,
			cloudsSend: 0.85,
			decay: 0.74,
			delaySend: 0.92,
			distAmount: 1.0,
			distDrive: 0.0,
			dur: 4.0,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.57,
			rate: 1.0,
			revDamp: 0.4,
			revDrywet: 0.89,
			revFreeze: 0.0,
			revHp: 0.46,
			revTime: 1.19,
			reverbSend: 0.95,
			speed: 0.5,
			startPos: 0.01,
			tempo: 165.0,
			variant: 0.0,
			volume: 0.0
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				// div: Pseq([2, Rest(6)], inf).asStream,
				div: Pseq(1 ! 31 ++ (0.5), inf).asStream,
				// duration: Pseq([2, 2, 2, 2, 2, 2, 2, Rest(1/2)], inf).asStream,
				duration: Pseq([2, 2, 2, 2], inf).asStream,
/*				div: Pseq(1 ! 63 ++ (0.5), inf).asStream,
				duration: Pseq([
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					0.25,
				], inf).asStream,*/
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.26,
			bankName: \HATS,
			cloudsSend: 0.0,
			decay: 0.04,
			delaySend: 0.0,
			distAmount: 0.62,
			distDrive: 0.0,
			dur: Rest(0.25),
			legato: 0.7,
			mul: 1.0,
			panDur: 0.1,
			rate: 3.42,
			revDamp: 0.47,
			revDrywet: 0.99,
			revFreeze: 0.0,
			revHp: 0.71,
			revTime: 0.87,
			reverbSend: 0.07,
			speed: 1.0,
			startPos: 0.0,
			tempo: 165.0,
			variant: 4.0,
			volume: 0.02
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				// rate: Pgeom(1.0, 1.01, inf).asStream,
				rate: Pseq([
					Pgeom(1.0, 1.01, 50),
					Pgeom(1.628, 0.99, 50)
				], inf).asStream,
				duration: Pseq([
					1/4,
					Rest(1/4),
					Rest(1/4),
					Rest(1/4),
				], inf).asStream,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.91,
			bankName: \HATS,
			cloudsSend: 0.0,
			decay: 1.0,
			delaySend: 0.12,
			distAmount: 0.21,
			distDrive: 0.0,
			dur: 0.5,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.12,
			rate: 1.33,
			revDamp: 0.0,
			revDrywet: 1.0,
			revFreeze: 0.0,
			revHp: 0.42,
			revTime: 0.55,
			reverbSend: 0.0,
			speed: 1.0,
			startPos: 0.2,
			tempo: 165.0,
			variant: 0.0,
			volume: 0.0
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: Pseq([2], inf).asStream,
				// duration: Pseq([1/2, 1]/2, inf).asStream,
				rate: Pseq([0.1, 2, 1/3], inf).asStream,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		)
	],
	// Global FX settings
	// $PRESET_FX_START
(
	clouds: (
		blend: 0.5,
		density: 0.7,
		feedback: 0.22,
		freeze: 0.0,
		inGain: 1.0,
		lofi: 0.0,
		mix: 1.0,
		mode: 3.0,
		pitch: 32.57,
		position: 0.5,
		reverb: 0.0,
		size: 0.5,
		spread: 0.5,
		texture: 0.5,
		volume: 0.46
	),
	delay: (
		feedback: 0.52,
		filterFreq: 3894.41,
		spread: 0.5,
		time: 0.23
	),
	reverb: (
		damp: 0.58,
		diffuse: 0.49,
		freeze: 0.0,
		hp: 0.49,
		time: 0.66
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

~timbreLFO = ~lfoSine.(2);
~morphLFO = ~lfoSine.(4);
~decayLFO = ~lfoSine.(1);
~tempoClock.tempo = ~dreads.synths[0].tempo/60;

~pushStateToUI.();
) 