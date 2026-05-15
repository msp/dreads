# MiPlaits Modulation: Timbre, Morph & the Internal Decay Envelope

## The Key Issue In One Example

The MiPlaits UGen checks whether its `timbre` input is a fixed number or a changeable arg. This determines whether the internal decay envelope works:

```supercollider
// SCALAR RATE — timbre is a literal 0.5, baked into the SynthDef
// timb_mod WORKS (scales the internal decay envelope per trigger)
// but timbre can't be changed at runtime via .set
SynthDef(\fixed, {
    MiPlaits.ar(timbre: 0.5, timb_mod: 0.8);
});

// CONTROL RATE — timbre is a SynthDef arg, changeable via .set
// timb_mod is DEAD (the UGen disables the internal envelope)
// this is what our SynthDefs use
SynthDef(\flexible, { arg timbre = 0.5;
    MiPlaits.ar(timbre: timbre, timb_mod: 0.8);
});
```

You can't have both: a runtime-tweakable timbre AND the internal decay envelope. This is a limitation of the UGen wrapper, not the underlying DSP engine. See "Future: Forking MiPlaits" below for the fix.

## Hardware Plaits: Three Independent Controls

On the physical Mutable Instruments Plaits module, timbre modulation involves three separate controls:

1. **TIMBRE knob** — sets the base value (0–1)
2. **TIMBRE CV jack** — accepts an external modulation signal
3. **Attenuverter** — scales the modulation source:
   - If CV is **patched**: scales the incoming CV signal
   - If CV is **unpatched** but trigger is patched: scales the **internal decay envelope**
   - If neither: no modulation

The same applies to MORPH. This gives you simultaneous control over the base value AND per-trigger envelope modulation depth.

## Plaits DSP Engine (C++ source)

The underlying DSP code (`eurorack/plaits/dsp/voice.h`) cleanly separates these:

```cpp
struct Patch {          // "knobs"
  float timbre;                      // TIMBRE knob position
  float timbre_modulation_amount;    // attenuverter depth (timb_mod)
};

struct Modulations {    // "jacks"
  float timbre;                      // TIMBRE CV jack signal
  bool timbre_patched;               // is something plugged into the jack?
};
```

The routing logic in `ApplyModulations` (voice.h):

```cpp
// Choose modulation source based on what's patched
float modulation = timbre_patched
    ? modulations.timbre                         // CV jack signal
    : (trigger_patched
        ? decay_envelope_.value()                // internal decay envelope
        : 0.0f);                                 // nothing

// Final value = knob + (attenuverter * chosen source)
p.timbre = patch.timbre + (patch.timbre_modulation_amount * modulation);
```

The engine supports all three controls independently. The limitation is in the UGen wrapper.

## MiPlaits UGen: The Conflation

Source: `ref/mi-UGens/projects/MiPlaits/MiPlaits.cpp`

The UGen exposes these SC arguments:

```
timbre    — timbre parameter (0–1)
timb_mod  — timbre modulation amount, if internal env is activated by trigger (-1–1)
```

### What the UGen does with them

The single `timbre` input maps to **only** `patch.timbre` (the knob). `modulations.timbre` (the CV jack) is **never set** — it stays at 0:

```cpp
// MiPlaits.cpp:169-170
CONSTRAIN(timbre_in, 0.0f, 1.0f);
unit->patch.timbre = timbre_in;          // sets the "knob"
// modulations.timbre is NEVER assigned — always 0
```

The `timbre_patched` flag is determined at Synth creation time based on the **rate** of the timbre input:

```cpp
// MiPlaits.cpp:112
unit->modulations.timbre_patched = (INRATE(3) != calc_ScalarRate);
```

- **Control rate** (SynthDef arg) → `timbre_patched = true` → engine reads `modulations.timbre` which is 0 → `timb_mod * 0 = 0` → **timb_mod has no effect**
- **Scalar rate** (literal value) → `timbre_patched = false` → engine uses internal decay envelope → `timb_mod` works, but timbre can't be changed at runtime

The same applies to `morph` / `morph_mod`.

### Why fm_mod is different

`frequency_patched` is hardcoded `false` (line 118, with a TODO comment), so the internal decay envelope always works for FM modulation regardless of how pitch is passed:

```cpp
// MiPlaits.cpp:118
unit->modulations.frequency_patched = false;  // TODO: we don't have an fm input yet.
```

## Consequences for Our SynthDefs

### Current setup (control-rate args)

```supercollider
SynthDef(\plaits, { arg timbre = 0.5, timbMod = 0.0, timbreLFO = 0;
    MiPlaits.ar(
        timbre: (timbre + (timbreLFO * timbMod)).clip(0, 1),
        timb_mod: 0.0,  // would be ignored anyway
        // ...
    );
});
```

- `timbre` is control rate → `timb_mod` is dead inside the engine
- Modulation is applied externally before reaching the engine: `timbre + (timbreLFO * timbMod)`
- This gives continuous LFO modulation (like hardware with a CV cable patched)
- The internal per-trigger decay envelope is **not available**

### Alternative: scalar rate (.ir) for pattern synths

```supercollider
SynthDef(\plaitsIR, {
    var timbre = \timbre.ir(0.5);   // .ir = scalar rate, set per-Synth at creation
    var timbMod = \timbMod.ir(0.0);
    MiPlaits.ar(
        timbre: timbre,
        timb_mod: timbMod,          // NOW WORKS — scales internal decay envelope
        // ...
    );
});
```

- `timbre` is scalar rate → `timbre_patched = false` → internal decay envelope active
- `timb_mod` scales the per-trigger decay envelope applied to timbre
- Trade-off: `.ir` values can be set at Synth creation but **not changed on a running Synth** via `.set`
- Works for pattern-triggered synths (each note creates a new Synth)
- Does **not** work for drones (need `.set` to tweak timbre on a live Synth)

### Possible dual-SynthDef approach

| SynthDef | timbre rate | timb_mod | modulation style | use case |
|----------|------------|----------|-----------------|----------|
| `\plaits` | `.ir` (scalar) | active | internal decay envelope per trigger | patterns |
| `\plaitsDrone` | `.kr` (control) | dead | external LFO via control bus | drones |

This would give pattern synths the authentic hardware behaviour (short timbre sweep on each trigger, scaled by attenuverter) while drones keep continuous LFO modulation.

## What a Proper Fix Would Look Like

The engine already supports separate knob and CV inputs. The UGen would need one additional input per parameter:

```cpp
// Hypothetical fix in MiPlaits.cpp:
unit->patch.timbre = timbre_knob_in;                              // knob
unit->modulations.timbre = timbre_cv_in;                          // CV (new input)
unit->modulations.timbre_patched = (INRATE(CV_INDEX) != calc_ScalarRate);
```

Then from SC:
```supercollider
MiPlaits.ar(
    timbre: 0.5,        // knob — base value, freely settable
    timbre_cv: lfoSig,  // CV jack — modulation signal (new arg)
    timb_mod: 0.8,      // attenuverter — scales CV or internal envelope
);
```

This would match the hardware exactly: independent base value, CV input, and attenuverter depth.

## Summary

| Parameter | Hardware | MiPlaits UGen | Our workaround |
|-----------|----------|---------------|----------------|
| Timbre base value | TIMBRE knob | `timbre` arg | same |
| Timbre CV input | TIMBRE CV jack | conflated with `timbre` arg | external LFO added before engine |
| Timbre envelope depth | Attenuverter | `timb_mod` (dead when timbre is .kr) | `timbMod` scales external LFO |
| FM envelope depth | FM attenuverter | `fm_mod` (always works) | same |

## Future: Forking MiPlaits to Fix the Conflation

The code change is ~10 lines in `MiPlaits.cpp`, wrapper only — the Plaits DSP engine stays untouched:

1. Add two new inputs (`timbre_cv`, `morph_cv`)
2. Wire them to `unit->modulations.timbre` and `unit->modulations.morph`
3. Set `timbre_patched` / `morph_patched` based on the CV input's rate, not the knob input's rate
4. Update `sc/Classes/MiPlaits.sc` to add the new args

Build:
```bash
cd ref/mi-UGens
mkdir build && cd build
cmake .. -DSC_PATH=/path/to/supercollider-source
cmake --build . --target MiPlaits
```

Produces a universal `.scx` (x86_64 + arm64 on macOS). Drop into SC extensions folder.

This would give proper independent control: `.kr` timbre for live tweaking AND a working `timb_mod` scaling the internal decay envelope via the separate CV input.

## Source References

- Hardware manual: https://pichenettes.github.io/mutable-instruments-documentation/modules/plaits/manual/
- MiPlaits UGen: `ref/mi-UGens/projects/MiPlaits/MiPlaits.cpp`
- Plaits DSP engine: `ref/mi-UGens/eurorack/plaits/dsp/voice.cc`, `voice.h`
- Our SynthDefs: `lib/synthdefs.scd`
