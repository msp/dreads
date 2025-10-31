////////////////////////////////////////////////////////////////////////////////
// Plaits State - Template-based default preset with global FX
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
// var fixed = true;
var fixed = false;

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

~plaits = ~presetFactory.(
	// Synth instances array
	[
		// $PLAITS1
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 0.97,
			decay: 0.5,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 0.05,
			engine: 11.0,
			fmMod: 0.0,
			harm: 0.59,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.5,
			morphMod: 0.1,
			mul: 0.5,
			pitch: 54.0,
			revDamp: 0.18,
			revDrywet: 0.0,
			revFreeze: 0.0,
			revHp: 0.59,
			revTime: 0.71,
			reverbSend: 0.0,
			stereoMode: 0.0,
			tempo: 40.0,
			timbMod: 0.3,
			timbre: 0.65,
			volume: 1.47
		),
			// $PRESET_SCALARS_END
			(
				// timbre: Pseq([0.0, 0.5, 0.2, 0.6, 1.0], inf).asStream,
				decay: Pseq(0.05 ! 5 ++ 0.3, inf).asStream,
				morph: Pseq([0.2, 0.3, 0.25, 0.4], inf).asStream,
				harm: Pseq([
					0.4, 0.1, 0.6, 0.4,
					Pwrand([1, 0.3], [0.3, 0.7].normalizeSum)
				], inf).asStream,
				// lpgColour: Pseq([0.1, 0.2, 0.4, 1], inf).asStream,
				// lpgColour: Pseq([0.01], inf).asStream,
				engine: Pseq(
					'e' ! 5
					++
					Pwrand([2, 'e'], [0.3, 0.5].normalizeSum),
					inf).asStream,
				mul: Pseq(1.9 ! 5 ++ 0.4, inf).asStream,
				duration: p1Duration,
				div: p1Div,
			)
		),

		// $PLAITS2
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.26,
			delaySend: 0.0,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: 0.05,
			engine: 5.0,
			fmMod: 0.0,
			harm: 0.64,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.55,
			morphMod: 0.8,
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
			timbMod: 0.7,
			timbre: 0.44,
			volume: 0.0
		),
			// $PRESET_SCALARS_END
			(
				duration: p2Duration,
				div: p2Div,
			)
		),

		// $PLAITS3
		~plaitsFactory.(
			// $PRESET_SCALARS_START
		(
			cloudsSend: 1.0,
			decay: 0.42,
			delaySend: 0.26,
			distAmount: 0.0,
			distDrive: 0.0,
			dur: Rest(1.0),
			engine: 6.0,
			fmMod: 0.0,
			harm: 0.48,
			legato: 9.0,
			lpgColour: 0.5,
			morph: 0.43,
			morphMod: 0.4,
			mul: 0.5,
			pitch: 54.0,
			revDamp: 0.4,
			revDrywet: 0.34,
			revFreeze: 0.0,
			revHp: 0.4,
			revTime: 0.9,
			reverbSend: 0.28,
			stereoMode: 1.0,
			tempo: 165.0,
			timbMod: 0.7,
			timbre: 0.63,
			volume: 0.0
		),
			// $PRESET_SCALARS_END
			(
				duration: Pseq([
					0.5,
					Rest(0.5),
					Rest(0.5),
					Rest(0.5),
					Pwrand([Rest(1.0), 0.5], [0.7, 0.3].normalizeSum),
				], inf).asStream,
				div: Pseq([0.5], inf).asStream,
				// div: Pseq([2.0], inf).asStream,
				// duration: ~sinePattern.(p1Length, p1Min, p1Max).asStream
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
		feedback: 0.44,
		filterFreq: 1030.72,
		spread: 0.5,
		time: 0.26
	),
	reverb: (
		damp: 0.6,
		diffuse: 0.63,
		freeze: 0.0,
		hp: 0.3,
		time: 0.34
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
~tempoClock.tempo = ~plaits.synths[0].tempo/60;

~pushStateToUI.();
)