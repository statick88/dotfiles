# Proposal: UCM Task MCP Server

**Change**: ucm-task-mcp  
**Author**: Diego Medardo Saavedra García  
**Date**: 2026-03-07  
**Status**: Proposed

---

## Intent

Create a Model Context Protocol (MCP) server that exposes the **tareas-ucm** framework as a standardized MCP resource, enabling Claude and other MCP clients to dynamically query, generate, and validate cybersecurity tasks for the Máster de Ciberseguridad (UCM).

The MCP abstracts task generation, evaluation, and anti-AI detection logic into reusable, discoverable tools—turning a static GitHub framework into a dynamic knowledge platform.

---

## Scope

### Phase 1 ✅ In Scope
- **MCP Protocol Layer**: Implement MCP server spec (stdio transport, JSON-RPC 2.0)
- **Task Query Tool**: `list_tasks` — discover available tasks by module, difficulty, type
- **Task Generation Tool**: `generate_task` — create new tasks using tareas-ucm templates
- **Anti-AI Detection**: `validate_task_complexity` — check task quality against anti-AI heuristics
- **Metadata Exposure**: Expose `config.yaml` (modules, rubrics, anti-patterns) as MCP resources
- **Integration**: Test with Claude Desktop and OpenCode via stdio
- **Documentation**: README, architecture diagram, tool schemas

### Phase 1 ❌ Out of Scope
- Web UI / Dashboard
- Database persistence (use filesystem + config.yaml for now)
- Authentication / RBAC (assume trusted MCP context)
- Task execution / auto-grading
- Langchain/LlamaIndex wrappers
- Multi-language task generation (Spanish only, Phase 1)

---

## Approach

1. **Wrap tareas-ucm Framework**  
   Analyze existing framework structure (config.yaml, task templates, anti-AI patterns).  
   Build a Node.js MCP server that reads this config and exposes task metadata + generation logic.

2. **Implement Core MCP Tools**  
   - `list_tasks(module, difficulty)` → discovers tasks from config.yaml
   - `generate_task(type, topic, anti_ai_level)` → calls tareas-ucm template engine
   - `validate_task_complexity(task)` → runs anti-AI heuristics from framework
   - Static resources: config schema, module definitions, rubrics

3. **Protocol Integration**  
   Use `@modelcontextprotocol/sdk` (Node.js). Expose stdio transport for Claude Desktop integration.  
   Test with OpenCode MCP runner.

4. **Academic Rigor**  
   Follow UCM standards: executive summary, learning objectives, technical foundations.  
   Document decision rationale (why MCP? why not gRPC? why stdio first?).

5. **Security Posture**  
   - No network I/O in Phase 1 (only filesystem reads)
   - Input validation on all tool parameters
   - Taint tracking for task content (prevent injection)

---

## Success Criteria

- ✅ MCP server starts without errors, accepts stdio connections
- ✅ All 4 core tools are discoverable and callable from Claude
- ✅ `list_tasks` returns ≥5 UCM modules with accurate metadata
- ✅ `generate_task` produces syntactically valid tasks matching templates
- ✅ `validate_task_complexity` flags low-effort / AI-solvable tasks with reason
- ✅ Integration test: Claude can discover tasks → generate one → validate it
- ✅ Documentation: architecture.md + tool schema + 2-page design rationale
- ✅ Zero security warnings from semgrep/codeql scan

---

## Key Assumptions

- **tareas-ucm is canonical** — Framework config.yaml is source of truth for task definitions
- **Filesystem I/O is acceptable** — No database needed for MVP (config lives in Git)
- **Stdio transport sufficient** — Phase 1 targets Claude Desktop + OpenCode (not web)
- **No auth required** — MCP runs in trusted context (user's machine / Vercel Edge)
- **Spanish-only content** — Task templates, rubrics, metadata all Spanish (UCM requirement)
- **UCM program structure stable** — 60 ECTS, 6 modules, ~3-4 tasks per module (verify with director)
- **Anti-AI patterns generalize** — Heuristics from crypto task apply to other modules

---

## Dependencies & Constraints

| Dependency | Constraint | Mitigation |
|------------|-----------|-----------|
| tareas-ucm repo | Must be cloned/vendored | Git submodule or copy config.yaml into MCP repo |
| Node.js 18+ | For @modelcontextprotocol/sdk | Use `package.json` engines field |
| Cristóbal Pareja Flores | Verify module structure + anti-AI requirements | Email/meeting before Phase 2 |
| TypeScript strict mode | Type safety for MCP tool contracts | tsconfig.json: strict=true |

---

## Decisions Made (Why?)

1. **MCP over gRPC**  
   - gRPC = fast, strong typing, but higher tooling overhead
   - MCP = JSON-RPC, immediate Claude integration, lower barrier for LLM clients ✅

2. **Stdio first (not HTTP)**  
   - HTTP = stateless, easier web integration, but requires auth/CORS
   - Stdio = direct process communication, perfect for Claude Desktop + local dev ✅

3. **Wrap tareas-ucm (not rebuild)**  
   - Reuse existing framework (34-page crypto report, validated templates)
   - Invest in protocol layer, not task generation logic ✅

4. **No database (filesystem)**  
   - Phase 1 = MVP, Git is version control
   - Database adds deployment complexity; defer to Phase 2 if needed

---

## Risks & Mitigation

| Risk | Impact | Mitigation |
|------|--------|-----------|
| tareas-ucm config drift | Tasks become stale | Automated weekly git pull; include version in MCP metadata |
| Anti-AI heuristics insufficient | Claude still "cracks" tasks | Iterative feedback from Cristóbal; refine after Phase 1 pilot |
| MCP SDK breaking changes | Code incompatibility | Pin `@modelcontextprotocol/sdk` to major version; monitor releases |
| Stdio reliability on Windows | Cannot run on Windows hosts | Test on WSL2; document Windows setup in Phase 2 |

---

## Next Steps (Dependency Chain)

1. **Kickoff** → This proposal approved ✅
2. **PRD** → Define user personas (Claude user, task author, director) + acceptance tests
3. **Design** → Architecture doc (MCP server structure, file layout, error handling)
4. **Tasks** → Break into implementable units (tools, integration, tests, docs)
5. **Apply** → Write MCP server code, integrate with tareas-ucm, test
6. **Verify** → Run integration tests, security scan, pilot with director
7. **Archive** → Tag release, add to MCP registry (if approved)

---

## Author Notes

This MCP fills a gap in the UCM program: currently, task generation is manual (email to director) and validation is subjective. By exposing tareas-ucm as a protocol, we enable:

- **Claude** to autonomously explore UCM tasks (useful for course prep)
- **Educators** to integrate task generation into CI/CD / grading pipelines
- **Students** to verify task authenticity (MCP signature + Cristóbal's approval)

The implementation leverages existing tareas-ucm work (no duplicate effort) and follows the academic rigor Diego has established (crypto report as baseline).
