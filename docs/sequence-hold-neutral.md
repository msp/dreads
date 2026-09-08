# `\hold` = "no sequence" (and why some old patches changed pitch)

## What `\hold` means
In a patch's sequences, `\hold` means **"no sequence — hold this param at its base value"**
(do nothing). It's what the clear/reset path writes when you remove a sequence in the UI.
The intent is: `\hold` is a **no-op** for *every* param.

## TL;DR
It wasn't actually a no-op for **pitch** (and sample **variant**). A patch with `pitch: \hold`
was playing **+0.5 semitone** (a quarter-tone sharp) whenever sequencing. As of this fix
`\hold` is a true no-op there too, so those patches now play at the **base pitch** the scalar
states. An old patch may therefore sound very slightly *lower* now — that's the bug being
corrected, not a new change. (Fixed 2026-09.)

## Why it wasn't a no-op
Sequence values combine with the base scalar two different ways:

- **Bipolar params** (timbre, morph, decay, harm, mul, volume, FX sends, amDepth, amRing…)
  combine via `~modulateBipolar`, where the no-op value is **0.5**.
- **Additive params** (`pitch`, sample `variant`) combine via `~add`, where the no-op value
  is **0** (base + 0 = base).

`\hold`'s stored value is **0.5** — the correct no-op for the bipolar params. But the clear
path writes `\hold` for *every* param, so additive `pitch` got `~add(0.5, base) = base + 0.5`
— a constant quarter-tone offset instead of "do nothing". (`variant` had the same issue but
was accidentally hidden by `.asInteger` truncation.)

This spread widely because snapshots are made by **copying patch files**: apply a pitch
sequence while jamming, remove it → the field resets to `pitch: \hold` → every derived
snapshot inherits it. ~375 of ~390 patches ended up with `pitch: \hold`.

## The fix
`\hold` stays the single "no sequence" symbol in patches (nothing to change in your files or
mental model). A named wrapper `~getSequenceValueAdditive` (`lib/utils.scd`) calls
`~getSequenceValue` normally — so its stream cache updates exactly as before (a cleared
sequence still restarts from 0 if re-applied) — then coerces `\hold` → **0**, making `\hold` a
true no-op for additive params. The additive call sites use the wrapper (point any future
additive params there too):

- pitch — `lib/sequencer.scd` `\pitch` Pfunc
- variant — `lib/sequencer.scd` `\sampleVariant` Pfunc

Real sequences (`Pseq([0,2,-3])`, `\oct_up`, `"v+2"`) aren't the `\hold` symbol, so they
resolve normally. No patch files were rewritten — the correction happens at load/runtime, so
all existing `pitch: \hold` patches are fixed in place.

## To intentionally transpose
`\hold` means "no transpose". For a real pitch move, use an additive pitch sequence in
semitones, e.g. `pitch: Pseq([1], inf)` for +1 semitone.
