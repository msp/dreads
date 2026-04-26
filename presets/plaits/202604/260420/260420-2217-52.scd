////////////////////////////////////////////////////////////////////////////////
// Plaits State - Template-based default preset with global FX
////////////////////////////////////////////////////////////////////////////////
(
~dreads = ~presetFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.17, decay: 0.04, delaySend: 0.06, distAmount: 0.08, distDrive: 0.03, droneMode: 0.0, dur: 2.0, engine: 3.0, fmMod: -0.06, harm: 0.09, legato: 6.31, lpgColour: 0.92, morph: 0.78, morphMod: 0.07, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 72.0, revDamp: 0.27, revDrywet: 0.38, revFreeze: 0.0, revHp: 0.18, revTime: 0.5, reverbSend: 0.2, sendToPhones: 0.0, speed: 1.0, stereoMode: 0.0, tempo: 175.0, timbMod: 0.38, timbre: 0.07, volume: 1.28),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				timbre: \hold,

				// timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
				decay: \hold,

				// decay: Pseq([0.5, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
				// decay: \gauss,
				morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
				harm: \hold,

				// harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
				lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
				engine: Pseq(["e", "e", "e-13", "e", "e", "e-14"], inf).asStream,
				// duration: \gauss,

				duration: Pseq([2], inf).asStream,

				// duration: Pseq([
				// 0.7,
				// Pwrand([0.7, Rest(0.7)], [0.9, 0.1].normalizeSum),
				// 0.7,
				// Pwrand([0.7, Rest(1.4)], [0.95, 0.05].normalizeSum),
				// 0.7,
				// Pwrand([1.4, 0.7], [0.6, 0.4].normalizeSum),
				// ], inf).asStream,
				div: Pseq([1, 2, 1, 1, 2], inf).asStream,
				pitch: \hold,
				distAmount: \gate_every16,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.0, decay: 0.91, delaySend: 0.22, distAmount: 0.0, distDrive: 0.1, droneMode: 0.0, dur: Rest(4.0), engine: 11.0, fmMod: 0.0, harm: 1.0, legato: 1.0, lpgColour: 0.5, morph: 0.81, morphMod: 0.64, mul: 0.5, mute: 1.0, phaseOffset: 0.5, pitch: 58.4, revDamp: 0.0, revDrywet: 0.07, revFreeze: 0.0, revHp: 0.34, revTime: 1.14, reverbSend: 0.0, sendToPhones: 0.0, speed: 0.25, stereoMode: 1.0, tempo: 175.0, timbMod: 0.83, timbre: 0.71, volume: 0.54),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: Pseq([
					1/2,
					Rest(1/2),
					Rest(1/2),
					Pwrand([Rest(1/2), 1/2], [0.9, 0.1].normalizeSum),
				], inf).asStream,
				div: Pseq([1/2], inf).asStream,
				harm: \hold,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.02, decay: 0.25, delaySend: 0.12, distAmount: 0.06, distDrive: 0.1, droneMode: 0.0, dur: Rest(0.5), engine: 16.0, fmMod: -0.09, harm: 0.27, legato: 8.26, lpgColour: 0.12, morph: 0.6, morphMod: 0.39, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 57.0, revDamp: 0.0, revDrywet: 0.29, revFreeze: 0.0, revHp: 0.13, revTime: 0.36, reverbSend: 0.22, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 175.0, timbMod: 0.05, timbre: 0.51, volume: 0.92),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: Pseq([0.5], inf).asStream,
				duration: \eucl_5_16,

				// duration: Pseq([
				// 0.25,
				// Rest(0.5),
				// 0.5,
				// Rest(0.25),
				// Rest(0.25),
				// Pwrand([Rest(1/4), 1/4], [0.9, 0.1].normalizeSum),
				// ] , inf).asStream,
				harm: \hold,
			)
			// $PRESET_SEQUENCES_END
		)
	],
	// Samples array
	[
		// $SAMPLE1
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.0, bankName: 'msp-iris-hits', cloudsSend: 0.0, decay: 0.34, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 5.0, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.01, phaseOffset: 0.0, rate: 4.27, revDamp: 0.58, revDrywet: 0.48, revFreeze: 0.0, revHp: 0.33, revTime: 0.75, reverbSend: 0.05, speed: 0.1, startPos: 0.0, tempo: 175.0, variant: 6.0, volume: 0.51),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				distAmount: \hold,
				rate: \hold,
				//main
				duration: Pseq([
					Pwrand([Rest(1/2), 1/2], [0.6, 0.4].normalizeSum),
					Pwrand([Rest(1/2), 1/2], [0.6, 0.4].normalizeSum),
					1/2,
					Pwrand([Rest(1/2), 1/2], [0.2, 0.8].normalizeSum),
					1/2,
					Pwrand([Rest(1/2), 1/2], [0.5, 0.5].normalizeSum),
					Pwrand([Rest(1/2), 1/2], [0.2, 0.8].normalizeSum),
					// 1/2,
				], inf).asStream,
				// sparse
				// duration: Pseq([
				// 	Pwrand([Rest(1/2), 1/2], [0.9, 0.1].normalizeSum),
				// 	Pwrand([Rest(1/2), 1/2], [0.8, 0.2].normalizeSum),
				// 	Rest(1/2),
				// 	Pwrand([Rest(1/2), 1/2], [0.8, 0.2].normalizeSum),
				// 	1/2,
				// 	Pwrand([Rest(1/2), 1/2], [0.5, 0.5].normalizeSum),
				// 	Rest(1/2),
				// 	// 1/2,
				// ], inf).asStream,
				// div: Pseq(1 ! 63 ++ 0.5, inf).asStream,
				// variant: Prand((0..19), inf).asStream,
				variant: Pseq(
					[
						Pseq((8..15), 5),
						Pseq((10..15), 8),
						Pseq([9], 3)
					],
					inf).asStream,
				// variant: Pseq((8..15).rand, inf).asStream,
			div: \unit,
			mul: \unit,
			decay: \gate_every8,
			revDrywet: \gate_prob50,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.56, bankName: 'msp-form-msp6', cloudsSend: 0.0, decay: 0.79, delaySend: 0.22, distAmount: 0.06, distDrive: 0.0, dur: 64.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.09, phaseOffset: 1.0, rate: 0.5, revDamp: 0.0, revDrywet: 0.84, revFreeze: 0.0, revHp: 0.31, revTime: 0.93, reverbSend: 0.68, speed: 0.25, startPos: 0.33, tempo: 175.0, variant: 3.0, volume: 0.16),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				duration: \hold,
				div: Pseq([1/32], inf).asStream,
				// variant: Pseq((0..2), inf).asStream,
			startPos: \gauss,
			rate: \unit,
			mul: \unit,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.0, bankName: 'msp-iris-hits', cloudsSend: 0.0, decay: 0.01, delaySend: 0.15, distAmount: 0.0, distDrive: 0.0, dur: Rest(2.0), legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.03, phaseOffset: 0.0, rate: 1.11, revDamp: 0.0, revDrywet: 0.65, revFreeze: 0.0, revHp: 0.01, revTime: 1.16, reverbSend: 0.0, speed: 0.25, startPos: 0.0, tempo: 175.0, variant: 4.0, volume: 0.63),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				rate: \gauss,
				duration: Pseq([
					Pwrand([Rest(1/2), 1/2], [0.5, 0.5].normalizeSum),
					Pwrand([Rest(1/2), 1/2], [0.5, 0.5].normalizeSum),
					1/2,
					Pwrand([Rest(1/2), 1/2], [0.8, 0.2].normalizeSum),
					1/2,
					Pwrand([Rest(1/2), 1/2], [0.5, 0.5].normalizeSum),
					Rest(1/2),
					//1/2,
				], inf).asStream,
				delaySend: \euclid,
			div: \unit,
			mul: \unit,
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
		feedback: 0.75,
		filterFreq: 3827.74,
		spread: 1.0,
		time: 0.07
	),
	reverb: (
		damp: 0.2,
		diffuse: 0.63,
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

~timbreLFO = ~lfoSine.(3);
~morphLFO = ~lfoSine.(4);
~decayLFO = ~lfoSine.(1);
~tempoClock.tempo = ~dreads.synths[0].tempo/60;

~pushStateToUI.();
)