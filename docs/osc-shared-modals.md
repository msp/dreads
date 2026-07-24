# Shared, context-driven modals (seq + LFO)

The seq/LFO modal is **one shared set of controls** that retargets to whichever
param opened it. This pattern deliberately overrides three Open Stage Control
defaults — none of it is obvious, so this documents *what* and *why* to avoid
re-discovering it the hard way.

## The setup

- One modal (`seqModal` → `seqModalPanel`) with a **seq** tab and an **lfo** tab.
- It's opened by a knob's seq button calling **`openSeqModal(param, instance, stateId, type)`**,
  which stores the target in a hidden widget **`seqModal/context`**:
  ```js
  { param: 'timbre', instance: '1', stateId: 'plaits_timbreLabel_seq_1', type: 'plaits' }
  ```
- Every control in the modal reads `seqModal/context` to know which param it's
  currently editing.

## Override 1 — the widget address is NOT the destination

Normally an O-S-C widget sends/receives on its own `address`. Here the controls'
addresses are **dummies** (`/seqModal/lfo/Freq`, `/seqModal/switch`) that SC
ignores. The real message is sent from **`onValue`**, which computes the true
per-param address from context and `send()`s there:

```js
// seq switch onValue (simplified)
var ctx = get('seqModal/context');
var addr = '/' + ctx.type + '/' + ctx.instance + '/' + ctx.param + '/seq';
send(addr, value);
```

Why: the destination is *dynamic* (depends on which param opened the modal), so it
can't be baked into a static address. `onValue` is the re-router.

## Override 2 — there is NO auto-reflect on open

O-S-C never queries SC for a value when a widget appears. So the controls would
show stale values on open unless we populate them. We do **not** ping SC either —
we read a **client-side cache** synchronously:

```js
// openSeqModal populate (simplified)
window._initializingSeqModal = true;   // guard (see override 3)
set('seqModal/switch', get(ctx.stateId));  // read the cache widget, set the control
window._initializingSeqModal = false;
```

`ctx.stateId` is the id of a **hidden per-param cache widget** that holds the
current value.

## Override 3 — the cache is hand-maintained (a bare `send` does NOT update it)

Confirmed in `osc.mjs`: a script `send(addr, value)` goes **out to SC only** — it
does not update local widgets listening on `addr`. So the cache stays current by
**two explicit moments**, nothing automatic:

1. **On patch load:** `~pushStateToUI` (SC) sends each param's value to its address
   (`/plaits/n/{param}/seq`, `/plaits/n/lfo/{param}/freq`, …) → the cache widget
   receives it.
2. **On user edit:** the control's `onValue` **writes the cache itself** right after
   sending:
   ```js
   send(addr, value);
   set(ctx.stateId, value);   // ← keep the cache current so reopen reads it back
   ```

Miss step 2 and the value won't survive close/reopen.

### The guard

Because populate calls `set(...)` on the controls, and controls have `onValue` that
sends, populate would **echo back out to SC**. A `window._initializing…` flag suppresses
that during populate — checked at the top of the seq switch's `onValue`, and (for LFO)
inside the shared `lfoSend`, which every LFO `onValue` calls.

## Override 4 — id-twin the cache to a real control for free two-way sync

Overrides 1–3 keep the modal's *own* controls current. But when a cached value
*also* has a dedicated on-page control — the `*Mod` depth knobs (`timbMod`,
`morphMod`) sit on the module face **and** are editable via the modal's mod knob —
the two would drift: the modal proxy-`send()`s (outgoing only), and the dedicated
knob has a different id, so neither updates the other.

Fix: make the hidden cache widget an **id-twin** of the dedicated control — give it
the **same `id`** (its address minus the leading slash, e.g. `plaits/1/timbMod`).
O-S-C auto-syncs same-`id` widgets (`{send:false, sync:false}` — no OSC, no scripts,
no loop; the `onChange`/`widgetsById` path), so:

- **modal → knob:** `lfoSend` does `set(scalarId, value, {send:false})`; the first
  match updates and the sync cascades to its twin. `send(addr)` still carries the
  value to SC (the cache is `bypass:true`, so it never emits on its own).
- **knob → modal:** dragging the dedicated knob fires the same-id sync → the cache
  mirrors it; `lfoPopulate` then reads the live value straight off that id.

Only applies to caches whose value has a real control twin. The LFO **source**
caches (freq/shape/base/width) are modal-only, so they keep their plain
`lfoState_…` ids — no twin, nothing to sync. (Commit `1a235f2`.)

## Where the cache lives → what this means for coverage

The hidden cache widgets live **inside the knob's fragment** — `large_knob` carries
`…Label_seq_…` (seq), and the `*_lfo` wrappers (`large_knob_lfo` / `small_knob_lfo`) plus
`volume.json` carry the `lfoState_…` (LFO) copies. Consequence: **reflect only works for
params whose knob is a fragment.** All the plaits/sample knobs are fragments now, so this
is mostly a note for any future inline knob — the cache rides along automatically once a
knob is converted.

## Reusable window functions (defined in `seqModal`'s `onCreate`)

Keep the per-widget `onValue` to one-liners; put the logic in shared functions:

- `openSeqModal(param, instance, stateId, type)` — set context, populate, open.
- `updateSeqButtonStyle(buttonId, value)` — restyle a seq label.
- `lfoSend(sub, value)` — send an LFO control to its real address **and** write its
  cache by that sub's id (handles the `mod` → `/{param}Mod` special case, `timbre`→`timbMod`;
  for `mod` the cache id *is* the scalar — an id-twin of the dedicated knob, see Override 4).
- `lfoPopulate()` — read the freq/shape/base/width `lfoState_…` caches plus the mod value
  (off the scalar id) and set the 5 LFO widgets, guarded.

## Adding a new control to the modal

1. Give it a **dummy/shared address** (SC won't listen there).
2. Its `onValue` calls the shared send helper (`lfoSend('freq', value)`), which sends
   to the real per-param address **and** writes the cache.
3. Its text-input twin shares the same id/address **and** the same `onValue` (so
   typing drives too — display sync alone isn't enough).
4. Make sure the param's knob is a **fragment** so the cache widget exists; otherwise
   reflect-on-open won't work for it.

## Divergence from O-S-C defaults — quick reference

| O-S-C default | Here |
|---|---|
| address = OSC destination | address is a dummy; `onValue` sends to a context-computed address |
| widget reflects its address automatically | no auto-reflect; populate reads a client cache on open |
| you set the address and forget it | you hand-maintain the cache (`set(stateId,…)`) on every edit |
| — | a guard flag prevents the populate from echoing sends |
