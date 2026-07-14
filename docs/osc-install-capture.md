# Capturing Dreads OSC for Playback in Installations

Design notes for capturing Dreads' generative OSC alongside audio/video, editing it in Reaper as envelopes, and replaying it in gallery/installation contexts to drive companion phone experiences.

**Status: 2026-07-07** — design captured, testing not yet done. Update this doc as decisions land.

## Motivation

For live performances, Dreads already streams OSC to visitors' phones via a WS bridge (`~ws` in `lib/globals.scd`). This gives audience participation via animation + synthesised sound triggered by Dreads' sequencer state.

Goal: bring the same "phones-as-companion-instrument" experience to **frozen** works — gallery installations, cinema screenings, curated releases. The audio and video are pre-rendered (from Reaper stems and VDMX video capture); we want a parallel OSC track that plays alongside and drives phone experiences via the existing WS bridge.

## Architecture

```
CAPTURE (studio, live jam):
  Dreads (SC) → ~ws OSC → 127.0.0.1:3333
                            ├── existing OSC→WS bridge → phones (live test at gig)
                            └── OSCar (record raw OSC to XML)

EDIT (studio, later):
  OSCar XML → imported into Reaper as envelope tracks
  Reaper: audio stems + video + editable OSC envelopes

PLAYBACK (venue):
  Reaper: transport → audio + video + OSC envelopes
     OSC envelopes → OSC output → existing OSC→WS bridge → visitor phones
```

OSCar is a **one-shot import bridge**, not an ongoing dependency. Its role is capturing raw OSC at recording time and getting that data into Reaper as editable envelope tracks. From that point forward, Reaper is the sole conductor.

## The bundle problem

Dreads' `~ws` OSC stream emits a **composite state message**, one per note:

```
/plaits/state <i> "note" <n> "pitch" <p> "engine" <e> "harm" <h> "timbre" <t> ...
```

One OSC path, ~20 arguments alternating key/value. This shape works fine for the live phone bridge (WS server unpacks it into a JSON blob per note).

**Reaper's OSC input, on the other hand, expects one path per envelope target.** Reaper arms a specific envelope (e.g. "record onto timbre param"), and captures values arriving at a single OSC path mapped to that envelope. It doesn't have a native way to unpack multi-arg composite messages into distinct envelope lanes.

So a composite state message will likely record round-trip through OSCar successfully (OSCar is format-agnostic) but Reaper won't fan it out into individual envelopes.

## Two possible approaches

### Approach A: Test the bundle path first

Before making any Dreads-side changes, verify what Reaper actually does with the composite message. Possible outcomes:

- **Reaper captures arg[0] only, ignores rest** — likely; only useful if arg[0] happens to be a value we care about
- **Reaper won't record composite messages at all** — need to split
- **Reaper has a pattern-file trick to unpack** — .ReaperOSC syntax might support extracting args by index; worth checking

**Concrete test:**
1. Boot Dreads, enable send-to-phones on one instance
2. Play something to generate OSC traffic
3. Configure Reaper OSC surface on port 3333
4. Arm an envelope on any track, set to Learn
5. See what path Reaper picks up and what value it records

If Reaper only records arg[0] (or nothing useful), move to Approach B.

### Approach B: Split OSC into per-parameter paths on the Dreads side

Add a parallel loop in `lib/sequencer.scd` alongside the existing `~ws.().sendMsg("/plaits/state", ...)` block:

```supercollider
// Existing composite send (keep for backward-compat with WS phones bridge):
~ws.().sendMsg("/plaits/state", i, "note", ~noteCounter[i], ...);

// New: individual per-param sends (for OSCar / Reaper capture as envelopes):
[\pitch, \engine, \harm, \timbre, \decay, \morph, \volume,
 \cloudsSend, \delaySend, \reverbSend, \revDrywet, \distAmount].do { |k|
    ~ws.().sendMsg("/plaits/" ++ i ++ "/" ++ k.asString, ev[k] ? 0.0);
};
```

Cost: 12 extra small OSC messages per note per instance. Bandwidth is negligible; the WS bridge already ignores unknown paths.

## Rate considerations

The `~ws` stream fires at **sequencer-tick rate** (1–4 Hz typically). This is fine for:
- Discrete "the sequencer just fired a note" events — plays cleanly as a MIDI-like trigger stream
- Slow-moving parameter automation — envelopes at 1–4 Hz look step-shaped but that's honest to the actual audio behaviour

Not fine for:
- Continuous modulation (LFO contribution) — that lives in a separate 60 Hz stream (`\lfoReporter` → `~lfo.reporterFunc` → `/plaits/{i}/lfo/{param}`). This stream goes to `~vis` (VDMX) not `~ws`.
- If you want continuous LFO modulation captured for the phones flow too, that's an additional design decision — the LFO reporter would need to fan out to a phones-suitable destination as well.

For the current use case (recapturing what phones already see), the sequencer-tick stream is the right source.

## Open questions

1. **Composite vs individual message shape** — resolved by the bundle test above
2. **Do we want to capture LFO data for phones too?** — separate design question; current live phones experience doesn't have this, so probably not needed for parity
3. **Timing sync between Reaper's transport and OSC playback** — Reaper's OSC output happens at envelope-value read time, sample-accurate with audio. Should be automatic once envelopes are in place.
4. **What does the phone side actually do with the OSC?** — determines whether individual param updates work standalone or need to be batched back into note-events. See `~ws` server code for current behaviour.

## Relationship to visualization-osc.md

This is a different OSC output flow than the visualisation stream:

| Stream | Destination | Rate | Format | Purpose |
|--------|-------------|------|--------|---------|
| `~vis` (in sequencer.scd) | VDMX (127.0.0.1:1234) | Sequencer-tick + UI-echo | Per-param `/plaits/{i}/{param}` | Visuals — this doc's cousin |
| `~ws` (in sequencer.scd) | WS bridge (127.0.0.1:3333) | Sequencer-tick | Composite `/plaits/state <i> <k> <v>...` | Phones — this doc's subject |
| LFO reporter | `~vis` (127.0.0.1:1234) | 60 Hz | Per-param `/plaits/{i}/lfo/{param}` | Continuous modulation, visuals |

If Approach B lands, the `~ws` stream gets a per-param companion, unifying its shape with `~vis`. Worth considering whether they could share a fan-out once both are per-param.

## Next steps (when picking this up)

1. Run the bundle test in Reaper — settle Approach A vs B
2. If B, implement the split in `lib/sequencer.scd`
3. Test OSCar record → export XML → import to Reaper as envelopes
4. Test Reaper playback → OSC output → WS bridge → phone displays reasonable content
5. Document the actual venue-side setup once proven
