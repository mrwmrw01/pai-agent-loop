---
name: isa
description: Own the ISA (Ideal State Artifact) — the single document that articulates "done" for any thing (project, task, app, library, infra, work session) as granular Ideal State Criteria. Use when a prompt mentions ISA, ISC, ideal state, ideal state criteria, articulating done, scaffolding/auditing/seeding a project spec, hill-climbing a task, or reconciling an ephemeral feature file back to a master. Companion to the isc-loop skill (the Algorithm invokes this at OBSERVE). Six workflows — Scaffold, Interview, CheckCompleteness, Reconcile, Seed, Append. NOT for postmortems/decision-logs (retrospective) or creating new skills.
---

# ISA — Ideal State Artifact (pi edition)

Port of the PAI ISA skill (canonical source: `~/.claude/PAI5/skills/ISA/`). The ISA is the single
document that articulates the ideal state of a thing and serves five identities at once:
(1) ideal-state articulation, (2) test harness (the ISCs ARE the tests), (3) build verification,
(4) done condition, (5) system of record. Don't invent parallel artifacts (acceptance.yaml, test
specs) — the ISA covers that surface.

For deep reference, read on demand:

- Workflows: `~/.claude/PAI5/skills/ISA/Workflows/{Scaffold,Interview,CheckCompleteness,Reconcile,Seed,Append}.md`
- Examples: `~/.claude/PAI5/skills/ISA/Examples/` (12 refs; start with `canonical-isa.md`)
- Format contract: `~/.claude/PAI5/PAI/DOCUMENTATION/IsaFormat.md`
- Conceptual frame: `~/.claude/PAI5/PAI/DOCUMENTATION/Isa/IsaSystem.md`

## Two homes

- **Project ISA**: `<project>/ISA.md` — for a thing with persistent identity. Lives in the repo as
  system of record; iteration on the project IS iteration on this ISA. Requires **E3+ structure**
  regardless of the active task's tier (`max(declared, E3)`).
- **Task ISA**: `MEMORY/WORK/{slug}/ISA.md` — for one-shot/ad-hoc work. Created at OBSERVE,
  archived (`phase: complete`) at the end.

Frontmatter: `task, slug, effort, phase, progress, mode, started, updated` (project ISAs add
`project:` and may omit `slug`).

## Twelve-section body (fixed order; empty sections never appear)

| # | Section | Purpose | Written at |
| --- | --------- | --------- | ----------- |
| 1 | `## Problem` | What is broken/missing now | OBSERVE |
| 2 | `## Vision` | What euphoric surprise looks like (1–5 sentences) | OBSERVE |
| 3 | `## Out of Scope` | Anti-vision — what is NOT included (prose) | OBSERVE |
| 4 | `## Principles` | Substrate-independent truths the work respects | OBSERVE |
| 5 | `## Constraints` | Immovable architectural mandates | OBSERVE |
| 6 | `## Goal` | Hard-to-vary spine — 1–3 sentences naming verifiable done | OBSERVE |
| 7 | `## Criteria` | Atomic ISCs (one binary tool probe each) incl. `Anti:` | OBSERVE → EXECUTE |
| 8 | `## Test Strategy` | Per-ISC: `isc \| type \| check \| threshold \| tool` | OBSERVE/PLAN |
| 9 | `## Features` | `name \| satisfies:[ISC…] \| depends_on \| parallelizable` | PLAN |
| 10 | `## Decisions` | Timestamped log incl. dead ends; `refined:` prefix | any phase |
| 11 | `## Changelog` | Conjecture / refuted-by / learned / criterion-now (all four) | LEARN |
| 12 | `## Verification` | Evidence per ISC (quoted tool output / file / screenshot) | VERIFY |

## Three-guardrail taxonomy (distinguished by who they bind)

| Guardrail | Binds | Example | Lives in |
| ----------- | ------- | --------- | ---------- |
| **Principles** | the *thinking* | "User-facing systems prioritize responsiveness." | `## Principles` |
| **Constraints** | the *solution space* | "No rolling our own crypto — OAuth via standard libs." | `## Constraints` |
| **Out of Scope** | the *vision* | "Mobile native apps are not part of v1." | `## Out of Scope` |
| **Anti-criteria** | the *test surface* | "Anti: /admin returns 200 in v1 build." | `## Criteria` (`Anti:`) |

First three are author-stated; anti-criteria are the derived, probe-able form. At least one
anti-criterion is required at every tier.

## Tier completeness gate (HARD)

| Tier | Required sections |
| ------ | ------------------- |
| E1 | Goal, Criteria |
| E2 | Problem, Goal, Criteria, Test Strategy |
| E3 | Problem, Vision, Out of Scope, Constraints, Goal, Criteria, Features, Test Strategy |
| E4 | all twelve |
| E5 | all twelve + an Interview pass before BUILD |

A miss blocks `phase: complete`. Project ISA override upgrades to E3+ automatically.

## Workflow routing (match the verb)

| Verb / intent | Workflow | Canonical file |
| --------------- | ---------- | ---------------- |
| scaffold / create / generate / new ISA / extract feature as ephemeral | **Scaffold** | `Workflows/Scaffold.md` |
| interview me / fill in / deepen / ask questions | **Interview** | `Workflows/Interview.md` |
| check / audit / score / is it complete? | **CheckCompleteness** | `Workflows/CheckCompleteness.md` |
| reconcile / merge feature file back / ephemeral → master | **Reconcile** | `Workflows/Reconcile.md` |
| seed / bootstrap from repo / draft from existing code | **Seed** | `Workflows/Seed.md` |
| append decision / changelog / verification (C/R/L) | **Append** | `Workflows/Append.md` |

When ambiguous: default Scaffold for new ISAs, CheckCompleteness for audits. Read the canonical
workflow file for the exact steps before running one.

## Non-negotiable rules & gotchas

- **ID-stability is the cornerstone.** ISC IDs never re-number on edit. Splits preserve the parent
  and add `ISC-7.1`, `ISC-7.2`; drops leave a tombstone (`ISC-N: [DROPPED — see Decisions]`).
  Reconcile keys on stable IDs; renumbering breaks feature-file merges silently.
- **Ephemeral files are derived views, never sources of truth.** Scaffold `--ephemeral` writes a
  slice to `MEMORY/WORK/{slug}/_ephemeral/<feature>.md`; workers operate there; Reconcile merges
  back and archives. Never hand-edit master from an ephemeral file.
- **Changelog format is non-negotiable** — every entry needs all four pieces (conjectured,
  refuted-by, learned, criterion-now) in order. A partial is a Decision, not a Changelog.
- **Empty sections never appear.** Required-but-empty for the tier → populate; not-required and
  unwritten → simply absent. Only `Verification` may be empty before VERIFY.
- **Antecedents for experiential goals.** Art/design/content that must "land" → at least one ISC
  uses an `Antecedent:` prefix naming a precondition that reliably produces the target experience.
- **The format spec wins on contradiction** — `IsaFormat.md` is the file-shape contract.

## Splitting test (granularity)

Split every criterion until a single tool call (`Read`, `Grep`, `Bash`, `curl`, screenshot,
`SELECT`, `pytest`, …) returns yes/no on whether it's met. If you can't name the probe, it isn't
atomic. If it needs human judgment, name the tool-verifiable proxy.

## pi adaptations (differences from Claude PAI)

- **No voice server, no `Skill("ISA")` tool.** Ignore any `curl localhost:31337` in the canonical
  files. Run each workflow yourself with Read/Edit/Write — you ARE the workflow engine here.
- **No CLI Tools/ hooks (ISASync/CheckpointPerISC).** Maintain frontmatter (`phase`, `progress`)
  and section content by editing the file directly.
- **Delegation = pi-crew.** Ephemeral/parallel feature work → `team`/`Agent` with one owner per
  file/symbol; Reconcile the ephemeral slice back into master afterward.
- Everything else — twelve sections, tier gate, guardrail taxonomy, ID-stability, C/R/L Changelog,
  antecedents — is identical to the canonical PAI ISA and stays authoritative.
