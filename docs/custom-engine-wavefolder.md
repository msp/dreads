# Custom Plaits Engine: Wavefolder

A minimal but musically useful new engine for the Plaits DSP framework.

## Concept

West Coast-style wavefolder. A basic oscillator is driven into a `sin()` waveshaper — increasing drive and fold count produces rich, evolving harmonic spectra. The interaction between drive and folds creates a huge sweet spot that responds beautifully to modulation.

## Control Mapping

| Control | Parameter | Range | Effect |
|---------|-----------|-------|--------|
| HARMONICS | Fold count | 1–8 | Number of wavefold stages — more folds = more harmonics |
| TIMBRE | Drive | 1–10x | Input gain into the folder — more drive = more complex spectrum |
| MORPH | Waveform | 0–1 | Blend sine → triangle → saw before folding |
| AUX output | Clean signal | — | Pre-fold waveform (useful as sub/reference) |

## Core DSP

The entire folding algorithm:

```cpp
float fold(float input, float folds) {
    return sinf(input * folds * M_PI);
}
```

## Implementation Sketch

### wavefolder_engine.h

```cpp
#ifndef PLAITS_DSP_ENGINE_WAVEFOLDER_ENGINE_H_
#define PLAITS_DSP_ENGINE_WAVEFOLDER_ENGINE_H_

#include "plaits/dsp/engine/engine.h"

namespace plaits {

class WavefolderEngine : public Engine {
 public:
  WavefolderEngine() { }
  ~WavefolderEngine() { }

  virtual void Init(stmlib::BufferAllocator* allocator);
  virtual void Reset();
  virtual void LoadUserData(const uint8_t* user_data) { }
  virtual void Render(const EngineParameters& parameters,
      float* out, float* aux, size_t size,
      bool* already_enveloped);

 private:
  float phase_;
  float previous_drive_;
  float previous_folds_;

  DISALLOW_COPY_AND_ASSIGN(WavefolderEngine);
};

}  // namespace plaits
#endif
```

### wavefolder_engine.cc

```cpp
#include "plaits/dsp/engine/wavefolder_engine.h"
#include "stmlib/dsp/parameter_interpolator.h"
#include <cmath>

namespace plaits {

using namespace stmlib;

void WavefolderEngine::Init(BufferAllocator* allocator) {
  phase_ = 0.0f;
  previous_drive_ = 0.0f;
  previous_folds_ = 0.0f;
}

void WavefolderEngine::Reset() {
  phase_ = 0.0f;
}

void WavefolderEngine::Render(
    const EngineParameters& parameters,
    float* out, float* aux, size_t size,
    bool* already_enveloped) {

  // Map controls
  const float f0 = NoteToFrequency(parameters.note);
  const float drive = 1.0f + parameters.timbre * 9.0f;       // 1x – 10x
  const float folds = 1.0f + parameters.harmonics * 7.0f;    // 1 – 8 folds
  const float morph = parameters.morph;

  // Smooth parameter changes to avoid zippering
  ParameterInterpolator drive_mod(&previous_drive_, drive, size);
  ParameterInterpolator folds_mod(&previous_folds_, folds, size);

  for (size_t i = 0; i < size; ++i) {
    // Advance phase
    phase_ += f0;
    if (phase_ >= 1.0f) phase_ -= 1.0f;

    float p = phase_ * 2.0f - 1.0f;  // bipolar -1..1

    // Morph between waveforms: sine → triangle → saw
    float sine = sinf(p * M_PI);
    float tri = (p < 0.0f ? p * 2.0f + 1.0f : 1.0f - p * 2.0f);  // triangle
    float saw = p;

    float wave;
    if (morph < 0.5f) {
      wave = sine + (tri - sine) * (morph * 2.0f);      // sine → tri
    } else {
      wave = tri + (saw - tri) * ((morph - 0.5f) * 2.0f);  // tri → saw
    }

    // Clean signal to aux before folding
    aux[i] = wave;

    // Wavefold: drive the waveform, then fold
    float d = drive_mod.Next();
    float f = folds_mod.Next();
    out[i] = sinf(wave * d * f * M_PI);
  }
}

}  // namespace plaits
```

## Registration

### voice.h

Add member:
```cpp
WavefolderEngine wavefolder_engine_;
```

Add include:
```cpp
#include "plaits/dsp/engine/wavefolder_engine.h"
```

Bump `kMaxEngines` from 24 to 25.

### voice.cc Init()

Add after the last `RegisterInstance`:
```cpp
engines_.RegisterInstance(&wavefolder_engine_, false, 0.8f, 0.8f);
```

- `false` — not already enveloped (use the LPG)
- `0.8f, 0.8f` — out/aux gain (same as most engines)

### MiPlaits.cpp

Change engine clamp from 23 to 24:
```cpp
CONSTRAIN(engine, 0, 24);  // 25 engines
```

### CMakeLists.txt

Add to `MI_SOURCES`:
```
${MI_PATH}/dsp/engine/wavefolder_engine.cc
${MI_PATH}/dsp/engine/wavefolder_engine.h
```

## What You Get For Free

The Voice wrapper handles all of this around your engine:

- **LPG** — low-pass gate with decay and colour controls
- **Internal decay envelope** — triggered per-note, applied to timbre/morph/FM
- **Trigger handling** — rising edge detection, trigger delay
- **Post-processing** — limiter, gain staging
- **Stereo out/aux** — two output channels

## Possible Extensions

- **Asymmetric folding**: offset the fold function for even harmonics
- **Multi-stage**: cascade multiple folders with different fold counts
- **Feedback**: feed output back into input (chaotic at high feedback)
- **Sync**: reset phase on trigger for hard sync timbres
- **Anti-aliasing**: use polyBLEP or oversampling to reduce aliasing at high fold counts

## Build

```bash
cd ref/mi-UGens
mkdir build && cd build
cmake .. -DSC_PATH=/path/to/supercollider-source
cmake --build . --target MiPlaits
```

Output: `MiPlaits.scx` — drop into SC extensions folder.

From SC: `engine: 24` selects the new wavefolder engine.
