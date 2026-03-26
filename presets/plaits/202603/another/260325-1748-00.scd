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
			decay: 1.0,
			delaySend: 0.41,
			distAmount: 0.13,
			distDrive: 0.3,
			dur: Rest(19.999999701977),
			engine: 0.0,
			fmMod: 0.06,
			harm: 0.34,
			legato: 0.9,
			lpgColour: 0.5,
			morph: 0.4,
			morphMod: 0.51,
			mul: 0.5,
			pitch: 22.16,
			revDamp: 0.27,
			revDrywet: 0.32,
			revFreeze: 0.0,
			revHp: 0.18,
			revTime: 1.14,
			reverbSend: 0.68,
			sendToPhones: 0.0,
			speed: 0.1,
			stereoMode: 0.0,
			tempo: 125.0,
			timbMod: 0.57,
			timbre: 0.61,
			volume: 0.13
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// div: Pseq(1/8 ! 64, inf).asStream,
				div: Pseq(1/8 ! 63 ++ (1.0), inf).asStream,
				// duration: Pseq([1/3], inf).asStream,
				duration: Pseq([
					// 0.25,
					// 0.25,
					// Pseq([0.25, Rest(0.25), 0.5], inf).asStream,
					// Rest(0.25),
					Pwrand([0.25, Rest(0.25)], [0.95, 0.05].normalizeSum),
					Rest(0.25),
					Rest(0.25),
					Pwrand([0.25, Rest(0.25)], [0.05, 0.95].normalizeSum),
					Rest(0.25),
					Pwrand([Rest(1/3), 1/3], [0.6, 0.4].normalizeSum),
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
					Pseq([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], 1),
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
			cloudsSend: 0.8,
			decay: 0.89,
			delaySend: 0.75,
			distAmount: 0.0,
			distDrive: 0.1,
			dur: 13.34,
			engine: 5.0,
			fmMod: 0.2,
			harm: 0.57,
			legato: 1.0,
			lpgColour: 0.5,
			morph: 0.44,
			morphMod: 0.03,
			mul: 0.5,
			pitch: 11.26,
			revDamp: 0.4,
			revDrywet: 0.71,
			revFreeze: 0.0,
			revHp: 0.33,
			revTime: 1.01,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 0.1,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.0,
			timbre: 0.38,
			volume: 0.32
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \gauss,

				// duration: Pseq([Rest(2), 2], inf).asStream,
				// duration: Pseq([1/2] * 2, inf).asStream,
				engine: Pseq(["e-1", "e", "e", "e", "e", "e"], inf).asStream,
				// engine: Pseq([0], inf).asStream,
			decay: \gauss,
			timbre: \hold,
			harm: \gauss,
			morph: \hold,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.0,
			decay: 0.34,
			delaySend: 0.34,
			distAmount: 0.03,
			distDrive: 0.1,
			dur: 1.0,
			engine: 13.0,
			fmMod: -0.25,
			harm: 0.39,
			legato: 0.1,
			lpgColour: 0.5,
			morph: 0.62,
			morphMod: 0.93,
			mul: 0.5,
			pitch: 49.92,
			revDamp: 0.0,
			revDrywet: 0.56,
			revFreeze: 0.0,
			revHp: 0.0,
			revTime: 0.9,
			reverbSend: 0.03,
			sendToPhones: 0.0,
			speed: 0.5,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.7,
			timbre: 0.68,
			volume: 0.18
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: Pseq(1 ! 63 ++ (0.5), inf).asStream,
				// div: Pseq([1], inf).asStream,
				duration: Pseq([
					0.25,
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					0.25,
					Rest(0.25),
					Rest(0.25),
					Pwrand([Rest(0.25), 0.25], [0.5, 0.5].normalizeSum),
				], inf).asStream,
				engine: Pseq(["e", "e", "e", "e", "e", "e-3"], inf).asStream,
				delaySend: \sweep,
				fmMod: \sweep,
				morph: \sweep,
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
			atk: 0.23,
			bankName: 'msp-iris-hits',
			cloudsSend: 0.0,
			decay: 0.1,
			delaySend: 0.1,
			distAmount: 0.1,
			distDrive: 0.0,
			dur: 8.0,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.1,
			rate: 0.52,
			revDamp: 0.56,
			revDrywet: 0.19,
			revFreeze: 0.0,
			revHp: 0.52,
			revTime: 0.3,
			reverbSend: 0.38,
			speed: 0.25,
			startPos: 0.01,
			tempo: 165.0,
			variant: 14.0,
			volume: 0.11
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				// div: Pseq([2, Rest(6)], inf).asStream,
				// div: Pseq(1 ! 31 ++ (0.5), inf).asStream,
				// duration: Pseq([2, 2, 2, 2, 2, 2, 2, Rest(1/2)], inf).asStream,
				// duration: Pseq([2, 2, 2, 2], inf).asStream,
				div: Pseq([1/8], inf).asStream,
				duration: Pseq([
					0.25,
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					0.25,
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
				], inf).asStream,
				rate: \updown,
				decay: \hold,
				delaySend: \gauss,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.51,
			bankName: 'msp-iris-hits',
			cloudsSend: 0.0,
			decay: 0.93,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(4.0),
			legato: 0.7,
			mul: 1.0,
			panDur: 0.15,
			rate: 0.93,
			revDamp: 0.5,
			revDrywet: 0.56,
			revFreeze: 0.0,
			revHp: 0.28,
			revTime: 0.61,
			reverbSend: 0.0,
			speed: 0.25,
			startPos: 0.0,
			tempo: 165.0,
			variant: 14.0,
			volume: 0.04
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				variant: Prand((0..19), inf).asStream,
				// duration: Pseq([8, Rest(8)]/2, inf).asStream,
				div: Pseq([1/4], inf).asStream,
				// duration: Pseq([0.25], inf).asStream
				duration: Pseq([
					Pwrand([Rest(0.25), 0.25], [0.5, 0.5].normalizeSum),
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
					Pwrand([Rest(0.25), 0.25], [0.5, 0.5].normalizeSum),
					Rest(0.25),
					Rest(0.25),
					Rest(0.25),
				], inf).asStream,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.33,
			bankName: 'msp-form-msp1',
			cloudsSend: 0.75,
			decay: 0.66,
			delaySend: 0.84,
			distAmount: 0.15,
			distDrive: 0.0,
			dur: 32.0,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.12,
			rate: 0.54,
			revDamp: 0.72,
			revDrywet: 0.33,
			revFreeze: 0.0,
			revHp: 0.2,
			revTime: 0.84,
			reverbSend: 0.9,
			speed: 0.25,
			startPos: 0.0,
			tempo: 165.0,
			variant: 1.0,
			volume: 0.0
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: Pseq([1/8], inf).asStream,
				// duration: Pseq([1/2, 1]/2, inf).asStream,
				rate: \gauss,

				// rate: Pseq([0.1, 2, 1/3], inf).asStream,
				startPos: \gauss,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		)
	],
	// Global FX settings
	// $PRESET_FX_START
(
	clouds: (
		blend: 0.5,
		density: 0.52,
		feedback: 0.48,
		freeze: 1.0,
		inGain: 1.0,
		lofi: 0.0,
		mix: 1.0,
		mode: 3.0,
		pitch: -9.19,
		position: 0.5,
		reverb: 0.29,
		size: 0.5,
		spread: 0.5,
		texture: 0.22,
		volume: 0.6
	),
	delay: (
		feedback: 0.92,
		filterFreq: 7149.62,
		spread: 1.22,
		time: 0.02
	),
	reverb: (
		damp: 0.0,
		diffuse: 0.12,
		freeze: 1.0,
		hp: 0.0,
		time: 1.03
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