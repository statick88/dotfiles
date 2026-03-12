# Plan Comprehensivo de Testing para Skills

**Basado en análisis de 12 skills (8 SDD workflow + 2 specialized + 1 infrastructure + 1 utilities)**

---

## EXECUTIVE SUMMARY

### Estado Actual
- ✅ **12 skills implementados** - todos son documentation-based (no ejecutable)
- ✅ **Estructura limpia** - flat directory con _shared infrastructure
- ✅ **0 skills roto** - todas las SKILL.md están completas y bien documentadas
- ⚠️ **No unit tests posible** - son documentation, no código ejecutable

### Necesidades de Testing
1. **Integration tests** - verificar que artifacts flown correctamente entre skills
2. **E2E tests** - test full SDD cycle en proyectos reales (Go, Python, TypeScript)
3. **Persistence tests** - engram mode, openspec mode, none mode
4. **Dependency tests** - verify DAG correctness, no circular dependencies

---

## TEST MATRIX (Qué Testear)

### 1. STRUCTURE & CONFIGURATION TESTS

| Test | Scope | Input | Expected Output | Status |
|------|-------|-------|-----------------|--------|
| **T1.1** - Skill metadata | All 12 skills | Read SKILL.md frontmatter | name, description, license, author, version present | ✅ |
| **T1.2** - Persistence contract reference | All 8 SDD skills | Read "Execution and Persistence Contract" section | References persistence-contract.md with mode rules | ✅ |
| **T1.3** - SKILL.md completeness | All 12 skills | Audit each SKILL.md | Has Purpose, When to Use, Contract, What to Do, Rules | ✅ |
| **T1.4** - Shared infrastructure | _shared/ | Read all .md files | persistence-contract.md, engram-convention.md, openspec-convention.md present | ✅ |

### 2. DEPENDENCY GRAPH TESTS

| Test | Scope | Input | Expected Output | Status |
|------|-------|-------|-----------------|--------|
| **T2.1** - No circular deps | DAG | Trace dependencies | proposal → spec/design → tasks → apply → verify → archive (linear) | ✅ |
| **T2.2** - Parallel execution valid | spec + design | Both require proposal only | Can run in parallel without race | ⚠️ Need orchestrator verification |
| **T2.3** - Blocking conditions | sdd-tasks, sdd-apply, sdd-verify, sdd-archive | Check dependency list | Blocked: tasks(spec+design), apply(tasks), verify(apply), archive(verify+CRITICAL) | ⚠️ Need orchestrator enforcement |
| **T2.4** - All dependencies documented | All 8 SDD | Search "dependencies" section | incoming/outgoing clearly stated | ✅ |

### 3. PERSISTENCE MODE TESTS

#### Mode: engram

| Test | Skill | Input | Expected Output | Status |
|------|-------|-------|-----------------|--------|
| **T3.1a** - Artifact naming | sdd-propose | Create proposal artifact | topic_key = "sdd/{change}/proposal" | Design only |
| **T3.1b** - Recovery protocol | sdd-spec | Read proposal | mem_search() + mem_get_observation() (2-step) | Design only |
| **T3.1c** - Full artifact retrieved | All skills | Read via recovery protocol | Complete untruncated content (not truncated preview) | Design only |

#### Mode: openspec

| Test | Skill | Input | Expected Output | Status |
|------|-------|-------|-----------------|--------|
| **T3.2a** - File structure | sdd-init | Initialize openspec | Creates config.yaml, specs/, changes/, changes/archive/ | Design only |
| **T3.2b** - Artifact paths | Each skill | Create artifact in openspec | Writes to correct path per convention (e.g., proposal.md) | Design only |
| **T3.2c** - Config.yaml | sdd-init | Auto-detect project stack | Generated config has tech stack, testing, linters, rules | Design only |
| **T3.2d** - Archive structure | sdd-archive | Archive change | Moves to changes/archive/YYYY-MM-DD-{change}/ | Design only |

#### Mode: none

| Test | Skill | Input | Expected Output | Status |
|------|-------|-------|-----------------|--------|
| **T3.3a** - No project files | All skills | Run with mode=none | No files written to project | Design only |
| **T3.3b** - Return inline | All skills | Run with mode=none | Results returned as markdown inline | Design only |
| **T3.3c** - Fallback behavior | Skills with no Engram/openspec | Detect mode=none | Return recommendation to enable persistence | Design only |

### 4. ARTIFACT LIFECYCLE TESTS

| Test | Artifact | Skill Chain | Expected | Status |
|------|----------|-------------|----------|--------|
| **T4.1** - proposal creates | proposal | sdd-propose | File exists with all sections (Intent, Scope, Approach, Risks, Rollback, Success Criteria) | Design only |
| **T4.2** - proposal feeds to spec | proposal → spec | sdd-propose → sdd-spec | spec reads proposal, creates delta specs | Design only |
| **T4.3** - proposal feeds to design | proposal → design | sdd-propose → sdd-design | design reads proposal, creates architecture decisions | Design only |
| **T4.4** - spec + design feed to tasks | (spec, design) → tasks | sdd-spec/design → sdd-tasks | tasks reads both, creates hierarchical task list | Design only |
| **T4.5** - tasks feed to apply | tasks → code | sdd-tasks → sdd-apply | apply reads tasks, marks [x] as complete, writes code | Design only |
| **T4.6** - apply output feeds to verify | code → verify-report | sdd-apply → sdd-verify | verify reads code, spec, design, generates compliance matrix | Design only |
| **T4.7** - verify blocks archive | verify-report → archive | sdd-verify → sdd-archive | archive blocked if CRITICAL issues; allowed if PASS/PASS WITH WARNINGS | Design only |
| **T4.8** - archive merges specs | delta specs → main specs | sdd-archive | Delta specs merged into main specs (ADDED→append, MODIFIED→replace, REMOVED→delete) | Design only |

### 5. SPEC COMPLIANCE TESTS (sdd-spec)

| Test | Input | Expected Output | Status |
|------|-------|-----------------|--------|
| **T5.1** - Given/When/Then format | spec.md scenarios | All scenarios use Given/When/Then structure | ✅ Documented |
| **T5.2** - RFC 2119 keywords | spec.md requirements | Requirements use MUST, SHALL, SHOULD, MAY with proper meaning | ✅ Documented |
| **T5.3** - Delta vs Full | spec created | If main spec exists → delta (ADDED/MODIFIED/REMOVED); if not → FULL spec | ✅ Documented |
| **T5.4** - No implementation details | spec.md | Describes WHAT not HOW | ✅ Rule documented |

### 6. IMPLEMENTATION TESTS (sdd-apply)

| Test | Mode | Input | Expected Output | Status |
|------|------|-------|-----------------|--------|
| **T6.1** - TDD detection | Standard project | config.yaml rules.apply.tdd | Correctly detect TDD mode | Design only |
| **T6.2** - TDD workflow | TDD mode | Task 1.1 (RED test) → Task 1.2 (GREEN code) → Task 1.3 (REFACTOR) | RED fails → GREEN passes → no behavior change in REFACTOR | Design only |
| **T6.3** - Standard workflow | Non-TDD mode | Write code directly | Code matches spec acceptance criteria | Design only |
| **T6.4** - Pattern matching | Apply phase | Read existing codebase | Follow existing patterns (not generic best practices) | Design only |
| **T6.5** - Skill loading | Apply phase | Project has pytest installed | Load pytest skill patterns | Design only |
| **T6.6** - Test runner detection | Apply phase | No explicit config | Detect from package.json, Makefile, pytest.ini | Design only |

### 7. VERIFICATION TESTS (sdd-verify)

| Test | Check | Input | Expected Output | Status |
|------|-------|-------|-----------------|--------|
| **T7.1** - Completeness gate | Tasks | tasks.md | Count total vs completed; flag incomplete core tasks | Design only |
| **T7.2** - Correctness gate | Code | Search codebase | Every spec requirement has evidence in code | Design only |
| **T7.3** - Coherence gate | Design | Compare design vs code | Design decisions followed; flag deviations | Design only |
| **T7.4** - Testing gate | Unit/Integration | Run test suite | Tests pass; CRITICAL if failed | Design only |
| **T7.5** - Build gate | Build | Run build command | Build succeeds; CRITICAL if failed | Design only |
| **T7.6** - Coverage gate | Coverage | Check vs threshold | Above threshold = OK; below = WARNING | Design only |
| **T7.7** - Compliance matrix | Spec scenarios | Each scenario has test + test passed | ✅ COMPLIANT; ❌ FAILING; ❌ UNTESTED; ⚠️ PARTIAL | Design only |
| **T7.8** - Report generation | All checks | Combine all evidence | verify-report.md with CRITICAL/WARNING/SUGGESTION issues | Design only |

### 8. ARCHIVE TESTS (sdd-archive)

| Test | Input | Expected Output | Status |
|------|-------|-----------------|--------|
| **T8.1** - Spec merge | Delta specs | Requirements matched by name, preserved if not in delta | Design only |
| **T8.2** - Folder move | Change folder | Moved to archive/YYYY-MM-DD-{change}/ (ISO date format) | Design only |
| **T8.3** - CRITICAL block | verify-report with CRITICAL | Archive blocked; user warned | Design only |
| **T8.4** - Audit trail | Archive folder | Contains all artifacts (proposal, specs, design, tasks, verify-report) | Design only |

### 9. INITIALIZATION TESTS (sdd-init)

| Test | Input | Expected Output | Status |
|------|-------|-----------------|--------|
| **T9.1** - Stack detection | package.json, go.mod, pyproject.toml | Correctly identifies tech stack (Node, Go, Python, etc) | Design only |
| **T9.2** - Test framework detection | Project files | Detects jest, pytest, go test, vitest, etc | Design only |
| **T9.3** - CI/Linter detection | Config files | Detects eslint, pylint, golangci-lint, CI pipeline | Design only |
| **T9.4** - Config generation | All detected info | Generates config.yaml with detected context + rules | Design only |
| **T9.5** - Persistence bootstrap | mode parameter | Creates Engram context OR openspec/ structure OR returns inline | Design only |

### 10. EXPLORATION TESTS (sdd-explore)

| Test | Input | Expected Output | Status |
|------|-------|-----------------|--------|
| **T10.1** - Codebase reading | Project path | Reads entry points, affected files, existing behavior | Design only |
| **T10.2** - Approach comparison | Multiple options | Compares with pros/cons/complexity | Design only |
| **T10.3** - No code modification | During exploration | Original code unchanged | Design only |
| **T10.4** - Standalone exploration | topic only | Returns analysis inline; no files created | Design only |
| **T10.5** - Tied to change | change_name provided | Saves exploration.md to change folder | Design only |

---

## E2E TEST SCENARIOS

### Scenario 1: Full SDD Cycle (Go Project)

**Setup**: Sample Go CLI project with existing unit tests

```
Phase 1: sdd init
├── Input: project_root
├── Detect: Go stack, go test framework, existing Makefile
└── Output: Engram project context saved

Phase 2: sdd explore
├── Input: "Add interactive mode to CLI"
├── Investigate: Current CLI structure, existing UI patterns
└── Output: 3 approaches compared (flags vs interactive menu vs REPL)

Phase 3: sdd propose
├── Input: Exploration + change_name="add-interactive-mode"
├── Create: proposal.md with Intent (UX improvement), Scope, Approach (interactive menu)
└── Output: proposal artifact

Phase 4a: sdd spec (parallel)
├── Input: proposal
├── Create: spec.md with Given/When/Then scenarios for interactive menu
└── Output: spec artifact

Phase 4b: sdd design (parallel)
├── Input: proposal + (optional) spec
├── Create: design.md with Architecture (state machine), File Changes, Data Flow
└── Output: design artifact

Phase 5: sdd tasks
├── Input: proposal + spec + design
├── Create: tasks.md with 3 phases:
│   ├── Phase 1: Create UI state machine (1.1, 1.2)
│   ├── Phase 2: Integrate with CLI (2.1, 2.2)
│   └── Phase 3: Tests (3.1, 3.2)
└── Output: tasks artifact

Phase 6: sdd apply
├── Input: tasks batch (Phase 1)
├── Implement: Write state machine code, mark [x] tasks
├── Run: go test ./... (passing)
└── Output: Code + updated tasks.md

Phase 7: sdd verify
├── Input: All artifacts + Phase 1 code
├── Check: Completeness, Correctness, Coherence, Testing, Build
├── Run: go test ./..., go build
├── Generate: verify-report.md with compliance matrix
└── Output: PASS / PASS WITH WARNINGS / FAIL

Phase 8: sdd archive
├── Input: verify-report (PASS or PASS WITH WARNINGS, no CRITICAL)
├── Merge: Delta specs into main specs (if applicable)
├── Move: changes/add-interactive-mode/ → archive/2026-03-07-add-interactive-mode/
└── Output: Archived change, updated main specs

Expected Result: ✅ Full cycle complete, code implemented, specs synced
```

### Scenario 2: Parallel Spec + Design (Python Project)

**Setup**: FastAPI project

```
Phase 1: sdd init → detect Python, pytest, FastAPI
Phase 2: sdd explore → "Add JWT authentication"
Phase 3: sdd propose → create proposal

Phase 4a: sdd spec (START)         Phase 4b: sdd design (START)
├─ Read proposal                   ├─ Read proposal
├─ Create spec.md with:            ├─ Read existing codebase
│  ├─ Req: JWT tokens MUST expire  ├─ Create design.md with:
│  ├─ Scenario: Valid token        │  ├─ Middleware architecture
│  ├─ Scenario: Expired token      │  ├─ Token validation flow
│  └─ Scenario: Invalid token      │  ├─ File changes: middleware.py, utils.py
└─ WAIT for design                 └─ WAIT for spec (wait time = 0 if parallel)

After both complete:
├─ sdd tasks (requires BOTH spec + design)
├─ Create tasks.md with authenticated task ordering
└─ Continue to sdd apply

Expected Result: ✅ Parallel execution validated, both artifacts complete, tasks accurate
```

### Scenario 3: Verification Blocking Archive (TypeScript Project)

**Setup**: React + vitest project

```
Phases 1-6: Complete implementation of change

Phase 7: sdd verify
├─ Check completeness: ✅ All tasks done
├─ Check correctness: ✅ All spec requirements in code
├─ Check coherence: ✅ Design decisions followed
├─ Run: npm test
│  └─ Result: ❌ 3 tests failing
│       - Test 1: UserAuth scenario broken
│       - Test 2: TokenRefresh scenario broken
│       - Test 3: PermissionCheck scenario broken
├─ Run: npm build → ✅ Build succeeds
├─ Generate verify-report.md
│  ├─ Status: FAIL
│  ├─ Compliance matrix: 3 scenarios ❌ FAILING
│  └─ CRITICAL issues:
│      - UserAuth scenario: test fails
│      - TokenRefresh scenario: test fails
└─ Return: verify-report to orchestrator

Phase 8: sdd archive (attempt)
├─ Input: verify-report with CRITICAL issues
├─ Decision: BLOCKED
├─ Output: "Cannot archive - fix CRITICAL issues first"

Orchestrator Decision:
├─ Option A: Rerun sdd-apply to fix failing tests
├─ Option B: Rerun sdd-verify after fixes applied
└─ User is informed of blocking issues

Expected Result: ✅ Archive correctly blocked by CRITICAL issues
```

---

## TEST EXECUTION PLAN

### Phase 1: Configuration & Structure Tests (Week 1)

```bash
# T1.1 - Read all SKILL.md frontmatter
for skill in skills/sdd-*/; do
  grep -A 5 "^---" "$skill/SKILL.md"
done

# T1.2 - Verify persistence contract references
grep -l "persistence-contract.md" skills/sdd-*/SKILL.md

# T1.3 - Check SKILL.md sections
for skill in skills/sdd-*/; do
  grep -c "## Purpose" "$skill/SKILL.md"
  grep -c "## What to Do" "$skill/SKILL.md"
  grep -c "## Rules" "$skill/SKILL.md"
done

# T1.4 - Verify shared infrastructure exists
ls -la skills/_shared/
```

### Phase 2: Dependency Graph Tests (Week 1)

```bash
# T2.1 - Trace dependency chain
# Manual: Review each skill's "dependencies" section
# Check: No circular references found

# T2.2 - Parallel execution validation
# Manual: Verify sdd-spec & sdd-design both depend on proposal only

# T2.3 - Blocking conditions verification
# Manual: Check sdd-tasks blocks until spec+design, etc
```

### Phase 3: Persistence Mode Tests (Week 2)

```
T3.1 (engram mode): Design review → Engram integration test (when available)
T3.2 (openspec mode): Design review → File system integration test
T3.3 (none mode): Design review → Inline return test
```

### Phase 4: E2E Tests (Weeks 3-4)

```
Scenario 1 (Go): Set up test Go project, run full SDD cycle
Scenario 2 (Python): Set up test Python project, run full SDD cycle
Scenario 3 (TypeScript): Set up test TypeScript project, run full SDD cycle

Verify each step:
├─ Artifacts created correctly
├─ Content format matches spec
├─ Dependencies met
├─ Blocking conditions work
└─ Final state correct
```

---

## TESTING TOOLS & INFRASTRUCTURE

### Needed
- ✅ **Bash scripts** - to validate directory structure, file format
- ✅ **JSON validator** - to validate skills-analysis.json
- ✅ **Markdown checker** - to validate SKILL.md format
- ⚠️ **Sample projects** - Go CLI, Python FastAPI, TypeScript React (for E2E)
- ⚠️ **Mock Engram** - for testing persistence mode (if needed)
- ⚠️ **Mock filesystem** - for testing openspec mode

### Available Now
- ✅ `skills-analysis.json` - comprehensive skill catalog
- ✅ `SKILLS_ANALYSIS.md` - detailed documentation
- ✅ `TEST_SUITE_PLAN.md` - this plan

---

## SUCCESS CRITERIA

| Criterion | Target | Status |
|-----------|--------|--------|
| All 12 skills have complete SKILL.md | 12/12 | ✅ |
| All dependencies documented | 100% | ✅ |
| DAG is acyclic (no circular deps) | Yes | ✅ |
| Persistence contract clearly defined | Yes | ✅ |
| E2E cycle runs end-to-end without errors | 1+ project types | ⏳ |
| Artifacts flow correctly between skills | All chains | ⏳ |
| Verify can block archive on CRITICAL issues | Works | ⏳ |
| Parallel execution (spec+design) works | No race | ⏳ |

---

## NEXT STEPS

1. **Run Configuration Tests** (T1.1 - T1.4) - verify all skills are well-formed
2. **Run Dependency Tests** (T2.1 - T2.4) - verify DAG correctness
3. **Design Persistence Tests** (T3.1 - T3.3) - outline test scenarios
4. **Create Test Projects** (Go, Python, TypeScript samples)
5. **Execute E2E Scenarios** - full SDD cycle on each project
6. **Document Results** - create test report

