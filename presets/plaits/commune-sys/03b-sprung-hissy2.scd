////////////////////////////////////////////////////////////////////////////////
// Plaits State - Template-based default preset with global FX
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
			decay: 0.53,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(4.2),
			engine: 11.0,
			fmMod: 0.0,
			harm: 0.96,
			legato: 18.0,
			lpgColour: 0.5,
			morph: 0.12,
			morphMod: 0.4,
			mul: 0.5,
			pitch: 108.26,
			revDamp: 0.43,
			revDrywet: 1.0,
			revFreeze: 0.0,
			revHp: 0.83,
			revTime: 0.87,
			reverbSend: 0.54,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 60.0,
			timbMod: 0.3,
			timbre: 0.72,
			volume: 0.48
		),
			// $PRESET_SCALARS_END
			(
				timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
				decay: Pseq([0.5, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
				morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
				harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
				lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
				engine: Pseq(["e", "e", "e-5", "e", "e", "e-6"], inf).asStream,
				duration: Pseq([
					0.7,
					Pwrand([0.7, Rest(0.7)], [0.9, 0.1].normalizeSum),
					0.7,
					Pwrand([0.7, Rest(1.4)], [0.95, 0.05].normalizeSum),
					0.7,
					Pwrand([1.4, 0.7], [0.6, 0.4].normalizeSum),
				], inf).asStream,
				div: Pseq([1/6], inf).asStream
				// div: Pseq([1, 2, 1, 1, 2], inf).asStream
			)
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.8,
			delaySend: 0.07,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(2.8),
			engine: 13.0,
			fmMod: 0.0,
			harm: 0.87,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.46,
			morphMod: 0.8,
			mul: 0.5,
			pitch: 33.62,
			revDamp: 0.8,
			revDrywet: 0.86,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.86,
			reverbSend: 0.41,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 120.0,
			timbMod: 0.7,
			timbre: 0.92,
			volume: 0.79
		),
			// $PRESET_SCALARS_END
			(
				duration: Pseq([
					0.7,
					Rest(0.7),
					Rest(0.7),
					Rest(0.7),
				], inf).asStream,
				div: Pseq([0.25], inf).asStream
			)
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.1,
			delaySend: 0.09,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(2.8),
			engine: 9.0,
			fmMod: 0.0,
			harm: 0.48,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.43,
			morphMod: 0.4,
			mul: 0.5,
			pitch: 73.1,
			revDamp: 0.4,
			revDrywet: 0.12,
			revFreeze: 0.0,
			revHp: 0.4,
			revTime: 0.9,
			reverbSend: 0.47,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 120.0,
			timbMod: 0.7,
			timbre: 0.76,
			volume: 1.63
		),
			// $PRESET_SCALARS_END
			(
				duration: Pseq([
					0.7,
					Rest(0.7),
					Rest(0.7),
					Pwrand([Rest(1.4), 0.7], [0.5, 0.5].normalizeSum),
				], inf).asStream,
				div: Pseq([1/4], inf).asStream
			)
		)
	],
	// Samples array
	[
		// $SAMPLE1
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.09,
			bankName: \Tracks,
			cloudsSend: 0.6,
			decay: 0.33,
			delaySend: 0.19,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(5.6),
			mul: 1.0,
			panDur: 0.2,
			rate: 2.04,
			revDamp: 0.8,
			revDrywet: 0.25,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.76,
			startPos: 0.06,
			tempo: 165.0,
			variant: 0.0,
			volume: 1.42
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				decay: Pseq([1.0, 0.5, 0.8, 0.4, 0.1], inf).asStream,
				duration: Pseq([1.4, Rest(1.4 * 4)], inf).asStream,
				startPos: Pseq([0.1, 0.2, 0.5], inf).asStream,
				rate: Pseq([1.0, 0.5, 1.5, 2.0, 0.1], inf).asStream
			)
		),
		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.5,
			bankName: \SoundFX,
			cloudsSend: 0.84,
			decay: 0.5,
			delaySend: 0.68,
			distAmount: 0.65,
			distDrive: 0.0,
			dur: 4.0,
			mul: 1.0,
			panDur: 0.5,
			rate: 3.33,
			revDamp: 0.8,
			revDrywet: 0.51,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.68,
			reverbSend: 0.68,
			startPos: 0.15,
			tempo: 165.0,
			variant: 9.0,
			volume: 1.44
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				div: Pseq([1/4], inf).asStream
			)
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.5,
			bankName: \SoundFX,
			cloudsSend: 0.0,
			decay: 0.83,
			delaySend: 0.6,
			distAmount: 0.07,
			distDrive: 0.0,
			dur: 8.0,
			mul: 1.0,
			panDur: 0.5,
			rate: 3.61,
			revDamp: 0.0,
			revDrywet: 0.7,
			revFreeze: 0.0,
			revHp: 0.13,
			revTime: 0.7,
			reverbSend: 0.46,
			startPos: 0.25,
			tempo: 165.0,
			variant: 17.0,
			volume: 0.83
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				div: Pseq([1/8], inf).asStream
			)
		)
	],
	// Global FX settings
	// $PRESET_FX_START
(
	clouds: (
		blend: 0.5,
		density: 0.48,
		feedback: 0.4,
		freeze: 1.0,
		inGain: 1.0,
		lofi: 0.0,
		mix: 1.0,
		mode: 3.0,
		pitch: -34.17,
		position: 0.59,
		reverb: 0.35,
		size: 0.42,
		spread: 0.5,
		texture: 0.43,
		volume: 0.73
	),
	delay: (
		feedback: 0.93,
		filterFreq: 8000.0,
		spread: 1.5,
		time: 0.77
	),
	reverb: (
		damp: 0.81,
		diffuse: 0.68,
		freeze: 1.0,
		hp: 0.47,
		time: 1.0
	)
),
	// $PRESET_FX_END
);

("Preset loaded - Sample 0 mul: " ++ ~plaits.samples[0].mul).postln;

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