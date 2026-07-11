# Working agreement for PI

## Default methodology: the seven-phase ISC loop (PAI Algorithm)

For any **non-trivial** task, operate with the **isc-loop** skill — the seven-phase PAI Algorithm:
OBSERVE → THINK → PLAN → BUILD → EXECUTE → VERIFY → LEARN. Load `/skill:isc-loop` and follow it.

**Classify the request first (bias toward running the loop when unsure):**

- **MINIMAL** (greeting, acknowledgment, rating) or **NATIVE** (one fact lookup, one single-line
  edit to a named file, or one command — with no new artifact and no multi-step plan)
  → answer directly and skip the loop.
- **ALGORITHM** (build / create / implement / design / refactor / migrate / integrate, multi-file
  work, anything ambiguous or touching system/doctrine)
  → run the loop at the right effort tier. Default E1; `/e1`–`/e5` overrides the tier.

**Core discipline every time the loop runs:**

- Articulate ideal state as **granular, binary, tool-verifiable ISCs** — criteria `[C1]…` plus
  anti-criteria `[A1]…` derived from negations ("don't/not/avoid/no/without").
- Track them in an **ISA** (Ideal State Artifact) — use the **isa** skill (`/skill:isa`). The ISA
  is the system of record: `<project>/ISA.md` for a persistent thing, else
  `MEMORY/WORK/{slug}/ISA.md` for one-shot work.
- **VERIFY mechanically** — every criterion needs YES/NO evidence from a real tool call, never
  prose-only. Test anti-criteria too (confirm NOT done).
- Scale depth to tier (E2+ has ISC and thinking floors); delegate parallel, conflict-free work via
  pi-crew (`team` / `Agent`), one owner per file/symbol.

Full doctrine: `~/.agents/skills/isc-loop/SKILL.md`, `~/.agents/skills/isa/SKILL.md`, and the
canonical PAI spec at `~/.claude/PAI5/PAI/ALGORITHM/`.
