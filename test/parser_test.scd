// Test the sequence section parser
// Execute this entire block to run all tests
(
// Set base path if not already set
if (~basePath.isNil) {
	~basePath = thisProcess.nowExecutingPath.dirname.dirname;  // Go up one level from test/
};

// Load globals first (for defaults)
(~basePath +/+ "lib/globals.scd").load;

// Load the parser functions
(~basePath +/+ "lib/presets.scd").load;

"".postln;
"=== Testing Sequence Section Parser ===".postln;
"".postln;

// Test 1: Symbol → Symbol update
fork {
	var testLines, parsedBlocks, testOutput, contentLines;
	var passed = 0, failed = 0;  // Track results

	"=== Test 1: Symbol → Symbol Update ===".postln;

	// Simulate section lines from template (what's in default.scd)
	testLines = [
		"(",
		"\t\t\tduration: \\euclid",
		")"
	];

	"Input lines:".postln;
	testLines.do { |line| ("  " ++ line).postln };

	// Parse just the content (without parens)
	contentLines = testLines.select({ |line| (line.stripWhiteSpace != "(") && (line.stripWhiteSpace != ")") });
	parsedBlocks = ~parseSequenceSection.(contentLines);

	"".postln;
	"Parsed blocks:".postln;
	parsedBlocks.keysValuesDo { |key, val|
		("  " ++ key ++ ": " ++ val).postln;
	};

	// Simulate runtime state where user changed to \dense via UI
	~dreads = (synths: [
		(sequences: (duration: \dense))
	]);

	"".postln;
	("Runtime sequences: " ++ ~dreads.synths[0].sequences).postln;

	// Process the section
	testOutput = ~processSequenceSection.(testLines, \plaits, 0);

	"".postln;
	"Output lines:".postln;
	testOutput.do { |line| ("  " ++ line).postln };

	// Verify
	if (testOutput.any({ |line| line.contains("\\dense") })) {
		"✓ Test 1 PASSED: Symbol updated correctly".postln;
		passed = passed + 1;
	} {
		"✗ Test 1 FAILED: Symbol not updated".postln;
		failed = failed + 1;
	};

	1.wait; // Pause between tests

	// Test 2: Pattern → Symbol replacement (with commenting)
	"".postln;
	"".postln;
	"=== Test 2: Pattern → Symbol Replacement ===".postln;

	// Simulate section lines with multi-line pattern
	testLines = [
		"(",
		"\t\t\tduration: Pseq([",
		"\t\t\t\t0.7,",
		"\t\t\t\tRest(0.7)",
		"\t\t\t], inf).asStream,",
		")"
	];

	"Input lines:".postln;
	testLines.do { |line| ("  " ++ line).postln };

	// Simulate runtime state where user changed to \sparse via UI
	~dreads = (synths: [
		(sequences: (duration: \sparse))
	]);

	"".postln;
	("Runtime sequences: " ++ ~dreads.synths[0].sequences).postln;

	// Process the section
	testOutput = ~processSequenceSection.(testLines, \plaits, 0);

	"".postln;
	"Output lines:".postln;
	testOutput.do { |line| ("  " ++ line).postln };

	// Verify: should have new symbol line AND commented pattern
	if (testOutput.any({ |line| line.contains("duration: \\sparse") }) &&
	    testOutput.any({ |line| line.contains("// ") && line.contains("Pseq") })) {
		"✓ Test 2 PASSED: Pattern replaced with symbol and commented out".postln;
		passed = passed + 1;
	} {
		"✗ Test 2 FAILED: Pattern not handled correctly".postln;
		failed = failed + 1;
	};

	1.wait;

	// Test 3: Symbol → Stream (preserve template)
	"".postln;
	"".postln;
	"=== Test 3: Symbol → Stream (preserve template) ===".postln;

	// Template has symbol
	testLines = [
		"(",
		"\t\t\tduration: \\euclid",
		")"
	];

	"Input lines:".postln;
	testLines.do { |line| ("  " ++ line).postln };

	// Runtime has custom stream (not a symbol)
	~dreads = (synths: [
		(sequences: (duration: Pseq([0.5, 0.7], inf).asStream))
	]);

	"".postln;
	("Runtime sequences: " ++ ~dreads.synths[0].sequences).postln;

	// Process the section
	testOutput = ~processSequenceSection.(testLines, \plaits, 0);

	"".postln;
	"Output lines:".postln;
	testOutput.do { |line| ("  " ++ line).postln };

	// Verify: should preserve original symbol (user has custom pattern in runtime)
	if (testOutput.any({ |line| line.contains("\\euclid") })) {
		"✓ Test 3 PASSED: Template symbol preserved (runtime has custom pattern)".postln;
		passed = passed + 1;
	} {
		"✗ Test 3 FAILED: Template symbol not preserved".postln;
		failed = failed + 1;
	};

	1.wait;

	// Test 4: Pattern → Stream (preserve template pattern)
	"".postln;
	"".postln;
	"=== Test 4: Pattern → Stream (preserve template) ===".postln;

	// Template has pattern
	testLines = [
		"(",
		"\t\t\tduration: Pseq([",
		"\t\t\t\t0.7,",
		"\t\t\t\tRest(0.7)",
		"\t\t\t], inf).asStream,",
		")"
	];

	"Input lines:".postln;
	testLines.do { |line| ("  " ++ line).postln };

	// Runtime has different custom stream (not a symbol)
	~dreads = (synths: [
		(sequences: (duration: Pwhite(0.1, 0.9, inf).asStream))
	]);

	"".postln;
	("Runtime sequences: " ++ ~dreads.synths[0].sequences).postln;

	// Process the section
	testOutput = ~processSequenceSection.(testLines, \plaits, 0);

	"".postln;
	"Output lines:".postln;
	testOutput.do { |line| ("  " ++ line).postln };

	// Verify: should preserve original pattern (user has different custom pattern in runtime)
	if (testOutput.any({ |line| line.contains("Pseq") && line.contains("//").not })) {
		"✓ Test 4 PASSED: Template pattern preserved (runtime has custom pattern)".postln;
		passed = passed + 1;
	} {
		"✗ Test 4 FAILED: Template pattern not preserved".postln;
		failed = failed + 1;
	};

	1.wait;

	// Test 5: Adding new symbols not in template
	"".postln;
	"".postln;
	"=== Test 5: Adding new symbols ===".postln;

	// Template has only duration
	testLines = [
		"(",
		"\t\t\tduration: \\euclid",
		")"
	];

	"Input lines:".postln;
	testLines.do { |line| ("  " ++ line).postln };

	// Runtime has additional symbol (decay)
	~dreads = (synths: [
		(sequences: (duration: \dense, decay: \gauss))
	]);

	"".postln;
	("Runtime sequences: " ++ ~dreads.synths[0].sequences).postln;

	// Process the section
	testOutput = ~processSequenceSection.(testLines, \plaits, 0);

	"".postln;
	"Output lines:".postln;
	testOutput.do { |line| ("  " ++ line).postln };

	// Verify: should have both symbols
	if (testOutput.any({ |line| line.contains("duration: \\dense") }) &&
	    testOutput.any({ |line| line.contains("decay: \\gauss") })) {
		"✓ Test 5 PASSED: New symbol added from runtime".postln;
		passed = passed + 1;
	} {
		"✗ Test 5 FAILED: New symbol not added".postln;
		failed = failed + 1;
	};

	1.wait;

	// Test 6: Empty sequence section
	"".postln;
	"".postln;
	"=== Test 6: Empty sequence section ===".postln;

	// Template has empty section
	testLines = [
		"(",
		")"
	];

	"Input lines:".postln;
	testLines.do { |line| ("  " ++ line).postln };

	// Runtime has symbol
	~dreads = (synths: [
		(sequences: (duration: \sparse))
	]);

	"".postln;
	("Runtime sequences: " ++ ~dreads.synths[0].sequences).postln;

	// Process the section
	testOutput = ~processSequenceSection.(testLines, \plaits, 0);

	"".postln;
	"Output lines:".postln;
	testOutput.do { |line| ("  " ++ line).postln };

	// Verify: should add the symbol
	if (testOutput.any({ |line| line.contains("duration: \\sparse") })) {
		"✓ Test 6 PASSED: Symbol added to empty section".postln;
		passed = passed + 1;
	} {
		"✗ Test 6 FAILED: Symbol not added to empty section".postln;
		failed = failed + 1;
	};

	"".postln;
	"=== Test Summary ===".postln;
	("Passed: " ++ passed ++ "/6").postln;
	("Failed: " ++ failed ++ "/6").postln;
	"".postln;
	if (failed == 0) {
		"✓✓✓ ALL TESTS PASSED ✓✓✓".postln;
	} {
		"✗✗✗ SOME TESTS FAILED ✗✗✗".postln;
	};
};
)
