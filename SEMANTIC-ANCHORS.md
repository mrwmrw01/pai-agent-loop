# Semantic Anchors — full catalog (read on demand)

Canonical, widely-published frameworks: **MECE**, **Pyramid Principle (Minto)**, **BLUF**,
**Progressive Disclosure**, **Tufte Style**, **arc42**, **C4-Diagrams**, **ADR/MADR**,
**Clean / Hexagonal Architecture**, **Domain-Driven Design**, **Strangler Fig**, **Conway's Law**,
**Team Topologies**, **CAP Theorem**, **Circuit Breaker**, **Twelve-Factor App**,
**Quality Attribute Scenario**, **EARS-Requirements**, **Cockburn Use Cases**, **MoSCoW**,
**INVEST**, **Kano Model**, **Laddering**, **Event Storming**, **STRIDE**, **LINDDUN**,
**OWASP Top 10**, **Wardley Mapping**, **Jobs To Be Done**, **Cynefin**, **Goodhart's Law**,
**Second-Order Thinking**, **Conventional Commits**, **SemVer**, **Definition of Done**,
**Thin Vertical Slice**, **Mikado Method**, **Diátaxis**, **Site Reliability Engineering**.

Naming one invokes the whole dense concept instead of a paragraph describing it —
instruction-layer compression. Use them freely in prompts, prose, and deliverables.

Full list with definitions: `~/.claude/PAI5/PAI/USER/DEFINITIONS.md`
→ section "Named Frameworks (Semantic Anchors)".

### HARD BOUNDARY — an anchor is NOT an ISC and NOT a capability

- An **ISC** is a binary, tool-verifiable criterion with a named probe. *"Apply MECE"* is **not** an
  ISC. *"`grep -c '^## ' report.md` returns 5 top-level sections, none overlapping"* **is**.
- A **capability** is a binding commitment to invoke a tool (`Skill` / `Agent` / `/skill:`).
  Anchors have no tool behind them — they invoke the model's latent knowledge.
- **Never list an anchor as a selected capability.** Doing so is a phantom capability.
- Watch the near-collisions: the anchor *First Principles Thinking* ≠ the capability
  **FirstPrinciples**; *Five Whys* / *Devil's Advocate* / *Premortem* ≠ **RootCauseAnalysis** /
  **Council** / **RedTeam**.

**Excluded deliberately:** MBTI, DISC, Big Five (OCEAN), HEXACO — low-validity psychometrics.
Never in client-facing deliverables.
