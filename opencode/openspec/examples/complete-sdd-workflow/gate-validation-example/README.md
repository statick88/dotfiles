# Complete SDD Workflow Example: Gate Validation

This directory contains a **production-ready example** of a Spec-Driven Development (SDD) change that demonstrates:

1. **PRD Gate Validation** — How the orchestrator blocks `sdd-spec` until a proper PRD exists
2. **Enriched PRD Content** — Gentleman Programming patterns (personas, KPIs, rituals, approval matrix)
3. **Multi-phase Workflow** — Define → Orchestrate → Execute → Verify → Iterate
4. **Code Quality Gates** — Definition of Done, code review patterns, anti-patterns

## Files

- **`proposal.md`** — Change intent, scope, and approach (Phase 1)
- **`prd.md`** — Product Requirements Document with enriched content (Phase 1)
- **`README.md`** — This file

## How to Use This Example

### As a Reference Template

Copy `proposal.md` and `prd.md` as templates for your own changes:

```bash
cd ~/.config/opencode/openspec/changes
mkdir my-new-feature
cp ../examples/complete-sdd-workflow/gate-validation-example/{proposal,prd}.md my-new-feature/
# Edit with your specific details
```

### To Understand the Workflow

1. **Read `proposal.md`** first — Understand the change intent and scope
2. **Read `prd.md`** next — See how enriched personas, KPIs, and rituals are documented
3. **Check `/Users/statick/.config/opencode/INTEGRATION-SUMMARY.md`** — See full mapping of Gentleman Programming concepts
4. **Review `~/.agents/skills/sdd-apply/SKILL.md`** — Definition of Done checklist that gates this example
5. **Review `~/.agents/skills/sdd-verify/SKILL.md`** — Verification checklist used to validate this example

## Key Concepts Demonstrated

### 1. Personas (from Gentleman Programming)

This PRD defines personas as **stakeholders with decision authority**:

- **Product Owner** — Owns business goals, acceptance criteria, prioritization
- **Engineering Owner** — Owns delivery commitment, team capacity, technical architecture
- **Backend/Frontend Leads** — Own implementation quality and testing
- **Security Lead** — Owns security gates (conditional)
- **Accessibility Lead** — Owns a11y compliance (conditional)

**Book Reference**: "Propiedad Colectiva" (Collective Ownership), Gentleman Programming

### 2. KPIs (Key Performance Indicators)

Four categories of measurement:

| Category | Why | Example |
|----------|-----|---------|
| **Business** | Revenue, delivery speed, scope control | Sprint velocity, feature delivery time |
| **UX** | User satisfaction, task success | Satisfaction scores, task completion rate |
| **Team** | Sustainability, morale, retention | Velocity trend, sustainable pace |
| **Technical** | Code quality, maintainability, debt | Test coverage, refactoring debt, defect rate |

**Book Reference**: "Métricas que Importan" (Metrics that Matter), Gentleman Programming

### 3. Rituals & Cadence

Eight ceremonies with owners and decision outcomes:

- **Sprint Planning** (Weekly) — Define stories and task commitment
- **Daily Standup** (Daily) — Share context, identify blockers
- **Mid-cycle Review** (Mid-sprint) — Early risk detection
- **Sprint Review/Demo** (End of sprint) — Stakeholder feedback
- **Retrospective** (End of sprint) — Team improvement
- **Pair Programming** (Per task) — Shared ownership, knowledge
- **Refactoring Windows** (Per sprint) — Code quality sustainability
- **Security & A11y Audit** (Before merge) — Final quality gate

**Book Reference**: "Ceremonias ágiles" (Agile Ceremonies), Gentleman Programming

### 4. Approval Matrix

Defines which roles must approve based on scope:

- **PRIMARY** roles always required (PO, Eng Owner)
- **CONDITIONAL** roles triggered by scope (Security if auth/data involved, A11y if UI involved)
- **Evidence** column shows where approval is documented (prd.md sections)

**Book Reference**: "Decisiones Distribuidas" (Distributed Decisions), Gentleman Programming

### 5. Definition of Done (DoD)

This example is gated by a DoD checklist in `~/.agents/skills/sdd-apply/SKILL.md`:

✓ Proposal completed  
✓ PRD exists and approved  
✓ KPIs and ritual ownership documented  
✓ Stakeholder matrix filled  
✓ Scope clearly bounded  
✓ Team capacity assessed  
✓ No security/a11y surprises  

**Book Reference**: "Hecho significa Hecho" (Done means Done), Gentleman Programming

## Workflow State Machine

```
[PROPOSAL] ──→ orchestrator.gate checks PRD ──┐
                                               │
                                          PRD missing?
                                               │
                                        return BLOCKED
                                               │
                   PRD exists & valid? ────────┤
                              │                │
                              └─PRD invalid ───→ BLOCKED
                                  │
                           [ORCHESTRATE] ✅
                                  │
                      Launch sdd-spec, sdd-design, sdd-tasks
                                  │
                           [EXECUTE via sdd-apply]
                                  │
                      RED → GREEN → REFACTOR (TDD cycle)
                                  │
                           [VERIFY via sdd-verify]
                                  │
                  DoD validation, Code Quality audit, Anti-patterns check
                                  │
                              ✅ MERGED or ❌ BLOCKED with reasons
```

## Running Gate Validation

To test the gate with this example:

```bash
# 1. Check orchestrator config
cat ~/.config/opencode/opencode.json | grep -A 20 "orchestrator"

# 2. Inspect gate logic
cat ~/.agents/skills/sdd-spec/SKILL.md | grep -A 30 "Preflight"

# 3. See DoD checklist
cat ~/.agents/skills/sdd-apply/SKILL.md | grep -A 15 "Definition of Done"

# 4. See verification logic
cat ~/.agents/skills/sdd-verify/SKILL.md | grep -A 20 "DoD Validation"
```

## Integration Points

### With Gentleman Programming Book

All sections in `prd.md` reference the Spanish XP methodology:

- **Personas** → "Propiedad Colectiva" (Collective Ownership)
- **KPIs** → "Métricas que Importan" (Metrics that Matter)
- **Rituals** → "Ceremonias ágiles" (Agile Ceremonies)
- **Definition of Done** → "Hecho significa Hecho" (Done means Done)

Full extraction: `/Users/statick/.config/opencode/gentleman-programming-extract.md`

### With SDD Skills

| Phase | Skill | File |
|-------|-------|------|
| Define | sdd-propose, sdd-prd | proposal.md, prd.md |
| Design | sdd-design | (created after gate passes) |
| Specify | sdd-spec | (blocked until prd.md exists) |
| Task | sdd-tasks | (blocked until sdd-spec exists) |
| Apply | sdd-apply | (executes with DoD checklist from prd.md) |
| Verify | sdd-verify | (validates against prd.md KPIs and DoD) |
| Archive | sdd-archive | (final state after merge) |

### With Multi-Agent Orchestration

This example works across:
- **claude** (primary orchestrator)
- **amp** (SDD orchestrator variant)
- **kilocode** (execution agent)
- **cursor** / **codex** / **opencode** (specialized agents)

All load from `~/.agents/skills/` (shared location).

## Next Steps

1. **Copy this example** to your own change directory
2. **Customize personas, KPIs, rituals** for your feature
3. **Submit for approval** — Gate validates PRD before proceeding
4. **Execute workflow** — sdd-spec → design → tasks → apply → verify → archive
5. **Learn from retrospective** — Improve next iteration

## Questions?

- **How is the gate triggered?** See `~/.config/opencode/opencode.json` line 186
- **What blocks the gate?** See `~/.agents/skills/sdd-spec/SKILL.md` lines 36–49 (Preflight check)
- **What is Definition of Done?** See `~/.agents/skills/sdd-apply/SKILL.md` lines 50–80
- **How is it verified?** See `~/.agents/skills/sdd-verify/SKILL.md` lines 40–100 (DoD Validation)
- **Where is the full Gentleman Programming content?** `/Users/statick/.config/opencode/INTEGRATION-SUMMARY.md`

---

**Last Updated**: Mar 7, 2026  
**Version**: 1.0 (Phase D Refactorization)  
**Book Source**: Gentleman Programming (Spanish Edition, Diego Saavedra García)
