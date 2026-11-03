# Patch collaboration & repo structure

How the `patches/` directory is split so it can serve three roles at once —
shipped examples, personal work, and a shared library collaborators can
contribute to — without git's complexity landing on a non-programmer.

Status: **design agreed, not built.** Safe boot defaults + `config.scd` are now
done (fresh machines boot stereo); the patch-repo split itself is still to build.

## The problem

`patches/` currently does three jobs in one place inside the main repo:

1. **Examples** — reference patches shipped with the project.
2. **Personal work** — the author's own patches (lots of churn).
3. **Shared library** — a space to swap patches with collaborators.

Git is the right substrate (real history, undo, attribution — email and
Dropbox-style sync give none of that), and it's a *low-conflict* fit here
because patches are **additive and timestamp-named** (`260912-1259-28.scd`):
people add files, they don't co-edit one, so merges almost never conflict.
The only real issues are git's UX for non-programmers and the three roles
fighting in one directory.

## Decisions

- **Two repos.**
  - **main** — code + `patches/examples/`. Goes public later.
  - **dreads-patches** — the shared library everyone works in.
  Splitting keeps main's history readable: code changes aren't drowned in
  patch-save churn, so `git log`/Desktop on main answers "did the engine
  actually change?".

- **Nested, not sibling, not submodule.** The shared repo is cloned *into*
  `patches/repo/` inside main, and **`patches/repo/` is gitignored in main.**
  The gitignore is the whole trick — without it git treats the nested `.git`
  as an embedded repo (Desktop warns, risk of committing a bare gitlink).
  With it, main ignores the folder entirely and the two never interfere.
  - *Not a submodule:* Desktop can clone submodules but the write path
    (commit/push a patch) is a detached-HEAD, two-repo dance — the exact
    pain we're avoiding.
  - *Not siblings:* a fixed nested path means no sibling auto-detection and
    no symlink (symlinks are a Windows trap). `~patchesDir` is deterministic.
  - Name: prefer `patches/repo/` → consider `patches/shared/` (purpose, not
    mechanism; reads better next to `examples/`).

- **`~patchesDir`** defaults to `~app.root ++ "/patches/repo"`, overridable in
  `config.scd`. The patch loader reads **both** `patches/examples/`
  (bundled, read-only) and `~patchesDir` (external, read/write).

- **Git stays in GitHub Desktop (GUI).** Collaborators clone, Sync (pull+push)
  and resolve the rare conflict in Desktop — no terminal, no tokens (sign-in
  button handles auth), and they get visible history/undo, which is the point.
  - Desktop clones through its **own bundled git in the GUI** — so **no
    "Install Command Line Tool" step is needed.** Those CLI tools install a
    `github` opener, not `git` on PATH; irrelevant to clone/commit/push.

- **The installer never runs git.** It only *verifies* `patches/repo/` exists
  and points the user to clone it there if missing. (We can't rely on `git`
  being on PATH; Desktop's GUI clone sidesteps that entirely.) This is
  separate from extension install, which keeps its **curl/tar** path — the two
  never collide: curl/tar = binary SC plugins, Desktop = patch sync.

- **Private repo deferred** to when main goes public. Until then personal WIP
  lives in a local gitignored scratch folder. (Collaborators need the whole
  project to run Dreads anyway, so pre-public "don't share the code" isn't a
  real constraint for them.)

## Layout

```
dreads-main/                 (repo: main)
  dreads.scd
  lib/ …
  patches/
    examples/                shipped, read-only reference        ← in main
    repo/                    clone of dreads-patches             ← gitignored in main
      <collaborators' patches>
```

## Onboarding a new collaborator

One-time — install three apps:
1. SuperCollider (installer).
2. GitHub Desktop (installer → "Sign in with GitHub").
3. Open Stage Control (installer; macOS Gatekeeper `xattr`/"Allow Anyway" once).

One-time — get the project (all in Desktop's GUI, no terminal):
4. Clone **dreads-main**.
5. Clone **dreads-patches**, setting the local path to
   `…/dreads-main/patches/repo`. *(The one precise field; the installer checks
   it and guides if wrong.)*

One-time — SuperCollider setup:
6. Open `dreads.scd`, run `~app.install.()` → downloads MI-UGens + sc3-plugins.
7. Recompile the class library (**Cmd+Shift+L**) so the UGens load.

Each session:
8. `~app.start.()` → boots + loads everything (waits internally).
9. Launch Open Stage Control with the ports + `plaits.json`.
10. Load a patch (examples + shared), play.

Collaborating:
11. Save a new patch → lands in `patches/repo/`.
12. Desktop → **Sync**: pushes theirs, pulls everyone's.

## Prerequisites / open gaps

- **✅ Done — safe boot defaults + `config.scd`.** `configureServer` now defaults
  to `recordingMode = false`, stereo, system-default device, and loads an
  optional gitignored `config.scd` (copied from `config.scd.example` on first
  run) for studio overrides. SafetyNet was **dropped entirely** — per-voice
  `LeakDC.ar(sig.tanh)` already covers DC/full-scale protection — so the quark
  is no longer a dependency.
- **🟡 O-S-C launch friction** — the 3-port config (step 9) is the clunkiest
  recurring step; a launch helper/preconfig would remove it.
- **🟡 Recompile step** (step 7) — unavoidable with downloaded extensions;
  must be spelled out clearly in the setup instructions.

## Build order (when we return)

1. ~~Safe boot defaults + `config.scd`~~ — **done.**
2. `~patchesDir` + gitignore `patches/repo/` + loader reads both dirs.
3. Installer `patches/repo/` existence check + guidance.
4. O-S-C launch helper.
