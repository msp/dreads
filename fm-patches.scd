////////////////////////////////////////////////////////////////////////////////
// 6-Op FM Patch Browser
//
// Preview all 96 built-in DX7 patches across engines 18, 19, 20.
// Uses the sequencer on plaits instance 0 with a simple repeating trigger
// so you hear each patch's envelope character (attack, decay, sustain).
//
// Usage:
//   1. Boot plaits.scd (setup + play blocks) first
//   2. Run the setup block below (mutes other instances, configures instance 0)
//   3. Use ~fmFwd, ~fmBack, ~fmPick(n), ~fmBank(b) to browse
//   4. Run the cleanup block when done to restore previous state
////////////////////////////////////////////////////////////////////////////////

// Setup
(
var instance = 0;

// harm value for patch index (center of quantization band)
~fmHarm = { |patchIndex| (patchIndex + 0.5) / (1.02 * 32) };

~fmBanks = [
	// Engine 18 — Bass/Synth
	[
		"SOLID BASS",  "Mooger Low",  "LeaderTape",  "MORHOL TB1",
		"BASS 3",      "BILL BASS",   "BASS 1",      "ELEC BASS",
		"S.BAS 27.7",  "RESONANCES",  "SYN-BASS 2",  "PRC SYNTH1",
		"CROMA 2",     "ANALOG 4",    "ANALOG A",    "ANALOG 6",
		"CS 80",       "INSERT 1",    "SPIRAL",      "DX-TROTT",
		"GASHAUS",     "RING DING",   "PAPAGAYO",    "WINEGLASS",
		"AMYTAL",      "FAIRLIGHT",   "*PPG*Vol.1",  "*PPG*Vol.2",
		"*Fairl. 3",   "*Vocoder 2",  "*Sequence",   "Bounce 4"
	],
	// Engine 19 — Keys/Perc
	[
		"E.PIANO 1",  "FENDER 1",    "WINTRHODES",  "RS-EP C",
		"*Mark III",   "CLAV-E.PNO",  "SYN-CLAV",    "CLAVINET",
		"PIANO 5",     "GRD PIANO1",  "STEINWAY",    "GUIT ACOUS",
		"SITAR",       "KOTO",        "HARPSICH 1",  "CLAV 3",
		"XYLOPHONE",   "MARIMBA",     "VIBE 1",      "GLOKENSPL",
		"BELL C",      "BELLS",       "TUB BELLS",   "GONG 2",
		"KETTLE 6",    "MID DRM 3",   "ORI DRUM 1",  "WOOD 6",
		"LATN DRM 4",  "CIMBAL",      "SYNDM 25.8",  "B.DRM-SNAR"
	],
	// Engine 20 — Organ/Pad/Str/Brass
	[
		"CLICK 124",   "*Hammond 1",  "E.ORGAN 3",   "60-S ORGAN",
		"OPTIC 28",    "PIPES 1",     "PIPES 3",     "PIPES 2",
		"JX-33-P",     "SOUNDTRACK",  "ICE PAD 2",   "M1 PADS",
		"CARLOS 2",    "SOFT TOUCH",  "*Planets",    "CIRRUS",
		"ENTRIX",      "MAL POLY",    "Textures 6",  "Etherial5a",
		"'Airy'",      "BORON A",     "VANGELIS 1",  "STRINGS C",
		"STRINGS 3",   "STRINGS 2",   "STRINGS 7",   "FULL STRIN",
		"SYN-ORCH",    "BRASS 1",     "BRASS 6 BC",  "BR TRUMPET"
	]
];

~fmBankNames = ["Bass/Synth", "Keys/Perc", "Organ/Pad/Str/Brass"];

// Save current state for cleanup
~fmInstance = instance;
~fmSavedState = ~plaits.synths[instance].copy;
~fmSavedMutes = ~plaits.synths.collect { |inst| inst.mute };
~fmSavedSampleMutes = ~plaits.samples.collect { |inst| inst.mute };

// State
~fmBankIndex = 0;
~fmPatchIndex = 0;

// Apply current selection to the sequencer instance
~fmApply = {
	var engine = ~fmBankIndex + 18;
	var harm = ~fmHarm.(~fmPatchIndex);
	var name = ~fmBanks[~fmBankIndex][~fmPatchIndex];

	~plaits.synths[~fmInstance].engine = engine;
	~plaits.synths[~fmInstance].harm = harm;

	(">> [" ++ ~fmBankNames[~fmBankIndex] ++ "] "
		++ ~fmPatchIndex ++ "/31: " ++ name
		++ "  (engine:" ++ engine ++ " harm:" ++ harm.round(0.001) ++ ")").postln;
};

// Navigation
~fmFwd = {
	~fmPatchIndex = (~fmPatchIndex + 1) % 32;
	~fmApply.();
};

~fmBack = {
	~fmPatchIndex = (~fmPatchIndex - 1) % 32;
	~fmApply.();
};

~fmPick = { |n|
	~fmPatchIndex = n.clip(0, 31);
	~fmApply.();
};

~fmBank = { |b|
	~fmBankIndex = b.clip(0, 2);
	~fmPatchIndex = 0;
	("Switched to bank " ++ ~fmBankNames[~fmBankIndex]
		++ " (engine " ++ (~fmBankIndex + 18) ++ ")").postln;
	~fmApply.();
};

~fmList = {
	("== " ++ ~fmBankNames[~fmBankIndex]
		++ " (engine " ++ (~fmBankIndex + 18) ++ ") ==").postln;
	~fmBanks[~fmBankIndex].do { |name, idx|
		var marker = if (idx == ~fmPatchIndex) { " >> " } { "    " };
		(marker ++ idx.asString.padLeft(2) ++ ": " ++ name).postln;
	};
};

// Configure instance 0 for clean auditioning
~plaits.synths[instance].putAll((
	engine: 18,
	harm: ~fmHarm.(0),
	pitch: 60,
	morph: 0.5,
	timbre: 0.5,
	decay: 0.5,
	dur: 1.0,
	legato: 4.0,
	fmMod: 0,
	droneMode: 0,
	mute: 0,
	mul: 0.5,
	distAmount: 0,
	distDrive: 0,
	delaySend: 0,
	reverbSend: 0,
	cloudsSend: 0,
	revDrywet: 0.15,
	revTime: 0.3,
	volume: 0.6
));

// Mute all other instances so we hear the preview cleanly
~plaits.synths.do { |inst, idx|
	if (idx != instance) { inst.mute = 1 };
};
~plaits.samples.do { |inst| inst.mute = 1 };

~fmApply.();

"
FM Patch Browser ready! (sequencer mode)

  ~fmFwd           — next patch
  ~fmBack          — previous patch
  ~fmPick.(n)      — jump to patch n (0-31)
  ~fmBank.(b)      — switch bank (0=Bass/Synth, 1=Keys/Perc, 2=Organ/Pad/Str/Brass)
  ~fmList.()       — list all patches in current bank
".postln;
)

// Cleanup — restore previous state
(
~fmSavedState.keysValuesDo { |key, value|
	~plaits.synths[~fmInstance][key] = value;
};
~fmSavedMutes.do { |muteVal, idx|
	~plaits.synths[idx].mute = muteVal;
};
~fmSavedSampleMutes.do { |muteVal, idx|
	~plaits.samples[idx].mute = muteVal;
};
~fmBanks = nil; ~fmBankNames = nil; ~fmHarm = nil;
~fmInstance = nil; ~fmSavedState = nil; ~fmSavedMutes = nil; ~fmSavedSampleMutes = nil;
~fmBankIndex = nil; ~fmPatchIndex = nil;
~fmApply = nil; ~fmFwd = nil; ~fmBack = nil; ~fmPick = nil; ~fmBank = nil; ~fmList = nil;
"FM browser cleaned up — previous state restored.".postln;
)


(
~fmFwd.()
~fmBack.()     
  ~fmPick.(n) //       — jump to patch n (0-31)
~fmBank.(2)    //   — switch bank (0=Bass/Synth, 1=Keys/Perc, 2=Organ/Pad/Str/Brass)
  ~fmList.()       
)
