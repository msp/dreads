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
			cloudsSend: 1.0,
			decay: 0.62,
			delaySend: 0.1,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 0.35,
			engine: 11.0,
			fmMod: 0.85,
			harm: 0.42,
			legato: 0.7,
			lpgColour: 0.5,
			morph: 0.53,
			morphMod: 0.75,
			mul: 0.7,
			pitch: 42.0,
			revDamp: 0.78,
			revDrywet: 0.28,
			revFreeze: 0.0,
			revHp: 0.61,
			revTime: 0.56,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.6,
			timbre: 0.38,
			volume: 0.9
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
			] / 2, inf).asStream,
			div: Pseq([1, 1, 1, 1], inf).asStream
		)
	),
	
	// $PLAITS2
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.5,
			delaySend: 0.1,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(1.4),
			engine: 6.0,
			fmMod: 0.0,
			harm: 0.5,
			legato: 0.7,
			lpgColour: 0.5,
			morph: 0.5,
			morphMod: 0.4,
			mul: 0.5,
			pitch: 49.0,
			revDamp: 0.78,
			revDrywet: 0.28,
			revFreeze: 0.0,
			revHp: 0.61,
			revTime: 0.56,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.6,
			timbre: 0.5,
			volume: 0.0
		),
		// $PRESET_SCALARS_END
		(
			duration: Pseq([
				0.7,
				Rest(0.7),
				Rest(0.7),
				Rest(0.7),
			], inf).asStream,
			div: Pseq([0.5], inf).asStream
		)
	),
	
	// $PLAITS3
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.5,
			delaySend: 0.1,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(1.4),
			engine: 6.0,
			fmMod: 0.0,
			harm: 0.5,
			legato: 0.7,
			lpgColour: 0.5,
			morph: 0.5,
			morphMod: 0.4,
			mul: 0.5,
			pitch: 49.0,
			revDamp: 0.78,
			revDrywet: 0.28,
			revFreeze: 0.0,
			revHp: 0.61,
			revTime: 0.56,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.6,
			timbre: 0.5,
			volume: 0.0
		),
		// $PRESET_SCALARS_END
		(
			duration: Pseq([
				0.7,
				Rest(0.7),
				Rest(0.7),
				Rest(0.7),
			], inf).asStream,
			div: Pseq([0.5], inf).asStream
		)
	)
	],
	// Samples array
	[
		// $SAMPLE1
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.5,
			bankName: \numbers,
			cloudsSend: 0.0,
			decay: 0.5,
			delaySend: 0.0,
			dur: 2.0,
			mul: 1.0,
			panDur: 0.5,
			rate: 1.0,
			reverbSend: 0.0,
			startPos: 0.0,
			tempo: 165.0,
			variant: 1.0,
			volume: 0.64
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				div: Pseq([1/8], inf).asStream
			)
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.5,
			bankName: \default,
			cloudsSend: 0.0,
			decay: 0.5,
			delaySend: 0.0,
			dur: 0.25,
			mul: 1.0,
			panDur: 0.5,
			rate: 1.0,
			reverbSend: 0.0,
			startPos: 0.0,
			tempo: 165.0,
			variant: 0.0,
			volume: 0.0
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
			)
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.5,
			bankName: \default,
			cloudsSend: 0.0,
			decay: 0.5,
			delaySend: 0.0,
			dur: 0.25,
			mul: 1.0,
			panDur: 0.5,
			rate: 1.0,
			reverbSend: 0.0,
			startPos: 0.0,
			tempo: 165.0,
			variant: 0.0,
			volume: 0.0
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
			)
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
		feedback: 0.4,
		filterFreq: 6000.0,
		spread: 1.5,
		time: 0.25
	),
	reverb: (
		damp: 0.2,
		diffuse: 0.63,
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