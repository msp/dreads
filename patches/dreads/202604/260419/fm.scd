////////////////////////////////////////////////////////////////////////////////
// FM Patch Preview Preset
// PLAITS1 configured for clean FM auditioning — load this, then run fm-patches.scd
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
				decay: 0.37,
				delaySend: 0.62,
				distAmount: 0.08,
				distDrive: 0.0,
				droneMode: 0.0,
				dur: 0.5,
				engine: 18.0,
				fmMod: -0.04,
				harm: 0.29,
				legato: 4.0,
				lpgColour: 0.5,
				morph: 0.77,
				morphMod: 0.0,
				mul: 0.5,
				mute: 0.0,
				phaseOffset: 0.0,
				pitch: 48.0,
				revDamp: 0.8,
				revDrywet: 0.49,
				revFreeze: 0.0,
				revHp: 0.52,
				revTime: 0.3,
				reverbSend: 0.0,
				sendToPhones: 0.0,
				speed: 1.0,
				stereoMode: 1.0,
				tempo: 165.0,
				timbMod: 0.63,
				timbre: 0.7,
				volume: 0.97
			),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \sync_1,
				pitch: \triad_min_inv,
				div: \unit,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(
				cloudsSend: 0.03,
				decay: 0.04,
				delaySend: 0.54,
				distAmount: 0.06,
				distDrive: 0.0,
				droneMode: 0.0,
				dur: 5.0,
				engine: 20.0,
				fmMod: -0.02,
				harm: 0.11,
				legato: 15.0,
				lpgColour: 0.5,
				morph: 0.68,
				morphMod: 0.39,
				mul: 0.5,
				mute: 0.0,
				phaseOffset: -0.5,
				pitch: 48.0,
				revDamp: 0.8,
				revDrywet: 0.31,
				revFreeze: 0.0,
				revHp: 0.7,
				revTime: 0.66,
				reverbSend: 0.7,
				sendToPhones: 0.0,
				speed: 0.5,
				stereoMode: 1.0,
				tempo: 165.0,
				timbMod: 0.59,
				timbre: 0.41,
				volume: 0.42
			),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: Pseq([1/8], inf).asStream,
				duration: \sync_1,
				pitch: \triad_min_inv,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(
				cloudsSend: 0.0,
				decay: 0.18,
				delaySend: 0.0,
				distAmount: 0.16,
				distDrive: 0.0,
				droneMode: 0.0,
				dur: 1.0,
				engine: 20.0,
				fmMod: 0.0,
				harm: 0.23,
				legato: 9.0,
				lpgColour: 0.5,
				morph: 0.81,
				morphMod: 0.4,
				mul: 0.5,
				mute: 0.0,
				phaseOffset: 0.0,
				pitch: 23.0,
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
				timbre: 0.68,
				volume: 0.77
			),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: \unit,
				duration: \unit,
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
				mute: 0.0,
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
			filterFreq: 6603.47,
			spread: 1.5,
			time: 0.72
		),
		reverb: (
			damp: 0.6,
			diffuse: 0.63,
			freeze: 0.0,
			hp: 0.31,
			time: 0.65
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

// All LFOs neutralized for clean FM patch preview
// ~timbreLFO = Pfunc { 0.5 }.asStream;
~timbreLFO = ~lfoSine.(1/8);
// ~morphLFO = Pfunc { 0.5 }.asStream;
~morphLFO = ~lfoSine.(1/8);
~decayLFO = Pfunc { 0.5 }.asStream;
~tempoClock.tempo = ~dreads.synths[0].tempo/60;

~pushStateToUI.();
)
