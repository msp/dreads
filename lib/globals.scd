//////////////////////////////////////////////////////////////////////////////
// Global utility functions and shared state
//////////////////////////////////////////////////////////////////////////////
(
// Default tempo, will be updated by presets
~tempoClock = TempoClock.new(120/60);

~delayBus = Bus.audio(s, 2);
~reverbBus = Bus.audio(s, 2);
~cloudsBus = Bus.audio(s, 2);
~sendToPhones = false;

~ui = {
	if (~uiAddr.isNil) {
		~uiAddr = NetAddr("127.0.0.1", 8080);
	};
	~uiAddr;
};

~td = {
	if (~tdAddr.isNil) {
		~tdAddr = NetAddr("127.0.0.1", 10000);
	};
	~tdAddr;
};

~ws = {
	if (~wsAddr.isNil) {
		~wsAddr = NetAddr("127.0.0.1", 3333);
	};
	~wsAddr;
};

~saveAllModified = {
	Document.allDocuments.do{ |doc, index|
		[index, doc.isEdited, doc.path].postln;
		if (doc.path.notNil && doc.isEdited) {
			var file = File(doc.path, "w");
			("Saving editor changes: " ++ doc.path.basename).postln;
			file.write(doc.string);
			file.close;
		};
	};
	nil; // Explicitly return nil to avoid any return value issues
};

// Default scalar values for all plaits instances
~defaultScalars = (
	cloudsSend: 1.0,
	decay: 0.5,
	delaySend: 0.0,
	distAmount: 0.0,
	distDrive: 0.0,
	dur: 0.25,
	engine: 1.0,
	fmMod: 0.0,
	harm: 0.5,
	legato: 0.7,
	lpgColour: 0.5,
	morphMod: 0.0,
	morph: 0.5,
	mul: 0.5,
	pitch: 49.0,
	revDamp: 0.8,
	revDrywet: 0.0,
	revFreeze: 0.0,
	revHp: 0.7,
	revTime: 0.5,
	reverbSend: 0.0,
	sendToPhones: 0.0,
	stereoMode: 1.0,
	tempo: 165.0,
	timbMod: 0.0,
	timbre: 0.5,
	volume: 1.0,
);

// Default global FX settings for all presets
~defaultFX = (
	clouds: (
		blend: 0.5,
		density: 0.7,
		inGain: 1.0,
		lofi: 0.0,
		feedback: 0.0,
		freeze: 0.0,
		mode: 3,
		mix: 1.0,
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
		filterFreq: 6000,
		spread: 1.5,
		time: 0.25
	),
	reverb: (
		damp: 0.2,
		diffuse: 0.625,
		freeze: 0.0,
		hp: 0.3,
		time: 0.2
	)
);

// Default sequence patterns for all plaits instances
~defaultSequences = (
	cloudsSend: Pseq([0.5], inf).asStream,
	decay: Pseq([0.5], inf).asStream,
	delaySend: Pseq([0.5], inf).asStream,
	div: Pseq([1.0], inf).asStream,
	duration: Pseq([0.25], inf).asStream,
	engine: Pseq(["e"], inf).asStream,
	fmMod: Pseq([0.5], inf).asStream,
	harm: Pseq([0.5], inf).asStream,
	lpgColour: Pseq([0.5], inf).asStream,
	morph: Pseq([0.5], inf).asStream,
	revTime: Pseq([0.5], inf).asStream,
	reverbSend: Pseq([0.5], inf).asStream,
	timbre: Pseq([0.5], inf).asStream,
	volume: Pseq([0.5], inf).asStream,
	mul: Pseq([0.5], inf).asStream
);

// Sample buffer storage (just-in-time loading)
~sampleBuffers = Dictionary.new;

// Default scalar values for sample instances
~defaultSampleScalars = (
	atk: 0.01,
	cloudsSend: 0.0,
	decay: 0.1,
	delaySend: 0.0,
	dur: 0.25,
	mul: 1.0,
	panDur: 5.0,
	rate: 1.0,
	reverbSend: 0.0,
	samplePath: nil,  // Path to sample file on disk
	startPos: 0,
	tempo: 165.0,
	volume: 0.7
);

// Default sequence patterns for sample instances
~defaultSampleSequences = (
	atk: Pseq([0.5], inf).asStream,      // 0-1 normalized (uses ~modulateBipolar)
	cloudsSend: Pseq([0.0], inf).asStream,
	decay: Pseq([30.0], inf).asStream,   // Neutral = max/2 = 60/2 (uses ~modulateBipolarScaled)
	delaySend: Pseq([0.0], inf).asStream,
	div: Pseq([1.0], inf).asStream,
	duration: Pseq([0.25], inf).asStream,
	mul: Pseq([1.0], inf).asStream,
	rate: Pseq([1.0], inf).asStream,      // Multiplier (uses ~multiply)
	reverbSend: Pseq([0.0], inf).asStream,
	startPos: Pseq([0], inf).asStream     // Additive (uses ~add)
);
)