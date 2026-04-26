////////////////////////////////////////////////////////////////////////////////
// 6-Op FM Patch Browser
//
// Preview all 96 built-in DX7 patches across engines 18, 19, 20.
// All state is read from/written to the plaits instance — no local state.
//
// Note: decay knob has no effect on 6-op FM engines — they have their own
// internal DX7 envelopes and bypass the LPG/decay path entirely.
// (Decay is remapped to legato for FM engines in the sequencer.)
//
// Usage:
//   ~fm.(1, 7)     — set plaits 1 to patch 7
//   ~fmFwd.(1)     — next patch on plaits 1
//   ~fmBack.(1)    — previous patch on plaits 1
//   ~fmBank.(1, 2) — switch plaits 1 to bank 2 (1=Bass/Synth, 2=Keys/Perc, 3=Organ/Pad/Str/Brass)
//   ~fmList.(1)    — list patches in plaits 1's current bank
//   ~fmList.(1, 2) — list patches in bank 2
////////////////////////////////////////////////////////////////////////////////

// harm value for patch index (center of quantization band)
// C++ does: patch_index = floor(harmonics * 1.02 * 32)
~fmHarm = { |patchIndex| (patchIndex + 0.5) / (1.02 * 32) };

// Reverse: harm value back to 1-based patch number
~fmPatchFromHarm = { |harm| (harm * 1.02 * 32).floor.asInteger };

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

// Push harm and engine to UI
~fmPushUI = { |idx|
	var ui, instanceNum;
	ui = ~ui.();
	instanceNum = idx + 1;
	ui.sendMsg("/plaits/" ++ instanceNum ++ "/harm", ~dreads.synths[idx].harm);
	ui.sendMsg("/plaits/" ++ instanceNum ++ "/engine", ~dreads.synths[idx].engine);
};

// Read bank index (0-based internal) from instance's engine
~fmBankOf = { |idx| (~dreads.synths[idx].engine.asInteger - 18).clip(0, 2) };

// Read patch index (0-based internal) from instance's harm
~fmPatchOf = { |idx| ~fmPatchFromHarm.(~dreads.synths[idx].harm) };

// Set patch on a plaits instance (1-based: plaits 1-3, patch 1-32)
~fm = { |inst=1, n=1|
	var idx = inst - 1;
	var patchIdx = (n - 1).clip(0, 31);
	var harm = ~fmHarm.(patchIdx);
	var bankIdx = ~fmBankOf.(idx);
	var name = ~fmBanks[bankIdx][patchIdx];

	~dreads.synths[idx].harm = harm;
	~fmPushUI.(idx);

	(">> plaits " ++ inst ++ " [" ++ ~fmBankNames[bankIdx] ++ "] "
		++ n ++ "/32: " ++ name
		++ "  (engine:" ++ (bankIdx + 18) ++ " harm:" ++ harm.round(0.001) ++ ")").postln;
};

// Next patch
~fmFwd = { |inst=1|
	var idx = inst - 1;
	var patchNum = (~fmPatchOf.(idx) + 1) % 32 + 1;
	~fm.(inst, patchNum);
};

// Previous patch
~fmBack = { |inst=1|
	var idx = inst - 1;
	var patchNum = (~fmPatchOf.(idx) - 1) % 32 + 1;
	~fm.(inst, patchNum);
};

// Switch bank (1-based: bank 1-3), resets to patch 1
~fmBank = { |inst=1, b=1|
	var idx = inst - 1;
	var bankIdx = (b - 1).clip(0, 2);
	~dreads.synths[idx].engine = bankIdx + 18;
	("Switched plaits " ++ inst ++ " to bank " ++ b ++ ": " ++ ~fmBankNames[bankIdx]
		++ " (engine " ++ (bankIdx + 18) ++ ")").postln;
	~fm.(inst, 1);
};

// List patches in a bank (1-based, defaults to instance 1's current bank)
~fmList = { |inst=1, b|
	var idx = inst - 1;
	var bankIdx, currentPatchIdx;
	bankIdx = if (b.isNil) { ~fmBankOf.(idx) } { (b - 1).clip(0, 2) };
	currentPatchIdx = ~fmPatchOf.(idx);
	("== Bank " ++ (bankIdx + 1) ++ ": " ++ ~fmBankNames[bankIdx]
		++ " (engine " ++ (bankIdx + 18) ++ ") ==").postln;
	~fmBanks[bankIdx].do { |name, i|
		var marker = if (i == currentPatchIdx and: { bankIdx == ~fmBankOf.(idx) }) { " >> " } { "    " };
		(marker ++ (i + 1).asString.padLeft(2) ++ ": " ++ name).postln;
	};
};

"FM Patch Browser loaded.".postln;
