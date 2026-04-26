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
			(cloudsSend: 0.0, decay: 0.78, delaySend: 0.58, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 16.0, engine: 22.0, fmMod: -0.04, harm: 0.73, legato: 15.0, lpgColour: 0.5, morph: 0.47, morphMod: 0.78, mul: 0.5, mute: 1.0, phaseOffset: 0.0, pitch: 45.0, revDamp: 0.8, revDrywet: 0.07, revFreeze: 0.0, revHp: 0.52, revTime: 0.83, reverbSend: 0.7, sendToPhones: 0.0, speed: 0.25, stereoMode: 1.0, tempo: 165.0, timbMod: 0.0, timbre: 0.81, volume: 1.11),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \sprs_quarter,
				pitch: \triad_min_inv,
				div: Pseq([1/4], inf).asStream,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.03, decay: 0.52, delaySend: 0.27, distAmount: 0.05, distDrive: 0.0, droneMode: 0.0, dur: Rest(1.0), engine: 20.0, fmMod: -0.25, harm: 0.38, legato: 15.0, lpgColour: 0.5, morph: 0.48, morphMod: 0.57, mul: 0.5, mute: 0.0, phaseOffset: -0.75, pitch: 47.0, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.7, revTime: 0.07, reverbSend: 0.0, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 165.0, timbMod: 0.2, timbre: 0.34, volume: 0.62),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
			div: \unit,
			duration: \backbeat,
			pitch: \triad_min_inv,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.0, decay: 0.24, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: Rest(2.0), engine: 20.0, fmMod: -0.02, harm: 0.68, legato: 9.0, lpgColour: 0.5, morph: 0.81, morphMod: 0.4, mul: 0.5, mute: 1.0, phaseOffset: 0.0, pitch: 83.0, revDamp: 0.0, revDrywet: 0.64, revFreeze: 0.0, revHp: 0.55, revTime: 0.18, reverbSend: 0.0, sendToPhones: 0.0, speed: 0.25, stereoMode: 1.0, tempo: 165.0, timbMod: 0.26, timbre: 0.3, volume: 0.47),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
			div: \unit,
			duration: \sync_1,
			pitch: \triad_min,
			)
			// $PRESET_SEQUENCES_END
		)
	],
	// Samples array
	[
		// $SAMPLE1
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 165.0, variant: 0.0, volume: 0.0),
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
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 165.0, variant: 0.0, volume: 0.0),
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
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 165.0, variant: 0.0, volume: 0.0),
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
		feedback: 0.72,
		filterFreq: 5650.67,
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
