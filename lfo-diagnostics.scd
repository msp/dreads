(
var oscFunc, routine, minRaw = 999, maxRaw = -999, minScaled = 999, maxScaled = -999, n = 0;

oscFunc = OSCFunc({ |msg|
      // msg layout: [path, nodeID, replyID, timbre0, morph0, decay0, pitch0, volume0, ...]
      // /plaits/0/lfo/volume raw is at msg[7]
      var raw = msg[7];
      var scaled = raw * (~dreads.synths[0].volumeMod ? 0);
      minRaw = minRaw.min(raw);       maxRaw = maxRaw.max(raw);
      minScaled = minScaled.min(scaled); maxScaled = maxScaled.max(scaled);
      n = n + 1;
}, '/lfoValues');

routine = Routine({
      loop {
              0.5.wait;
              ["LFO tap  raw:", minRaw.round(0.001), "..", maxRaw.round(0.001),
               " post-mod:", minScaled.round(0.001), "..", maxScaled.round(0.001),
               " samples:", n].postln;
              minRaw = 999; maxRaw = -999; minScaled = 999; maxScaled = -999; n = 0;
      };
}).play;

~tapLFOStop = { oscFunc.free; routine.stop; "LFO tap stopped".postln };
"LFO tap started — run ~tapLFOStop.() to stop.".postln;
)

~tapLFOStop.();