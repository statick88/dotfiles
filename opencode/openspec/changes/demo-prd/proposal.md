# Change Proposal: demo-prd

## Intent
Validate SDD dependency gates for PRD-before-spec/verify behavior.

## Affected Areas
- sdd orchestration prompts
- sdd skill gate rules

## Success Criteria
- sdd-spec is blocked when PRD is missing.
- sdd-verify is blocked when PRD is missing.
- Both advance once PRD exists.
