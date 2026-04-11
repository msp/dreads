// Validate Bjorklund euclidean algorithm against Toussaint's paper:
// "The Euclidean Algorithm Generates Traditional Musical Rhythms" (2005)
// Source: cgm.cs.mcgill.ca/~godfried/publications/banff.pdf
(
var passed = 0, failed = 0;
var tests = [
	// [k, n, expected, name]
	// Edge cases
	[1, 4, [1,0,0,0], "single hit"],
	[4, 4, [1,1,1,1], "all hits"],

	// Toussaint paper examples
	[2, 3, [1,1,0], "conga"],
	[2, 5, [1,0,1,0,0], "khafif-e-ramal (Persian)"],
	[3, 4, [1,1,1,0], "cumbia (Colombia)"],
	[3, 5, [1,0,1,0,1], "Persian / Romanian folk"],
	[3, 7, [1,0,1,0,1,0,0], "ruchenitza (Bulgarian)"],
	[3, 8, [1,0,0,1,0,0,1,0], "tresillo (Cuban)"],
	[4, 7, [1,0,1,0,1,0,1], "aksak 7/8 (Bulgarian)"],
	[4, 9, [1,0,1,0,1,0,1,0,0], "aksak (Turkish)"],
	[4, 11, [1,0,0,1,0,0,1,0,0,1,0], "Frank Zappa 'Outside Now'"],
	[4, 12, [1,0,0,1,0,0,1,0,0,1,0,0], "fandango (Flamenco)"],
	[5, 6, [1,1,1,1,1,0], "York-Samai (Arab)"],
	[5, 7, [1,0,1,1,0,1,1], "nawakhat (Arab)"],
	[5, 8, [1,0,1,1,0,1,1,0], "cinquillo (Cuban)"],
	[5, 9, [1,0,1,0,1,0,1,0,1], "agsag-samai (Arab)"],
	[5, 11, [1,0,1,0,1,0,1,0,1,0,0], "Moussorgsky 'Pictures'"],
	[5, 12, [1,0,0,1,0,1,0,0,1,0,1,0], "Venda children's song (SA)"],
	[5, 16, [1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,0], "bossa nova necklace"],
	[7, 8, [1,1,1,1,1,1,1,0], "Bendir (Tuareg)"],
	[7, 12, [1,0,1,1,0,1,0,1,1,0,1,0], "West African bell"],
	[7, 16, [1,0,0,1,0,1,0,1,0,0,1,0,1,0,1,0], "Brazilian samba"],
	[9, 16, [1,0,1,1,0,1,0,1,0,1,1,0,1,0,1,0], "Central African Republic"],
];

if (~euclidean.isNil) {
	"ERROR: ~euclidean is nil - reload sequence_library.scd first".postln;
} {
	"--- Euclidean Algorithm Tests ---".postln;
	tests.do { |test|
		var k, n, expected, name, result;
		k = test[0]; n = test[1]; expected = test[2]; name = test[3];
		result = ~euclidean.(k, n);
		if (result == expected) {
			passed = passed + 1;
			("PASS E(" ++ k ++ "," ++ n ++ ") " ++ name).postln;
		} {
			failed = failed + 1;
			("FAIL E(" ++ k ++ "," ++ n ++ ") " ++ name).postln;
			("  expected: " ++ expected).postln;
			("  got:      " ++ result).postln;
		};
	};
	"".postln;
	(passed.asString ++ " passed, " ++ failed.asString ++ " failed").postln;
	if (failed == 0) { "ALL TESTS PASSED".postln };
};
)
