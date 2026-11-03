//////////////////////////////////////////////////////////////////////////////
// Dreads lifecycle commands — invoke via ~app.<command>.()  (see dreads.scd).
//
//   ~app.install.()   place SC extensions (first run only; recompile after)
//   ~app.start.()     configure + boot the server, load everything, in order
//
// Commands are idempotent and return a status Event, e.g. (ok: true, ...).
//////////////////////////////////////////////////////////////////////////////

~app = ~app ? ();
~app.root = if (thisProcess.nowExecutingPath.notNil) {
	thisProcess.nowExecutingPath.dirname.dirname   // <root>/lib/commands.scd -> <root>
} {
	Document.current.dir
};
~app.booted = false;

// Leveled logger. ~applog is a plain global (not ~app.x) so .() calls work without
// the Event auto-invoke caveat. Order: \debug < \info < \warn < \off. Override
// ~app.logLevel in config.scd.
~app.logLevel = \info;
~applog = { |msg, level = \info|
	var order = [\debug, \info, \warn, \off];
	if (order.indexOf(level) >= order.indexOf(~app.logLevel ? \info)) {
		("[dreads] " ++ msg).postln;
	};
};

// Required SC extensions, downloaded from the official releases on first install.
// Pinned versions drift when upstream re-releases — update the urls when they do.
// macOS builds are universal (Intel + Apple Silicon). install iterates this list;
// shrink it as dependencies drop.
~app.components = [
	(
		name: "mi-UGens",
		probe: \MiPlaits,
		quarantine: true,
		urls: (
			osx:     "https://github.com/v7b1/mi-UGens/releases/download/v0.0.9/mi-UGens-macOS.zip",
			windows: "https://github.com/v7b1/mi-UGens/releases/download/v0.0.9/mi-UGens-Windows.zip",
			linux:   "https://github.com/v7b1/mi-UGens/releases/download/v0.0.9/mi-UGens-Linux.zip"
		)
	),
	(
		name: "sc3-plugins",
		probe: \CrossoverDistortion,
		quarantine: true,
		urls: (
			osx:     "https://github.com/supercollider/sc3-plugins/releases/download/Version-3.14.1/sc3-plugins-3.14.1-macOS.zip",
			windows: "https://github.com/supercollider/sc3-plugins/releases/download/Version-3.14.1/sc3-plugins-3.14.1-Windows-64bit.zip",
			linux:   "https://github.com/supercollider/sc3-plugins/releases/download/Version-3.14.1/sc3-plugins-3.14.1-Linux-x64-24.04.zip"
		)
	),
];

// --- internal steps -------------------------------------------------------

// Copy config.scd.example -> config.scd (gitignored) on first run; never clobbers.
~app.ensureConfig = {
	var path, example;
	path    = ~app.root ++ "/config.scd";
	example = ~app.root ++ "/config.scd.example";
	if (File.exists(path).not and: { File.exists(example) }) {
		File.copy(example, path);
		~applog.("created config.scd from example — edit it to override defaults");
	};
};

~app.loadConfig = {
	var path;
	~app.ensureConfig.();
	path = ~app.root ++ "/config.scd";
	if (File.exists(path)) { path.load };
};

// recordingMode routes every voice/FX to its own bus for capture (18 ch); else stereo/multichannel.
~app.outChannels = { |recording, speakers| if (recording) { 18 } { speakers } };

~app.configureServer = {
	var chans;
	// Safe stereo defaults — override your rig in config.scd (see config.scd.example).
	~recordingMode = false;
	~numSpeakers   = 2;
	s.options.device = nil;               // system default output device
	~app.loadConfig.();                   // config.scd overrides the above
	// Subscript+value, not ~app.outChannels.(…): Events auto-invoke a function on
	// name access (prepending the Event), which breaks arg-taking helpers.
	chans = ~app[\outChannels].value(~recordingMode, ~numSpeakers);
	s.options.blockSize = 128;
	s.options.numBuffers = 2048;
	s.options.memSize = 8192 * 16;
	s.options.numInputBusChannels  = 0;
	s.options.numOutputBusChannels = chans;
	s.options.recChannels          = chans;
	s.freeAll;
};

~app.loadLangLibs = {
	var lib;
	lib = ~app.root ++ "/lib";
	~basePath = ~app.root;
	~currentPatchTemplate = (~app.root ++ "/patches/dreads/default.scd").standardizePath;
	~applog.("load globals", \debug);           (lib ++ "/globals.scd").load;
	~applog.("load sequence_library", \debug);  (lib ++ "/sequence_library.scd").load;
	~applog.("load utils", \debug);             (lib ++ "/utils.scd").load;
	if (File.exists((lib ++ "/user_sequence_library.scd").standardizePath)) {
		~applog.("load user_sequence_library", \debug);
		(lib ++ "/user_sequence_library.scd").load;
	};
	~applog.("load patches", \debug);           (lib ++ "/patches.scd").load;
};

~app.allocBuses = {
	// allocate away from likely synthdef/hardware outputs, at known indices
	~delayBus  = Bus(\audio, 100, 2, s);
	~reverbBus = Bus(\audio, 102, 2, s);
	~cloudsBus = Bus(\audio, 104, 2, s);
	~applog.("samples", \debug);        ~loadSampleLibrary.();
	~applog.("default patch", \debug);  (~app.root ++ "/patches/dreads/default.scd").load;
	~applog.("synthdefs", \debug);      (~app.root ++ "/lib/synthdefs.scd").load;
	~applog.("osc", \debug);            (~app.root ++ "/lib/osc.scd").load;
};

~app.wireEngine = {
	// Node order: lfoGroup -> voiceGroup -> fxGroup
	// (LFOs write buses before voices read; voices write FX sends before FX read)
	~lfoGroup   = Group.new(s);
	~voiceGroup = Group.new(~lfoGroup, \addAfter);
	~drones     = Array.fill(~dreads.synths.size, { nil });
	~fxGroup    = Group.new(~voiceGroup, \addAfter);
	~applog.("lfo", \debug);        (~app.root ++ "/lib/lfo.scd").load;
	~applog.("fx", \debug);         (~app.root ++ "/lib/fx.scd").load;
	~applog.("sequencer", \debug);  (~app.root ++ "/lib/sequencer.scd").load;
};

// --- public commands ------------------------------------------------------

// Install one component, cross-platform via curl + tar (both ship on macOS and
// Windows 10+; tar's libarchive extracts .zip). Idempotent and re-runnable:
// \present = class already live, \placed = installed but awaiting recompile,
// otherwise download + extract into the Extensions dir. A failed run writes no
// marker, so re-running just retries (tar overwrites a partial extract).
~app.installComponent = { |c|
	var plat, url, extDir, marker, zip, code, status;
	plat   = thisProcess.platform.name;
	url    = c.urls[plat];
	extDir = Platform.userExtensionDir;
	marker = extDir +/+ (".dreads-" ++ c.name);
	zip    = extDir +/+ (c.name ++ ".zip");
	case
		{ c.probe.asClass.notNil } {
			if (File.exists(marker)) { File.delete(marker) };   // live now; marker spent
			\present
		}
		{ File.exists(marker) } { \placed }                     // installed, awaiting recompile
		{ url.isNil }           { \noUrlForPlatform }
		{ true } {
			~applog.("downloading " ++ c.name ++ " …");
			code = ("curl -L -f -o " ++ zip.quote ++ " " ++ url.quote).systemCmd;
			status = if (code != 0) { \downloadFailed } {
				code = ("tar -xf " ++ zip.quote ++ " -C " ++ extDir.quote).systemCmd;
				if (code != 0) { \extractFailed } {
					if (plat == \osx and: { c.quarantine }) {
						("xattr -dr com.apple.quarantine " ++ extDir.quote).systemCmd;
					};
					File.use(marker, "w", { |f| f.write("installed") });
					\installed
				};
			};
			if (File.exists(zip)) { File.delete(zip) };
			status
		}
};

~app.install = {
	var extDir, results;
	~app.ensureConfig.();                 // create config.scd so it can be edited pre-boot
	extDir = Platform.userExtensionDir;
	if (File.exists(extDir).not) { File.mkdir(extDir) };
	results = ~app.components.collect { |c| c.name -> ~app[\installComponent].value(c) };
	results.do { |a| ~applog.("install: " ++ a.key ++ " -> " ++ a.value) };
	if (results.any { |a| a.value == \installed }) {
		~applog.("extensions placed — recompile the class library (Cmd+Shift+L), then ~app.start.()", \warn);
	};
	( ok: results.every { |a| [\present, \installed, \placed].includes(a.value) }, components: results )
};

~app.start = {
	if (~app.booted) {
		~applog.("already running");
		( ok: true, already: true )
	} {
		~applog.("booting…");
		~applog.("configureServer", \debug);
		~app.configureServer.();
		~applog.("loadLangLibs", \debug);
		~app.loadLangLibs.();
		~applog.("waitForBoot (serverRunning=" ++ s.serverRunning ++ ")", \debug);
		s.waitForBoot {
			// Routine so we can s.sync — SynthDef.add / Buffer.read are async, so the
			// server must confirm them before wireEngine spawns synths that use them.
			// (This s.sync is what the old manual SETUP→RUN gap was standing in for.)
			Routine({
				~applog.("server up → allocBuses", \debug);
				~app.allocBuses.();
				s.sync;
				~applog.("synced → wireEngine", \debug);
				~app.wireEngine.();
				~app.booted = true;
				~applog.("Dreads ready.");
			}).play;
		};
		( ok: true, booting: true )
	};
};
