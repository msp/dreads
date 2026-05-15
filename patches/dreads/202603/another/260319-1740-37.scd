////////////////////////////////////////////////////////////////////////////////
// Plaits State - Data structures and synth instance definitions
////////////////////////////////////////////////////////////////////////////////
(
~dreads = ~patchFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.0,
			decay: 0.73,
			delaySend: 0.51,
			distAmount: 0.26,
			distDrive: 0.3,
			dur: 52.12,
			engine: 10.0,
			fmMod: -0.66,
			harm: 0.83,
			legato: 0.9,
			lpgColour: 0.5,
			morph: 0.14,
			morphMod: 0.51,
			mul: 0.5,
			pitch: 104.11,
			revDamp: 0.78,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.18,
			revTime: 0.39,
			reverbSend: 0.12,
			sendToPhones: 0.0,
			speed: 0.1,
			stereoMode: 0.0,
			tempo: 175.0,
			timbMod: 0.57,
			timbre: 1.0,
			volume: 0.55
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: Pseq(1/8 ! 63 ++ (1.0), inf).asStream,
				// div: Pseq(1/8 ! 64, inf).asStream,
				duration: \gauss,

				// duration: Pseq([
				// 0.25,
				// Pseq([0.25, Rest(0.25), 0.5], inf).asStream,
				// // Rest(0.25),
				// Pwrand([0.25, Rest(0.25)], [0.95, 0.05].normalizeSum),
				// Rest(0.25),
				// Rest(0.25),
				// Pwrand([0.25, Rest(0.25)], [0.95, 0.05].normalizeSum),
				// Rest(0.25),
				// Pwrand([Rest(0.25), 0.25], [0.6, 0.4].normalizeSum),
				// ], inf).asStream,
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
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.0,
			decay: 0.77,
			delaySend: 0.0,
			distAmount: 0.17,
			distDrive: 0.1,
			dur: 5.33,
			engine: 8.0,
			fmMod: 0.0,
			harm: 0.5,
			legato: 1.0,
			lpgColour: 0.5,
			morph: 0.62,
			morphMod: 0.92,
			mul: 0.5,
			pitch: 46.0,
			revDamp: 0.0,
			revDrywet: 0.16,
			revFreeze: 0.0,
			revHp: 0.4,
			revTime: 1.09,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 0.75,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.9,
			timbre: 0.57,
			volume: 0.0
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: Pseq([0.5], inf).asStream,
				duration: Pseq([Rest(2), 2], inf).asStream,
				// duration: Pseq([1/2] * 2, inf).asStream,
				engine: Pseq(["e", "e", "e", "e", "e", "e"], inf).asStream,
				// engine: Pseq([0], inf).asStream,
			harm: \random,
			morph: \gauss,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.0,
			decay: 0.88,
			delaySend: 0.13,
			distAmount: 0.15,
			distDrive: 0.1,
			dur: 4.0,
			engine: 13.0,
			fmMod: 0.37,
			harm: 0.85,
			legato: 0.1,
			lpgColour: 0.5,
			morph: 0.99,
			morphMod: 0.93,
			mul: 0.5,
			pitch: 30.64,
			revDamp: 0.0,
			revDrywet: 0.21,
			revFreeze: 0.0,
			revHp: 0.0,
			revTime: 0.9,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 0.25,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.7,
			timbre: 0.68,
			volume: 0.65
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: Pseq(1 ! 63 ++ (0.5), inf).asStream,
				// div: Pseq([1], inf).asStream,
				duration: \ramp,

				// duration: Pseq([
				// 0.25,
				// Rest(0.25),
				// Rest(0.25),
				// Rest(0.25),
				// 0.25,
				// Rest(0.25),
				// Rest(0.25),
				// Rest(0.25),
				// ], inf).asStream,
				engine: Pseq(["e", "e", "e", "e", "e", "e+1"], inf).asStream,
			),
			// $PRESET_SEQUENCES_END
			// $PRESET_LFO_START
			()
			// $PRESET_LFO_END
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
			delaySend: 0.18,
			distAmount: 0.1,
			distDrive: 0.0,
			dur: Rest(8.0),
			legato: 0.7,
			mul: 1.0,
			panDur: 0.1,
			rate: 0.52,
			revDamp: 0.56,
			revDrywet: 0.19,
			revFreeze: 0.0,
			revHp: 0.52,
			revTime: 0.3,
			reverbSend: 0.08,
			speed: 0.25,
			startPos: 0.0,
			tempo: 165.0,
			variant: 14.0,
			volume: 0.35
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
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
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
			volume: 0.15
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				// div: Pseq([1/16], inf).asStream,
				// duration: Pseq([8, Rest(8)]/2, inf).asStream,
				div: Pseq([1/4], inf).asStream,
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
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.38,
			bankName: 'msp-form-msp1',
			cloudsSend: 0.75,
			decay: 0.59,
			delaySend: 0.3,
			distAmount: 0.6,
			distDrive: 0.0,
			dur: 16.0,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.12,
			rate: 0.81,
			revDamp: 0.8,
			revDrywet: 0.73,
			revFreeze: 0.0,
			revHp: 0.09,
			revTime: 1.02,
			reverbSend: 0.9,
			speed: 0.5,
			startPos: 0.05,
			tempo: 165.0,
			variant: 1.0,
			volume: 0.09
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: Pseq([1/8], inf).asStream,
				// duration: Pseq([1/2, 1]/2, inf).asStream,
				rate: Pseq([0.1, 2, 1/3], inf).asStream,
			startPos: \gauss,
			),
			// $PRESET_SAMPLE_SEQUENCES_END
			// $PRESET_SAMPLE_LFO_START
			()
			// $PRESET_SAMPLE_LFO_END
		)
	],
	// Global FX settings
	// $PRESET_FX_START
(
	clouds: (
		blend: 0.5,
		density: 0.24,
		feedback: 0.28,
		freeze: 1.0,
		inGain: 1.0,
		lofi: 0.0,
		mix: 1.0,
		mode: 3.0,
		pitch: -1.3,
		position: 0.5,
		reverb: 0.02,
		size: 0.5,
		spread: 0.5,
		texture: 0.69,
		volume: 0.25
	),
	delay: (
		feedback: 0.77,
		filterFreq: 2478.14,
		spread: 1.5,
		time: 0.22
	),
	reverb: (
		damp: 0.6,
		diffuse: 0.63,
		freeze: 0.0,
		hp: 0.2,
		time: 0.6
	)
),
	// $PRESET_FX_END
);

~states = Pseq([\a, \b, \c, \d], inf).asStream;
~state = ~states.next;
~playCount = 0;

~tempoClock.tempo = ~dreads.synths[0].tempo/60;

// $LFO_SOURCES_START
~dreads.lfoSources = (
	lfo1: (freq: 0.1333),
	lfo2: (freq: 0.2667),
	lfo3: (freq: 0.0667),
	lfo6: (freq: 0.1333),
	lfo7: (freq: 0.2667),
	lfo8: (freq: 0.0667),
	lfo11: (freq: 0.1333),
	lfo12: (freq: 0.2667),
	lfo13: (freq: 0.0667)
);
// $LFO_SOURCES_END

~applyPatch.();
) 