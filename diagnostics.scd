////////////////////////////////////////////////////////////////////////////////
// DIAGNOSTICS - Run this block to check your system configuration
////////////////////////////////////////////////////////////////////////////////
(
var missingUGens = [];

"=== SuperCollider Version ===".postln;
Main.version.postln;
"".postln;

"=== Extension Directories ===".postln;
"User extensions:".postln;
Platform.userExtensionDir.postln;
"System extensions:".postln;
Platform.systemExtensionDir.postln;
"".postln;

"=== All Include Paths ===".postln;
LanguageConfig.includePaths.do(_.postln);
"".postln;

"=== Server Configuration ===".postln;
("Sample rate: " ++ Server.default.sampleRate).postln;
("Block size: " ++ s.options.blockSize).postln;
("Control period: " ++ (s.options.blockSize / 48000) ++ " seconds (assuming 48kHz)").postln;
("Output channels: " ++ s.options.numOutputBusChannels).postln;
("Memory size: " ++ s.options.memSize).postln;
"".postln;

"=== OSC Configuration ===".postln;
("SuperCollider listening on port: " ++ NetAddr.langPort).postln;
("Active OSCdefs: " ++ OSCdef.all.size).postln;
"".postln;

"=== Required UGens Check ===".postln;

"Checking MiPlaits...".postln;
try {
	MiPlaits.dumpInterface;
	"✓ MiPlaits available".postln;
} {
	"✗✗✗ ERROR: MiPlaits NOT FOUND ✗✗✗".postln;
	"    Install MI-UGens from: https://github.com/v7b1/mi-UGens/releases".postln;
	missingUGens = missingUGens.add("MiPlaits");
};

"Checking CrossoverDistortion...".postln;
try {
	CrossoverDistortion.dumpInterface;
	"✓ CrossoverDistortion available".postln;
} {
	"✗✗✗ ERROR: CrossoverDistortion NOT FOUND ✗✗✗".postln;
	"    Install sc3-plugins from: https://github.com/supercollider/sc3-plugins/releases".postln;
	missingUGens = missingUGens.add("CrossoverDistortion");
};

"Checking MiVerb...".postln;
try {
	MiVerb.dumpInterface;
	"✓ MiVerb available".postln;
} {
	"✗✗✗ ERROR: MiVerb NOT FOUND ✗✗✗".postln;
	"    Install MI-UGens from: https://github.com/v7b1/mi-UGens/releases".postln;
	missingUGens = missingUGens.add("MiVerb");
};

"Checking MiClouds...".postln;
try {
	MiClouds.dumpInterface;
	"✓ MiClouds available".postln;
} {
	"✗✗✗ ERROR: MiClouds NOT FOUND ✗✗✗".postln;
	"    Install MI-UGens from: https://github.com/v7b1/mi-UGens/releases".postln;
	missingUGens = missingUGens.add("MiClouds");
};
"".postln;

if (missingUGens.size > 0) {
	"".postln;
	"═══════════════════════════════════════════════════════".postln;
	"⚠️  INSTALLATION INCOMPLETE ⚠️".postln;
	("Missing UGens: " ++ missingUGens.join(", ")).postln;
	"".postln;
	"ACTION REQUIRED:".postln;
	"1. Download and install the missing extensions".postln;
	"2. Restart SuperCollider".postln;
	"3. Run diagnostics.scd again to verify".postln;
	"═══════════════════════════════════════════════════════".postln;
	"".postln;
};

"=== Dreads Configuration (if loaded) ===".postln;
if (~using6_1.notNil) {
	("Audio mode: " ++ if(~using6_1, "Multichannel (8ch)", "Stereo (2ch)")).postln;
} {
	"~using6_1 not set - run setup block first".postln;
};

if (~plaits.notNil) {
	("Plaits instances loaded: " ++ ~plaits.synths.size).postln;
} {
	"~plaits not loaded - run setup block first".postln;
};

if (~voiceGroup.notNil) {
	"✓ Voice group exists".postln;
} {
	"~voiceGroup not created - run play block first".postln;
};

if (~fxGroup.notNil) {
	"✓ FX group exists".postln;
} {
	"~fxGroup not created - run play block first".postln;
};

"".postln;
"=== Diagnostics complete ===".postln;
)
