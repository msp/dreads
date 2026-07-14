# Reaper Render Settings for Reference Drafts

Quick-reference for the "send a reference mix to a collaborator" case. Not mastering-grade — optimised for "fast, plays anywhere, small enough to email/upload without friction".

## When to use these settings

- Draft mix for collaborator review / feedback
- Rough bounce to listen back on other devices
- Reference for sync work (e.g. paired with a video render, sent to Resolve)
- Anything where the file will be reprocessed later — not the final delivery

For final delivery / mastering, dial these differently: WAV 24-bit, ceiling at -0.3 dBTP, no MP3 encoding, no colour on the master beyond intent.

## Recommended settings

Open with `Cmd+Alt+R` (File → Render).

### Source and bounds

| Setting | Value | Why |
|---------|-------|-----|
| Source | Master mix | Single stereo file with the master chain applied |
| Bounds | Entire project | Or `Project regions` if you've marked sections |

### Format

| Setting | Value | Why |
|---------|-------|-----|
| Format | MP3 | Universal playback, small file size |
| Bitrate | 320 kbps CBR (or VBR ~245–260) | Transparent enough for reference; simpler for collaborators |
| Sample rate | 48000 | Match project |
| Channels | Stereo | Downmix to stereo for reference |

**Alternative — small but lossless:** FLAC. ~50% of WAV size, no lossy artifacts. Use when the collaborator will re-process the audio in a DAW, not just listen.

### Options

| Setting | Value | Why |
|---------|-------|-----|
| Tail | 2000 ms | Captures reverb/delay tails past the project end |
| Normalize | Off | The limiter's ceiling already sets the level; normalising defeats that intent |
| Dither | Auto/On for MP3 | Handles the down-conversion cleanly |
| 2nd pass render | Off | Rare, for lookahead-compensation edge cases |
| Trim silence at end | Off | Tail handles the fade cleanly |
| Trim silence at start | On | Collaborator hears content immediately |

### Filename

Use tokens for auto-versioning:

```
$project - draft-$YYYY-$MM-$DD.mp3
```

Reaper expands `$project`, `$YYYY`, `$MM`, `$DD` at render time. Prevents accidental overwrite of a previous draft.

## Master chain notes

For a "little global limiting" reference draft, the limiter setup that matches this workflow:

| Setting | Value | Why |
|---------|-------|-----|
| Limiter position | Last insert on master | Everything else is upstream |
| True-peak limiting | On (if plugin supports) | Prevents intersample peaks clipping the MP3 encode |
| Ceiling | -1.0 dBTP | Headroom for lossy encoding; -0.3 dBTP for WAV/FLAC |
| Threshold | Musical judgment | Reference drafts often live around -3 to -6 dB gain reduction on peaks |

## Master automation mode gotcha

If the master track has any recorded automation (volume, mute, etc.), its **automation mode must be `Read`** at render time — otherwise the render doesn't reflect the automation.

- `Read` — plays back existing automation ✓
- `Trim/Read` — plays back and adds offset for touched params ✓ (usually)
- `Off` — no automation playback ✗
- `Write / Latch / Touch` — records incoming changes; playback still works but you may accidentally overwrite envelopes ⚠️

Set to `Read` before rendering to be safe.

## Related workflow

- A/V sync workflow: this draft goes into DaVinci Resolve alongside the VDMX video capture. See `/Users/spatial/Library/Graphics/ISF/dreads/docs/session-prep.md` for the full session workflow.
- Video encode-review counterpart: `/Users/spatial/Library/Graphics/ISF/dreads/scripts/encode-review.sh` produces the review-quality video render.

## Non-obvious things not covered

- **Stems / multitrack render** — different beast; use "Master mix + stems" or "Selected tracks" in Bounds. Not documented here since the reference-draft case is single stereo.
- **Video render** — Reaper can render video too, but we render video via VDMX Movie Recorder in this workflow. Reaper's video export isn't part of the standard flow.
- **Loudness targets (LUFS)** — not addressed for drafts. For platform delivery (YouTube -14 LUFS, Spotify -14, Apple -16), a dedicated mastering pass with metering is the right move.
