# Análisis Completo: Estructura de Skills en Gentleman.Dots

**Generado**: 2026-03-07  
**Total Skills**: 12 (8 SDD workflow + 2 specialized + 1 infrastructure + 1 utilities)

---

## 1. ESTRUCTURA DE DIRECTORIOS

```
./skills/
├── _shared/                    # Shared infrastructure (NO skill, solo conventions)
│   ├── persistence-contract.md
│   ├── engram-convention.md
│   └── openspec-convention.md
│
├── sdd-init/                   # SDD Workflow Phase 1: Initialize
│   └── SKILL.md
│
├── sdd-explore/                # SDD Workflow Phase 2: Discovery
│   └── SKILL.md
│
├── sdd-propose/                # SDD Workflow Phase 3: Proposal
│   └── SKILL.md
│
├── sdd-spec/                   # SDD Workflow Phase 4A: Specification
│   └── SKILL.md
│
├── sdd-design/                 # SDD Workflow Phase 4B: Design
│   └── SKILL.md
│
├── sdd-tasks/                  # SDD Workflow Phase 5: Task Breakdown
│   └── SKILL.md
│
├── sdd-apply/                  # SDD Workflow Phase 6: Implementation
│   └── SKILL.md
│
├── sdd-verify/                 # SDD Workflow Phase 7: Verification
│   └── SKILL.md
│
├── sdd-archive/                # SDD Workflow Phase 8: Finalization
│   └── SKILL.md
│
├── go-testing/                 # Specialized: Go Testing Patterns
│   └── SKILL.md
│
└── skill-creator/              # Meta: Skill Creation Guidance
    └── SKILL.md
```

### Características de la Estructura:

- **Flat structure** - todos los skills en el mismo nivel
- **No código ejecutable** - cada skill contiene solo `SKILL.md` (documentación/guía)
- **_shared es meta** - no es un skill, contiene contratos compartidos
- **Convención de naming** - `sdd-*` para workflow phases, funcional names para especializados
- **Versionado** - cada skill tiene versión en el frontmatter de SKILL.md

---

## 2. CONFIGURACIÓN DE SKILLS

### Formato de SKILL.md (Frontmatter + Content)

```yaml
---
name: {skill-id}                    # Required: lowercase, hyphens
description: >                      # Required: What + Trigger
  {One-line description}.
  Trigger: {When AI should load this}.
license: MIT | Apache-2.0           # Required
metadata:
  author: gentleman-programming     # Required
  version: "2.0"                     # Required: semantic version
---
```

### Secciones Estándares en SKILL.md:

1. **Purpose** - Qué hace el skill
2. **When to Use / Trigger** - Cuándo activarlo
3. **Execution and Persistence Contract** - Referencias a persistence-contract.md
4. **What to Do** - Steps numerados (Step 1, Step 2, etc)
5. **Rules** - Restricciones y debe/no debe
6. **Code Examples** (si aplica) - Ejemplos mínimos
7. **Commands** (si aplica) - Comandos copy-paste
8. **Resources** (si aplica) - Referencias a docs locales

### Convenciones de Persistencia:

Cada skill referencia explícitamente **persistence-contract.md** que define 3 modos:

- **engram**: Guarda artifacts en Engram con naming determinístico
- **openspec**: Guarda artifacts como archivos en openspec/
- **none**: Retorna resultados inline, sin persistencia

---

## 3. PUNTOS DE INTEGRACIÓN

### Con el Orchestrator (Lead Agent):

El **Orchestrator** controla el flujo SDD invocando skills como sub-agents:

```
Comandos del usuario → Orchestrator → Sub-agent (skill)
                              ↑
                         State tracking
                         Dependency enforcement
                         User communication
```

### Comandos SDD Mapeados a Skills:

| Comando | Sub-agent Lanzado | Responsabilidad |
|---------|------------------|-----------------|
| `sdd init` | sdd-init | Detecta stack, crea config.yaml |
| `sdd explore <topic>` | sdd-explore | Investigación de codebase |
| `sdd new <change-name>` | sdd-propose | Crea proposal.md |
| `sdd ff <change-name>` | sdd-propose → sdd-spec → sdd-design → sdd-tasks | Fast-forward: todas las fases |
| `sdd apply <phase>` | sdd-apply | Implementa tasks en batch |
| `sdd verify` | sdd-verify | Valida implementation vs specs |
| `sdd archive` | sdd-archive | Archiva change, merge delta specs |

### Integración con Memoria (Engram):

Cuando mode = `engram`:
- Skills usan `mem_search()` + `mem_get_observation()` para leer artifacts
- Skills usan `mem_save()` para crear nuevos artifacts
- Skills usan `mem_update()` para actualizar existentes
- **Naming determinístico** → `sdd/{change-name}/{artifact-type}`

Cuando mode = `openspec`:
- Skills usan `Read()`, `Write()`, `Edit()` para filesystem
- **Estructura fija** → `openspec/changes/{change-name}/`, `openspec/specs/`

Cuando mode = `none`:
- Skills retornan resultados inline en markdown
- Sin persistencia entre sesiones

---

## 4. DEPENDENCIAS ENTRE SKILLS

### Grafo de Dependencias (DAG):

```
sdd-init (proyecto context)
    ↓
sdd-explore (opcional)
    ↓
sdd-propose (crea proposal.md)
    ├→ sdd-spec (crea spec.md)      ⟶┐
    │  (requires: proposal)            │
    │                                  ├→ sdd-tasks (crea tasks.md)
    ├→ sdd-design (crea design.md)   ⟶┤  (requires: proposal + spec + design)
    │  (requires: proposal)            │
    └                                  ↓
                                   sdd-apply (escribe código)
                                        ↓
                                   sdd-verify (test + build)
                                        ↓
                                   sdd-archive (merge specs + move to archive)
```

### Parallelization:

- **sdd-spec y sdd-design PUEDEN correr en paralelo** (ambos solo requieren proposal)
- **sdd-tasks DEBE esperar** a que ambos terminen (requiere spec + design + proposal)
- **sdd-apply DEBE esperar** a sdd-tasks (requiere tasks.md)

### Blocking Conditions:

| Skill | Bloqueado por | Razón |
|-------|--------------|-------|
| sdd-tasks | (sdd-spec AND sdd-design) | Necesita TODOS los inputs |
| sdd-apply | sdd-tasks | Las tasks definen qué implementar |
| sdd-verify | sdd-apply | Necesita código implementado |
| sdd-archive | sdd-verify CRITICAL issues | No archiva si hay issues críticos |

---

## 5. ARTIFACTS Y SU CICLO DE VIDA

### Tipos de Artifacts (del persistence-contract.md):

| Artifact | Skill Producer | Consumidores | Storage Mode |
|----------|---|---|---|
| `explore` | sdd-explore | sdd-propose (optional) | engram topic_key: `sdd/explore/{topic}` |
| `proposal` | sdd-propose | sdd-spec, sdd-design, sdd-tasks | engram: `sdd/{change}/proposal` |
| `spec` | sdd-spec | sdd-design, sdd-tasks, sdd-verify | engram: `sdd/{change}/spec` |
| `design` | sdd-design | sdd-tasks, sdd-apply | engram: `sdd/{change}/design` |
| `tasks` | sdd-tasks | sdd-apply (reads), sdd-verify (reads) | openspec: `changes/{change}/tasks.md` |
| `apply-progress` | sdd-apply | sdd-verify | engram: `sdd/{change}/apply-progress` |
| `verify-report` | sdd-verify | sdd-archive | engram: `sdd/{change}/verify-report` |
| `archive-report` | sdd-archive | (audit trail) | engram: `sdd/{change}/archive-report` |

### OpenSpec File Structure (modo openspec):

```
openspec/
├── config.yaml                          # Proyecto config (creado por sdd-init)
├── specs/                               # Main specs (source of truth)
│   └── {domain}/
│       └── spec.md
└── changes/
    ├── {change-name}/                   # Change en progreso
    │   ├── exploration.md (opcional)
    │   ├── proposal.md
    │   ├── specs/
    │   │   └── {domain}/
    │   │       └── spec.md              # Delta spec
    │   ├── design.md
    │   ├── tasks.md                     # Updated by sdd-apply with [x]
    │   └── verify-report.md
    └── archive/                         # Completed changes
        └── 2026-03-07-{change-name}/    # ISO date prefix
            ├── proposal.md
            ├── specs/
            ├── design.md
            ├── tasks.md
            └── verify-report.md
```

---

## 6. CONTRATOS Y CONVENCIONES COMPARTIDAS

### persistence-contract.md

Define **cómo se resuelve el modo de persistencia**:

```
Resolución de Modo (default):
1. Si Engram está disponible → usar `engram`
2. Sino → usar `none`

openspec NUNCA es default → solo si orchestrator lo pasa explícitamente
```

Comportamiento per-mode:

| Aspecto | engram | openspec | none |
|--------|--------|----------|------|
| Read from | Engram artifacts | Filesystem | Orchestrator context |
| Write to | Engram | Filesystem | Nowhere |
| Project files | Never | Yes | Never |
| Fallback | Degrada a `none` | Fallback a `none` | N/A |

### engram-convention.md

Define **naming determinístico para Engram**:

```
Artifact:
  title:     sdd/{change-name}/{artifact-type}
  topic_key: sdd/{change-name}/{artifact-type}
  type:      architecture
  project:   {detected project}
  scope:     project

Recovery Protocol (2-step, OBLIGATORIO):
  Step 1: mem_search(query: "sdd/{change}/{type}", project: "{proj}")
          → Returns truncated preview + observation_id
  
  Step 2: mem_get_observation(id: observation_id)
          → Returns FULL untruncated content
```

**Crítico**: Nunca usar `mem_search` results directamente - siempre hacer `mem_get_observation` para contenido completo.

### openspec-convention.md

Define **estructura de archivos para modo openspec**:

```yaml
openspec/config.yaml:
  schema: spec-driven
  context: |
    Tech stack: {detected}
    Architecture: {detected}
    Testing: {detected}
    Style: {detected}
  rules:
    proposal: [list of rules]
    specs: [list of rules]
    design: [list of rules]
    tasks: [list of rules]
    apply:
      tdd: false              # Enable RED-GREEN-REFACTOR
      test_command: ""        # e.g., "npm test"
    verify:
      test_command: ""        # Override for verify
      build_command: ""       # Override for build
      coverage_threshold: 0   # 0 = disabled
    archive: [list of rules]
```

---

## 7. 10 SKILLS MÁS IMPORTANTES

### 1️⃣ **sdd-init** (Initialization)

- **Qué hace**: Detecta tech stack del proyecto, crea `openspec/config.yaml`
- **Inputs**: project_root
- **Outputs**: Project context (Engram) o estructura openspec/
- **Responsabilidades clave**:
  - Detectar package.json, go.mod, pyproject.toml
  - Detectar test framework (jest, pytest, go test)
  - Detectar CI/linters (eslint, pylint, golangci-lint)
  - Generar config.yaml con detected rules
- **Punto de integración**: Entry point - todos los otros skills dependen del contexto

### 2️⃣ **sdd-propose** (Proposal)

- **Qué hace**: Crea `proposal.md` con Intent, Scope, Approach, Risks, Rollback Plan
- **Inputs**: change_name, proyecto context (opcional)
- **Outputs**: proposal artifact
- **Regla crítica**: TODA proposal DEBE tener rollback plan + success criteria
- **Dependencias**: Opcional sdd-explore, required sdd-init context

### 3️⃣ **sdd-spec** (Specification)

- **Qué hace**: Crea delta specs (ADDED/MODIFIED/REMOVED requirements) con Given/When/Then scenarios
- **Inputs**: change_name, proposal
- **Outputs**: spec.md (delta si existe main spec, FULL si es nuevo dominio)
- **RFC 2119 keywords**: MUST, SHALL, SHOULD, MAY (requirement strength)
- **Regla crítica**: Nunca include implementation details - specs describe WHAT, not HOW

### 4️⃣ **sdd-design** (Design)

- **Qué hace**: Crea `design.md` con Architecture Decisions, Data Flow, File Changes, Testing Strategy
- **Inputs**: change_name, proposal (required), spec (optional)
- **Outputs**: design artifact
- **Regla crítica**: MUST read actual codebase before designing - nunca guess
- **Can run in parallel with sdd-spec** (ambos requieren solo proposal)

### 5️⃣ **sdd-tasks** (Task Breakdown)

- **Qué hace**: Crea `tasks.md` con hierarchical task list (1.1, 1.2, 2.1, etc) organized by phase
- **Inputs**: change_name, proposal, spec, design (TODOS required)
- **Outputs**: tasks artifact
- **Task format**: `- [ ] {phase}.{number} {Concrete action - what file, what change}`
- **TDD integration**: Si TDD mode detectado, integra RED → GREEN → REFACTOR tasks

### 6️⃣ **sdd-apply** (Implementation)

- **Qué hace**: Lee tasks.md, escribe código REAL siguiendo specs como acceptance criteria
- **Inputs**: change_name, task_range, artifact_store_mode
- **Dependencies**: proposal, spec, design, tasks (TODOS required)
- **Outputs**: Código actual + updated tasks.md con [x] marks
- **Workflow modes**:
  - **TDD**: RED (failing test) → GREEN (minimal code) → REFACTOR (clean up)
  - **Standard**: Write code directly matching specs
- **Skill loading**: Lee installed skills (react-19, typescript, pytest, vitest, etc) para follow coding patterns

### 7️⃣ **sdd-verify** (Verification)

- **Qué hace**: Valida que implementation coincida con specs, design, tasks
- **Inputs**: change_name, artifact_store_mode
- **Dependencies**: proposal, spec, design, tasks, implementation (TODOS)
- **Outputs**: verify-report.md con Spec Compliance Matrix
- **Verification gates**:
  - Completeness: ¿Tasks completos?
  - Correctness: ¿Code implements ALL specs?
  - Coherence: ¿Design decisions followed?
  - Testing: ¿Tests pass? (CRITICAL if failed)
  - Build: ¿Build succeeds? (CRITICAL if failed)
  - Coverage: ¿Above threshold? (WARNING if below)
- **Real execution**: NO solo static analysis - MUST run tests + build

### 8️⃣ **sdd-archive** (Finalization)

- **Qué hace**: Merge delta specs into main specs, mueve change folder a archive/
- **Inputs**: change_name, artifact_store_mode
- **Dependencies**: verify-report (para check CRITICAL issues)
- **Outputs**: Archived change folder con date prefix (YYYY-MM-DD-{change})
- **Merge rules**:
  - Match requirements by name
  - Preserve requirements NOT in delta
  - Apply ADDED → append, MODIFIED → replace, REMOVED → delete
- **Blocking**: BLOCKED si verify-report tiene CRITICAL issues

### 9️⃣ **sdd-explore** (Discovery)

- **Qué hace**: Investiga codebase, compara approaches, NO modifica código
- **Inputs**: topic, change_name (opcional)
- **Outputs**: Analysis markdown con Current State, Approaches, Pros/Cons, Recommendation
- **Standalone o tied to change**: Puede ser `/sdd-explore <topic>` o parte de `/sdd-new`
- **Does NOT modify code** - solo analiza

### 🔟 **go-testing** (Specialized)

- **Qué hace**: Guía patterns para testing en Go (teatest TUI, table-driven tests, golden files)
- **No invoked by orchestrator** - es una reference skill
- **Key patterns**:
  - Table-driven tests
  - Bubbletea Model testing
  - Teatest integration tests
  - Golden file testing
- **File organization**: `*_test.go` alongside source, `testdata/` for golden files

---

## 8. ESTADO ACTUAL: ¿BROKEN O ISSUES?

### ✅ Estado General: TODO OK

- **No skills roto** - todos están bien documentados
- **Cada SKILL.md es completo**: Purpose + Execution Contract + Steps + Rules
- **Conventions compartidas funcionan**: persistence-contract.md + engram + openspec defined

### ⚠️ Potential Issues (no son bloqueadores):

| Issue | Categoría | Riesgo | Mitigación |
|-------|-----------|--------|-----------|
| Race condition en spec + design paralelos | Integration | Medium | Orchestrator serializa o espera ambos |
| Si config.yaml no existe | Configuration | Low | sdd-init la crea; fallback detection en skills |
| Mode resolution falla (no Engram, no openspec) | Persistence | Low | Fallback a `none`; skills recommendan enable persistence |
| Tests lentos en sdd-verify | Testing | Low | Usar `-short` flag o test sharding |
| Tasks.md update conflicts (sdd-apply writes) | Persistence (openspec) | Low | Leer primero, update, write después |

---

## 9. TEST SUITE PLAN

### Unit Testing (N/A)

Estos son documentation skills, no hay código ejecutable.

### Integration Testing

```
Test Scenarios:
├── Full SDD Cycle
│   └── Init → Explore → Propose → Spec/Design → Tasks → Apply → Verify → Archive
│
├── Persistence Modes
│   ├── engram-only mode
│   ├── openspec-only mode
│   ├── none-only mode
│   └── engram → openspec transition
│
├── Dependency Chain
│   ├── proposal feeds correctly to spec, design, tasks
│   ├── spec + design feed to tasks
│   ├── tasks feed to apply
│   └── apply output feeds to verify
│
└── Incomplete Flows
    ├── What if sdd-apply interrupted? (orchestrator resumes)
    ├── What if verify finds CRITICAL? (archive blocked)
    └── What if parallel spec+design race? (serialized correctly)
```

### E2E Testing

```
Test on Real Projects:
├── Python project (FastAPI, pytest)
│   └── Init → ... → Apply → Verify → Archive
│
├── Go project (CLI, go test)
│   └── Init → ... → Apply → Verify → Archive
│
└── TypeScript project (React, vitest)
    └── Init → ... → Apply → Verify → Archive

Verify:
├── Artifacts have correct format
├── Task checklist accurate
├── Implementation complete
├── Tests pass
├── Specs synced correctly
```

---

## 10. MATRIZ DE INTEGRACIÓN: CÓMO SE CONECTAN

```
┌─────────────────────────────────────────────────────────────┐
│                    ORCHESTRATOR (Lead)                       │
│  - Controla flujo                                            │
│  - Tracks state (qué artifacts existen)                     │
│  - Enforce dependencies                                     │
│  - Communicate con usuario                                  │
└─────────────────────────────────────────────────────────────┘
         ↑                           ↑
         │ Invoca sub-agents        │ Recibe reports
         │ (with mode + context)    │
         ↓                           ↓
    [Sub-Agents - Skills]
    ├── sdd-init
    ├── sdd-explore
    ├── sdd-propose
    ├── sdd-spec
    ├── sdd-design
    ├── sdd-tasks
    ├── sdd-apply
    ├── sdd-verify
    └── sdd-archive
         ↓
    Memory Layer (si aplica)
    ├── Engram (mem_save, mem_search, mem_get_observation)
    └── Filesystem (Read, Write, Edit)
         ↓
    Project Files (si openspec mode)
    ├── openspec/config.yaml
    ├── openspec/specs/
    └── openspec/changes/
```

---

## CONCLUSIÓN

Los 12 skills forman un **sistema cohesivo y bien documentado** para Spec-Driven Development:

1. **8 SDD workflow phases** - Cover complete lifecycle (init → archive)
2. **2 specialized skills** - Go testing, skill creation meta-skill
3. **1 infrastructure** - Shared conventions for persistence
4. **1 utilities** - Configuration management

**Cada skill:**
- Tiene clara responsabilidad
- Define inputs/outputs
- Specifica dependencias
- Sigue contratos de persistencia
- Integra con orchestrator

**Sistema está listo para testing y deployment.**

