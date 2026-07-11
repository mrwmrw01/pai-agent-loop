# pai-agent-loop

The **seven-phase PAI Algorithm (Ideal State Criteria loop)** wired for **pi** — and portable to
any compatible agent harness (e.g. AgentOS). This repo is the single source of truth for the loop
config we deploy onto this machine.

Loop: **OBSERVE → THINK → PLAN → BUILD → EXECUTE → VERIFY → LEARN**, with granular binary
tool-verifiable ISCs (criteria + anti-criteria) tracked in an ISA (Ideal State Artifact).

Ported from Daniel Miessler's PAI (canonical source lives locally at `~/.claude/PAI5/`).

## Layout

| Path | What it is |
| ------ | ----------- |
| `AGENTS.md` | Global always-on directive — tells the agent to run the loop by default |
| `skills/isc-loop/SKILL.md` | The seven-phase loop doctrine (tiers E1–E5, mode classify, fast-path, ISC TRACKER) |
| `skills/isa/SKILL.md` | The ISA authoring contract (12 sections, tier gate, 6 workflows, guardrails) |
| `templates/project-AGENTS.md` | Per-project pointer to drop at a repo root |
| `install.sh` | Symlinks the live locations to this repo, then run `/reload` in pi |

## Install / deploy

```bash
./install.sh          # symlinks ~/AGENTS.md and ~/.agents/skills/{isc-loop,isa} → this repo
# then run /reload inside pi (or restart) to load skills + context files
```

Deploys to:

- `~/AGENTS.md` ← `AGENTS.md`
- `~/.agents/skills/isc-loop` ← `skills/isc-loop`
- `~/.agents/skills/isa` ← `skills/isa`

pi discovers global skills from `~/.agents/skills/` and loads `AGENTS.md` walking up from the cwd.

## What's where — project map (this machine)

**Your repos (github.com/mrwmrw01 unless noted) — safe to push:**

| Dir (~/) | GitHub | Notes |
| ---------- | -------- | ------- |
| `pai-agent-loop` | mrwmrw01/pai-agent-loop | **this repo** — the ISC loop config |
| `sentinel-mes-fwa` | mrwmrw01/sentinel-mes-fwa | NH Medicaid FWA detector (renamed from mmis-fwa-detector); perf fixes pushed |
| `rfx-factory` | mrwmrw01/rfx-factory | RFx factory app |
| `sentinel-rebuild` | mrwmrw01/sentinel-rebuild | Sentinel rebuild |
| `ea-engine` | mrwmrw01/ea-engine | EA engine |
| `nicole-products` | mrwmrw01/nicole-products | Nicole products |
| `color-consultant-pro` | mrwmrw01/color-consultant-pro | Color consultant |
| `lucebox-hub` | Luce-Org/lucebox-hub | org repo (Luce-Org) |

**Third-party clones — do NOT push our changes (no write access):**

| Dir (~/) | Upstream |
| ---------- | ---------- |
| `ctx` | dchu917/ctx |
| `idea-os` | aiorgdev/idea-os |
| `free-code` | paoloanzn/free-code |
| `TradingAgents` | TauricResearch/TradingAgents |
| `Personal_AI_Infrastructure` | danielmiessler/Personal_AI_Infrastructure (canonical PAI upstream) |
| `llama.cpp`, `arch-as-code`, `HRM`, `TRELLIS.2`, `claw-code`, `claude-code` | various upstreams |

**Loop config on disk (deployed by `install.sh`, source = this repo):**

- `~/AGENTS.md` — global directive
- `~/.agents/skills/isc-loop`, `~/.agents/skills/isa` — the two skills
- Per-project pointer `AGENTS.md` files live at the root of your own project repos, kept local via
  each repo's `.git/info/exclude` (not committed).

**Related but NOT part of this repo:**

- `~/.claude/PAI5/` — the canonical PAI source (danielmiessler fork) the skills reference for depth.
- `~/sentinel-tools/` — system tuning (freeze-watchdog service, ollama GPU drop-in). Separate
  concern; not saved to GitHub yet.
