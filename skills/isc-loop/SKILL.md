---
name: isc-loop
description: Run the seven-phase PAI Algorithm (Ideal State Criteria loop) — OBSERVE, THINK, PLAN, BUILD, EXECUTE, VERIFY, LEARN — for any non-trivial problem-solving, implementation, design, refactor, migration, or investigation task. Use when the user asks to build/create/make/implement/design/refactor something, when a task spans multiple files or is ambiguous, when they invoke the "algorithm"/"ISC loop"/"ideal state criteria", or when they set an effort tier (/e1–/e5). Turns work into granular, binary, tool-verifiable criteria and hill-climbs current state → ideal state.
---

# The Seven-Phase ISC Loop (PAI Algorithm, pi edition)

Port of Daniel Miessler's PAI Algorithm (canonical spec: `~/.claude/PAI5/PAI/ALGORITHM/`,
current version in that dir's `LATEST` file). This skill carries the doctrine self-contained
so pi can run it without the Claude Code hook/voice/dashboard plumbing. For the full source
spec, read on demand:

- `~/.claude/PAI5/PAI/ALGORITHM/LATEST` then `~/.claude/PAI5/PAI/ALGORITHM/v<version>.md`
- `~/.claude/PAI5/PAI/ALGORITHM/mode-detection.md` (effort/ideate/optimize/fast-path)
- `~/.claude/PAI5/PAI/ALGORITHM/capabilities.md` (closed thinking-capability list)

## Doctrine — internalize first

**Every run does one thing: transition CURRENT STATE → IDEAL STATE.** Articulate the ideal
state as testable criteria (ISCs), pursue them through the phases, verify each one met.

- The most important activity is capturing and maintaining **IDEAL STATE**.
- Anything to improve must have state that is **verifiable at a granular level**.
- Everything becomes **discrete, granular, binary, testable criteria**.
- The ISC set **becomes the verification criteria** — it is the test harness AND the done condition.
- Experiential metric: **euphoric surprise** on convergence — the result clicks as obviously right.

## Mode classification (self-assessed — pi has no classifier hook)

Before starting, classify the prompt yourself (bias higher when in doubt):

- **MINIMAL** — greetings, acknowledgments, ratings. Answer plainly; skip the loop.
- **NATIVE** — one fact lookup OR one single-line edit to a named file OR one command, with no
  new artifact and no multi-step plan. Do it directly; skip the loop.
- **ALGORITHM** — everything else: build/create/implement/design/refactor/migrate/integrate,
  multi-file work, anything ambiguous, anything touching system/doctrine. Run the loop at a tier.

**Conversation-context override:** if a short prompt ("yes", "do it") approves a multi-step
proposal, treat it as ALGORITHM at the appropriate tier.

## Effort tiers (set the depth)

| Tier | Budget | ISC floor | Thinking floor | Delegation | When |
| ------ | -------- | ----------- | ---------------- | ------------ | ------ |
| E1 Standard | <90s | none | 0–1 | 0 | Normal request (DEFAULT) |
| E2 Extended | <3min | ≥16 | ≥2 | ≥1 | Must be extraordinary |
| E3 Advanced | <10min | ≥32 | ≥4 | ≥2 | Substantial multi-file work |
| E4 Deep | <30min | ≥128 | ≥6 (HARD) | ≥2 | Complex design / cross-cutting |
| E5 Comprehensive | <120min+ | ≥256 | ≥8 (HARD) | ≥4 | No time pressure |

Explicit `/e1`–`/e5` (or `E1`–`E5`) in the message overrides auto-detection. The time budget is
the hard constraint; the ISC floor is a soft minimum on criterion count. In pi, "delegation
capabilities" = pi-crew `team`/`Agent` subagents (explorer, analyst, planner, critic, executor,
reviewer, security-reviewer, test-engineer, verifier, writer).

**Fast-path (E1 only, whitelist):** rename a symbol, fix a typo, run a command, read-and-report,
append one line, format/lint, single-package install, single test run — single file/command, no
new architecture/endpoints/deps/migrations. If ALL hold → compress to **OBSERVE → EXECUTE →
VERIFY**. If ANY fails → full 7 phases at the resolved tier. Research-only (no code changes) →
**OBSERVE → THINK → EXECUTE → VERIFY → LEARN**.

## ISC quality rule

**Every criterion describes one verifiable end-state, answerable YES/NO by one tool call.**

> Split until each criterion is one binary tool probe (`Read`, `Grep`, `Bash`, `curl`,
> screenshot, `SELECT`, `pytest`, etc.). If you cannot name the probe, it is not atomic — split
> it. If it needs human judgment, name the tool-verifiable proxy.

| ❌ Vague / multi-part | ✅ Granular / testable |
| ---------------------- | ------------------------ |
| Researched the topic fully | Plugin docs found at URL |
| Implemented the feature correctly | Button renders on page |
| Fixed all the issues | Null check added at line 47 |

Track with IDs: `[C1]`, `[C2]`… = criteria; `[A1]`, `[A2]`… = anti-criteria (from negations:
"don't", "not", "avoid", "no", "without"). **ID-stability:** never renumber on edit — splits
become `C-N.M`; drops become tombstones (`C-N: [DROPPED — see Decisions]`).

## The ISA (Ideal State Articulation) — system of record

The ISA is the living document of "done". Two homes:

- **Project ISA**: `<project>/ISA.md` — for a thing with persistent identity (app, CLI, library).
  Requires E3+ structure regardless of task tier.
- **Task ISA**: `MEMORY/WORK/{slug}/ISA.md` — for one-shot/ad-hoc work. Created at OBSERVE,
  archived (`phase: complete`) at the end.

Write ISA content directly with Read/Edit/Write (no hook syncs it in pi). Frontmatter:
`task, slug, effort, phase, progress, mode, started, updated`.

**Twelve sections (fixed order, empty ones never appear):** Problem, Vision, Out of Scope,
Principles, Constraints, Goal, Criteria, Test Strategy, Features, Decisions, Changelog,
Verification.

**Tier completeness gate (HARD):**

- E1 → Goal, Criteria
- E2 → Problem, Goal, Criteria, Test Strategy
- E3 → Problem, Vision, Out of Scope, Constraints, Goal, Criteria, Features, Test Strategy
- E4 → all twelve
- E5 → all twelve + an Interview pass before BUILD

A missing required section blocks `phase: complete`.

## The seven phases

Announce each phase transition in your output (pi has no voice server — text only).

- 👀 **OBSERVE** — Parse the request into initial ISC (criteria + anti-criteria). Set mode & tier.
  Scaffold the ISA at the tier's required sections. Capture Problem/Vision/Goal.
- 🧠 **THINK** — Challenge assumptions, surface hidden constraints, refine ISC. Select thinking
  capabilities (first-principles, systems-thinking, root-cause, red-team, council, science, …).
  At E2+ meet the thinking floor.
- 📋 **PLAN** — Map each ISC to a capability/skill/agent. Identify parallel vs sequential work
  (pi: assign one owner per file/symbol; use `team`/`Agent` for parallelizable, conflict-free
  subtasks). Fill Features + Test Strategy.
- 🔨 **BUILD** — Create the solution. Track which ISC now have artifacts. Log new requirements
  discovered during implementation into Criteria/Decisions.
- ▶️ **EXECUTE** — Run it. Monitor against ISC; edge cases become new criteria.
- ✅ **VERIFY** — ISC becomes verification criteria. Test each with YES/NO **evidence from a real
  tool call**. Test anti-criteria (confirm NOT done). Mark ✓ satisfied / ⚠ partial / ✗ failed.
  Mechanical verification, never prose-only.
- 🎓 **LEARN** — Capture insights to memory, append Decisions/Changelog/Verification, decide
  whether another iteration is needed (loop back to OBSERVE if criteria remain unmet).

## ISC TRACKER (print at each phase boundary)

```
┌─ 🎯 ISC: Ideal State Criteria ────────────────────┐
│ Phase: [PHASE NAME]                               │
│ ✅ Criteria: [X] → [Y]  (+/-[N])                  │
│ ⛔ Anti:     [X] → [Y]  (+/-[M])                  │
├───────────────────────────────────────────────────┤
│ ➕ [Cn] added   📝 [Cn] modified   ➖ [Cn] removed │
└───────────────────────────────────────────────────┘
```

## Output format (ALGORITHM mode)

```
📋 SUMMARY: [one sentence — what this response is about]
🔍 ANALYSIS: [key findings / observations]
⚡ ACTIONS: [steps taken / tools used]
✅ RESULTS: [outcomes]
📊 STATUS: [current phase + criteria state]
📁 CAPTURE: [context worth preserving]
➡️ NEXT: [recommended next steps]
🎯 COMPLETED: [≤12 words]
```

## pi adaptations (what differs from Claude PAI)

- **No hooks/classifier/voice/dashboard/kitty tabs.** You self-classify mode+tier and
  self-enforce the completeness + thinking-floor gates. No `curl localhost:31337`.
- **No `Skill("ISA")` tool** — write/refine the ISA file yourself with Read/Edit/Write.
- **Delegation = pi-crew.** Claude `Task`/subagents → `team action='run'` or `Agent(...)`. Respect
  conflict-safe splitting (one owner per file/symbol; workers report intended files before editing).
- **Capabilities** map to pi's builtin agents + installed skills; pick the pi tool that can produce
  YES/NO evidence for each criterion.
- Keep the discipline that matters: granular binary ISC, anti-criteria, the ISA as source of
  record, tier-scaled depth, and mechanical verification with real tool output.
