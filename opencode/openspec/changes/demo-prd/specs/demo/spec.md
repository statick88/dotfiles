# Delta for demo

## ADDED Requirements

### Requirement: PRD Gate for Specs and Verify

The system MUST block sdd-spec and sdd-verify when prd.md is missing.

Trace: AC-001, AC-002, AC-003

#### Scenario: Missing PRD blocks
- GIVEN a change folder without prd.md
- WHEN sdd-spec or sdd-verify is executed
- THEN status is blocked

#### Scenario: Existing PRD allows progress
- GIVEN a change folder with prd.md
- WHEN sdd-spec or sdd-verify is executed
- THEN execution continues
