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
	pitch: 49.0,
	harm: 0.5,
	timbre: 0.5,
	morph: 0.5,
	decay: 0.5,
	engine: 1.0,
	fm_mod: 0.0,
	lpg_colour: 0.5,
	timb_mod: 0.0,
	morph_mod: 0.0,
	mul: 0.5,
	volume: 1.0,
	tempo: 165.0,
	dur: 0.25,
	legato: 0.7,
	rev_drywet: 0.0,
	rev_time: 0.5,
	rev_damp: 0.8,
	rev_hp: 0.7,
	rev_freeze: 0.0,
	stereoMode: 1.0,
	dist_drive: 0.0,
	dist_amount: 0.0,
	delay_send: 0.0,
	reverb_send: 0.0
);

// Default sequence patterns for all plaits instances
~defaultSequences = (
	decay: Pseq([0.5], inf).asStream,
	delay_send: Pseq([0.5], inf).asStream,
	div: Pseq([1.0], inf).asStream,
	duration: Pseq([0.25], inf).asStream,
	engine: Pseq(["e"], inf).asStream,
	fm_mod: Pseq([0.5], inf).asStream,
	harm: Pseq([0.5], inf).asStream,
	lpg_colour: Pseq([0.5], inf).asStream,
	morph: Pseq([0.5], inf).asStream,
	rev_time: Pseq([0.5], inf).asStream,
	reverb_send: Pseq([0.5], inf).asStream,
	timbre: Pseq([0.5], inf).asStream
);
)