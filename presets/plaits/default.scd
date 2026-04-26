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
		(
			cloudsSend: 0.0,
			decay: 0.12,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			droneMode: 0.0,
			dur: Rest(1.0),
			engine: 13.0,
			fmMod: 0.47,
			harm: 0.67,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.59,
			morphMod: 0.4,
			mul: 0.5,
			mute: 0.0,
			phaseOffset: 0.0,
			pitch: 60.0,
			revDamp: 0.8,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 1.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.3,
			timbre: 0.76,
			volume: 1.82
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
				decay: Pseq([0.64, 0.69, 0.73, 0.09, 0.9, 0.56, 0.19, 0.2], inf).asStream,

				// decay: Pseq([0.64, 0.69, 0.73, 0.09, 0.9, 0.56, 0.19, 0.2], inf).asStream,

				// decay: Pseq([0.47, 0.75, 0.73, 0.47, 0.2, 0.91, 0.1, 0.36, 0.68, 0.31, 0.08, 0.43, 0.54, 0.16, 0.78, 0.02], inf).asStream,

				// decay: Pseq([0.47, 0.75, 0.73, 0.47, 0.2, 0.91, 0.1, 0.36, 0.68, 0.31, 0.08, 0.43, 0.54, 0.16, 0.78, 0.02], inf).asStream,

				// decay: Pseq([0.5, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
				// decay: \gauss,
				morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
				harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
				lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
				// engine: Pseq(["e", "e", "e-5", "e", "e", "e-6"], inf).asStream,
				// duration: \gauss,

				duration: \sprs_quarter,

				// duration: Pseq([1.0, 0.75, 1.0, 0.25, 0.5, Rest(0.75), 0.5, Rest(0.75), Rest(0.25), 0.75], inf).asStream,

				// duration: Pseq([0.5, 0.75, 0.25, Rest(0.5), Rest(0.5), Rest(0.75), Rest(1.0), 0.5, Rest(1.0), Rest(0.75), 0.25, Rest(0.25), Rest(0.25), 1.0, 1.0], inf).asStream,

				// duration: Pseq([Rest(0.5), 1.0, 1.0, 0.25, 0.75, Rest(0.25), Rest(1.0), Rest(1.0), Rest(1.0), 0.75, Rest(0.5)], inf).asStream,

				// duration: Pseq([1, Rest(1), Rest(1), 1, Rest(1), 1, Rest(1)], inf).asStream,

				// duration: Pseq([
				// 0.7,
				// Pwrand([0.7, Rest(0.7)], [0.9, 0.1].normalizeSum),
				// 0.7,
				// Pwrand([0.7, Rest(1.4)], [0.95, 0.05].normalizeSum),
				// 0.7,
				// Pwrand([1.4, 0.7], [0.6, 0.4].normalizeSum),
				// ], inf).asStream,
				div: \unit,

				// div: Pseq([1, 2, 1, 1, 2], inf).asStream,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.03,
			decay: 0.39,
			delaySend: 0.06,
			distAmount: 0.0,
			distDrive: 0.0,
			droneMode: 0.0,
			dur: 1.0,
			engine: 15.0,
			fmMod: 0.0,
			harm: 0.48,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.07,
			morphMod: 0.2,
			mul: 0.5,
			mute: 0.0,
			phaseOffset: -0.5,
			pitch: 49.0,
			revDamp: 0.8,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 1.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.5,
			timbre: 0.59,
			volume: 0.37
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \offbeat,

				// duration: Pseq([
				// 0.7,
				// Rest(0.7),
				// Rest(0.7),
				// Rest(0.7),
				// ], inf).asStream,
				div: Pseq([0.5], inf).asStream,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.0,
			decay: 0.54,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			droneMode: 0.0,
			dur: Rest(1.4),
			engine: 18.0,
			fmMod: 0.06,
			harm: 0.94,
			legato: 9.0,
			lpgColour: 0.6,
			morph: 0.73,
			morphMod: 0.4,
			mul: 0.5,
			mute: 0.0,
			phaseOffset: 0.0,
			pitch: 40.0,
			revDamp: 0.4,
			revDrywet: 0.19,
			revFreeze: 0.0,
			revHp: 0.4,
			revTime: 0.37,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 1.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.7,
			timbre: 0.27,
			volume: 0.85
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: Pseq([1.0, Rest(0.25), 0.75, Rest(0.5), 1.0, Rest(0.75), 0.5, 1.0], inf).asStream,

				// duration: Pseq([1.0, Rest(0.25), 0.75, Rest(0.5), 1.0, Rest(0.75), 0.5, 1.0], inf).asStream,

				// duration: Pseq([
				// 0.7,
				// Rest(0.7),
				// Rest(0.7),
				// Pwrand([Rest(1.4), 0.7], [0.5, 0.5].normalizeSum),
				// ], inf).asStream,
				div: Pseq([0.5], inf).asStream,
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
			atk: 0.5,
			bankName: 'default',
			cloudsSend: 0.0,
			decay: 0.5,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 1.0,
			legato: 0.7,
			mul: 1.0,
			mute: 1.0,
			panDur: 0.5,
			phaseOffset: 0.0,
			rate: 1.0,
			revDamp: 0.8,
			revDrywet: 0.25,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			speed: 1.0,
			startPos: 0.0,
			tempo: 165.0,
			variant: 0.0,
			volume: 0.0
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
			div: \unit,
			rate: \unit,
			mul: \unit,
			duration: \unit,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.5,
			bankName: 'default',
			cloudsSend: 0.0,
			decay: 0.5,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 1.0,
			legato: 0.7,
			mul: 1.0,
			mute: 1.0,
			panDur: 0.5,
			phaseOffset: 0.0,
			rate: 1.0,
			revDamp: 0.8,
			revDrywet: 0.25,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			speed: 1.0,
			startPos: 0.0,
			tempo: 165.0,
			variant: 0.0,
			volume: 0.0
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
			div: \unit,
			rate: \unit,
			mul: \unit,
			duration: \unit,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.5,
			bankName: 'default',
			cloudsSend: 0.0,
			decay: 0.5,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 1.0,
			legato: 0.7,
			mul: 1.0,
			mute: 1.0,
			panDur: 0.5,
			phaseOffset: 0.0,
			rate: 1.0,
			revDamp: 0.8,
			revDrywet: 0.25,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			speed: 1.0,
			startPos: 0.0,
			tempo: 165.0,
			variant: 0.0,
			volume: 0.0
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
			div: \unit,
			rate: \unit,
			mul: \unit,
			duration: \unit,
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
		feedback: 0.0,
		freeze: 0.0,
		inGain: 1.0,
		lofi: 0.0,
		mix: 1.0,
		mode: 3.0,
		pitch: 0.5,
		position: 0.5,
		reverb: 0.0,
		size: 0.5,
		spread: 0.5,
		texture: 0.5,
		volume: 1.0
	),
	delay: (
		feedback: 0.36,
		filterFreq: 1375.07,
		spread: 1.5,
		time: 0.72
	),
	reverb: (
		damp: 0.6,
		diffuse: 0.63,
		freeze: 0.0,
		hp: 0.3,
		time: 0.4
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
