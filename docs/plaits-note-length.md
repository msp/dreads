# Plaits engines & envelopes (how "decay" and note-length actually work)

Why the `decay` knob feels inconsistent across engines, and what shapes a note's
length. Grounded in the MiPlaits UGen / eurorack DSP (`ref/mi-UGens`) and the
Dreads sequencer/synthdef.

## Two levels stacked on every note

1. **MiPlaits engine (Level 1).** The `decay` knob → `patch.decay` → drives the
   engine's internal **LPG (low-pass gate) envelope**, *if that engine uses the
   LPG*. Some engines are **`already_enveloped`** — they generate their own
   envelope and the LPG is **bypassed**, so `decay` does nothing to their amplitude.
2. **Our `Linen` (Level 2), on top of whatever Level 1 produced.** In the `\plaits`
   synthdef: `Linen.kr(gate, attack 0.01, sustain 1.0, release 1.0, doneAction:
   freeSelf)`. It gates the note (held for `dur × legato`), applies a **fixed ~1 s
   release fade**, and its completion is what **frees the synth**. Applies to every
   engine.

The `decay→legato` remap (below) is **not a third stage** — it's a Dreads
control-routing choice that feeds Level 2's gate-hold timing for FM engines.

## Which engines the LPG is bypassed on (`already_enveloped`)

From `voice.cc` `RegisterInstance(engine, already_enveloped, …)`:

| # | Engine (UI label) | LPG / `decay` shapes amplitude? |
|---|---|---|
| 0 | Virtual Analogue | ✅ yes |
| 1 | Waveshaping | ✅ yes |
| 2 | FM (2-op) | ✅ yes |
| 3 | Grain | ✅ yes |
| 4 | Additive | ✅ yes |
| 5 | Wavetable | ✅ yes |
| 6 | Chord | ✅ yes |
| 7 | Speech | ✅ yes* |
| 8 | Swarm | ✅ yes |
| 9 | Noise | ✅ yes |
| 10 | Particle | ✅ yes |
| 11 | **String** | ❌ **bypassed** (self-envelopes) |
| 12 | **Modal** | ❌ **bypassed** |
| 13 | **BD** (bass drum) | ❌ **bypassed** |
| 14 | **SD** (snare) | ❌ **bypassed** |
| 15 | **HH** (hi-hat) | ❌ **bypassed** |
| 16 | VA+VCF | ✅ yes |
| 17 | Phase Dist | ✅ yes |
| 18 | **6op Bass/Syn** | ❌ **bypassed** |
| 19 | **6op Keys/Perc** | ❌ **bypassed** |
| 20 | **6op Pad/Str** | ❌ **bypassed** |
| 21 | Wave Terrain | ✅ yes |
| 22 | Str Machine | ✅ yes |
| 23 | Chiptune | ✅ yes* |

\* Speech and Chiptune toggle `already_enveloped` at runtime (prosody / clocked
mode); treat as "mostly LPG".

We always patch the trigger and not level, so `lpg_bypass` = the engine's flag
(`voice.cc:236`).

## What controls length on the self-enveloped engines

`decay` is inert on amplitude for 11,12,13,14,15,18,19,20 — length comes from the
engine's own controls:

- **BD / SD / HH:** **MORPH = decay/tail length**, TIMBRE = tone/attack, HARMONICS
  = drive (`bass_drum_engine.cc:89` derives the decay term from `morph`). One-shot
  hits — they decay to silence regardless of gate length.
- **String / Modal:** internal resonance decay (structure/damping via
  harmonics/morph). Pluck-and-decay.
- **6-op FM:** fixed internal DX envelopes per algorithm — **no accessible length
  param**, and the voice **sustains while gated**.

## The Dreads `decay→legato` remap (FM only)

Because 6-op FM has no internal length control *and* sustains while gated, the
sequencer repurposes the (otherwise-dead) `decay` knob as **legato** for engines
18–20 (`lib/sequencer.scd`, the `\legato` Pfunc):

```
leg = (eng in 18..20) ? decay.linlin(0, 1, 0.01, 15)   // decay knob → gate hold
                      : legato_scalar;
leg.max(0.05)                                           // leak floor, see below
```

So the decay knob does double duty in Dreads: **always** → `patch.decay` (a no-op
on self-enveloped engines) and **for FM only** → `legato` (Level 2 gate hold).

### The leak floor (`leg.max(0.05)`)
`decay: 0` on an FM engine gave legato `0.01` — a gate so short the `Linen` release
never completed, so note synths never freed → accumulation → server death (hit via
a loaded patch with `decay: 0.0`, which bypasses any UI clamp). Flooring legato at
**0.05** (empirical minimum that still frees) fixes it for all input paths. Commit
`5aa90ab`.

## The release tail — `releaseTime` scalar
Level 2's `Linen` release used to be **hardcoded at 1.0 s**. It's now the per-voice
**`releaseTime`** scalar (`~defaultScalars`, default 1.0), fed to the synthdef's `Linen`
release each note (`sequencer.scd` `\releaseTime` key). Shorter = punchier
FM/percussive stabs and fewer concurrent synths (they free sooner); longer = more
tail (more concurrent synths, steady-state — not a leak); very short (≲0.02) can
click. Most audible on the **self-enveloped** engines (FM, drums, string/modal)
where the release is the dominant tail; subtle on the LPG engines where the internal
decay already shaped the sound. It also sets each note synth's minimum lifetime
(frees at gate-release + `releaseTime`).

Set it via `~dreads.synths[i].releaseTime = 0.2`, OSC `/plaits/N/releaseTime`, or a patch
scalar (round-trips on save). No UI knob yet. Old patches fall back to the 1.0
default.

## Ideas / open questions (not built)
- **`releaseTime` on the UI surface** — currently OSC/patch-settable only; a per-voice
  knob would make it playable live.
- **Would the other self-enveloped engines benefit from decay→legato?** Mostly no —
  drums/string/modal are one-shot, so gate-hold doesn't extend their sound (only
  delays freeing). The FM trio is special because it sustains + has no length param.
- **A more intuitive fix for those engines:** remap the decay knob to each engine's
  *real* length control — **MORPH for drums** (that's their decay). This is a
  *semantic* remap, distinct from FM's decay→legato (gate) trick, and it overloads
  MORPH, so it needs a design pass.
