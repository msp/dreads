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
			cloudsSend: 1.0,
			decay: 0.05,
			delaySend: 0.82,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 14.0,
			engine: 2.0,
			fmMod: 0.0,
			harm: 0.45,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.72,
			morphMod: 0.4,
			mul: 0.5,
			pitch: 66.02,
			revDamp: 0.0,
			revDrywet: 0.26,
			revFreeze: 0.0,
			revHp: 0.0,
			revTime: 0.44,
			reverbSend: 0.76,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.0,
			timbre: 0.75,
			volume: 1.49
		),
			// $PRESET_SCALARS_END
			(
				timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
				decay: Pseq([0.1, 0.3, Pseq([0.6, 0.1, 0.8] / 3)] / 1, inf).asStream,
				morph: Pseq(0.2 ! 19 ++ 0.5, inf).asStream,
				harm: Pseq(0.5 ! 5 ++ 0.3, inf).asStream,
				lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
				engine: Pseq(["e", "e", "e-5", "e", "e", "e-6"], inf).asStream,
				duration: Pseq([0.5,1,2,3,4,5, 6,7,8], inf).asStream,
				// duration: Pseq([0.3], inf).asStream,
				div: Pseq([1, 2, 0.5, 1, 4], inf).asStream
			)
		),
		
		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.78,
			delaySend: 0.0,
			distAmount: 0.5,
			distDrive: 0.1,
			dur: Rest(14.0),
			engine: 13.0,
			fmMod: 0.0,
			harm: 0.15,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 1.0,
			morphMod: 0.8,
			mul: 0.5,
			pitch: 35.66,
			revDamp: 0.48,
			revDrywet: 0.63,
			revFreeze: 0.0,
			revHp: 0.0,
			revTime: 0.93,
			reverbSend: 0.1,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.7,
			timbre: 0.98,
			volume: 2.0
		),
			// $PRESET_SCALARS_END
			(
				duration: Pseq([
					0.5,
					Rest(7),
				], inf).asStream,
				div: Pseq([0.5], inf).asStream
			)
		),
		
		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.88,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(11.2),
			engine: 0.0,
			fmMod: 0.0,
			harm: 0.49,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.45,
			morphMod: 1.0,
			mul: 0.5,
			pitch: 35.19,
			revDamp: 0.4,
			revDrywet: 0.8,
			revFreeze: 0.0,
			revHp: 0.0,
			revTime: 0.85,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 1.0,
			timbre: 0.23,
			volume: 0.16
		),
			// $PRESET_SCALARS_END
			(
				morph: Pseq([0.1, 0.2, 0.4, 0.8], inf).asStream,
				timbre: Pseq([0.2, 0.4, 0.8], inf).asStream,
				duration: Pseq([
					1.4,
					Rest(1.4),
					Rest(1.4),
					Pwrand([Rest(2.8), 1.4], [0.5, 0.5].normalizeSum),
				], inf).asStream,
				div: Pseq([0.5, 0.25, 1], inf).asStream
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
			decay: 0.25,
			delaySend: 0.0,
			dur: 16.0,
			mul: 1.0,
			panDur: 0.5,
			rate: 1.0,
			reverbSend: 0.0,
			startPos: 0.0,
			tempo: 165.0,
			variant: 0.0,
			volume: 1.37
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				div: Pseq([1/16], inf).asStream
			)
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.0,
			bankName: \halfmastv6,
			cloudsSend: 0.0,
			decay: 0.56,
			delaySend: 0.14,
			dur: 4.0,
			mul: 1.0,
			panDur: 0.5,
			rate: 2.55,
			reverbSend: 0.0,
			startPos: 0.0,
			tempo: 165.0,
			variant: 0.0,
			volume: 0.19
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				div: Pseq([0.5, 0.25, 1], inf).asStream
			)
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.05,
			bankName: \halfmastv6,
			cloudsSend: 0.7,
			decay: 0.5,
			delaySend: 0.14,
			dur: 1.0,
			mul: 1.0,
			panDur: 0.5,
			rate: 1.04,
			reverbSend: 0.74,
			startPos: 0.24,
			tempo: 165.0,
			variant: 2.0,
			volume: 0.1
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