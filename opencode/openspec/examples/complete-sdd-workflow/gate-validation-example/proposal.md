# Test Gate E2E Validation

## Intent
Validate that the PRD gate properly blocks sdd-spec when PRD is missing.

## Scope
- Test gate blocking behavior
- Verify gate allows after PRD exists
- Confirm enriched PRD content appears

## Approach
1. Create change with proposal only (no PRD) → gate should BLOCK
2. Add PRD with enriched personas/KPIs/rituals
3. Retry sdd-spec → gate should ALLOW

## Affected Areas
- Orchestrator gate logic
- PRD prerequisite validation
