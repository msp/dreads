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
			decay: 0.27,
			delaySend: 0.0,
			distAmount: 0.11,
			distDrive: 0.3,
			dur: Rest(8.0),
			engine: 2.0,
			fmMod: -0.33,
			harm: 0.6,
			legato: 0.9,
			lpgColour: 0.5,
			morph: 0.4,
			morphMod: 0.51,
			mul: 0.5,
			phaseOffset: 0.0,
			pitch: 52.02,
			revDamp: 0.0,
			revDrywet: 0.85,
			revFreeze: 0.0,
			revHp: 0.84,
			revTime: 1.03,
			reverbSend: 0.19,
			sendToPhones: 0.0,
			speed: 0.25,
			stereoMode: 0.0,
			tempo: 125.0,
			timbMod: 0.57,
			timbre: 1.0,
			volume: 0.38
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
			cloudsSend: 0.04,
			decay: 0.25,
			delaySend: 0.11,
			distAmount: 0.0,
			distDrive: 0.1,
			dur: Rest(2.0),
			engine: 0.0,
			fmMod: 0.01,
			harm: 0.31,
			legato: 1.0,
			lpgColour: 0.5,
			morph: 0.5,
			morphMod: 0.5,
			mul: 0.5,
			phaseOffset: 0.0,
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
			timbre: 0.55,
			volume: 1.26
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// duration: Pseq([Rest(1), 2], inf).asStream,
				// duration: \sparse,
				decay: \sine,
				delaySend: \gate_burst,
				duration: \sprs_dotted,
				div: Pseq([1/2, 1/2, 1], inf).asStream,
			)
			// $PRESET_SEQUENCES_END
		),
		
		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.0,
			decay: 0.38,
			delaySend: 0.4,
			distAmount: 0.0,
			distDrive: 0.4,
			dur: Rest(1.0),
			engine: 13.0,
			fmMod: 0.0,
			harm: 0.82,
			legato: 0.1,
			lpgColour: 0.5,
			morph: 0.42,
			morphMod: 0.0,
			mul: 0.5,
			phaseOffset: 0.0,
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
			volume: 1.48
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
				engine: Pseq(["e", "e", "e", "e", "e"], inf).asStream,
				delaySend: \gate_every8,
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
			atk: 0.18,
			bankName: 'HATS',
			cloudsSend: 0.0,
			decay: 0.12,
			delaySend: 0.1,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 1.5,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.11,
			phaseOffset: 0.5,
			rate: 1.0,
			revDamp: 0.4,
			revDrywet: 0.14,
			revFreeze: 0.0,
			revHp: 0.46,
			revTime: 0.0,
			reverbSend: 0.0,
			speed: 1.0,
			startPos: 0.01,
			tempo: 165.0,
			variant: 2.0,
			volume: 0.79
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				// div: Pseq([2, Rest(6)], inf).asStream,
				div: Pseq(1 ! 31 ++ (0.5), inf).asStream,
				// duration: Pseq([2, 2, 2, 2, 2, 2, 2, Rest(1/2)], inf).asStream,
				duration: \tresillo,
				
				// duration: Pseq([2, 2, 2, 2], inf).asStream,
				delaySend: \gate_stutter,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),
		
		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.0,
			bankName: 'msp-iris-hits',
			cloudsSend: 0.0,
			decay: 0.18,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 3.0,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.1,
			phaseOffset: 0.25,
			rate: 0.58,
			revDamp: 0.0,
			revDrywet: 0.41,
			revFreeze: 0.0,
			revHp: 0.58,
			revTime: 0.16,
			reverbSend: 0.0,
			speed: 0.5,
			startPos: 0.0,
			tempo: 165.0,
			variant: 0.0,
			volume: 1.4
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				
				rate: \hold,
				// rate: Pseq([
				// Pgeom(1.0, 1.01, 50),
				// Pgeom(1.628, 0.99, 50)
				// ], inf).asStream,
				duration: \tresillo,
				variant: Pseq([11,11,11,11, 9], inf).asStream,
				
				// duration: Pseq([
				// 1/4,
				// Rest(1/4),
				// Rest(1/4),
				// Rest(1/4),
				// ], inf).asStream,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),
		
		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.0,
			bankName: 'CLAPS',
			cloudsSend: 0.0,
			decay: 0.16,
			delaySend: 0.07,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 1.5,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.12,
			phaseOffset: 0.0,
			rate: 1.83,
			revDamp: 0.0,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.42,
			revTime: 0.57,
			reverbSend: 0.04,
			speed: 0.5,
			startPos: 0.0,
			tempo: 165.0,
			variant: 1.0,
			volume: 0.44
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: Pseq([1, 2, 1, 2, 1, 2], inf).asStream,
				// duration: Pseq([1/2, 1]/2, inf).asStream,
				// rate: Pseq([0.1, 2, 1/3], inf).asStream,
				duration: \tresillo,
				delaySend: \gate_every4,
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
		feedback: 0.28,
		filterFreq: 2646.44,
		spread: 0.55,
		time: 0.23
	),
	reverb: (
		damp: 0.72,
		diffuse: 0.49,
		freeze: 0.0,
		hp: 0.49,
		time: 0.55
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