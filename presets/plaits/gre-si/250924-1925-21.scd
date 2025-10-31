////////////////////////////////////////////////////////////////////////////////
// Plaits State - Template-based default preset
////////////////////////////////////////////////////////////////////////////////
(
~plaits = ~presetFactory.(
	// Synth instances array
	[
	// $PLAITS1
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			cloudsSend: 0.05,
			decay: 1.0,
			delaySend: 0.0,
			distAmount: 0.04,
			distDrive: 0.0,
			dur: 2.0,
			engine: 2.0,
			fmMod: 0.0,
			harm: 0.39,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.75,
			morphMod: 0.4,
			mul: 0.5,
			pitch: 90.59,
			revDamp: 0.0,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.0,
			revTime: 0.28,
			reverbSend: 0.29,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.0,
			timbre: 0.71,
			volume: 0.0
		),
		// $PRESET_SCALARS_END
		(
			timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
			decay: Pseq([0.1, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
			morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
			harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
			lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
			engine: Pseq(["e", "e", "e-5", "e", "e", "e-6"], inf).asStream,
				duration: Pseq([0.5,1,2,3,4,5], inf).asStream,
				// duration: Pseq([0.3], inf).asStream,
				div: Pseq([1, 2, 0.5, 1, 2], inf).asStream
		)
	),

	// $PLAITS2
	~plaitsFactory.(
		// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.87,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(1.4),
			engine: 9.0,
			fmMod: 0.0,
			harm: 0.16,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.55,
			morphMod: 0.8,
			mul: 0.5,
			pitch: 29.39,
			revDamp: 0.24,
			revDrywet: 0.83,
			revFreeze: 0.0,
			revHp: 0.06,
			revTime: 1.09,
			reverbSend: 0.45,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.7,
			timbre: 0.1,
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
			decay: 1.0,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(1.4),
			engine: 5.0,
			fmMod: 0.0,
			harm: 0.42,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.7,
			morphMod: 1.0,
			mul: 0.5,
			pitch: 22.97,
			revDamp: 0.4,
			revDrywet: 0.8,
			revFreeze: 0.0,
			revHp: 0.27,
			revTime: 0.9,
			reverbSend: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 1.0,
			timbre: 0.75,
			volume: 1.63
		),
		// $PRESET_SCALARS_END
		(
			duration: Pseq([
				1.4,
				Rest(1.4),
				Rest(1.4),
				Pwrand([Rest(2.8), 1.4], [0.5, 0.5].normalizeSum),
			], inf).asStream,
			div: Pseq([1], inf).asStream
		)
	)
	],
	// Samples array
	[],
	// Global FX settings
	// $PRESET_FX_START
(
	clouds: (
		blend: 0.5,
		density: 0.33,
		feedback: 0.59,
		freeze: 0.0,
		inGain: 1.0,
		lofi: 0.0,
		mix: 1.0,
		mode: 3.0,
		pitch: -19.05,
		position: 0.5,
		reverb: 0.0,
		size: 0.18,
		spread: 0.5,
		texture: 0.5,
		volume: 0.47
	),
	delay: (
		feedback: 0.93,
		filterFreq: 7545.34,
		spread: 1.5,
		time: 0.25
	),
	reverb: (
		damp: 0.2,
		diffuse: 0.63,
		freeze: 0.0,
		hp: 0.3,
		time: 1.06
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