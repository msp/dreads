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
			cloudsSend: 0.0,
			decay: 0.33,
			delaySend: 0.0,
			distAmount: 0.19,
			distDrive: 0.3,
			dur: Rest(2.0),
			engine: 6.0,
			fmMod: -0.05,
			harm: 0.51,
			legato: 2.0,
			lpgColour: 0.5,
			morph: 0.3,
			morphMod: 0.0,
			mul: 0.5,
			pitch: 49.0,
			revDamp: 0.27,
			revDrywet: 0.28,
			revFreeze: 0.0,
			revHp: 0.19,
			revTime: 1.25,
			reverbSend: 0.91,
			sendToPhones: 0.0,
			stereoMode: 0.0,
			tempo: 125.0,
			timbMod: 0.0,
			timbre: 0.17,
			volume: 1.05
		),
			// $PRESET_SCALARS_END
			(
				// div: Pseq(1/8 ! 63 ++ (1.0), inf).asStream,
				div: Pseq(1/4 ! 64, inf).asStream,
				duration: Pseq([
					Pseq([Rest(1/2), 1/2], 1),
/*					Pwrand([Rest(1/2), 1/2], [0.2, 0.8].normalizeSum, 1),*/
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
			decay: 0.55,
			delaySend: 0.14,
			distAmount: 0.0,
			distDrive: 0.1,
			dur: 1.0,
			engine: 2.0,
			fmMod: 0.0,
			harm: 0.47,
			legato: 1.0,
			lpgColour: 0.5,
			morph: 0.49,
			morphMod: 0.21,
			mul: 0.5,
			pitch: 41.19,
			revDamp: 0.22,
			revDrywet: 0.26,
			revFreeze: 0.0,
			revHp: 0.16,
			revTime: 0.68,
			reverbSend: 0.89,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.0,
			timbre: 0.41,
			volume: 0.64
		),
			// $PRESET_SCALARS_END
			(
				// div: Pseq(1/! 127 ++ (1/4), inf).asStream,
				div: Pseq(1/2 ! 127, inf).asStream,
				duration: Pseq([
					Rest(1/2),
					Pwrand([Rest(1/2), 1/2], [0.2, 0.8].normalizeSum),
					Rest(1/2),
					Rest(1/2),
					Rest(1/2),
					Pwrand([Rest(1/2), 1/2], [0.3, 0.7].normalizeSum),
					Rest(1/2),
					Rest(1/2),
				], inf).asStream,
				engine: Pseq(["e", "e", "e", "e", "e", "e-2"], inf).asStream
			)
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.21,
			delaySend: 0.01,
			distAmount: 0.0,
			distDrive: 0.4,
			dur: 0.25,
			engine: 15.0,
			fmMod: 0.0,
			harm: 0.84,
			legato: 0.3,
			lpgColour: 0.5,
			morph: 0.15,
			morphMod: 0.51,
			mul: 0.5,
			pitch: 49.0,
			revDamp: 0.0,
			revDrywet: 0.13,
			revFreeze: 0.0,
			revHp: 0.13,
			revTime: 1.1,
			reverbSend: 0.08,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.39,
			timbre: 0.89,
			volume: 0.75
		),
			// $PRESET_SCALARS_END
			(
				// div: Pseq(1 ! 31 ++ (1/2), inf).asStream,
				div: Pseq(1 ! 8, inf).asStream,
				duration: Pseq([
					// Rest(2),
					Rest(1),
					Rest(0.25),
					0.25,
					Pwrand([Rest(1/4), 1/4], [0.2, 0.8].normalizeSum),
					Rest(0.25),
					0.25,
					Pwrand([Rest(1/4), 1/4], [0.7, 0.3].normalizeSum),
					Rest(0.25),
					Rest(0.25),
					Rest(1),
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
			delaySend: 0.45,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 4.0,
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
			volume: 1.13
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				div: Pseq(1 ! 15 ++ (0.5), inf).asStream,
				// div: Pseq(1 ! 64, inf).asStream,
				duration: Pseq([2], inf).asStream,
				delaySend: Pseq([
					Pwrand([0.7, 0.0], [0.7, 0.3]),
					0.0,
					0.5,
					0.0,
					Pwrand([0.5, 0.0], [0.7, 0.3]),
					0.0,
					Pwrand([0.5, 0.0], [0.7, 0.3]),
					0.0,
				], inf).asStream,
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
			volume: 0.0
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
			bankName: \SoundFX,
			cloudsSend: 0.0,
			decay: 0.2,
			delaySend: 0.88,
			distAmount: 0.48,
			distDrive: 0.0,
			dur: Rest(2.0),
			legato: 0.7,
			mul: 1.0,
			panDur: 0.5,
			rate: 0.48,
			revDamp: 0.0,
			revDrywet: 0.3,
			revFreeze: 0.0,
			revHp: 0.24,
			revTime: 0.66,
			reverbSend: 0.63,
			startPos: 0.46,
			tempo: 165.0,
			variant: 6.0,
			volume: 0.69
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				div: Pseq([1/4], inf).asStream,
				duration: Pseq([Rest(0.5), 0.5], inf).asStream,
				// rate: Pseq([0.1, 2, 1/3], inf).asStream,
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
		filterFreq: 675.09,
		spread: 1.5,
		time: 0.22
	),
	reverb: (
		damp: 0.2,
		diffuse: 0.63,
		freeze: 0.0,
		hp: 0.3,
		time: 0.49
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