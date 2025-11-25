////////////////////////////////////////////////////////////////////////////////
// Plaits State - Data structures and synth instance definitions
////////////////////////////////////////////////////////////////////////////////
(
~plaits = ~presetFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.91,
			decay: 0.21,
			delaySend: 0.21,
			distAmount: 0.15,
			distDrive: 0.3,
			dur: 2.0,
			engine: 13.0,
			fmMod: -0.25,
			harm: 0.15,
			legato: 0.9,
			lpgColour: 0.5,
			morph: 0.41,
			morphMod: 0.0,
			mul: 0.5,
			pitch: 52.02,
			revDamp: 0.27,
			revDrywet: 0.6,
			revFreeze: 0.0,
			revHp: 0.18,
			revTime: 1.08,
			reverbSend: 0.25,
			sendToPhones: 0.0,
			stereoMode: 0.0,
			tempo: 125.0,
			timbMod: 0.0,
			timbre: 0.89,
			volume: 0.0
		),
			// $PRESET_SCALARS_END
			(
				div: Pseq(1/8 ! 63 ++ (1.0), inf).asStream,
				// div: Pseq(1/8 ! 64, inf).asStream,
				duration: Pseq([
					0.25,
					Pseq([0.25, Rest(0.25), 0.5], inf).asStream,
					// Rest(0.25),
					Pwrand([0.25, Rest(0.25)], [0.95, 0.05].normalizeSum),
					Rest(0.25),
					Rest(0.25),
					Pwrand([0.25, Rest(0.25)], [0.95, 0.05].normalizeSum),
					Rest(0.25),
					Pwrand([Rest(0.25), 0.25], [0.6, 0.4].normalizeSum),
				], inf).asStream,
				// engine: Pseq(["e", "e+1", "e", "e", "e", "e"], inf).asStream,
				engine: Pseq(["e", "e", "e", "e", "e", "e"], inf).asStream,
				lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
				morph: Pseq([
					1.0,
					0.2,
					0.5,
					0.5,
					0.5,
					0.6,
					0.5,
					0.2,
				], inf).asStream,
				// distAmount: Pseq([0.8, 0.1, 0.3, 0.4], inf).asStream,
				distAmount: Pseq([
					Pseq([0.0, 0.3, 0.0, 0.0, 0.4, 0.0, 0.0, 0.0], 1),
					Pseq([0.0, 0.0, 0.1, 0.0, 0.1, 0.0, 0.0, 0.0], 1),
					Pseq([0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.0], 1)
				], inf).asStream,
				distDrive: Pseq([0.8, 0.3], inf).asStream,
				revDrywet: Pseq([0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], inf).asStream,
				delaySend: Pseq([
					Pseq([0.8, 0.0, 0.0, 0.0, 0.8, 0.0, 0.0, 0.0], 1),
					Pseq([0.0, 0.0, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0], 1),
					Pseq([0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.0], 1)
				], inf).asStream,
			)
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.26,
			delaySend: 0.59,
			distAmount: 0.0,
			distDrive: 0.1,
			dur: 0.67,
			engine: 11.0,
			fmMod: 0.0,
			harm: 1.0,
			legato: 1.0,
			lpgColour: 0.5,
			morph: 0.81,
			morphMod: 0.7,
			mul: 0.5,
			pitch: 46.0,
			revDamp: 0.21,
			revDrywet: 0.3,
			revFreeze: 0.0,
			revHp: 0.0,
			revTime: 1.14,
			reverbSend: 0.18,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.9,
			timbre: 0.37,
			volume: 0.0
		),
			// $PRESET_SCALARS_END
			(
				duration: Pseq([1/3] * 2, inf).asStream,
				// duration: Pseq([1/2] * 2, inf).asStream,
				engine: Pseq(["e", "e", "e", "e", "e", 0], inf).asStream
			)
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.0,
			delaySend: 0.09,
			distAmount: 0.2,
			distDrive: 0.4,
			dur: Rest(1.0),
			engine: 15.0,
			fmMod: 0.0,
			harm: 0.0,
			legato: 0.9,
			lpgColour: 0.5,
			morph: 0.0,
			morphMod: 0.93,
			mul: 0.5,
			pitch: 49.0,
			revDamp: 0.0,
			revDrywet: 0.82,
			revFreeze: 0.0,
			revHp: 0.13,
			revTime: 0.9,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.7,
			timbre: 0.59,
			volume: 0.19
		),
			// $PRESET_SCALARS_END
			(
				div: Pseq(1/4 ! 63 ++ (0.5), inf).asStream,
				duration: Pseq([
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					0.25,
				], inf).asStream,
				engine: Pseq(["e", "e", "e", "e", "e", "e-1"], inf).asStream
			)
		)
	],
	// Samples array
	[
		// $SAMPLE1
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.0,
			bankName: \impacts,
			cloudsSend: 0.0,
			decay: 0.49,
			delaySend: 0.73,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 2.0,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.57,
			rate: 1.65,
			revDamp: 0.66,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.22,
			revTime: 0.3,
			reverbSend: 0.0,
			startPos: 0.0,
			tempo: 165.0,
			variant: 0.0,
			volume: 1.2
		),
			// $PRESET_SAMPLE_SCALARS_END
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
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.3,
			bankName: \hum,
			cloudsSend: 0.0,
			decay: 0.01,
			delaySend: 0.8,
			distAmount: 0.31,
			distDrive: 0.0,
			dur: 64.0,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.5,
			rate: 3.19,
			revDamp: 0.0,
			revDrywet: 0.8,
			revFreeze: 0.0,
			revHp: 0.48,
			revTime: 1.1,
			reverbSend: 0.0,
			startPos: 0.0,
			tempo: 165.0,
			variant: 1.0,
			volume: 0.1
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				div: Pseq([1/16], inf).asStream,
				duration: Pseq([8, Rest(8)]/2, inf).asStream,
			)
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.0,
			bankName: \default,
			cloudsSend: 0.0,
			decay: 0.61,
			delaySend: 0.24,
			distAmount: 0.62,
			distDrive: 0.0,
			dur: 0.25,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.5,
			rate: 2.01,
			revDamp: 0.0,
			revDrywet: 0.69,
			revFreeze: 0.0,
			revHp: 0.01,
			revTime: 0.94,
			reverbSend: 0.63,
			startPos: 0.0,
			tempo: 165.0,
			variant: 0.0,
			volume: 0.33
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				div: Pseq([1, 1, 1, 1], inf).asStream,
				duration: Pseq([1/2, 1]/2, inf).asStream,
				rate: Pseq([0.1, 2, 1/3], inf).asStream,
			)
		)
	],
	// Global FX settings
	// $PRESET_FX_START
(
	clouds: (
		blend: 0.5,
		density: 0.7,
		feedback: 0.37,
		freeze: 0.0,
		inGain: 1.0,
		lofi: 0.0,
		mix: 1.0,
		mode: 3.0,
		pitch: 6.28,
		position: 0.5,
		reverb: 0.0,
		size: 0.5,
		spread: 0.5,
		texture: 0.5,
		volume: 0.75
	),
	delay: (
		feedback: 0.57,
		filterFreq: 554.69,
		spread: 1.5,
		time: 0.22
	),
	reverb: (
		damp: 0.2,
		diffuse: 0.63,
		freeze: 0.0,
		hp: 0.3,
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
~tempoClock.tempo = ~plaits.synths[0].tempo/60;

~pushStateToUI.();
) 