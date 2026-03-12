# AGENTS.md

This file contains guidelines and commands for agentic coding agents working in this dotfiles repository.

## Project Overview

This is a personal dotfiles repository containing:
- **Neovim Configuration** (primary) - LazyVim-based setup with OpenCode.nvim integration
- **OpenCode AI Assistant** - Node.js project using Bun package manager
- **Supporting tool configs** - Kitty terminal, htop, Tmux, etc.

## Build/Lint/Test Commands

### Neovim Configuration (Lua)
```bash
# Code Formatting
stylua .                    # Format all Lua files
stylua --check .           # Check formatting without changes
stylua lua/config/lazy.lua # Format specific file

# Plugin Management (run within Neovim)
:Lazy                      # Open Lazy.nvim interface
:Lazy update              # Update all plugins
:Lazy install             # Install missing plugins
:Lazy clean               # Clean unused plugins

# Health Checks
:checkhealth              # Overall Neovim health
:checkhealth lazyvim      # LazyVim specific health

# Configuration Validation
nvim --headless -c "lua print('Config loaded successfully')" -c "q"
nvim --headless -c "lua require('config.lazy')" -c "q"
```

### OpenCode Project (Node.js/Bun)
```bash
bun install               # Install dependencies
# No build/test scripts currently defined
```

## Code Style Guidelines

### Lua Formatting (stylua.toml)
- **Indentation**: 2 spaces
- **Line width**: 120 characters
- **Quote style**: Auto-detected (prefer double quotes for consistency)

### File Structure Conventions
```
lua/
├── config/          # Core configuration files
│   ├── lazy.lua     # Lazy.nvim bootstrap and setup
│   ├── options.lua  # Neovim options
│   ├── keymaps.lua  # Key mappings
│   └── autocmds.lua # Auto commands
└── plugins/         # Plugin configurations
    ├── *.lua        # Individual plugin specs
```

### Plugin Configuration Patterns
- Each plugin file returns a Lazy.nvim spec table: `return { "plugin/name", ... }`
- Plugin config in `config = function()` block
- Dependencies in `dependencies = { ... }` table
- Import system: `{ import = "plugins" }` for custom plugins

### Naming Conventions
- **Files**: lowercase with underscores (snake_case)
- **Variables**: snake_case for local variables
- **Functions**: snake_case for local functions
- **Global variables**: `vim.g.variable_name` for configuration
- **Keymaps**: Descriptive names in `desc` field

### Import/Require Patterns
```lua
-- Require Lua modules
require("module.path")

-- LazyVim plugins
{ import = "lazyvim.plugins" }

-- Custom plugins  
{ import = "plugins" }
```

### Error Handling
- Use `pcall()` for safe plugin loading where needed
- Check `vim.v.shell_error` after system commands
- Use `vim.api.nvim_echo()` for user-facing error messages
- Graceful fallbacks for optional features

### Key Mapping Patterns
- Use `vim.keymap.set()` for all key mappings
- Include descriptive `desc` for all mappings
- Use mode table: `{ "n", "x", "v" }` for multiple modes
- Buffer-local mappings should include `buffer = bufnr`
- Silent mappings for non-interactive commands: `silent = true`

### Configuration Variables
- Global config: `vim.g.config_name = value`
- Buffer-local: `vim.bo[bufnr].option = value`
- Window-local: `vim.wo[winid].option = value`
- Use `vim.opt` for options that support it

## Development Principles (from model.md)

### Clean Architecture
- Separate layers clearly: domain, application, infrastructure
- Dependencies point inward (core doesn't depend on details)
- Keep framework-independent code in the center

### Clean Code
- Use meaningful names that reveal intent
- Write small functions that do one thing
- Avoid flag arguments
- Follow DRY principle (no duplication)
- Add comments only when necessary
- Handle errors explicitly and appropriately

### SOLID Principles
- **S** - Single Responsibility: Each component has one reason to change
- **O** - Open/Closed: Open for extension, closed for modification
- **L** - Liskov Substitution: Subtypes must be substitutable for base types
- **I** - Interface Segregation: Specific interfaces over general ones
- **D** - Dependency Inversion: Depend on abstractions, not concretions

### TDD (Test Driven Development)
- Red: Write failing test
- Green: Write minimal code to pass
- Refactor: Improve code while keeping tests green
- Focus on unit, integration, and e2e tests

## Performance Guidelines

### Plugin Loading
- Use lazy loading for non-essential plugins
- Disable unused runtime plugins in lazy config
- Configure required dependencies in `opts` parameter
- Prefer `vim.fn.stdpath()` for cross-platform paths

### Code Organization
- Separate concerns: options, keymaps, autocmds in different files
- Group related functionality in the same file
- Use local variables for frequently accessed APIs
- Keep plugin configurations focused and minimal

### Async Operations
- Use `vim.uv` (or `vim.loop`) for async operations
- Avoid blocking operations in startup code
- Use `vim.defer_fn()` for non-critical startup tasks

## Testing Strategy

This configuration uses validation through:
1. **Configuration Loading**: Ensure Neovim starts without errors
2. **Health Checks**: Use `:checkhealth` for plugin validation
3. **Manual Testing**: Verify key mappings and functionality
4. **Plugin Loading**: Check Lazy.nvim status with `:Lazy`

## Common Tasks

### Adding a New Plugin
1. Create `lua/plugins/plugin-name.lua`
2. Return Lazy.nvim spec with plugin configuration
3. Add dependencies if needed
4. Configure with `opts` or `config` function
5. Run `stylua .` to format

### Modifying Core Configuration
1. Edit files in `lua/config/`
2. Follow existing patterns for options, keymaps, autocmds
3. Use LazyVim's VeryLazy event for startup-heavy operations
4. Restart Neovim to test changes

### Debugging Configuration Issues
1. Check `:messages` for error messages
2. Run `:checkhealth` for plugin health status
3. Use `:Lazy log` for plugin-related errors
4. Test individual files with `nvim --headless` commands

## Integration Notes

### OpenCode.nvim Integration
- Uses Kitty provider for better terminal integration
- Key mappings: `<C-a>` (ask), `<C-x>` (select), `<C-.>` (toggle)
- Auto-reload enabled for edited buffers
- Statusline integration available with lualine

### LazyVim Base
- Extends LazyVim's default plugin set
- Follows LazyVim's loading conventions
- Compatible with LazyVim's color schemes and themes
- Maintains LazyVim's performance optimizations

## Security Best Practices

### General Security
- Never commit secrets or API keys
- Use environment variables for sensitive configuration
- Regularly update dependencies for security patches
- Follow principle of least privilege

### DevSecOps Integration
- Integrate security scanning in development workflow
- Use static analysis tools for vulnerability detection
- Implement proper secret management
- Follow secure coding practices

## Workflow Commands

### Before Making Changes
```bash
# Ensure clean state
git status
nvim --headless -c "lua print('Config OK')" -c "q"
```

### After Making Changes
```bash
# Format code
stylua .

# Test configuration
nvim --headless -c "lua print('Config loaded')" -c "q"

# Check plugin health
nvim --headless -c "checkhealth lazyvim" -c "q"
```

### When Adding Plugins
```bash
# Install new plugin
nvim --headless -c "Lazy install" -c "q"

# Check health
nvim --headless -c "checkhealth" -c "q"

# Format new configuration
stylua lua/plugins/new-plugin.lua
```

Remember to run `stylua .` after making changes to maintain consistent code formatting.

## Document Processing Skills

### Installed Skills from skills.sh

The following skills from skills.sh are installed and available for document processing:

#### Core Document Skills (from anthropics/skills)
- **pdf**: PDF processing - text extraction, merging, splitting, forms, OCR
- **docx**: Word document handling - reading, editing, creating .docx files
- **xlsx**: Excel/spreadsheet operations - data extraction, manipulation, CSV/TSV
- **pptx**: PowerPoint handling - slide extraction, presentation parsing

#### Custom Skills
- **drive-documents**: Process Google Drive directories or local folders containing mixed office documents. Extract context, metadata, and content to feed project context.

### Skill Locations
```
~/.opencode/skills/.agents/skills/
├── pdf/           # PDF processing skill
├── docx/          # Word document skill
├── xlsx/          # Spreadsheet skill
├── pptx/          # PowerPoint skill
└── drive-documents/ # Multi-document directory processor
```

### Usage Examples

#### Process Drive Directory
```bash
# Use drive-documents skill when user provides:
# - Google Drive directory path
# - Local folder with mixed documents
# - Request to analyze documents for project context
```

#### Individual Document Processing
- Use **pdf** skill for PDF operations
- Use **docx** skill for Word documents
- Use **xlsx** skill for spreadsheets
- Use **pptx** skill for presentations

### Installing Additional Skills
```bash
# Install from skills.sh
npx skills add https://github.com/anthropics/skills --skill <skill-name> --yes

# Example: Install image skill if available
npx skills add https://github.com/anthropics/skills --skill image --yes
```

### Supported Document Formats
- **PDF**: .pdf
- **Word**: .docx, .doc
- **Excel**: .xlsx, .xls, .csv, .tsv
- **PowerPoint**: .pptx, .ppt
- **Text**: .txt, .md, .json, .xml, .yaml, .yml
- **Images**: .png, .jpg, .jpeg, .gif, .bmp, .svg, .tiff

## Security & DevSecOps Skills

### Perfil Profesional del Usuario (statick88.github.io)

**Diego Medardo Saavedra García** - Desarrollador Full Stack con 10+ años de experiencia:
- **Especialidades principales**: Clean Architecture, DevOps, Docker, Kubernetes, Linux Server
- **Stack tecnológico**: Python, Django, FastAPI, React, Next.js, Node.js, Angular, Vue, Flutter
- **Cloud**: AWS, Azure, Vercel, Railway
- **Actividades académicas**: Bootcamps de Desarrollo Web, Data Science, Desarrollo Móvil

### Skills de Seguridad Instalados

#### De trailofbits/skills (líder en seguridad blockchain/web)
| Skill | Descripción | Uso |
|-------|-------------|-----|
| **semgrep** | Análisis estático de seguridad, escaneo de vulnerabilidades | SAST, detección de patrones de bugs |
| **codeql** | Análisis estático avanzado con tracking de data flow | Auditorías de seguridad profundas |
| **differential-review** | Revisión de seguridad de cambios en PRs | Prevenir regresiones de seguridad |
| **sharp-edges** | Detecta APIs propensas a errores y configuraciones peligrosas | Revisión de código seguro |
| **insecure-defaults** | Detecta configuraciones inseguras por defecto | Hardening de aplicaciones |
| **modern-python** | Configuración moderna de Python (uv, ruff, ty) | Mejores prácticas de desarrollo |

#### De sickn33/antigravity-awesome-skills
| Skill | Descripción | Uso |
|-------|-------------|-----|
| **docker-expert** | Contenedores Docker, multi-stage builds, seguridad | DevOps, container hardening |
| **api-security-best-practices** | Mejores prácticas de seguridad APIs | OWASP, autenticación, autorización |
| **clean-code** | Estándares de código limpio | Mantenibilidad del código |
| **security-review** | Guías para revisiones de seguridad | Auditorías de código |
| **nextjs-best-practices** | Mejores prácticas Next.js App Router | Desarrollo web seguro |

### Instalación de Skills Adicionales de Seguridad
```bash
# De trailofbits (recomendado para seguridad)
npx skills add https://github.com/trailofbits/skills --skill <skill-name> --yes

# De sickn33 (awesome collection)
npx skills add https://github.com/sickn33/antigravity-awesome-skills --skill <skill-name> --yes
```

### Skills de Seguridad Recomendados (no instalados aún)
| Skill | Repo | Descripción |
|-------|------|-------------|
| **variant-analysis** | trailofbits | Encontrar variantes de vulnerabilidades |
| **property-based-testing** | trailofbits | Testing basado en propiedades |
| **yara-rule-authoring** | trailofbits | Detección de malware |
| **audit-prep-assistant** | trailofbits | Preparación para auditorías |
| **security-auditor** | erichowens | Escaneo comprehensivo de seguridad |

### Casos de Uso según Perfil

#### 1. Desarrollo Seguro (Tu stack: Django, FastAPI, React)
```
- Usar semgrep para escaneo rápido de código
- Aplicar api-security-best-practices en endpoints
- Usar insecure-defaults para verificar configuraciones
```

#### 2. DevOps & Containers (Docker, Kubernetes)
```
- docker-expert para Dockerfile optimization
- sharp-edges para revisar configs de seguridad
- differential-review en PRs de infraestructura
```

#### 3. Clean Architecture (Tu proyecto Saavedra Construction)
```
- clean-code para código mantenible
- codeql para análisis profundo
- security-review antes de deployments
```

#### 4. Docencia & Bootcamps
```
- Usar skills como guías de enseñanza
- Demonstrar vulnerabilidades con semgrep
- Enseñar mejores prácticas con modern-python
```

### Recursos Relacionados YA Instalados
- **solid-principles**: Principios SOLID para arquitectura limpia
- **clean-architecture-python**: Clean Architecture en Python
- **fastapi-advanced**: FastAPI avanzado (tu stack incluye FastAPI)
- **docker-compose**: Orquestación de contenedores
- **testing-strategies**: Estrategias de testing

### Pipeline de Seguridad Recomendado
```bash
# 1. Pre-commit hook
semgrep --config=auto

# 2. Code Review
differential-review --security-only

# 3. Pre-deployment
codeql database create --language=python
codeql database analyze

# 4. Producción
insecure-defaults check --strict
sharp-edges --report=all
```

## Ciberseguridad: Master en Ciberseguridad Defensiva y Ofensiva

### Análisis de Skills para el Master

Basado en que estás cursando un **Master en Ciberseguridad Defensiva y Ofensiva**, he instalado skills especializados para ambas áreas:

---

### 🛡️ CIBERSEGURIDAD DEFENSIVA (Blue Team)

| Skill | Fuente | Descripción | Aplicación en el Master |
|-------|--------|-------------|------------------------|
| **cybersecurity-analyst** | amplihack | Marcos de trabajo CIA Triad, Zero Trust, NIST, ISO 27001 | Fundamentos de análisis defensivo |
| **security-compliance** | davila7 | Defense in Depth, Zero Trust Architecture | Cumplimiento y marcos normativos |
| **security-auditor** | erichowens | Auditorías comprehensivas, escaneo de vulnerabilidades | Evaluaciones de seguridad |
| **vulnerability-scanning** | aj-geddes | Escaneo sistemático de vulnerabilidades | Detección de weaknesses |
| **security-scanning** | orchestkit | Detección automatizada, dependency scanning | Scanning continuo |
| **security-review** | sickn33 | Guías para revisiones de seguridad | Auditorías de código |
| **insecure-defaults** | trailofbits | Detecta configuraciones inseguras | Hardening de sistemas |
| **sharp-edges** | trailofbits | APIs peligrosas y footguns | Revisión de código seguro |
| **semgrep** | trailofbytes | SAST rápido y efectivo | Análisis estático |
| **codeql** | trailofbits | Análisis profundo con data flow | Auditorías avanzadas |
| **differential-review** | trailofbits | Revisión de cambios en PRs | Seguridad en CI/CD |
| **bash-pro** | sickn33 | Scripts Bash seguros y profesionales | Automatización defensiva |

---

### ⚔️ CIBERSEGURIDAD OFENSIVA (Red Team)

| Skill | Fuente | Descripción | Aplicación en el Master |
|-------|--------|-------------|------------------------|
| **semgrep** | trailofbits | Detección de patrones vulnerables | Identificación de bugs explotables |
| **variant-analysis** | trailofbits | Encontrar variantes de vulns | Hunting de vulnerabilidades |
| **codeql** | trailofbits | Taint tracking para análisis profundo | Exploit development |
| **docker-expert** | sickn33 | Container security, multi-stage builds | Entornos de pentesting |
| **api-security-best-practices** | sickn33 | OWASP Top 10, vulnerabilidades API | Testing de APIs |

---

### 🐧 LINUX & SHELL (Esencial para Ciberseguridad)

| Skill | Descripción |
|-------|-------------|
| **bash-pro** | Scripts Bash seguros, defensive patterns, dry-run modes |
| **linux-production-shell-scripts** | Backups, monitoring, log analysis, automation |

---

### 📚 Skills Adicionales Recomendados para el Master

```bash
# Auditorías y Preparación
npx skills add https://github.com/trailofbits/skills --skill audit-prep-assistant --yes
npx skills add https://github.com/trailofbits/skills --skill testing-handbook-generator --yes

# Análisis Forense y Malware
npx skills add https://github.com/trailofbits/skills --skill yara-rule-authoring --yes

# Web Security
npx skills add https://github.com/anthropics/skills --skill webapp-testing --yes
npx skills add https://github.com/trailofbits/skills --skill secure-workflow-guide --yes
```

---

### 🎯 Plan de Estudio Según el Master

#### Semestre 1: Fundamentos Defensivos
- Usar **cybersecurity-analyst** para marcos teóricos
- Aplicar **security-compliance** para frameworks
- Practicar **vulnerability-scanning** en laboratorios

#### Semestre 2: Análisis y Auditoría
- Implementar **security-auditor** en proyectos
- Usar **codeql** para auditorías de código
- Aplicar **semgrep** en CI/CD pipelines

#### Semestre 3: Hacking Ético (Ofensivo)
- Utilizar **semgrep/codeql** para encontrar vulnerabilidades
- Aplicar **variant-analysis** para hunting
- Documentar findings con guías de **security-review**

#### Semestre 4: Proyecto Final
- Combinar skills defensivos y ofensivos
- Usar **differential-review** para evaluar cambios
- Aplicar **insecure-defaults** para hardening

---

### 📂 Ubicación de Skills de Ciberseguridad
```
~/.opencode/skills/.agents/skills/
├── # Defensivos
│   ├── cybersecurity-analyst/
│   ├── security-compliance/
│   ├── security-auditor/
│   ├── vulnerability-scanning/
│   ├── security-scanning/
│   └── security-review/
│
├── # Análisis de Código
│   ├── semgrep/
│   ├── codeql/
│   ├── differential-review/
│   ├── sharp-edges/
│   └── insecure-defaults/
│
├── # Ofensivos
│   ├── docker-expert/
│   └── api-security-best-practices/
│
└── # Utilitarios
    ├── bash-pro/
    └── clean-code/
```

---

### 🔬 Casos de Uso para el Master

#### Laboratorio de Análisis Defensivo
```
1. Escanear sistema: vulnerability-scanning
2. Revisar configuraciones: security-compliance  
3. Auditoría de código: security-auditor
4. Verificar hardenning: insecure-defaults
5. Documentar findings: cybersecurity-analyst
```

#### Ejercicio de Pentesting
```
1. Reconocimiento: semgrep para código vulnerable
2. Identificación: codeql para data flow analysis
3. Explotación: variant-analysis para finding variants
4. Reporte: security-review para documentación
5. Remediación: sharp-edges para mejoras
```

#### Auditoría de Cumplimiento
```
1. Framework: cybersecurity-analyst (NIST, ISO 27001)
2. Controles: security-compliance (Defense in Depth)
3. Evidence: vulnerability-scanning
4. Reporte: security-auditor
```

## Análisis Profundo de Skills Adicionales para Ciberseguridad

### 📋 SKILLS INSTALADOS ACTUALMENTE: 32 skills

---

### 🔐 ANÁLISIS POR CATEGORÍA DE CIBERSEGURIDAD

---

#### 1. **CRIPTOGRAFÍA Y SEGURIDAD CRÍTICA**

| Skill | Descripción | Casos de Uso |
|-------|-------------|--------------|
| **constant-time-analysis** | Detecta fugas de timing en código crypto | Verificar implementaciones crypto contra timing attacks |
| **wycheproof** | Test vectors para crypto (Google) | Validar implementaciones crypto contra ataques conocidos |
| **constant-time-testing** | Testing de side-channels en crypto | Testing de operaciones cryptográficas |

**Aplicación en el Master:**
- **Defensivo**: Validar que implementaciones crypto no filtran información
- **Ofensivo**: Identificar vulnerabilidades de timing en crypto

**Comandos de uso:**
```bash
# Análisis de constant-time
constant-time-analysis --code crypto_impl.py

# Validación con Wycheproof
wycheproof --test AES --format json
```

---

#### 2. **FUZZING Y TESTING DE VULNERABILIDADES**

| Skill | Descripción | Casos de Uso |
|-------|-------------|--------------|
| **fuzzing-dictionary** | Diccionarios para fuzzing | Parser fuzzing, protocol fuzzing |
| **harness-writing** | Crear harnesses de fuzzing | Custom fuzz targets |
| **libafl** | Fuzzer modular en Rust | Fuzzing avanzado |

**Aplicación en el Master:**
- Encontrar vulnerabilidades de memoria
- Testing de parsers y protocolos
- Desarrollo de exploits

**Pipeline de fuzzing:**
```bash
# 1. Crear harness
harness-writing --input parser.c --output harness.c

# 2. Ejecutar fuzzing
libafl --input fuzzing-dictionary --corpus ./corpus --out ./results

# 3. Analizar crashes
semgrep --config=pwn ./results/crashes/
```

---

#### 3. **MALWARE Y ANÁLISIS FORENSE**

| Skill | Descripción | Casos de Uso |
|-------|-------------|--------------|
| **yara-rule-authoring** | Crear reglas YARA | Detección de malware, IOC matching |
| **frontend-security** | Auditorías de seguridad frontend | XSS, CSRF, inyectables en JS |
| **backend-security-coder** | Desarrollo seguro backend | SQLi, RCE, auth bypass |

**Aplicación en el Master:**
- **Forense**: Crear reglas YARA para detectar malware
- **Web Security**: Testing de aplicaciones web
- **Code Review**: Análisis de código malicioso

**Workflow de análisis forense:**
```bash
# 1. Crear regla YARA
yara-rule-authoring --name ransomware_detector --pattern "encrypted_files" --output rules/

# 2. Escanear sistema
yara -r rules/ransomware_detector.sig /suspicious/

# 3. Reportar hallazgos
security-auditor --format markdown --output report.md
```

---

#### 4. **AUDITORÍA PREPARATION Y CONTEXT BUILDING**

| Skill | Descripción | Casos de Uso |
|-------|-------------|--------------|
| **audit-prep-assistant** | Preparación para auditorías TOB | Checklist pre-auditoría |
| **audit-context-building** | Análisis ultra-granular | Context building antes de audit |
| **isms-audit-expert** | ISO 27001 ISMS auditing | Compliance auditing |

**Aplicación en el Master:**
- Preparar codebases para auditorías formales
- Documentación de hallazgos
- Cumplimiento normativo

**Proceso de auditoría:**
```bash
# 1. Preparación
audit-prep-assistant --checklist --output prep/

# 2. Context building
audit-context-building --deep --scope ./src

# 3. Cumplimiento ISO 27001
isms-audit-expert --standard ISO27001 --evidence ./evidence/
```

---

#### 5. **WEB APPLICATION SECURITY**

| Skill | Descripción | Casos de Uso |
|-------|-------------|--------------|
| **webapp-testing** | Testing con Playwright | E2E security testing |
| **frontend-security** | Auditorías frontend | XSS, clickjacking, CORS |
| **backend-security-coder** | Secure coding backend | Auth, sessions, input validation |

**Aplicación en el Master:**
- OWASP Top 10 testing
- Security testing de SPAs
- API security testing

**Pipeline de web security:**
```bash
# 1. Testing automatizado
webapp-testing --suite OWASP --output results/

# 2. Frontend audit
frontend-security --audit --framework react

# 3. Backend secure review
backend-security-coder --check --api endpoints/
```

---

#### 6. **DIFERENTIAL REVIEW Y CODE ANALYSIS**

| Skill | Descripción | Casos de Uso |
|-------|-------------|--------------|
| **differential-review** | Revisión diferencial de PRs | Detectar regresiones de seguridad |
| **sharp-edges** | APIs peligrosas | Footguns de seguridad |
| **insecure-defaults** | Configuraciones inseguras | Hardening checks |

**Aplicación en el Master:**
- Review de código en PRs
- Identificar antipatterns de seguridad
- Mejores prácticas de hardening

**Workflow de review:**
```bash
# 1. Differential review
differential-review --pr 123 --security-only

# 2. Detectar footguns
sharp-edges --report=all --format json

# 3. Verificar hardening
insecure-defaults check --strict
```

---

#### 7. **FRAMEWORKS Y COMPLIANCE**

| Skill | Descripción | Casos de Uso |
|-------|-------------|--------------|
| **cybersecurity-analyst** | Marcos CIA Triad, Zero Trust | Frameworks teóricos |
| **security-compliance** | Defense in Depth | Arquitecturas seguras |
| **isms-audit-expert** | ISO 27001 | Auditorías de cumplimiento |

**Aplicación en el Master:**
- Diseño de arquitecturas seguras
- Documentación de controles
- Cumplimiento regulatorio

---

#### 8. **VULNERABILITY SCANNING Y DEPENDENCY CHECKING**

| Skill | Descripción | Casos de Uso |
|-------|-------------|--------------|
| **vulnerability-scanning** | Escaneo de vulnerabilidades | SAST/DAST |
| **security-scanning** | Dependency scanning | SCA |
| **security-auditor** | Auditorías comprehensivas | Full security audit |

**Pipeline completo:**
```bash
# 1. SAST
semgrep --config=auto --json > semgrep.json

# 2. Dependency check
vulnerability-scanning --deps package.json requirements.txt

# 3. SCA
security-scanning --sca --output sca_report.json

# 4. Consolidated audit
security-auditor --consolidate semgrep.json sca_report.json
```

---

### 📊 MATRIZ DE APLICACIÓN POR SEMESTRE

| Semestre | Área | Skills Principales | Skills Secundarios |
|----------|------|-------------------|-------------------|
| 1 | Fundamentos | cybersecurity-analyst, security-compliance | bash-pro, constant-time-analysis |
| 2 | Análisis | semgrep, codeql, security-auditor | sharp-edges, insecure-defaults |
| 3 | Testing | webapp-testing, fuzzing-dictionary | harness-writing, yara-rule-authoring |
| 4 | Advanced | audit-prep-assistant, isms-audit-expert | differential-review, backend-security-coder |

---

### 🎯 SKILLS CRÍTICOS PARA CADA FASE DEL MASTER

#### **Fase 1: Teoría y Frameworks**
- **Obligatorios**: cybersecurity-analyst, security-compliance, isms-audit-expert
- **Complementarios**: constant-time-analysis (crypto security)

#### **Fase 2: Análisis de Código**
- **Obligatorios**: semgrep, codeql, security-auditor, sharp-edges
- **Complementarios**: insecure-defaults, backend-security-coder

#### **Fase 3: Testing y Exploitation**
- **Obligatorios**: webapp-testing, fuzzing-dictionary, yara-rule-authoring
- **Complementarios**: harness-writing, frontend-security

#### **Fase 4: Auditoría y Cumplimiento**
- **Obligatorios**: audit-prep-assistant, audit-context-building, differential-review
- **Complementarios**: security-scanning, vulnerability-scanning

---

### 📚 RECURSOS ADICIONALES INSTALADOS

| Categoría | Skills | Descripción |
|-----------|--------|-------------|
| **Desarrollo** | clean-code, modern-python, nextjs-best-practices | Mejores prácticas de código |
| **DevOps** | docker-expert, security-scanning | Container security, CI/CD |
| **Documentos** | pdf, docx, xlsx, pptx, drive-documents | Procesamiento de documentos |
| **Análisis** | variant-analysis, sarif-parsing | Análisis avanzado |

---

### 🚀 COMANDOS RÁPIDOS DE REFERENCIA

```bash
# Análisis de seguridad completo
semgrep --config=auto . > scan.json
security-auditor --input scan.json --format markdown

# Revisión de PR con foco en seguridad
differential-review --pr $(git pr --number) --security-only

# Validación crypto
constant-time-analysis --code ./src/crypto/
wycheproof --test RSA --strict

# Fuzzing de parsers
harness-writing --input parser.c --fuzzer libafl
libafl --dict fuzzing-dictionary/ --out results/

# Creación de reglas YARA
yara-rule-authoring --name new_rule --ioc "file_pattern" --output rules/

# Web security testing
webapp-testing --target http://localhost:3000 --suite OWASP

# Compliance ISO 27001
isms-audit-expert --standard ISO27001:2022 --evidence ./evidence/
```

---

### 📖 UBICACIÓN DE TODOS LOS SKILLS

```
~/.opencode/skills/.agents/skills/
├── # Criptografía
│   ├── constant-time-analysis/
│   └── wycheproof/
│
├── # Fuzzing
│   ├── fuzzing-dictionary/
│   └── harness-writing/
│
├── # Malware & Forense
│   └── yara-rule-authoring/
│
├── # Web Security
│   ├── webapp-testing/
│   ├── frontend-security/
│   └── backend-security-coder/
│
├── # Auditoría
│   ├── audit-prep-assistant/
│   ├── audit-context-building/
│   └── isms-audit-expert/
│
├── # Code Analysis
│   ├── semgrep/
│   ├── codeql/
│   ├── differential-review/
│   ├── sharp-edges/
│   ├── insecure-defaults/
│   └── security-auditor/
│
├── # Frameworks
│   ├── cybersecurity-analyst/
│   └── security-compliance/
│
├── # Scanning
│   ├── vulnerability-scanning/
│   └── security-scanning/
│
└── # Utilitarios
    ├── bash-pro/
    └── clean-code/
```