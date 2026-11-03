////////////////////////////////////////////////////////////////////////////////
//
// DREADS - Mutable Instruments Plaits playground for Supercollider
//
// Run each line below: put the cursor in the line and press Cmd+Enter.
//
//   1. ~app.install.()   first run only — place the SC extensions, then
//                        recompile the class library (Cmd+Shift+L) and re-run it
//   2. ~app.start.()     boot the server and load everything (waits internally)
//
// Once started, launch the Open Stage Control UI (see README) and you can
// re-execute dependent files (e.g. lib/sequencer.scd) while patterns play.
////////////////////////////////////////////////////////////////////////////////

(Document.current.dir ++ "/lib/commands.scd").load;

~app.install.()

~app.start.()

// Safety.disable
// Quarks.gui


// s.options.device.postln;   // should print nil (system default)
// s.boot;

