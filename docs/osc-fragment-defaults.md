# O-S-C fragment prop defaults & the `module` gotcha

Applies to `open-stage-control/fragments/large_knob.json` (the reusable knob
fragment) and any future fragment that defaults a variable.

## The mechanism

Fragment instances pass values via `props.variables`. In O-S-C this is a
**shallow replace**, not a merge:

```js
// src/client/widgets/containers/fragment.mjs → createFragment()
var data = {...deepCopy(fragment.getRoot()), ...this.getProp('props')}
```

So `props.variables` overwrites the fragment root's `variables` object
wholesale. There is **no schema / default layer** for fragment props — any
default has to be synthesised at each point where the variable is *used*.

## The gotcha

A **bare** `@{parent.variables.x}` for an *omitted* variable does not error and
does not go empty — `resolveProp` substitutes `String(undefined)`, i.e. the
literal string **`"undefined"`**. That string is truthy, so it also sails past
any downstream `x || 'default'` guard.

Real example that bit us: the seq-modal `type` arg was passed bare, so an
omitted `module` produced applied-sequence addresses like
`/undefined/1/morph/seq` instead of `/plaits/1/morph/seq`. Silent — the knob
itself worked; only the outbound seq apply was wrong.

**Rule:** every use of a defaultable variable must be wrapped:

```
#{@{parent.variables.module}||'plaits'}          // strings
#{Number(@{parent.variables.max})||1}            // numbers
#{@{parent.variables.displayName}||@{parent.variables.name}}   // derive from another var
```

Inside `#{…}` the `@{}` binds as a real value (proper `undefined`), so the
`||` fallback works. Outside `#{…}` it does not — that's the trap.

## The trade we accepted

`module` defaults to `plaits`. Consequence:

| Knob type | Default behaviour | Omission is… |
|---|---|---|
| plaits (timbre, morph, decay, FX…) | correct (`plaits`) | **safe** — the ergonomic win |
| sample knobs | wrong — needs `module: "samples"` | **silent breakage** (addresses `/plaits/…` instead of `/samples/…`) |

Note the irony: the default converts a *loud* failure (`/undefined/…` in the
log) into a *silent* one for samples (a plausible but wrong `/plaits/…`).

## Why we left it as-is

The per-use `#{… || default}` pattern is only error-prone when you **edit the
fragment internals** (add a new consumption point and forget the wrapper). With
the param set now stable (`instance`, `name`, `module`, `displayName`, `min`,
`max`, `step`) and only *instantiation* happening from here on, those internal
points are frozen — the lurker stays dormant. Not worth the structural change.

## Checkpoint for the sample rollout

When `large_knob` is used for the sample module, the instance-side risk is live:
**every sample knob must pass `module: "samples"`**. After converting, verify
each sample knob emits `/samples/…` (watch the O-S-C OSC log, or grep the
resolved addresses) — a forgotten override is silent.

## If it ever does start biting (the real fix)

Hydrate defaults **once** in an inner wrapper panel between the root and the
widgets: the wrapper's `variables` computes the defaulted/derived values, and
every child then reads them **bare** (they're now real values, so `"undefined"`
can't occur). Defaults live in one place; consumers get simple. Cost: one extra
nesting level + minor layout re-anchoring.
