////////////////////////////////////////////////////////////////////////////////
// Dreads Patch with global FX
////////////////////////////////////////////////////////////////////////////////
(
// var p1Length = 256;
var p1Length = 64;
// var p1Min = 0.03;
var p1Min = 0.05;
var p1Max = 0.3;
var p1Duration;
var p1Div;
var p2Duration;
var p2Div;
var fixed = true;
// var fixed = false;

if(fixed,{
	p1Duration = Pseq([
		Pwrand([0.5, 1.0], [0.9, 0.1].normalizeSum),
		1.0,
		Pwrand([1.0, Rest(1.0)], [0.99, 0.05].normalizeSum),
		Pwrand([1.0, 0.5], [0.7, 0.3].normalizeSum),
	], inf).asStream;

	p1Div = Pseq(
		(4 ! 24) ++
		(2 ! 2)
		// (4 ! 16)
		,inf
	).asStream;

	p2Duration = Pseq([
		Pwrand([0.5, 1.0], [0.9, 0.1].normalizeSum),
		1.0,
		Pwrand([1.0, Rest(1.0)], [0.99, 0.05].normalizeSum),
		Pwrand([1.0, 0.5], [0.7, 0.3].normalizeSum),
	], inf).asStream;

	p2Div = Pseq(
		(4 ! 24) ++
		(1 ! 2)
		// (4 ! 16)
		,inf
	).asStream;
},{
	// p1Duration = ~sinePattern.(p1Length, p1Min, p1Max).asStream;
	p1Duration = Pfunc {
		// ~sineAtBeat.(thisThread.clock.beats, p1Length, p1Min, p1Max)
		~sineAtBeatWithPhase.(thisThread.clock.beats, p1Length, p1Min, p1Max, 0.25)
	}.asStream;
	p1Div = Pseq([1], inf).asStream;
	// p2Duration = ~sinePattern.(p1Length, p1Min, p1Max).asStream;
	p2Duration = Pfunc {
		// ~sineAtBeat.(thisThread.clock.beats, p1Length, p1Min, p1Max)
		~sineAtBeatWithPhase.(thisThread.clock.beats, p1Length, p1Min, p1Max, 0.25)
	}.asStream;
	p2Div = Pseq([1], inf).asStream;
});

~dreads = ~patchFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.0,
			decay: 0.1,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 0.5,
			engine: 11.0,
			fmMod: 0.0,
			harm: 0.56,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.09,
			morphMod: 0.32,
			mul: 0.5,
			phaseOffset: 0.0,
			pitch: 35.72,
			revDamp: 0.18,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.59,
			revTime: 0.71,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 1.0,
			stereoMode: 0.0,
			tempo: 140.0,
			timbMod: 0.39,
			timbre: 0.8,
			volume: 0.61
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				div: Pseq([0.5], inf).asStream,
				// timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
				decay: \euclid,

				// decay: Pseq(0.05 ! 5 ++ 0.3, inf).asStream,
				morph: \gauss,

				// morph: Pseq([0.2, 0.3, 0.25, 0.4], inf).asStream,
				harm: \gauss,

				// harm: Pseq([
				// 0.4, 0.1, 0.6, 0.4,
				// Pwrand([1, 0.3], [0.3, 0.7].normalizeSum)
				// ], inf).asStream,
				// lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
				// lpgColour: Pseq([0.01], inf).asStream,
				engine: Pseq(
					'e' ! 5
					++
					Pwrand([2, 'e'], [0.3, 0.5].normalizeSum),
					inf).asStream,
				mul: Pseq(1.9 ! 5 ++ 0.4, inf).asStream,
				duration: Pseq([1/4], inf).asStream,
				// div: p1Div,
				timbre: \euclid,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.6,
			decay: 0.28,
			delaySend: 0.2,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 16.0,
			engine: 5.0,
			fmMod: 0.0,
			harm: 0.81,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.81,
			morphMod: 0.0,
			mul: 0.5,
			phaseOffset: 0.0,
			pitch: 44.0,
			revDamp: 0.21,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.39,
			revTime: 0.7,
			reverbSend: 0.15,
			sendToPhones: 0.0,
			speed: 0.5,
			stereoMode: 1.0,
			tempo: 140.0,
			timbMod: 0.0,
			timbre: 0.89,
			volume: 1.46
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: Pseq([0.5], inf).asStream,
				// duration: p2Duration,
				div: Pseq([1/16], inf).asStream,
				delaySend: \euclid,
			)
			// $PRESET_SEQUENCES_END
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.16,
			decay: 0.32,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(0.25),
			engine: 13.0,
			fmMod: 0.82,
			harm: 0.82,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.61,
			morphMod: 0.79,
			mul: 0.5,
			phaseOffset: 0.0,
			pitch: 34.0,
			revDamp: 0.21,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.11,
			revTime: 0.75,
			reverbSend: 0.0,
			sendToPhones: 0.0,
			speed: 0.5,
			stereoMode: 0.0,
			tempo: 140.0,
			timbMod: 0.0,
			timbre: 0.17,
			volume: 1.31
		),
			// $PRESET_SCALARS_END
			// $PRESET_SEQUENCES_START
			(
				duration: Pseq([
					1/4,
					Rest(1/4),
					Rest(1/4),
					Rest(1/4),
					// Pwrand([Rest(1.0), 0.5], [0.7, 0.3].normalizeSum),
				], inf).asStream,
				div: Pseq([2], inf).asStream,
				// div: Pseq([2.0], inf).asStream,
				// duration: ~sinePattern.(p1Length, p1Min, p1Max).asStream,
			)
			// $PRESET_SEQUENCES_END
		)
	],
	// Samples array
	[
		// $SAMPLE1
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.84,
			bankName: 'default',
			cloudsSend: 0.68,
			decay: 0.08,
			delaySend: 0.41,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 10.0,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.27,
			phaseOffset: 0.0,
			rate: 3.69,
			revDamp: 0.0,
			revDrywet: 0.11,
			revFreeze: 0.0,
			revHp: 0.7,
			revTime: 0.89,
			reverbSend: 0.33,
			speed: 0.1,
			startPos: 0.0,
			tempo: 140.0,
			variant: 0.0,
			volume: 0.49
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				panDur: \euclid,
				delaySend: \euclid,
				atk: \ramp,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),

		// $SAMPLE2
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.72,
			bankName: 'msp-iris-hits',
			cloudsSend: 0.41,
			decay: 0.08,
			delaySend: 0.13,
			distAmount: 0.03,
			distDrive: 0.0,
			dur: 1.0,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.07,
			phaseOffset: 0.0,
			rate: 3.29,
			revDamp: 0.59,
			revDrywet: 0.29,
			revFreeze: 0.0,
			revHp: 0.33,
			revTime: 0.74,
			reverbSend: 0.0,
			speed: 1.0,
			startPos: 0.0,
			tempo: 140.0,
			variant: 14.0,
			volume: 0.28
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		),

		// $SAMPLE3
		~sampleFactory.(
			// $PRESET_SAMPLE_SCALARS_START
		(
			atk: 0.0,
			bankName: 'msp-amencutup',
			cloudsSend: 0.09,
			decay: 0.45,
			delaySend: 0.18,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 1.0,
			legato: 0.7,
			mul: 1.0,
			panDur: 0.09,
			phaseOffset: 0.0,
			rate: 1.8,
			revDamp: 0.41,
			revDrywet: 0.58,
			revFreeze: 0.0,
			revHp: 0.27,
			revTime: 0.43,
			reverbSend: 0.03,
			speed: 1.0,
			startPos: 0.0,
			tempo: 140.0,
			variant: 0.0,
			volume: 0.46
		),
			// $PRESET_SAMPLE_SCALARS_END
			// $PRESET_SAMPLE_SEQUENCES_START
			(
				// variant: Pseq((0..31), inf).asStream
				variant: Pseq([8, 9, 10], inf).asStream,
				duration: Pseq([2], inf).asStream,
				div: Pseq([
					2,
					2,
					2,
					Rest(2)
				], inf).asStream,
			delaySend: \euclid,
			revDrywet: \euclid,
			)
			// $PRESET_SAMPLE_SEQUENCES_END
		)
	],
	// Global FX settings
	// $PRESET_FX_START
(
	clouds: (
		blend: 0.5,
		density: 0.7,
		feedback: 0.56,
		freeze: 0.0,
		inGain: 1.0,
		lofi: 0.0,
		mix: 1.0,
		mode: 3.0,
		pitch: 35.55,
		position: 0.5,
		reverb: 0.0,
		size: 0.5,
		spread: 0.5,
		texture: 0.57,
		volume: 0.0
	),
	delay: (
		feedback: 0.48,
		filterFreq: 6050.57,
		spread: 1.0,
		time: 0.21
	),
	reverb: (
		damp: 0.8,
		diffuse: 0.63,
		freeze: 0.0,
		hp: 0.3,
		time: 0.57
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
~decayLFO = ~lfoSine.(5);
~tempoClock.tempo = ~dreads.synths[0].tempo/60;

~pushStateToUI.();
)