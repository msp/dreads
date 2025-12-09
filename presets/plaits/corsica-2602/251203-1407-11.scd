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
			cloudsSend: 0.0,
			decay: 0.82,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 17.04,
			engine: 8.0,
			fmMod: -0.02,
			harm: 0.03,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.25,
			morphMod: 1.0,
			mul: 0.5,
			pitch: 80.48,
			revDamp: 0.62,
			revDrywet: 0.22,
			revFreeze: 0.0,
			revHp: 0.0,
			revTime: 0.85,
			reverbSend: 0.64,
			sendToPhones: 0.0,
			speed: 1.0 ,
			stereoMode: 1.0,
			tempo: 85.0,
			timbMod: 1.0,
			timbre: 0.69,
			volume: 0.18
		),
			// $PRESET_SCALARS_END
			(
				timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
				decay: Pgeom(1.0, 0.9, inf).asStream,
				// lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
				engine: Pseq(["e", "e", "e", "e", "e", "e"], inf).asStream,
				duration: Pseq([
					(1 ! 2),
					Rest(8),
					Pgauss(3, 2.0, 10),
				], inf).flatten.asStream,
				div: Pseq([1/4], inf).asStream
			)
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.25,
			decay: 0.66,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 1.0,
			engine: 12.0,
			fmMod: -0.02,
			harm: 0.63,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.69,
			morphMod: 0.8,
			mul: 0.5,
			pitch: 113.32,
			revDamp: 0.69,
			revDrywet: 0.52,
			revFreeze: 0.0,
			revHp: 0.83,
			revTime: 0.89,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 1.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.7,
			timbre: 0.78,
			volume: 0.17
		),
			// $PRESET_SCALARS_END
			(
				harm: Pseq([
					1.0,
					0.9,
					Pwrand([1.0, 0.8], [0.5, 0.5].normalizeSum),
					1.0,
					0.9
				], inf).asStream,
				morph: Pseq([1.0, 0.1, 0.3, 0.9], inf).asStream,
				duration: Pseq([
					1,
					Rest(1),
					Rest(1),
				], inf).asStream,
				div: Pseq([1/4], inf).asStream
			)
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.0,
			decay: 1.0,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 0.33,
			engine: 10.0,
			fmMod: 0.0,
			harm: 0.52,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.51,
			morphMod: 0.82,
			mul: 0.5,
			pitch: 66.26,
			revDamp: 0.59,
			revDrywet: 1.0,
			revFreeze: 0.0,
			revHp: 0.0,
			revTime: 0.91,
			reverbSend: 0.95,
			sendToPhones: 0.0,
			speed: 3.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 1.0,
			timbre: 0.12,
			volume: 0.09
		),
			// $PRESET_SCALARS_END
			(
				// duration: Pseq([
				// 	(1 ! 2),
				// 	Rest(8),
				// 	Pgeom(5, 4.9, 50),
				// 	Pgeom(2.02, 5.1, 30),
				// 	Rest(8),
				// 	Pgauss(0.01, 1.0, 20),
				// ], inf).flatten.asStream,
				div: Pseq([1/4], inf).asStream,
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
			bankName: \SoundFX,
			cloudsSend: 1.0,
			decay: 0.5,
			delaySend: 0.0,
			distAmount: 0.13,
			distDrive: 0.0,
			dur: 45.29,
			legato: 9.0,
			mul: 1.0,
			panDur: 0.5,
			rate: 0.22,
			revDamp: 0.0,
			revDrywet: 0.9,
			revFreeze: 0.0,
			revHp: 0.87,
			revTime: 0.85,
			reverbSend: 0.0,
			speed: 1.0,
			startPos: 0.0,
			tempo: 165.0,
			variant: 19.0,
			volume: 0.0
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				duration: Pseq([
					Rest(1),
					Rest(1),
					Pgauss(1.0, 4.0, 20),
				], inf).asStream,
				div: Pseq([1/7], inf).asStream,
				variant: Pseq([0, 2, 3], inf).asStream
			)
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.0,
			bankName: \subrumble,
			cloudsSend: 0.0,
			decay: 0.5,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 12.58,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.5,
			rate: 1.0,
			revDamp: 0.0,
			revDrywet: 0.21,
			revFreeze: 0.0,
			revHp: 0.03,
			revTime: 0.3,
			reverbSend: 0.0,
			speed: 1.0,
			startPos: 0.0,
			tempo: 165.0,
			variant: 0.0,
			volume: 0.0
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				duration: Pseq([
					Rest(1),
					Rest(1),
					Pgauss(1.0, 4.0, 20),
				], inf).asStream,
				div: Pseq([1/6], inf).asStream,

			)
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.0,
			bankName: \default,
			cloudsSend: 0.0,
			decay: 0.86,
			delaySend: 0.11,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(0.071428571428571),
			legato: 0.7,
			mul: 1.0,
			panDur: 0.5,
			rate: 5.0,
			revDamp: 0.8,
			revDrywet: 1.0,
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
			(
				duration: Pseq([
					1,
					Rest(1),
					Rest(1),
				], inf).asStream,
				div: Pseq([14], inf).asStream
			)
		)
	],
	// Global FX settings
	// $PRESET_FX_START
(
	clouds: (
		blend: 0.5,
		density: 0.33,
		feedback: 0.5,
		freeze: 0.0,
		inGain: 1.0,
		lofi: 0.0,
		mix: 1.0,
		mode: 3.0,
		pitch: 37.0,
		position: 0.5,
		reverb: 0.0,
		size: 0.18,
		spread: 0.5,
		texture: 0.39,
		volume: 0.17
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
		hp: 0.27,
		time: 1.03
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