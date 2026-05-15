# MiPlaits Trigger & Level: The Four Patching Scenarios

## Hardware Plaits: Two Inputs, Four Modes

The TRIG and LEVEL inputs on Plaits interact to select between fundamentally different voice behaviours. The combination of what's patched and what isn't determines whether the internal LPG is active, how it's controlled, and whether the internal decay envelope fires.

## The Four Scenarios

### 1. Nothing patched (free-running drone)

- No trigger → engines that need excitation won't sound, others drone freely
- No level → LPG bypassed entirely — raw engine output passes straight through
- No internal decay envelope
- **Use case:** ambient drone, feed output into your own external VCA/VCF

### 2. Only TRIG patched (self-contained voice)

This is Plaits' signature mode — a complete voice from one module.

- Each trigger fires the internal decay envelope AND strikes the LPG
- The LPG shapes both **amplitude and brightness** with organic vactrol-like decay
- `decay` controls how long the LPG stays open
- `lpg_colour` controls the filter character (dark → bright)
- The LPG uses a resonant "ping" response — percussive, natural-sounding
- **Use case:** patch a clock/gate in, get fully shaped notes out. No external VCA or envelope needed.

### 3. Only LEVEL patched (external envelope controls LPG)

- No trigger → no internal decay envelope, no trigger events for engines
- LEVEL opens the LPG continuously — acts like an externally controlled VCA+VCF
- Louder = brighter, quieter = darker (the whole point of a low-pass gate)
- **Use case:** patch an external envelope, LFO, or sequencer into LEVEL. You control when and how the sound opens and closes. The LPG still adds its organic filter character.

### 4. Both TRIG and LEVEL patched (trigger + accent)

- Trigger fires the internal decay envelope but does **not** strike the LPG
- LEVEL controls the LPG opening (amplitude/brightness)
- LEVEL also becomes an **accent** control — physical/percussive models hit harder with higher level
- **Use case:** sequenced triggers with velocity/accent control via LEVEL

## C++ Implementation (voice.cc)

The behaviour is determined by two booleans: `trigger_patched` and `level_patched`.

### Trigger handling (lines 108–122)

```cpp
if (trigger_value > 0.3f) {
    trigger_state_ = true;
    if (!modulations.level_patched) {
        lpg_envelope_.Trigger();          // strike LPG only if level NOT patched
    }
    decay_envelope_.Trigger();            // always fire decay envelope
    engine_cv_ = modulations.engine;      // sample & hold engine selection
}
```

Key: `lpg_envelope_.Trigger()` is gated by `!level_patched`. When level is patched, trigger no longer strikes the LPG — level takes over that role.

### LPG bypass (line 236–237)

```cpp
bool lpg_bypass = already_enveloped ||
    (!modulations.level_patched && !modulations.trigger_patched);
```

LPG is only active when at least one of trigger or level is patched (and the engine doesn't handle its own envelope).

### LPG mode selection (lines 240–250)

```cpp
if (modulations.level_patched) {
    lpg_envelope_.ProcessLP(compressed_level, short_decay, decay_tail, hf);
} else {
    const float attack = NoteToFrequency(p.note) * float(kBlockSize) * 2.0f;
    lpg_envelope_.ProcessPing(attack, short_decay, decay_tail, hf);
}
```

- **Level patched** → `ProcessLP`: smooth, continuous opening/closing driven by the level signal
- **Level not patched** → `ProcessPing`: resonant ping response triggered by each gate, pitch-tracked attack time

### Accent (line 168)

```cpp
p.accent = modulations.level_patched ? compressed_level : 0.8f;
```

When level is patched, its value becomes the accent control passed to engines. Physical and percussive models (strings, modal, drums) respond to this — higher accent = harder excitation.

## How Dreads Uses These

### \plaits (pattern-triggered synths)

```supercollider
MiPlaits.ar(trigger: gate, ...)  // level not passed (defaults to 0, scalar rate)
```

- **Scenario 2** — self-contained voice
- LPG is active, struck by each pattern trigger via `ProcessPing`
- `decay` and `lpgColour` shape each note's amplitude + brightness
- Internal decay envelope fires (used by `fmMod`)
- Output is then wrapped in an additional `Linen.kr` for synth node cleanup (`doneAction`)

### \plaitsDrone (continuous synths)

```supercollider
MiPlaits.ar(trigger: 1, ...)  // literal 1, scalar rate; level not passed
```

- **Scenario 1** — nothing patched (trigger is scalar → `trigger_patched = false`)
- LPG bypassed entirely
- Engine runs continuously, raw output shaped only by the external `Env.asr` envelope

## What Dreads Could Do With Level

### Drone LPG modulation (scenario 3)

If `\plaitsDrone` passed `level` as a control-rate signal, the LPG would become active and respond continuously. This would be more interesting than a plain ASR envelope because the LPG simultaneously controls brightness — louder = brighter, quieter = darker, like an acoustic instrument.

Possible modulation sources for level on a drone:
- **LFO** → breathing, pulsing drone with timbral movement
- **External envelope** → shaped swells with the LPG's filter colour
- **Sequence value** → rhythmic gating of a drone with natural decay

This would require:
1. Adding `level` as a control-rate arg to `\plaitsDrone` (not `.ir`)
2. Mapping an LFO bus or sequence value to it
3. Possibly removing or reducing the external ASR envelope since the LPG would handle amplitude

### Pattern accent/velocity (scenario 4)

If `\plaits` passed `level` as a control-rate signal, it would switch from scenario 2 to scenario 4 — trigger still fires the decay envelope (so `fmMod` still works per-trigger), but the LPG is no longer struck by trigger. Instead, level drives the LPG via `ProcessLP` (a smooth follower) rather than `ProcessPing` (a resonant percussive strike). This changes the LPG character entirely — you lose the natural vactrol ping and instead get smooth VCA+VCF tracking of the level signal. This enables:
- Per-note velocity (level from pattern)
- Accent patterns (higher level = louder + brighter + harder excitation on physical models)
- Note: for punchy percussive notes with velocity, you'd need to send a shaped envelope into level yourself, since the LPG no longer self-pings

This would require passing level from the Pbind, potentially derived from a sequence or velocity value.

## Summary Table

| Scenario | trigger | level | LPG | Decay env | Dreads |
|----------|---------|-------|-----|-----------|--------|
| 1. Drone | unpatched | unpatched | bypassed | no | `\plaitsDrone` currently |
| 2. Self-contained | patched | unpatched | ping (per-trigger) | yes | `\plaits` currently |
| 3. External envelope | unpatched | patched | continuous (LP) | no | not used — opportunity for drones |
| 4. Trigger + accent | patched | patched | continuous (LP) | yes | not used — opportunity for velocity |

## Source References

- Plaits manual: https://pichenettes.github.io/mutable-instruments-documentation/modules/plaits/manual/
- MiPlaits UGen: `ref/mi-UGens/projects/MiPlaits/MiPlaits.cpp`
- Plaits voice: `ref/mi-UGens/eurorack/plaits/dsp/voice.cc` (lines 96–275)
- LPG: `ref/mi-UGens/eurorack/plaits/dsp/fx/low_pass_gate.h`
- Our SynthDefs: `lib/synthdefs.scd`
