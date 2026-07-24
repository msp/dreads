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
			decay: 0.48,
			delaySend: 0.0,
			distAmount: 0.04,
			distDrive: 0.3,
			dur: Rest(0.25),
			engine: 13.0,
			fmMod: 0.49,
			harm: 0.83,
			legato: 0.7,
			lpgColour: 0.5,
			morph: 0.22,
			morphMod: 0.0,
			mul: 0.5,
			pitch: 34.47,
			revDamp: 0.8,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 1.25,
			reverbSend: 0.0,
			stereoMode: 0.0,
			tempo: 125.0,
			timbMod: 0.0,
			timbre: 0.68,
			volume: 1.36
		),
		// $PRESET_SCALARS_END
		// $PRESET_SEQUENCES_START
		(
			div: Pseq(1 ! 63 ++ (1.0), inf).asStream,
			duration: Pseq([
				0.25,
				Rest(0.25),
				Pwrand([0.25, Rest(0.25)], [0.95, 0.05].normalizeSum),
				Rest(0.25),
				Rest(0.25),
				Pwrand([0.25, Rest(0.25)], [0.95, 0.05].normalizeSum),
				Rest(0.25),
				Pwrand([Rest(0.25), 0.25], [0.6, 0.4].normalizeSum),
			], inf).asStream,
			engine: Pseq(["e", "e+1", "e", "e", "e", "e"], inf).asStream,
			lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
			morph: Pseq([
				0.3,
				0.2,
				0.5,
				0.5,
				0.5,
				0.6,
				0.5,
				0.2,
			], inf).asStream
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
			decay: 0.18,
			delaySend: 0.0,
			distAmount: 0.03,
			distDrive: 0.1,
			dur: Rest(0.25),
			engine: 2.0,
			fmMod: 0.0,
			harm: 0.86,
			legato: 0.1,
			lpgColour: 0.5,
			morph: 0.24,
			morphMod: 0.46,
			mul: 0.5,
			pitch: 58.5,
			revDamp: 0.48,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.39,
			revTime: 0.0,
			reverbSend: 0.63,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 1.0,
			timbre: 0.81,
			volume: 1.32
		),
		// $PRESET_SCALARS_END
		// $PRESET_SEQUENCES_START
		(
			div: Pseq(1 ! 127 ++ (0.5), inf).asStream,
			duration: Pseq([
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				0.25,
			], inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", 0], inf).asStream
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
			decay: 0.53,
			delaySend: 0.0,
			distAmount: 0.2,
			distDrive: 0.4,
			dur: Rest(0.25),
			engine: 15.0,
			fmMod: 0.0,
			harm: 0.48,
			legato: 4.0,
			lpgColour: 0.5,
			morph: 0.23,
			morphMod: 0.93,
			mul: 0.5,
			pitch: 49.0,
			revDamp: 0.08,
			revDrywet: 0.67,
			revFreeze: 0.0,
			revHp: 0.69,
			revTime: 0.9,
			reverbSend: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.7,
			timbre: 0.44,
			volume: 0.46
		),
		// $PRESET_SCALARS_END
		// $PRESET_SEQUENCES_START
		(
			div: Pseq(1 ! 63 ++ (0.5), inf).asStream,
			duration: Pseq([
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				Rest(0.25),
				0.25,
			], inf).asStream,
			engine: Pseq(["e", "e", "e", "e", "e", "e-1"], inf).asStream
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