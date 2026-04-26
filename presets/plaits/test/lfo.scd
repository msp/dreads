////////////////////////////////////////////////////////////////////////////////
// FM Patch Preview Preset
// PLAITS1 configured for clean FM auditioning — load this, then run fm-patches.scd
////////////////////////////////////////////////////////////////////////////////
(
~dreads = ~presetFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.09, decay: 0.44, decayMod: 0.3, delaySend: 0.38, distAmount: 0.0, distDrive: 0.0, droneMode: 1.0, dur: 0.5, engine: 0.0, fmMod: -0.04, harm: 0.48, legato: 4.0, lpgColour: 0.5, morph: 0.07, morphMod: 0.01, mul: 0.5, mute: 0.0, phaseOffset: 0.0, pitch: 48.0, pitchMod: 0.8, revDamp: 0.8, revDrywet: 0.88, revFreeze: 0.0, revHp: 0.38, revTime: 0.82, reverbSend: 0.53, sendToPhones: 0.0, speed: 1.0, stereoMode: 1.0, tempo: 165.0, timbMod: 0.0, timbre: 0.22, volume: 0.45, volumeMod: 0.8),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: \hold,
				div: \unit,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.73, decay: 0.42, decayMod: 0.0, delaySend: 0.27, distAmount: 0.15, distDrive: 0.0, droneMode: 1.0, dur: 1.0, engine: 20.0, fmMod: -0.02, harm: 0.11, legato: 15.0, lpgColour: 0.5, morph: 0.72, morphMod: 0.39, mul: 0.5, mute: 1.0, phaseOffset: -0.5, pitch: 60.0, pitchMod: 0.0, revDamp: 0.48, revDrywet: 0.58, revFreeze: 0.0, revHp: 0.63, revTime: 1.08, reverbSend: 0.7, sendToPhones: 0.0, speed: 0.5, stereoMode: 1.0, tempo: 165.0, timbMod: 0.59, timbre: 0.57, volume: 0.2, volumeMod: 0.5),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: \unit,
				duration: \sync_1,
				pitch: \hold,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
			(cloudsSend: 0.84, decay: 0.75, decayMod: 0.0, delaySend: 0.66, distAmount: 0.0, distDrive: 0.0, droneMode: 0.0, dur: 1.0, engine: 23.0, fmMod: 0.0, harm: 0.38, legato: 9.0, lpgColour: 0.5, morph: 0.31, morphMod: 0.73, mul: 0.5, mute: 1.0, phaseOffset: 0.0, pitch: 52.0, pitchMod: 0.0, revDamp: 0.69, revDrywet: 1.0, revFreeze: 0.0, revHp: 0.94, revTime: 0.88, reverbSend: 0.0, sendToPhones: 0.0, speed: 0.5, stereoMode: 1.0, tempo: 165.0, timbMod: 0.42, timbre: 0.3, volume: 0.3, volumeMod: 0.0),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: \unit,
				duration: \offbeat,
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
			(atk: 0.0, bankName: 'halfmastv6', cloudsSend: 0.0, decay: 0.57, delaySend: 0.0, distAmount: 0.21, distDrive: 0.0, dur: 4.0, legato: 0.7, mul: 1.0, mute: 0.0, panDur: 0.1, phaseOffset: 0.0, rate: 0.63, rateMod: 0.9, revDamp: 0.8, revDrywet: 0.0, revFreeze: 0.0, revHp: 0.0, revTime: 0.92, reverbSend: 0.14, speed: 0.25, startPos: 0.54, tempo: 165.0, variant: 10.0, volume: 0.9, volumeMod: 0.9),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				div: \unit,
				rate: \hold,
				mul: \unit,
				duration: \unit,
				startPos: \rndm_walk_slow,
				distAmount: \gate_every4,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
			(atk: 0.0, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 165.0, variant: 0.0, volume: 0.0, volumeMod: 0.0),
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
			(atk: 0.5, bankName: 'default', cloudsSend: 0.0, decay: 0.5, delaySend: 0.0, distAmount: 0.0, distDrive: 0.0, dur: 1.0, legato: 0.7, mul: 1.0, mute: 1.0, panDur: 0.5, phaseOffset: 0.0, rate: 1.0, rateMod: 0.0, revDamp: 0.8, revDrywet: 0.25, revFreeze: 0.0, revHp: 0.7, revTime: 0.3, reverbSend: 0.0, speed: 1.0, startPos: 0.0, tempo: 165.0, variant: 0.0, volume: 0.0, volumeMod: 0.0),
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
	clouds: (blend: 0.5, density: 0.58, feedback: 0.49, freeze: 0.0, inGain: 1.0, lofi: 0.0, mix: 1.0, mode: 3.0, pitch: 0.5, position: 0.36, reverb: 0.0, size: 0.74, spread: 0.5, texture: 0.4, volume: 0.0),
	delay: (feedback: 0.36, filterFreq: 6742.75, spread: 1.5, time: 0.72),
	reverb: (damp: 0.6, diffuse: 0.63, freeze: 0.0, hp: 0.23, time: 0.87)
),
	// $PRESET_FX_END
);

~states = Pseq([\a, \b, \c, \d], inf).asStream;
~state = ~states.next;
~playCount = 0;
~tempoClock.tempo = ~dreads.synths[0].tempo/60;

// Server-side LFO speeds for this preset (per instance)
3.do { |i|
	~lfoSynths[i].timbre.set(\freq, 1/5);
	~lfoSynths[i].morph.set(\freq, 1/8);
	~lfoSynths[i].decay.set(\freq, 1/6);
	~lfoSynths[i].pitch.set(\freq, 1);
	~lfoSynths[i].volume.set(\freq, 6);
	~sampleLfoSynths[i].rate.set(\freq, 1/8);
	~sampleLfoSynths[i].volume.set(\freq, 1/12);
};

~droneSynths[0].set(\volumeMod, 0.0);
~droneSynths[0].set(\pitchMod, 0.6);

~lfoSynths[0].volume.set(\freq, 1/26);
~lfoSynths[0].pitch.set(\freq, 1/2);
~lfoSynths[0].pitch.set(\shape, 5);


~dreads.samples[0].volume = 0.9;
~dreads.samples[0][\volumeMod] = 0.9;
~dreads.samples[0][\rateMod] = 0.9;

~dreads.synths[0][\volume] = 0.8;
~dreads.synths[0].volume = 0.3;

~sampleLfoSynths[0].rate.set(\freq, 5, \shape, 4, \width, 0.9);
~sampleLfoSynths[0].volume.set(\freq, 1);

~pushStateToUI.();
)


