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
			decay: 1.0,
			delaySend: 0.0,
			distAmount: 0.06,
			distDrive: 0.0,
			dur: 39.66,
			engine: 13.0,
			fmMod: -0.29,
			harm: 0.21,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 1.0,
			morphMod: 0.74,
			mul: 0.5,
			phaseOffset: 0.0,
			pitch: 34.54,
			revDamp: 0.8,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 0.25,
			stereoMode: 1.0,
			tempo: 242.7,
			timbMod: 0.36,
			timbre: 0.3,
			volume: 0.66
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// duration: \hold,
				duration: \gauss,
				distAmount: \gate_tail,
				delaySend: \gate_every4,
				div: Pseq([1/16], inf).asStream,
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
			cloudsSend: 0.24,
			decay: 1.0,
			delaySend: 0.26,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 8.0,
			engine: 0.0,
			fmMod: 0.08,
			harm: 0.23,
			legato: 45.0,
			lpgColour: 0.5,
			morph: 0.74,
			morphMod: 0.56,
			mul: 0.5,
			phaseOffset: 0.0,
			pitch: 51.0,
			revDamp: 0.8,
			revDrywet: 0.72,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.83,
			reverbSend: 0.46,
			sendToPhones: 0.0,
			speed: 1.0,
			stereoMode: 1.0,
			tempo: 242.7,
			timbMod: 0.56,
			timbre: 0.48,
			volume: 0.46
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				// duration: \hold,
				duration: Pseq([1, Rest(1), Rest(1), 1, Rest(1), 1, Rest(1), 1, Rest(1), 1, Rest(1), Rest(1), 1, Rest(1), 1, Rest(1)], inf).asStream,
				reverbSend: \gate_every4,
				delaySend: \gate_tail,
				fmMod: \triangle,
				div: Pseq([1/8], inf).asStream,
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
			decay: 0.44,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 6.06,
			engine: 6.0,
			fmMod: -0.06,
			harm: 0.54,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.58,
			morphMod: 0.2,
			mul: 0.5,
			phaseOffset: -0.25,
			pitch: 58.25,
			revDamp: 0.4,
			revDrywet: 0.19,
			revFreeze: 0.0,
			revHp: 0.4,
			revTime: 0.37,
			reverbSend: 0.12,
			sendToPhones: 0.0,
			speed: 0.25,
			stereoMode: 1.0,
			tempo: 242.7,
			timbMod: 0.46,
			timbre: 0.3,
			volume: 0.72
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: Pseq([0.5], inf).asStream,
				duration: \rndm_walk_slow,
				delaySend: \gate_stutter,
				decay: \sine_slow,
			fmMod: \sine_slow,
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
			atk: 0.62,
			bankName: 'CLAPS',
			cloudsSend: 0.0,
			decay: 0.19,
			delaySend: 0.52,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(32.0),
			legato: 0.7,
			mul: 1.0,
			panDur: 0.5,
			phaseOffset: 0.5,
			rate: 1.05,
			revDamp: 0.55,
			revDrywet: 0.56,
			revFreeze: 0.0,
			revHp: 0.33,
			revTime: 0.64,
			reverbSend: 0.53,
			speed: 0.25,
			startPos: 0.0,
			tempo: 242.7,
			variant: 2.0,
			volume: 0.29
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				duration: \sprs_dotted,
				div: Pseq([1/8], inf).asStream,
				reverbSend: \hold,
				delaySend: \gate_every4,
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
			atk: 0.55,
			bankName: 'halfmastv6',
			cloudsSend: 0.0,
			decay: 0.55,
			delaySend: 0.33,
			distAmount: 0.07,
			distDrive: 0.0,
			dur: 22.12,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.26,
			phaseOffset: 0.0,
			rate: 1.1,
			revDamp: 0.0,
			revDrywet: 0.12,
			revFreeze: 0.0,
			revHp: 0.45,
			revTime: 0.77,
			reverbSend: 0.14,
			speed: 0.25,
			startPos: 0.0,
			tempo: 242.7,
			variant: 4.0,
			volume: 0.16
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				startPos: \sweep_slow,
				atk: \gauss,
				decay: \updown,
				duration: \gauss,
				div: Pseq([1/8], inf).asStream,
				variant: Pseq([4, 5, 6], inf).asStream,
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
			atk: 0.5,
			bankName: 'default',
			cloudsSend: 0.0,
			decay: 0.5,
			delaySend: 0.09,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 6.19,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.5,
			phaseOffset: 0.25,
			rate: 4.4,
			revDamp: 0.8,
			revDrywet: 0.5,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			speed: 0.1,
			startPos: 0.0,
			tempo: 242.7,
			variant: 0.0,
			volume: 0.32
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				delaySend: \gate_prob50,
			duration: \gauss,
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
		density: 0.7,
		feedback: 0.46,
		freeze: 0.0,
		inGain: 1.0,
		lofi: 0.0,
		mix: 1.0,
		mode: 3.0,
		pitch: 0.5,
		position: 0.31,
		reverb: 0.53,
		size: 0.5,
		spread: 0.5,
		texture: 0.5,
		volume: 0.6
	),
	delay: (
		feedback: 0.9,
		filterFreq: 6614.93,
		spread: 0.76,
		time: 0.28
	),
	reverb: (
		damp: 0.18,
		diffuse: 0.56,
		freeze: 0.0,
		hp: 0.28,
		time: 0.85
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
	lfo2: (freq: 0.0333),
	lfo3: (freq: 0.0667),
	lfo7: (freq: 0.0333),
	lfo8: (freq: 0.0667),
	lfo12: (freq: 0.0333),
	lfo13: (freq: 0.0667)
);
// $LFO_SOURCES_END

~applyPatch.();
)
