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
			dur: 7.0,
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
			tempo: 120.0,
			timbMod: 0.0,
			timbre: 0.75,
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
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(14.0),
			engine: 13.0,
			fmMod: 0.0,
			harm: 0.06,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 1.0,
			morphMod: 0.8,
			mul: 0.5,
			pitch: 35.66,
			revDamp: 0.48,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.0,
			revTime: 0.93,
			reverbSend: 0.67,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 120.0,
			timbMod: 0.7,
			timbre: 1.0,
			volume: 1.01
		),
			// $PRESET_SCALARS_END
			(
				duration: Pseq([
					2,
					Rest(14),
				], inf).asStream,
				div: Pseq([1], inf).asStream
			)
		),
		
		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.65,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(14.0),
			engine: 2.0,
			fmMod: 0.0,
			harm: 0.38,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.49,
			morphMod: 0.43,
			mul: 0.5,
			pitch: 42.02,
			revDamp: 0.4,
			revDrywet: 0.27,
			revFreeze: 0.0,
			revHp: 0.0,
			revTime: 0.5,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			stereoMode: 1.0,
			tempo: 120.0,
			timbMod: 0.47,
			timbre: 0.3,
			volume: 0.67
		),
			// $PRESET_SCALARS_END
			(
				duration: Pseq([
					2,
					Rest(14),
				], inf).asStream,
				div: Pseq([1], inf).asStream
			)
		)
	],
	// Samples array
	[
		// $SAMPLE1
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.0,
			bankName: \impacts,
			cloudsSend: 0.0,
			decay: 0.67,
			delaySend: 0.14,
			distAmount: 0.11,
			distDrive: 0.0,
			dur: Rest(15.0),
			mul: 1.0,
			panDur: 0.5,
			rate: 2.01,
			revDamp: 0.38,
			revDrywet: 0.18,
			revFreeze: 0.0,
			revHp: 0.14,
			revTime: 0.97,
			reverbSend: 0.28,
			startPos: 0.06,
			tempo: 120.0,
			variant: 1.0,
			volume: 1.01
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				duration: Pseq([
					1,
					Rest(15),
				], inf).asStream,
				div: Pseq([1], inf).asStream
			)
		),
		
		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.0,
			bankName: \subrumble,
			cloudsSend: 0.0,
			decay: 0.56,
			delaySend: 0.14,
			distAmount: 0.13,
			distDrive: 0.0,
			dur: Rest(14.0),
			mul: 1.0,
			panDur: 0.5,
			rate: 2.55,
			revDamp: 0.8,
			revDrywet: 0.25,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.0,
			startPos: 0.0,
			tempo: 120.0,
			variant: 0.0,
			volume: 1.01
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				duration: Pseq([
					2,
					Rest(14),
				], inf).asStream,
				div: Pseq([1], inf).asStream
			)
		),
		
		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.0,
			bankName: \halfmastv6,
			cloudsSend: 0.7,
			decay: 0.05,
			delaySend: 0.14,
			distAmount: 0.14,
			distDrive: 0.0,
			dur: Rest(14.0),
			mul: 1.0,
			panDur: 0.5,
			rate: 0.4,
			revDamp: 0.8,
			revDrywet: 0.25,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.3,
			reverbSend: 0.74,
			startPos: 0.32,
			tempo: 120.0,
			variant: 20.0,
			volume: 1.38
		),
			// $PRESET_SAMPLE_SCALARS_END
			(
				duration: Pseq([
					2,
					Rest(14),
				], inf).asStream,
				div: Pseq([1], inf).asStream
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
		time: 0.72
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