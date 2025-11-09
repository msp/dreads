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
			cloudsSend: 0.66,
			decay: 0.21,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 4.23,
			engine: 4.0,
			fmMod: -0.05,
			harm: 0.66,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.17,
			morphMod: 1.0,
			mul: 0.5,
			pitch: 17.37,
			revDamp: 0.15,
			revDrywet: 0.2,
			revFreeze: 0.0,
			revHp: 0.29,
			revTime: 0.93,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 85.0,
			timbMod: 1.0,
			timbre: 1.0,
			volume: 1.49
		),
			// $PRESET_SCALARS_END
			(
				timbre: Pgauss(0.0, 1.0, inf).asStream,
				decay: Pgauss(0.0, 0.01, inf).asStream,
				morph: Pgbrown(1.0, 1.0, 1.0, inf).asStream,
				harm: Pgauss(0.0, 1.0, inf).asStream,
				// lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
				engine: Pseq(["e-2", "e", "e+5", "e", "e+1", "e+4"], inf).asStream,
				duration: Pgauss(0.1, 2.0, inf).asStream,
				// div: Pseq([1, 3, 1, 1, 2], inf).asStream,
				reverbSend: Pgauss(0.0, 0.2, inf).asStream,
				// revTime: Pwhite(1.0, 1.2, inf).asStream,
			)
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.1,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 16.36,
			engine: 13.0,
			fmMod: 0.0,
			harm: 0.48,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.43,
			morphMod: 0.8,
			mul: 0.5,
			pitch: 90.0,
			revDamp: 0.8,
			revDrywet: 0.25,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.1,
			sendToPhones: 1.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.7,
			timbre: 0.44,
			volume: 0.7
		),
			// $PRESET_SCALARS_END
			(
				duration: Pgauss(3.0, 8.0, inf).asStream,
				div: Pseq([0.5], inf).asStream
			)
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.77,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 9.54,
			engine: 14.0,
			fmMod: 0.0,
			harm: 0.48,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 1.0,
			morphMod: 1.0,
			mul: 0.5,
			pitch: 33.09,
			revDamp: 0.58,
			revDrywet: 0.58,
			revFreeze: 0.0,
			revHp: 0.45,
			revTime: 0.56,
			reverbSend: 0.19,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 1.0,
			timbre: 0.44,
			volume: 0.5
		),
			// $PRESET_SCALARS_END
			(
				duration: Pwhite(5.0, 10.0, inf).asStream,
				// div: Pseq([0.5], inf).asStream,
				revTime: Pwhite(0.4, 1.1, inf).asStream,
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
			bankName: \default,
			cloudsSend: 0.0,
			decay: 0.5,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 2.55,
			mul: 1.0,
			panDur: 0.5,
			rate: 1.0,
			revDamp: 0.8,
			revDrywet: 0.25,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			startPos: 0.0,
			tempo: 165.0,
			variant: 0.0,
			volume: 0.7
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				duration: Pwhite(1.0, 5.0, inf).asStream,
				// div: Pseq([0.5], inf).asStream,
				rate: Pgauss(0.0, 1.0, inf).asStream,
				decay: Pgauss(0.1, 1.0, inf).asStream,
			)
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.5,
			bankName: \subrumble,
			cloudsSend: 0.0,
			decay: 0.5,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 2.95,
			mul: 1.0,
			panDur: 0.5,
			rate: 1.0,
			revDamp: 0.0,
			revDrywet: 0.82,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			startPos: 0.0,
			tempo: 165.0,
			variant: 0.0,
			volume: 1.28
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				duration: Pwhite(1.0, 5.0, inf).asStream,
				// div: Pseq([0.5], inf).asStream,
				rate: Pgauss(0.9, 1.1, inf).asStream,
				decay: Pgauss(0.1, 1.0, inf).asStream,
			)
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.5,
			bankName: \hum,
			cloudsSend: 0.0,
			decay: 0.5,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 3.28,
			mul: 1.0,
			panDur: 0.5,
			rate: 1.0,
			revDamp: 0.8,
			revDrywet: 0.85,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			startPos: 0.0,
			tempo: 165.0,
			variant: 4.0,
			volume: 0.12
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				duration: Pwhite(1.0, 5.0, inf).asStream,
				// div: Pseq([0.5], inf).asStream,
				rate: Pgauss(0.9, 1.1, inf).asStream,
				decay: Pgauss(0.1, 1.0, inf).asStream,
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
		volume: 0.09
	),
	delay: (
		feedback: 0.0,
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