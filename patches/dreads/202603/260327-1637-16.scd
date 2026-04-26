////////////////////////////////////////////////////////////////////////////////
// Dreads Patch with global FX
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
			decay: 0.17,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.3,
			dur: 0.25,
			engine: 2.0,
			fmMod: -0.33,
			harm: 0.0,
			legato: 0.9,
			lpgColour: 0.5,
			morph: 0.45,
			morphMod: 0.51,
			mul: 0.5,
			pitch: 52.02,
			revDamp: 0.27,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.18,
			revTime: 0.83,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 1.0,
			stereoMode: 0.0,
			tempo: 125.0,
			timbMod: 0.57,
			timbre: 0.6,
			volume: 0.62
		),
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
				engine: Pseq(["e", "e", "e-5", "e", "e", "e-6"], inf).asStream,
				// duration: \gauss,
				
				duration: \hold,
				
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
			)
			// $PRESET_SEQUENCES_END
		),
		
		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.0,
			decay: 0.34,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.1,
			dur: 1.4,
			engine: 11.0,
			fmMod: 0.0,
			harm: 1.0,
			legato: 1.0,
			lpgColour: 0.5,
			morph: 0.81,
			morphMod: 0.67,
			mul: 0.5,
			pitch: 46.0,
			revDamp: 0.0,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.4,
			revTime: 1.14,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 1.0,
			stereoMode: 1.0,
			tempo: 125.0,
			timbMod: 0.9,
			timbre: 0.71,
			volume: 1.07
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: Pseq([
					0.7,
					Rest(0.7),
					Rest(0.7),
					Rest(0.7),
				], inf).asStream,
				div: \hold,
				
				// div: Pseq([0.5], inf).asStream,
				harm: \hold,
			)
			// $PRESET_SEQUENCES_END
		),
		
		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.0,
			decay: 0.14,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.4,
			dur: 1.0,
			engine: 13.0,
			fmMod: 0.62,
			harm: 0.34,
			legato: 0.9,
			lpgColour: 0.5,
			morph: 0.69,
			morphMod: 0.93,
			mul: 0.5,
			pitch: 33.91,
			revDamp: 0.0,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.13,
			revTime: 0.9,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 1.0,
			stereoMode: 1.0,
			tempo: 125.0,
			timbMod: 0.7,
			timbre: 0.53,
			volume: 1.01
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: Pseq([0.5], inf).asStream,
				div: Pseq([0.5], inf).asStream,
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
		(
			atk: 0.0,
			bankName: 'msp-iris-hits',
			cloudsSend: 0.0,
			decay: 0.09,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 0.5,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.01,
			rate: 1.87,
			revDamp: 0.66,
			revDrywet: 0.45,
			revFreeze: 0.0,
			revHp: 0.0,
			revTime: 0.3,
			reverbSend: 0.0,
			speed: 1.0,
			startPos: 0.0,
			tempo: 125.0,
			variant: 0.0,
			volume: 0.32
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				distAmount: \hold,
				rate: \hold,
				duration: \hold,
				// div: Pseq(1 ! 7 ++ 0.5, inf).asStream,
				// variant: Prand((0..19), inf).asStream,				
				variant: Pseq((5..15), inf).asStream,				
			)			
			// $PRESET_SAMPLE_SEQUENCES_END
		),
		
		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.52,
			bankName: 'HATS',
			cloudsSend: 0.51,
			decay: 0.47,
			delaySend: 0.6,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 1.0,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.6,
			rate: 1.0,
			revDamp: 0.15,
			revDrywet: 0.7,
			revFreeze: 0.0,
			revHp: 0.28,
			revTime: 0.87,
			reverbSend: 0.78,
			speed: 0.5,
			startPos: 0.0,
			tempo: 125.0,
			variant: 0.0,
			volume: 0.2
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				duration: \hold,
				variant: Pseq((0..2), inf).asStream,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),
		
		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.0,
			bankName: 'msp-iris-hits',
			cloudsSend: 0.0,
			decay: 0.01,
			delaySend: 0.21,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 1.0,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.09,
			rate: 1.11,
			revDamp: 0.0,
			revDrywet: 0.64,
			revFreeze: 0.0,
			revHp: 0.01,
			revTime: 1.16,
			reverbSend: 0.0,
			speed: 0.5,
			startPos: 0.0,
			tempo: 125.0,
			variant: 4.0,
			volume: 0.3
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				rate: \gauss,
				duration: \hold,
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
		feedback: 0.57,
		filterFreq: 554.69,
		spread: 1.5,
		time: 0.22
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

