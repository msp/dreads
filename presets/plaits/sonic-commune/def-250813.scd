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
			decay: 0.5,
			delaySend: 0.17,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 0.7,
			engine: 1.0,
			fmMod: 0.0,
			harm: 0.48,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.43,
			morphMod: 0.4,
			mul: 0.5,
			pitch: 49.0,
			revDamp: 0.8,
			revDrywet: 0.25,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.1,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.3,
			timbre: 0.44,
			volume: 2.0
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
				// div: Pseq([1, 2, 1, 1, 2], inf).asStream
				div: Pseq(
					(0.5 ! 12) ++
					(1.0 ! 60)
					,inf
				).asStream
			)
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.8,
			delaySend: 0.15,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(5.6),
			engine: 6.0,
			fmMod: 0.0,
			harm: 0.48,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.43,
			morphMod: 0.8,
			mul: 0.5,
			pitch: 49.0,
			revDamp: 0.8,
			revDrywet: 0.5,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.1,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.7,
			timbre: 0.44,
			volume: 1.34
		),
			// $PRESET_SCALARS_END
			(
				duration: Pseq([
					0.7,
					Rest(0.7),
					Rest(0.7),
					Rest(0.7),
				], inf).asStream,
				div: Pseq(
					(0.25 ! 16) ++
					(0.5 ! 32) ++
					(0.125 ! 16)
					,inf
				).asStream
			)
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.59,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(5.6),
			engine: 2.0,
			fmMod: 0.0,
			harm: 0.48,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.43,
			morphMod: 0.4,
			mul: 0.5,
			pitch: 49.0,
			revDamp: 0.4,
			revDrywet: 0.7,
			revFreeze: 0.0,
			revHp: 0.4,
			revTime: 0.9,
			reverbSend: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.7,
			timbre: 0.44,
			volume: 0.77
		),
			// $PRESET_SCALARS_END
			(
				duration: Pseq([
					0.7,
					Rest(0.7),
					Rest(0.7),
					Pwrand([Rest(1.4), 0.7], [0.5, 0.5].normalizeSum),
				], inf).asStream,
				div: Pseq(
					(0.25 ! 32) ++
					(0.5 ! 14)
					,inf
				).asStream
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
		volume: 0.0
	),
	delay: (
		feedback: 0.24,
		filterFreq: 4198.58,
		spread: 1.5,
		time: 0.25
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
~tempoClock.tempo = ~plaits.synths[0].tempo/60;

~pushStateToUI.();
)