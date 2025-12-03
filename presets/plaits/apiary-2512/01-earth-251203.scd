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
			decay: 0.07,
			delaySend: 0.0,
			distAmount: 0.15,
			distDrive: 0.0,
			dur: Rest(16.0),
			engine: 10.0,
			fmMod: 0.0,
			harm: 1.0,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.5,
			morphMod: 0.4,
			mul: 0.5,
			pitch: 88.88,
			revDamp: 0.0,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.0,
			revTime: 0.87,
			reverbSend: 0.11,
			sendToPhones: 0.0,
			speed: 0.5,
			stereoMode: 1.0,
			tempo: 85.0,
			timbMod: 0.0,
			timbre: 0.28,
			volume: 0.0
		),
			// $PRESET_SCALARS_END
			(
				timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
				decay: Pgeom(1.0, 0.9, inf).asStream,
				morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
				harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
				lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
				engine: Pseq(["e", "e", "e-5", "e", "e", "e-6"], inf).asStream,
				duration: Pseq([
					(1 ! 2),
					Rest(8),
					Pgeom(1, 0.9, 50),
					Pgeom(0.02, 1.1, 30),
					Rest(12),
					Pgauss(0.01, 1.0, 20),
				], inf).flatten.asStream,
				// div: Pseq([1, 2, 0.5, 1, 2], inf).asStream
			)
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.25,
			decay: 0.12,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 0.14,
			engine: 13.0,
			fmMod: -1.0,
			harm: 1.0,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.69,
			morphMod: 0.8,
			mul: 0.5,
			pitch: 113.32,
			revDamp: 1.0,
			revDrywet: 0.71,
			revFreeze: 0.0,
			revHp: 0.91,
			revTime: 0.89,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 0.5,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.7,
			timbre: 0.78,
			volume: 0.0
		),
			// $PRESET_SCALARS_END
			(
				duration: Pseq([
					1,
					Rest(1),
					Rest(1),
				], inf).asStream,
				div: Pseq([14], inf).asStream
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
			dur: 166.67,
			engine: 10.0,
			fmMod: 0.0,
			harm: 0.52,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.51,
			morphMod: 0.82,
			mul: 0.5,
			pitch: 66.26,
			revDamp: 0.4,
			revDrywet: 1.0,
			revFreeze: 0.0,
			revHp: 0.27,
			revTime: 0.91,
			reverbSend: 1.0,
			sendToPhones: 0.0,
			speed: 3.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 1.0,
			timbre: 0.12,
			volume: 0.1
		),
			// $PRESET_SCALARS_END
			(
				duration: Pseq([
					(1 ! 2),
					Rest(8),
					Pgeom(5, 4.9, 50),
					Pgeom(2.02, 5.1, 30),
					Rest(8),
					Pgauss(0.01, 1.0, 20),
				], inf).flatten.asStream,
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
			cloudsSend: 0.0,
			decay: 0.5,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(32.0),
			legato: 9.0,
			mul: 1.0,
			panDur: 0.5,
			rate: 1.0,
			revDamp: 0.99,
			revDrywet: 0.71,
			revFreeze: 0.0,
			revHp: 0.87,
			revTime: 0.85,
			reverbSend: 0.0,
			speed: 1.0,
			startPos: 0.49,
			tempo: 165.0,
			variant: 17.0,
			volume: 0.05
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				startPos: Pwhite(0.0, 0.9, inf).asStream,
				rate: Pwhite(0.0, 5.0, inf).asStream,
				decay: Pwhite(0.01, 0.05, inf).asStream,
				duration: Pseq([
					Rest(16),
					Pgauss(1.0, 4.0, 3),
				], inf).asStream,
				div: Pseq([1/2], inf).asStream,
				// variant: Pseq([0, 2, 3], inf).asStream
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
			dur: 15.7,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.5,
			rate: 1.0,
			revDamp: 0.0,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.03,
			revTime: 0.3,
			reverbSend: 0.0,
			speed: 1.0,
			startPos: 0.0,
			tempo: 165.0,
			variant: 0.0,
			volume: 0.39
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
			bankName: \Tracks,
			cloudsSend: 0.0,
			decay: 0.05,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 9.73,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.5,
			rate: 2.56,
			revDamp: 0.11,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.0,
			revTime: 1.07,
			reverbSend: 0.72,
			speed: 1.0,
			startPos: 0.5,
			tempo: 165.0,
			variant: 0.0,
			volume: 0.14
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				startPos: Pwhite(0.0, 0.9, inf).asStream,
				rate: Pwhite(0.0, 5.0, inf).asStream,
				decay: Pwhite(0.01, 0.2, inf).asStream,
				// rate: Pseq([0.8, 1.0, 2.5, 4.5, 3.0, 0.1], inf).asStream,
				duration: Pseq([
					Pgauss(4.0, 1.0, 10),
					Rest(8),
				], inf).asStream,
				div: Pseq([1/2], inf).asStream
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
		freeze: 1.0,
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