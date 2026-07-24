# Installation Playback: Options & Trade-offs

Design notes for playing back a captured Dreads performance (audio + video + OSC) reliably in cinema / gallery / museum contexts. Cousin doc to [`osc-install-capture.md`](./osc-install-capture.md) — that one covers capture, this covers deployment.

**Status: 2026-07-07** — options explored, no path committed. Update as decisions land.

## Deployment constraints

- 3–4 hour looped content, unattended for the run
- Content is a mix of segments: audio-only, A/V (VDMX rendered), A/V + phones OSC
- Playback machine: user's M3 Max MacBook (64 GB RAM) — comfortably over-spec for the workload
- Cinema install target; potentially in-situ audio mix desired at load-in
- Optional per-venue phone experience driven by OSC → existing WS bridge → visitors' phones

## The core problem

All three output streams (audio, video, OSC events) share a single logical timeline. They were generated in Dreads against a shared sequencer clock. Whatever plays them back at the venue must preserve that shared timeline.

The failure mode to avoid: **two independent playback processes drift out of sync over the course of a 3-hour run.** This is a real class of installation bug — video player and OSC player each have their own clock, tiny per-frame errors accumulate, by hour 2 the OSC-driven phone experience is firing at the wrong moment in the video.

The fix: **one clock as source of truth**, with all streams referencing it. Every viable option below satisfies this; they differ in *how*.

## Options survey

Ranked roughly by dev/setup effort ascending — but that's not the whole story:

| Option | Dev effort | OSS/commercial | Timing precision | Notes |
|--------|-----------|----------------|-------------------|-------|
| **Reaper as playback** | None (already used) | Commercial (owned) | Sample-accurate (audio clock) | DAW-in-venue overhead concerns; user has assessed as fine on M3 Max |
| **QLab (free tier)** | Modest (new tool) | Free tier: stereo A/V + OSC, Paid tier: multichannel | Sample-accurate (cue-list clock) | Cue-per-event mental model; theatre-industry pedigree |
| **QLab (paid)** | Modest | ~$399+ or rent-to-own | Sample-accurate | Multichannel + FX + fading unlocked |
| **Millumin** | Modest | Commercial (~€399 or rental) | Frame-accurate (timeline events) | Installation-industry native; timeline mental model |
| **mpv + Lua script** | 2–3 days | Open source | ~50 ms polling window | Free, endlessly hackable, ~200 line script |
| **libmpv + C** | 1–2 weeks | Open source | ~16 ms (per-frame) | Better precision than Lua, more integration effort |
| **MP4 + timed metadata + custom AVFoundation player** | 3–5 weeks | Open source (build yourself) | Container-level sample-accurate | Elegant single-artifact format; genuine ecosystem gap that no one has filled |

## Why "just build the MP4 metadata thing" is tempting but risky

The container spec (ISO Base Media / MP4) supports timed metadata tracks natively. AVFoundation reads them. In principle you could bake video + audio + OSC events into one `.mov` file and write a small player.

But the **tooling ecosystem doesn't exist**. Every adjacent industry solved timed-events-alongside-video differently:
- Broadcast: SCTE-35 markers in MPEG-TS
- Streaming: ID3 tags in HLS fragments
- Cinema (DCP): XML sidecar files
- Museum media servers: proprietary timeline files (Watchout, Pandora's Box, Millumin, etc.)
- Interactive TV: HbbTV signalling

Nobody generalised "OSC events as MP4 timed metadata" because the commercial museum industry solved it with proprietary formats and hobbyists solved it with duct tape (mpv scripts, TouchDesigner). Building this yourself is a **genuine open-source contribution to the artist community**, but it's real work and a project alongside the actual artwork.

Realistic estimate: 3–5 weeks with LLM dev assistance, including hardening. Not "a week of focused work".

## Sync mechanisms — brief primer

- **mpv Lua**: 50 ms minimum polling resolution (documented). Not drift-accumulating (single clock), but bounded ~50 ms lateness on event firing. Fine for Dreads' sequencer-tick data (1–4 Hz events).
- **libmpv C API**: better than Lua (~16 ms per-frame updates). For sample-accurate, would need to hook `mpv_render_context` render callbacks. More work.
- **QLab / Millumin / Reaper**: internal cue/timeline clock, sample-accurate by design.
- **MP4 timed metadata + AVFoundation**: samples are on the container timeline, presentation-time-scheduled by AVFoundation. Sample-accurate by design.

For Dreads' actual data (sequencer-tick OSC at 1–4 Hz, phones consuming discrete events), 50 ms lateness is invisible. Precision is not the deciding factor between viable options.

## QLab vs Reaper — the practical decision

For Dreads-driven installs, these are the two front-runners. Not because they're categorically best but because Reaper is already owned and QLab is theatre-industry-tested for exactly this class of work.

### Reaper path

**Wins:**
- Already owned, zero learning curve
- Full multichannel mixing at venue is trivial
- In-situ tweaks (mix, EQ, limiting) work exactly as user already knows
- OSC output via envelopes is documented (see `visualization-osc.md`)

**Concerns (already assessed by user as fine on M3 Max):**
- DAW UI running for 3+ hours (mitigated by install-mode preparation)
- Video playback is Reaper's weakest feature (mitigated by pre-rendered ProRes)

### QLab path

**Wins:**
- `.qlab` show file is a proper archival artifact — one document per piece
- Cue-list model handles "sections + events" naturally
- Metal-based video engine is Apple-current, built for install use
- OSC output is first-class from Network cues
- Theatre-industry stress-tested for exactly this shape of problem
- Rent-to-own pricing is uniquely honest — all rental spend becomes store credit toward permanent license

**Concerns:**
- New paradigm (cue list) vs familiar (DAW timeline). Real friction.
- **Free tier is stereo-only for audio** — multichannel stem mixing at venue requires the Audio license (~$399 or rent-to-own)
- No audio effects in free tier — limiter etc. would require the Audio license too

### The specific free-tier limitation

QLab 5 free tier for A/V + phones OSC:
- ✅ Video playback (single output stage — fine for one venue projection)
- ✅ 2-channel audio playback (stereo — fine for stereo mix)
- ✅ Unlimited Network cues (the OSC-to-phones flow)
- ✅ Unlimited cue lists, script cues, workflow features
- ❌ Multichannel audio (needs Audio license — 128 channels)
- ❌ Audio effects, fading (needs Audio license)

For a piece that will be mixed stereo at the venue, **the free tier is enough**. For a piece requiring in-situ multichannel stem mixing, QLab needs the Audio license.

### QLab Network cue semantics (important)

Confirmed: **one Network cue = one OSC message.** Not a log, not a script running inside. So an OSC event log with thousands of events becomes thousands of Network cues in the workspace.

This is fine — QLab is designed to hold and fire massive cue lists (theatrical shows have hundreds). Generation is a scripting task: read the OSC log (JSONL from Dreads capture), emit AppleScript or OSC-in commands to build cues in QLab programmatically. Small day of work; scripts exist in the community (see [QLab 5 – OSC Cue Creator Scripts](https://groups.google.com/g/qlab/c/2Ow7o0SRWqM)).

Alternative — a single Script cue running AppleScript that loops through an OSC log and sends messages. But then timing precision is script-polling territory, and you've lost QLab's whole point (sample-accurate cue firing). Prefer the cue-per-event approach.

## Recommendation

For **this** cinema install: **Reaper**. Zero paradigm shift, all mixing tools native, user has assessed stability concerns as met. Free.

**Prototype QLab in parallel** (free tier, one weekend): load a 30-second Dreads test render + a stub OSC log, build the cue list, see if the paradigm clicks. The value is *knowing* whether it's worth revisiting for the next install — not committing to it now.

The MP4-metadata pipeline is a genuine open-source contribution to the installation art community that no one has built. If it appeals as a side project alongside making artwork, worthwhile. As a deployment tactic for a specific install, no.

## Deployment tier model (from the design conversation)

Regardless of tool choice, three deployment tiers exist depending on venue capability:

- **Tier 1 — Fully baked**: render a single `.mov` (audio + video), play in any dumb player (VLC, mpv kiosk). No OSC. No in-situ mix. Bulletproof.
- **Tier 2 — Reaper as playback, no interactive**: audio stems + video, in-situ mix possible, no OSC to venue. Preserves flexibility, still simple.
- **Tier 3 — Full live system**: audio + video + OSC to phones bridge. QLab or Reaper or Millumin. Most moving parts, most rehearsal cost.

Design the Reaper project (or QLab workspace) so OSC send is one arm-click to enable or disable. Same project runs in Tier 2 (OSC muted, cinema without phones) or Tier 3 (OSC live, gallery with phone bridge).

## In-situ mix lever

An underrated option regardless of runtime tool: **assemble in studio, mix in-situ at venue, render final A/V to a file**. Then play that file with anything — Reaper, dumb player, QLab.

Trade-offs:
- ✅ In-situ mixing preserved
- ✅ Post-render runtime becomes bulletproof (no DAW at venue, or a much smaller QLab workspace with pre-rendered A/V + OSC only)
- ❌ Loses the phones OSC path unless captured as an editable envelope pre-render
- ❌ Loses ability to later re-mix without re-attending the venue

For cinema installs without phone interactivity, this is often the cleanest path.

## What we still don't know

- Whether the `~ws` composite `/plaits/state` message will fan out into per-cue OSC events cleanly (may need to split — see [`osc-install-capture.md`](./osc-install-capture.md))
- Whether Reaper video playback holds up for 3+ hour loops of 4K ProRes on M3 Max in a cinema environment (probably yes, verify in rehearsal)
- Whether QLab's cue-list paradigm actually feels better for this workflow than DAW timelines (open with a weekend prototype)

## Related docs

- [`visualization-osc.md`](./visualization-osc.md) — two-tier modulation (client Pbind + server LFO), OSC outbound streams from Dreads
- [`osc-install-capture.md`](./osc-install-capture.md) — capture-side design (record Dreads OSC into an editable log/envelope)
- `/Users/spatial/Library/Graphics/ISF/dreads/docs/session-prep.md` — A/V session prep checklist (studio + portable modes)
- `/Users/spatial/Library/Graphics/ISF/dreads/docs/reaper-notes` (not yet written) — Reaper-specific workflow tips if adopted

## Next steps

When picking this back up:

1. Decide whether **this specific install** needs multichannel mixing at venue (drives QLab-free vs Reaper vs QLab-paid)
2. Decide whether phones OSC is part of this venue or a future venue (drives Tier 2 vs Tier 3)
3. If phones OSC: run the bundle/split test outlined in `osc-install-capture.md` to determine whether Dreads-side per-param split is needed
4. If prototyping QLab: one weekend, free tier, 30-second Dreads render, stub OSC log, build workspace, evaluate paradigm fit
5. Whichever runtime: full-duration rehearsal on target hardware before doors open
