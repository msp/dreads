//////////////////////////////////////////////////////////////////////////////
// Global utility functions and shared state
//////////////////////////////////////////////////////////////////////////////
(
// Default tempo, will be updated by presets
~tempoClock = TempoClock.new(120/60);

~delayBus = Bus.audio(s, 2);
~reverbBus = Bus.audio(s, 2);

~ui = {
	if (~uiAddr.isNil) {
		~uiAddr = NetAddr("127.0.0.1", 8080);
	};
	~uiAddr;
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
	stereoMode: 1.0,
	tempo: 165.0,
	timbMod: 0.0,
	timbre: 0.5,
	volume: 1.0,
);

// Default global FX settings for all presets
~defaultFX = (
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
	timbre: Pseq([0.5], inf).asStream
);
)