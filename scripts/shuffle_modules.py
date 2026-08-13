#!/usr/bin/env python3
"""
Reorder the three PLAITS module slots in a Dreads patch file, keeping each
module's LFO settings with it.

A patch has three plaits slots (0,1,2). Each slot's scalars + sequences live in
its $PLAITS block; its LFO source freq/shape values live in $LFO_SOURCES, keyed
by number: slot 0 -> lfo1-6, slot 1 -> lfo7-12, slot 2 -> lfo13-18 (params in
order timbre, morph, decay, pitch, volume, harm). Sample LFOs (lfo19+) and the
sample blocks are untouched.

This moves each slot's scalars, sequences AND lfo values to a new slot together,
so a reorder in the UI/patch stays sonically identical, just re-slotted.

Usage:
    python3 scripts/shuffle_modules.py PATCH.scd [perm]

  perm = comma-separated 3 old-slot indices, one per new slot:
         new_slot_i receives old_slot[perm[i]].
  Default "2,0,1" = the rotation old-p3->p1, old-p1->p2, old-p2->p3.

Examples:
    python3 scripts/shuffle_modules.py patches/.../2a-mod.scd          # 2,0,1
    python3 scripts/shuffle_modules.py patches/.../2a-mod.scd 1,2,0    # other way
    python3 scripts/shuffle_modules.py patches/.../2a-mod.scd 1,0,2    # swap p1<->p2

Writes in place. Prints a summary; re-run is safe (idempotent only if perm is
identity — otherwise each run applies the permutation again, so run once).
"""
import re, sys

PARAMS = ["timbre", "morph", "decay", "pitch", "volume", "harm"]  # per-slot lfo order


def rotate_blocks(txt, marker, perm):
    """Rotate the payloads between START/END markers (3 expected) per perm."""
    pat = re.compile(
        r'(// \$PRESET_%s_START\n)(.*?)(\n[ \t]*// \$PRESET_%s_END)' % (marker, marker),
        re.S)
    payloads = [m.group(2) for m in pat.finditer(txt)]
    if len(payloads) != 3:
        raise SystemExit("expected 3 %s blocks, found %d" % (marker, len(payloads)))
    new = [payloads[perm[i]] for i in range(3)]
    it = iter(new)
    return pat.sub(lambda m: m.group(1) + next(it) + m.group(3), txt)


def remap_lfo(txt, perm):
    """Rewrite $LFO_SOURCES, moving each plaits slot's lfo entries to its new slot."""
    m = re.search(r'~dreads\.lfoSources = \((.*?)\n\);', txt, re.S)
    if not m:
        raise SystemExit("no ~dreads.lfoSources block found")
    body = m.group(1)

    # parse entries: lfoN: (freq: X[, shape: Y]),   -> keep the (...) verbatim
    entries = {}  # N -> "(freq: ...)"
    for em in re.finditer(r'lfo(\d+):\s*(\([^)]*\))', body):
        entries[int(em.group(1))] = em.group(2)

    # new_slot = position where perm maps to a given old_slot
    old_to_new = {perm[i]: i for i in range(3)}

    out = {}   # new N -> value
    samples = {}
    for n, val in entries.items():
        if n <= 18:                       # a plaits source
            old_slot, p = (n - 1) // 6, (n - 1) % 6
            new_n = old_to_new[old_slot] * 6 + p + 1
            out[new_n] = val
        else:
            samples[n] = val              # sample source, unchanged

    lines = ["~dreads.lfoSources = ("]
    for slot in range(3):
        lines.append("\t// plaits %d" % slot)
        for p in range(6):
            n = slot * 6 + p + 1
            if n in out:
                lines.append("\tlfo%d: %s, // plaits %d %s" % (n, out[n], slot, PARAMS[p]))
    lines.append("\t// samples (unchanged)")
    for n in sorted(samples):
        idx = (n - 19) // 2
        kind = "rate" if (n - 19) % 2 == 0 else "volume"
        lines.append("\tlfo%d: %s, // sample %d %s" % (n, samples[n], idx, kind))
    lines.append(")")
    new_block = "\n".join(lines)
    return txt[:m.start()] + new_block + txt[m.end() - 1:]  # keep trailing ;


def check_balanced(txt):
    c = "\n".join((l[:l.find("//")] if "//" in l else l) for l in txt.split("\n"))
    c = re.sub(r'"(\\.|[^"\\])*"', " ", c)
    c = re.sub(r"'(\\.|[^'\\])*'", " ", c)
    pairs = {"(": ")", "[": "]", "{": "}"}
    st = []
    for ch in c:
        if ch in "([{":
            st.append(ch)
        elif ch in ")]}":
            if not st or pairs[st.pop()] != ch:
                return False
    return not st


def main():
    if len(sys.argv) < 2:
        raise SystemExit(__doc__)
    path = sys.argv[1]
    perm = [int(x) for x in (sys.argv[2] if len(sys.argv) > 2 else "2,0,1").split(",")]
    if sorted(perm) != [0, 1, 2]:
        raise SystemExit("perm must be a permutation of 0,1,2 (got %r)" % perm)

    txt = open(path).read()
    txt = rotate_blocks(txt, "SCALARS", perm)
    txt = rotate_blocks(txt, "SEQUENCES", perm)
    txt = remap_lfo(txt, perm)

    if not check_balanced(txt):
        raise SystemExit("ABORT: result is not bracket-balanced; not writing")
    # duplicate-key guard
    keys = re.findall(r'\n\s*(lfo\d+):', txt)
    dups = [k for k in set(keys) if keys.count(k) > 1]
    if dups:
        raise SystemExit("ABORT: duplicate lfo keys %r" % dups)

    open(path, "w").write(txt)
    print("shuffled %s with perm new<-old %r (balanced, no dup lfo keys)" % (path, perm))


if __name__ == "__main__":
    main()
