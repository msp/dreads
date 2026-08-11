# Sequence Crib Sheet

Quick reference for hand-writing sequences in patch files (the
`$PRESET_SEQUENCES_START … END` block). Examples are pulled from
`lib/sequence_library.scd` and existing patches.

---

## 1. Anatomy

Sequences live in a per-instance Event, one key per parameter:

```supercollider
// $PRESET_SEQUENCES_START
(
    duration: Pseq([0.5, 0.5, 1], inf).asStream,   // raw pattern, .asStream REQUIRED
    timbre:   \sine,                               // OR a named library symbol
    morph:    \hold,                               // \hold = neutral (no modulation)
)
// $PRESET_SEQUENCES_END
```

Two ways to fill a key:
- **Raw pattern** — any `P…` pattern, always end with **`.asStream`**.
- **Named symbol** — `\sine`, `\eucl_3_8`, `\hold` … resolved from `~sequenceLibrary`
  at load (no `.asStream`). See `lib/sequence_library.scd` for the full list.

`\hold` (= 0.5, neutral for modulation) and `\unit` (= 1.0, neutral for timing)
are the "do nothing" defaults.

---

## 2. Pattern classes

| Pattern | Does | Example |
|---|---|---|
| `Pseq([…], inf)` | play the list in order, loop forever | `Pseq([0, 0.5, 1], inf)` |
| `Pseq([…], n)` | play the list `n` times then stop | `Pseq([0, 12], 4)` |
| `Prand([…], inf)` | random pick each step | `Prand([0, 3, 7], inf)` |
| `Pxrand([…], inf)` | random, but never the same twice running | `Pxrand([0, 5, 7], inf)` |
| `Pwrand([…], weights, inf)` | weighted random pick | `Pwrand([0.5, Rest(0.5)], [0.7, 0.3].normalizeSum, inf)` |
| `Pshuf([…], inf)` | shuffle once, then loop that order | `Pshuf([0, 2, 4, 7], inf)` |
| `Pwhite(lo, hi, inf)` | uniform random (ints if lo/hi are ints) | `Pwhite(0.3, 0.7, inf)` |
| `Pexprand(lo, hi, inf)` | exponential random (favours low end) | `Pexprand(0.01, 1.0, inf)` |
| `Pbrown(lo, hi, step, inf)` | random walk, max `step` per move | `Pbrown(0.0, 1.0, 0.1, inf)` |
| `Pseries(start, step, len)` | arithmetic ramp | `Pseries(0.0, 0.05, inf)` |
| `Pgeom(start, grow, len)` | geometric ramp | `Pgeom(0.1, 1.2, 8)` |
| `Pfunc { … }` | compute a value per event (advanced) | `Pfunc { rrand(0.0, 1.0) }` |

`.normalizeSum` on the weights array makes them sum to 1 (Pwrand needs that).

---

## 3. Rests & duration

`duration` values are **beat fractions** (1 = a quarter note; the step is then
scaled by `div`). Silence is a `Rest` of that many beats:

```supercollider
duration: Pseq([0.5, Rest(0.5), 0.5, 1], inf).asStream,   // eighth, rest, eighth, quarter
```

- `0.25` sixteenth · `0.5` eighth · `1` quarter · `2` half · `3/4` dotted-eighth
- `Rest(1)` = a one-beat gap · `Rest(0.5)` = half-beat gap
- **`div`** multiplies the step: `\unit` (1), `0.5` (half-time subdivision), `2` (double).

Probabilistic rhythm (from a real patch):

```supercollider
duration: Pseq([
    0.7,
    Pwrand([0.7, Rest(0.7)], [0.9, 0.1].normalizeSum),   // 90% hit, 10% rest
    0.7,
    Pwrand([1.4, 0.7],       [0.6, 0.4].normalizeSum),
], inf).asStream,
```

---

## 4. Array & math shorthand

These build the list *before* it goes into a pattern — handy for terse shapes:

| Idiom | Result |
|---|---|
| `0.2 ! 19` | array of nineteen `0.2`s |
| `a ++ b` | concatenate arrays: `0.5 ! 5 ++ [0.3]` |
| `(1..8)` | `[1, 2, 3, 4, 5, 6, 7, 8]` |
| `(0, 0.25 .. 1.0)` | range with step: `[0, 0.25, 0.5, 0.75, 1.0]` |
| `.collect { |x| … }` | map: `(1..8).collect { |i| i / 8.0 }` |
| `.normalize(0, 1)` | rescale array into 0–1 |
| `.normalizeSum` | rescale so the array sums to 1 (weights) |
| `.reverse` `.mirror` `.scramble` | flip / there-and-back / shuffle |

Real examples from the library:

```supercollider
// glitch: nineteen quiet steps then one loud
Pseq(0.2 ! 19 ++ [0.8], inf)

// sine wavetable as a stepped shape
Pseq((0, 0.04166 .. 1.0).collect { |x| sin(x * 2pi) * 0.5 + 0.5 }, inf)

// gate every 16 steps
Pseq([1] ++ (0 ! 15), inf)
```

---

## 5. Nesting

Patterns compose — a `Pseq` can contain `Pwrand`, `Prand`, another `Pseq`, etc.
Each inner pattern advances one value per outer step:

```supercollider
decay: Pseq([0.5, 0.3, Pseq([0.6, 0.1, 0.8])], inf).asStream,
lpgColour: Pseq([0.1, Prand([0.4, 0.9], 1), 0.2], inf).asStream,
```

Array maths distributes over a whole pattern list:
`Pseq([0.6, 0.1, 0.8] / 3, inf)` divides every element by 3.

---

## 6. What each parameter expects

| Param(s) | Type / range | Notes |
|---|---|---|
| `duration` | beat fractions + `Rest()` | literal step length; scaled by `div` |
| `div` | timing multiplier | `\unit`=1, `0.5`, `2`, `2/3` (triplet) … |
| `timbre` `morph` `harm` `decay` `lpgColour` `fmMod` | **0–1** | blended via the knob — see below |
| `cloudsSend` `delaySend` `reverbSend` | **0–1** | same knob-as-depth blend |
| `pitch` | **semitone offsets**, additive | `0`=base, `12`=+oct, `-7`=fifth down |
| `volume` `mul` | 0–1 | literal, centred ~0.5 |
| `engine` | Pseq of **string exprs** | `"e"` = keep; `"(e-5).mod(16)"` = shift −5, wrap 0–15 |
| sample `rate` `startPos` `atk` `panDur` | 0–1 | scaled to the sample's own duration |

**Knob-as-depth (shape/FX params):** the value you sequence is 0–1, but the
param's **knob sets how much of it lands** (`~modulateBipolar`):

- knob **0** → output 0 (sequence suppressed)
- knob **0.5** → sequence value played **verbatim**
- knob **1.0** → pushed toward 1.0

So write the shape in 0–1 and park the knob near **0.5** to hear it as written.

---

## 7. Named library shortcuts

Instead of a raw pattern you can drop in a symbol, resolved from
`~sequenceLibrary` (tag in brackets = which params it suits):

- **rhythm** (`duration`): `\eucl_3_8` `\eucl_5_16` `\tresillo` `\son_clave`
  `\bossa_nova` `\backbeat` `\offbeat` `\sprs_quarter` `\dense_burst`
- **shape** (`timbre`/`morph`/`decay`/FX): `\sine` `\triangle` `\ramp_up`
  `\steps_4` `\sweep` `\rndm_walk` `\rndm_narrow` `\glitch` `\wobble` `\cycle5`
- **accent** (`volume`/`mul`/sends): `\acnt_downbeat` `\gate_every4`
  `\gate_prob50` `\swell_8` `\dyn_cresc`
- **timing** (`div`): `\half` `\double` `\triplet` `\dotted` `\shuffle`
  `\swing` `\accel` `\poly_3_over_4`
- **pitch** (`pitch`): `\oct_updown` `\fifth` `\triad_min` `\scale_pent`
  `\rndm_fifth` `\walk_semi`
- **constants**: `\hold` (0.5, neutral) · `\unit` (1.0, neutral)

Full list + definitions: `lib/sequence_library.scd`. Euclidean rhythms of any
`k`/`n` are also generatable inline: `~euclideanSeq.(5, 12)`.

---

## 8. Gotchas

- **`.asStream` is mandatory** on raw patterns in a patch (symbols don't need it).
- **`inf`** loops forever; a finite count stops the param (it holds its last value).
- **`Rest()` only makes sense in `duration`** — a rest elsewhere is a held value.
- **`div` shifts everything** — omitting it uses the module default (plaits `\hold`
  → 0.5, samples `\unit` → 1.0), which is why the same `duration` can sound
  different across module types.
- A modulation param sitting at **`\hold`** (0.5) plus its **knob at 0.5** = no
  audible movement; nudge the knob up to reveal the sequence.

---

## 9. Period, speed and smoothness (how a stepped sequence "moves")

These are **step-based, not time-based**: one value is pulled per sequencer
event (`.next` per tick). So the wall-clock behaviour has two independent axes.

### Period — how long one cycle takes
```
period  = (steps per cycle) × (seconds per step)
sec/step = duration / div × (60 / tempo)        // ~setDuration = duration/div, in beats
```
- **steps per cycle** is baked into the pattern (e.g. `sweep_slow` ≈ 100, `sine_slow`
  ≈ 49). **sec/step** is set by that param's `duration`/`div` sequences and the
  global tempo — *not* by a rate knob.
- To slow a drift without touching tempo, **lengthen `duration`** (bigger = slower,
  smaller = faster). A handy idiom is a global `~dur = [1/16]` fed to
  `duration: Pseq(~dur, inf).asStream` on several voices.
- It's tempo/rhythm-locked — you can't decouple drift speed from note rate. That
  decoupling is the one thing a continuous LFO gives that a grid sequence can't.

### Smoothness — whether you hear "stepping"
Audible stepping depends on the **value jump per step, NOT the seconds per step.**
A fine sequence sounds smooth even held for seconds; a coarse one clunks even fast.

```
granularity = value range ÷ steps per cycle      // smaller Δ = smoother
```

Per-step Δ of the shape sequences (for `amRing`/any 0–1 gain-morph param):

| sequence | steps/cycle | Δ per step | feel |
|---|---|---|---|
| `sine_slow` | 49 | ~0.02–0.065 | glassy — no perceptible steps at any speed |
| `sine` | 25 | ~0.08–0.13 | mild stepping visible on a gain morph |
| `saw` | 10 | 0.125 rising **+ 1.0 jump at wrap** | coarse; the reset is an audible click/thump |
| `steps_4` | 4 | 0.25 | obvious 4-state stepping |

- A **0.02** change in a gain-like param (`amRing`, sends) is ~**0.18 dB** — below
  the threshold to hear as a discrete step. That's why `sweep_slow`/`sine_slow`
  read as continuous even slow and dry.
- Watch for **built-in discontinuities**: `saw` snaps 1.0→0 at the wrap (sines turn
  around smoothly and never do), and a `Pseq` with a big gap between its last and
  first value will click at the loop point.
- **Want stepping?** Use a coarse sequence (`steps_4`, `steps_8`, or a custom `Pseq`
  with big gaps). **Want smooth?** Use a fine one (`*_slow`). Speed and smoothness
  are separate dials.
- **CPU note:** very small `duration` (e.g. `1/256`) fires hundreds of events/sec
  per voice, each also emitting `~vis`/`~td`/`~ws` OSC bundles. Past ~30–50
  updates/sec a gain morph is already perceptually smooth, so faster just burns
  cycles for no audible gain. `1/16`–`1/32` is a good smooth-but-cheap zone.
