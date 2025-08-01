//////////////////////////////////////////////////////////////////////////////
// Global utility functions and shared state
//////////////////////////////////////////////////////////////////////////////

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
	Document.allDocuments.collect{ |doc, index|
		[index, doc.isEdited, doc.path].postln;
		if (doc.path.notNil && doc.isEdited) {
			var file = File(doc.path, "w");
			("Saving editor changes: " ++ doc.path.basename).postln;
			file.write(doc.string);
			file.close;
		};
	}
};