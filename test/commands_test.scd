// Tests for lib/commands.scd — config layering + install-decision logic.
// Load lib/commands.scd (or run dreads.scd's first line) first, then execute
// this block. Does NOT boot the server or hit the network.
(
var passed = 0, failed = 0, check, tmp, cfg, example;
var savedRoot, savedRec, savedSpk;

check = { |name, got, expected|
	if (got == expected) {
		passed = passed + 1;
		("PASS " ++ name).postln;
	} {
		failed = failed + 1;
		("FAIL " ++ name).postln;
		("  expected: " ++ expected).postln;
		("  got:      " ++ got).postln;
	};
};

if (~app.isNil) {
	"ERROR: ~app is nil — load lib/commands.scd first".postln;
} {
	savedRoot = ~app.root; savedRec = ~recordingMode; savedSpk = ~numSpeakers;
	tmp     = Platform.defaultTempDir +/+ "dreads-cfg-test";
	cfg     = tmp +/+ "config.scd";
	example = tmp +/+ "config.scd.example";
	File.mkdir(tmp);
	[cfg, example].do { |f| if (File.exists(f)) { File.delete(f) } };

	"--- commands.scd tests ---".postln;

	// outChannels (pure): stereo / multichannel / recording
	// Subscript+value — Events auto-invoke a function on name access (see commands.scd).
	check.("outChannels stereo",        ~app[\outChannels].value(false, 2), 2);
	check.("outChannels multichannel",  ~app[\outChannels].value(false, 6), 6);
	check.("outChannels recording = 18", ~app[\outChannels].value(true, 2), 18);

	// ensureConfig: creates config.scd from the example when missing
	~app.root = tmp;
	File.use(example, "w", { |f| f.write("// example\n") });
	~app.ensureConfig.();
	check.("ensureConfig creates config.scd", File.exists(cfg), true);

	// ensureConfig: never clobbers an existing config.scd
	File.use(cfg, "w", { |f| f.write("// user edited\n") });
	~app.ensureConfig.();
	check.("ensureConfig no-clobber", File.readAllString(cfg), "// user edited\n");

	// loadConfig: config.scd overrides the safe defaults
	~recordingMode = false; ~numSpeakers = 2;
	File.use(cfg, "w", { |f| f.write("~recordingMode = true;\n~numSpeakers = 6;\n") });
	~app.loadConfig.();
	check.("config overrides recordingMode", ~recordingMode, true);
	check.("config overrides numSpeakers",   ~numSpeakers, 6);
	check.("overridden config -> 18 channels",
		~app[\outChannels].value(~recordingMode, ~numSpeakers), 18);

	// installComponent decisions that need neither server nor network
	check.("installComponent \\present when class already loaded",
		~app[\installComponent].value((name: "zz-test-present", probe: \SinOsc, quarantine: false, urls: ())),
		\present);
	check.("installComponent \\noUrlForPlatform when missing + no url",
		~app[\installComponent].value((name: "zz-test-nourl", probe: \ZzNoSuchClass, quarantine: false, urls: ())),
		\noUrlForPlatform);

	// cleanup + restore mutated globals
	[cfg, example].do { |f| if (File.exists(f)) { File.delete(f) } };
	if (File.exists(tmp)) { File.delete(tmp) };
	~app.root = savedRoot; ~recordingMode = savedRec; ~numSpeakers = savedSpk;

	"".postln;
	(passed.asString ++ " passed, " ++ failed.asString ++ " failed").postln;
	if (failed == 0) { "ALL TESTS PASSED".postln };
};
)
