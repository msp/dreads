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
			decay: 0.6,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 0.35,
			engine: 15.0,
			fmMod: 0.25,
			harm: 0.41,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.05,
			morphMod: 1.0,
			mul: 0.7,
			pitch: 127.0,
			revDamp: 0.78,
			revDrywet: 0.3,
			revFreeze: 0.0,
			revHp: 0.61,
			revTime: 0.25,
			reverbSend: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 1.0,
			timbre: 0.7,
			volume: 0.7
		),
		// $PRESET_SCALARS_END
		// $PRESET_SEQUENCES_START
		(
			decay: Pseq([0.5, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
			div: Pseq([2], inf).asStream,
			duration: Pseq([
				Rest(0.7),
				0.7,
				Rest(0.7),
				Pwrand([Rest(0.7), 0.7], [0.1, 0.9].normalizeSum),
			], inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", "e+11"], inf).asStream,
			harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
			timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream
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
			decay: 0.59,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(1.4),
			engine: 13.0,
			fmMod: 0.7,
			harm: 0.5,
			legato: 0.7,
			lpgColour: 0.5,
			morph: 0.87,
			morphMod: 0.4,
			mul: 0.5,
			pitch: 33.36,
			revDamp: 0.8,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.61,
			revTime: 0.56,
			reverbSend: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.6,
			timbre: 0.28,
			volume: 2.0
		),
		// $PRESET_SCALARS_END
		// $PRESET_SEQUENCES_START
		(
			decay: Pseq([0.5, 0.1], inf).asStream,
			div: Pseq([0.5], inf).asStream,
			duration: Pseq([
				0.7,
				Rest(0.7),
				Rest(0.7),
				Pwrand([Rest(0.7), 0.7], [0.5, 0.5].normalizeSum),
				Rest(0.7),
				Pwrand([Rest(0.7), 0.7], [0.6, 0.4].normalizeSum),
			], inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", "e+1"], inf).asStream,
			morph: Pseq([
				Pwrand([0.1, 0.5, 0.9], [0.4, 0.2, 0.2].normalizeSum),
				0.1,
				0.1,
				0.1,
				0.1,
				0.05
			], inf).asStream
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
			decay: 0.5,
			delaySend: 0.1,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 1.4,
			engine: 6.0,
			fmMod: 0.0,
			harm: 0.48,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.75,
			morphMod: 0.4,
			mul: 0.5,
			pitch: 49.0,
			revDamp: 0.78,
			revDrywet: 0.28,
			revFreeze: 0.0,
			revHp: 0.61,
			revTime: 0.56,
			reverbSend: 0.5,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.6,
			timbre: 0.39,
			volume: 1.15
		),
		// $PRESET_SCALARS_END
		// $PRESET_SEQUENCES_START
		(
			div: Pseq([0.25], inf).asStream,
			duration: Pseq([
				0.7,
				Rest(0.7),
				Rest(0.7),
				Pwrand([Rest(1.4), 0.7], [0.5, 0.5].normalizeSum),
			], inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", "e+9"], inf).asStream
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
			),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
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
			),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
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
			),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
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
		delay: (
			feedback: 0.4,
			filterFreq: 6000,
			spread: 1.5,
			time: 0.25
		),
		reverb: (
			damp: 0.2,
			diffuse: 0.625,
			freeze: 0.0,
			hp: 0.3,
			time: 0.2
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
	lfo1: (freq: 0.2),
	lfo2: (freq: 0.2667),
	lfo3: (freq: 0.0667),
	lfo6: (freq: 0.2),
	lfo7: (freq: 0.2667),
	lfo8: (freq: 0.0667),
	lfo11: (freq: 0.2),
	lfo12: (freq: 0.2667),
	lfo13: (freq: 0.0667)
);
// $LFO_SOURCES_END

~applyPatch.();
)