# PRD: demo-prd

## Intent & Problem Statement
Validate PRD gating in SDD workflow.

## Personas & Stakeholders
- Primary: Product Owner
- Secondary: Developer, QA Engineer, Security Reviewer
- Required approvers: Product Owner, Engineering Owner

## Success Metrics (KPIs)
- Business KPI: planning-to-implementation lead time baseline 5d, target 3d, weekly measurement.
- UX KPI: escaped requirement defects baseline 3/change, target <=1/change, per release.
- Delivery KPI: PRD-to-spec traceability baseline 0%, target 100%, per change.

## Scope
- In-scope: enforce PRD prerequisites for spec/verify.
- Out-of-scope: implementation of runtime CLI command parser.

## High-Level Approach
Use gate checks in orchestrator and skill rules.

## Acceptance Criteria
- AC-001 (MUST): Given a change without prd.md, when sdd-spec runs, then it returns blocked.
- AC-002 (MUST): Given a change without prd.md, when sdd-verify runs, then it returns blocked.
- AC-003 (MUST): Given prd.md exists, when sdd-spec or sdd-verify runs, then it can proceed.

## Risks & Constraints
- Depends on CLI model availability for full E2E run.

## Dependencies & Approvals
- Product Owner sign-off: pending
- Engineering Owner sign-off: pending

## Rituals
- Planning ritual: PRD kickoff review (owner: Product Owner, cadence: once per change)
- Mid-cycle review ritual: spec/design sync (owner: Tech Lead, cadence: once per change)
- End ritual: demo + retro (owner: Engineering Manager, cadence: once per change)
