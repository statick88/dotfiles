# Gentleman Programming Flow - Setup Completo

## ✅ Estado del Setup (Completado)

### 1. Engram - Memoria Persistente
- **Versión**: 1.2.1
- **Instalación**: Homebrew (`gentleman-programming/tap/engram`)
- **Servidor HTTP**: Corriendo en http://127.0.0.1:7437
- **Base de datos**: ~/.engram/engram.db (SQLite + FTS5)
- **Plugin OpenCode**: ~/.config/opencode/plugins/engram.ts

### 2. MCP Configuration
- **Archivo**: ~/.config/opencode/opencode.json
- **Server**: engram (type: local, enabled: true)
- **Command**: `engram start --mcp-only`

### 3. Skills SDD Instalados (9 skills)
Ubicación: ~/.claude/skills/

| Skill | Propósito | Uso |
|-------|-----------|-----|
| **sdd-init** | Inicializar SDD en proyecto | `opencode sdd-init` |
| **sdd-propose** | Crear propuesta de cambio | `opencode sdd-propose "desc"` |
| **sdd-spec** | Escribir especificaciones | Automático en propose |
| **sdd-explore** | Explorar código existente | `opencode sdd-explore` |
| **sdd-design** | Diseño técnico | `opencode sdd-design` |
| **sdd-tasks** | Desglose de tareas | `opencode sdd-tasks` |
| **sdd-apply** | Implementar tareas | `opencode sdd-apply` |
| **sdd-verify** | Verificar implementación | `opencode sdd-verify` |
| **sdd-archive** | Archivar cambio completado | `opencode sdd-archive` |

### 4. Stack Tecnológico Disponible (20+ skills)
- **Frontend**: react-19, nextjs-15, angular-core, tailwind-4
- **Backend**: django-drf, ai-sdk-5
- **Estado**: zustand-5
- **Validación**: zod-4, typescript
- **Testing**: pytest, playwright
- **DevOps**: github-pr, jira-epic, jira-task

---

## 🚀 Cómo Usar el Flujo Completo

### Paso 1: Iniciar Proyecto con SDD
```bash
cd ~/Projects/mi-proyecto
opencode
```

En OpenCode:
```
> sdd-init
```

Esto crea la estructura:
```
mi-proyecto/
└── openspec/
    ├── specs/
    ├── design/
    └── tasks/
```

### Paso 2: Crear Propuesta de Cambio
```
> sdd-propose "Agregar autenticación OAuth2 con Google"
```

Engram automáticamente guardará:
- Tu propuesta inicial
- Contexto del proyecto
- Decisiones arquitectónicas

### Paso 3: Explorar y Diseñar
```
> sdd-explore
```
Busca en Engram si ya trabajaste en auth antes.

```
> sdd-design
```
Crea SPEC.md con diseño técnico.

### Paso 4: Desglosar Tareas
```
> sdd-tasks
```
Genera checklist automático con tareas específicas.

### Paso 5: Implementar
```
> sdd-apply
```
Ejecuta las tareas una por una. Engram guarda:
- Bugs encontrados y fixes
- Decisiones de implementación
- Patrones descubiertos

### Paso 6: Verificar
```
> sdd-verify
```
Valida contra SPEC.md original.

### Paso 7: Archivar
```
> sdd-archive
```
Sincroniza spec delta con spec principal y archiva.

---

## 🔍 Comandos de Engram

### Verificar Estado
```bash
# Ver si el servidor está corriendo
curl http://127.0.0.1:7437/health

# Ver estadísticas de memoria
engram stats

# Ver contexto reciente
engram context

# Buscar en memoria
engram search "autenticación"

# Abrir TUI (Terminal UI)
engram tui
```

### Gestión de Memoria
```bash
# Guardar memoria manual
engram save "Fixed auth bug" "JWT token expired check was missing" --type bugfix

# Buscar por tipo
engram search "auth" --type decision

# Ver timeline de una observación
engram timeline <obs_id>

# Exportar memoria
engram export backup.json

# Importar memoria
engram import backup.json
```

### Sincronización entre Equipos
```bash
# Exportar a .engram/ (para git)
engram sync

# Importar desde .engram/
engram sync --import

# Ver estado de sync
engram sync --status
```

---

## 📊 Arquitectura del Sistema

```
┌─────────────────────────────────────────────────┐
│                  OpenCode CLI                     │
│  (Agent + Subagents + Tools + Hooks)             │
└────────────────┬────────────────────────────────┘
                 │
    ┌────────────┼────────────┐
    │            │            │
    ▼            ▼            ▼
┌────────┐  ┌────────┐  ┌────────────┐
│ Skills │  │   MCP  │  │   Engram   │
│  SDD   │  │ Protocol│  │  Plugin    │
└────────┘  └────────┘  └─────┬──────┘
                             │
                    ┌────────┴────────┐
                    │                 │
                    ▼                 ▼
            ┌─────────────┐   ┌──────────────┐
            │ Engram HTTP │   │ Engram MCP   │
            │   :7437     │   │   Server     │
            └──────┬──────┘   └──────┬───────┘
                   │                 │
                   └────────┬────────┘
                            ▼
                   ┌──────────────────┐
                   │  SQLite + FTS5   │
                   │  ~/.engram/db    │
                   └──────────────────┘
```

---

## 🧠 Protocolo de Memoria de Engram

### Cuándo Guardar (OBLIGATORIO)
El agente automáticamente llama a `mem_save` cuando:

1. **Bug fix completado**
   - title: "Fixed N+1 query in UserList"
   - type: bugfix
   - content: qué, por qué, dónde, aprendido

2. **Decisión de arquitectura**
   - title: "Chose Zustand over Redux"
   - type: decision
   - content: qué se decidió, por qué, alternativas

3. **Patrón establecido**
   - title: "Naming convention: use camelCase for APIs"
   - type: pattern
   - content: descripción del patrón

4. **Preferencia del usuario**
   - title: "User prefers Tailwind over CSS modules"
   - type: preference
   - scope: personal
   - content: qué prefiere y por qué

### Cuándo Buscar
El agente busca en memoria cuando:

1. **Usuario pregunta**:
   - "¿recuerdas cómo arreglamos el bug de auth?"
   - "what did we do about the N+1 queries?"
   - "acordate del issue con las sessions"

2. **Proactivamente**:
   - Antes de empezar tarea similar
   - Cuando usuario menciona tema sin contexto

### Session Summary (OBLIGATORIO)
Antes de terminar sesión, el agente llama a `mem_session_summary` con:

```
## Goal
[Qué estábamos trabajando]

## Instructions
[Preferencias descubiertas]

## Discoveries
[Hallazgos técnicos, gotchas]

## Accomplished
[Items completados]

## Next Steps
[Qué falta por hacer]

## Relevant Files
[path/to/file — qué hace]
```

---

## 🎯 Próximos Pasos Recomendados

### 1. Probar el Flujo Completo (15 min)
```bash
# Crear proyecto de prueba
mkdir -p ~/Projects/test-sdd-flow
cd ~/Projects/test-sdd-flow
git init

# Iniciar OpenCode
opencode

# En OpenCode:
> sdd-init
> sdd-propose "Crear API REST básica con FastAPI"
> sdd-explore
> sdd-design
> sdd-tasks
> sdd-apply
> sdd-verify
> sdd-archive

# Verificar memoria guardada
> !engram stats
> !engram context
```

### 2. Explorar TUI de Engram (5 min)
```bash
engram tui
```

Controles:
- `↑/↓` - Navegar observaciones
- `/` - Buscar
- `f` - Filtrar por tipo
- `p` - Filtrar por proyecto
- `q` - Salir

### 3. Integrar con Proyecto Existente
```bash
cd ~/Projects/tu-proyecto-existente
opencode

> sdd-init
> sdd-explore  # Engram aprenderá del proyecto
> sdd-propose "Mejorar performance del dashboard"
```

### 4. Configurar Auto-start de Engram (Opcional)
```bash
# Agregar a ~/.zshrc o ~/.bashrc
echo '# Auto-start Engram server
if ! pgrep -f "engram start" > /dev/null; then
  engram start > /dev/null 2>&1 &
fi' >> ~/.zshrc
```

---

## 📚 Referencias

### Video Original
- **Título**: Cómo ser TONY STARK con IA: Agentes, Subagentes, Memoria y Skills
- **Canal**: Gentleman Programming
- **URL**: https://youtu.be/SOxuW5K2FFY
- **Duración**: 01:07:10

### Repositorios
- **Engram**: https://github.com/Gentleman-Programming/engram
- **Skills**: https://github.com/anthropics/skills
- **MCP Spec**: https://modelcontextprotocol.io

### Documentación
- **Spec Driven Development**: ~/.claude/skills/sdd-*/SKILL.md
- **Engram Protocol**: ~/.config/opencode/plugins/engram.ts (MEMORY_INSTRUCTIONS)
- **MCP Config**: ~/.config/opencode/opencode.json

---

## 🔧 Troubleshooting

### Engram no guarda memorias
```bash
# Verificar que el servidor está corriendo
curl http://127.0.0.1:7437/health

# Si no responde, reiniciar
pkill -f "engram start"
engram start > /dev/null 2>&1 &
```

### OpenCode no ve los skills SDD
```bash
# Verificar ubicación
ls ~/.claude/skills/ | grep sdd

# Debería mostrar 9 skills sdd-*
```

### MCP server no funciona
```bash
# Verificar configuración
cat ~/.config/opencode/opencode.json

# Debería mostrar engram en mcpServers

# Verificar que engram start --mcp-only funciona
engram start --mcp-only
# (debería quedar en espera de stdin)
```

### Base de datos corrupta
```bash
# Backup
engram export backup.json

# Eliminar DB
rm ~/.engram/engram.db

# Restaurar
engram import backup.json
```

---

## 🎉 ¡Listo para Usar!

Tu setup del flujo de Gentleman Programming está completo:

✅ Engram instalado y corriendo
✅ MCP configurado en OpenCode
✅ Skills SDD disponibles
✅ Stack tecnológico listo
✅ Protocolo de memoria activo

**Próximo paso**: Abre OpenCode en tu proyecto y ejecuta `sdd-init` para empezar.

---

## 🤖 Gentleman Guardian Angel (GGA) - Code Review en cada Push

### ¿Qué es GGA?

**Gentleman Guardian Angel (gga)** es un sistema de revisión de código automática que se ejecuta en cada commit. Valida tus archivos modificados contra tu archivo `AGENTS.md` usando cualquier AI provider (Claude, Gemini, OpenCode, Ollama, etc.).

```
┌─────────────────┐     ┌──────────────┐     ┌─────────────────┐
│   git commit    │ ──▶ │  AI Review   │ ──▶ │  ✅ Pass/Fail   │
│  (staged files) │     │  (any LLM)   │     │  (with details) │
└─────────────────┘     └──────────────┘     └─────────────────┘
```

### Características Principales

- 🔌 **Provider agnostic** - Usa Claude, Gemini, Codex, OpenCode, Ollama, LM Studio, GitHub Models
- 📦 **Zero dependencies** - Bash puro, sin Node/Python/Go
- 🪝 **Git native** - Se instala como pre-commit hook
- ⚙️ **Highly configurable** - Patrones de archivos, exclusiones, reglas personalizadas
- 🚨 **Strict mode** - Fail en CI si la respuesta es ambigua
- ⚡ **Smart caching** - Skip archivos sin cambios para reviews más rápidos
- ⏱️ **Timeout & progress** - Timeout configurable con spinner visual
- 🔍 **PR review mode** - Revisa todo el PR, no solo el último commit

### Instalación

```bash
# Homebrew (recomendado)
brew tap gentleman-programming/tap
brew install gga

# Verificar instalación
gga version
# Output: gga v2.7.0
```

### Configuración en tu Proyecto

```bash
cd ~/tu-proyecto

# 1. Inicializar configuración
gga init

# 2. Editar .gga (provider, patrones, etc.)
cat .gga
```

Ejemplo de `.gga`:
```bash
# AI Provider (claude, gemini, opencode, ollama:<model>, lmstudio, github:<model>)
PROVIDER="claude"

# Archivos a revisar
FILE_PATTERNS="*.ts,*.tsx,*.js,*.jsx"

# Archivos a excluir
EXCLUDE_PATTERNS="*.test.ts,*.spec.ts,*.d.ts"

# Archivo de reglas (AGENTS.md o personalizado)
RULES_FILE="AGENTS.md"

# Modo estricto (fail en respuestas ambiguas)
STRICT_MODE="true"

# Timeout en segundos
TIMEOUT="300"
```

### Crear tu AGENTS.md (Reglas de Código)

```bash
cat > AGENTS.md << 'EOF'
# Code Review Rules

## TypeScript

REJECT if:
- `any` type used without justification
- Missing return types on public functions

PREFER:
- Interfaces over type aliases for objects
- const over let when possible

## React

REJECT if:
- `import * as React` → use `import { useState }`
- Missing "use client" in client components

PREFER:
- Functional components with hooks
- Named exports over default exports

## Styling

REJECT if:
- Hardcoded colors → use Tailwind classes
- Inline styles → use Tailwind

## Response Format

FIRST LINE must be exactly:
STATUS: PASSED
or
STATUS: FAILED

If FAILED, list: `file:line - rule violated - issue`
EOF
```

### Instalar el Hook de Git

```bash
# Hook pre-commit (revisar archivos staged)
gga install

# Opcional: Hook commit-msg (revisar mensaje de commit)
gga install --commit-msg
```

### Uso

```bash
# Revisión normal (archivos staged)
git add src/
git commit -m "feat: add new component"

# Revisión en CI (último commit)
gga run --ci

# Revisión de PR completo
gga run --pr-mode

# Revisión sin cache
gga run --no-cache

# Bypassear revisión
git commit --no-verify -m "hotfix: urgent fix"
```

### Comandos de Cache

```bash
# Ver estado del cache
gga cache status

# Limpiar cache del proyecto
gga cache clear

# Limpiar todo el cache
gga cache clear-all
```

### Integración con CI/CD

#### GitHub Actions
```yaml
# .github/workflows/ai-review.yml
name: Gentleman Guardian Angel

on:
  pull_request:
    types: [opened, synchronize]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      
      - name: Install GGA
        run: |
          brew install gentleman-programming/tap/gga
      
      - name: Run AI Review
        run: gga run --pr-mode
```

### Flujo Completo SDD + GGA

```
┌─────────────────────────────────────────────────────────────────┐
│                    FLUJO SDD + GGA                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. sdd-propose "Nueva feature"                               │
│        ↓                                                        │
│  2. sdd-spec (especificaciones)                               │
│        ↓                                                        │
│  3. sdd-design (diseño técnico)                                │
│        ↓                                                        │
│  4. sdd-tasks (checklist de tareas)                           │
│        ↓                                                        │
│  5. sdd-apply (implementar tareas)                            │
│        ↓                                                        │
│  6. git add . && git commit                                    │
│        ↓                                                        │
│  7. 🤖 GGA revisa el código → PASS/FAIL                       │
│        ↓                                                        │
│  8. sdd-verify (validar contra spec)                          │
│        ↓                                                        │
│  9. git push                                                   │
│        ↓                                                        │
│  10. CI/CD + PR Review (GGA --pr-mode)                        │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 📦 Gentleman.Dots - Plugins y Skills de OpenCode

### ¿Qué es Gentleman.Dots?

Es la configuración completa de desarrollo de Gentleman Programming que incluye:
- Configuraciones para Neovim (LazyVim), shells, terminals
- **Skills de OpenCode** para diferentes tecnologías
- TUI Installer para instalación automática

### Skills de OpenCode Disponibles (22 skills)

Gentleman.Dots incluye estos skills en `GentlemanOpenCode/skill/`:

| Skill | Descripción |
|-------|-------------|
| **sdd-*** (9) | Spec-Driven Development: init, propose, spec, explore, design, tasks, apply, verify, archive |
| **react-19** | React 19 con React Compiler |
| **nextjs-15** | Next.js 15 App Router |
| **typescript** | TypeScript strict patterns |
| **tailwind-4** | Tailwind CSS 4 |
| **zod-4** | Zod schema validation |
| **zustand-5** | Zustand state management |
| **ai-sdk-5** | Vercel AI SDK 5 |
| **django-drf** | Django REST Framework |
| **playwright** | E2E testing |
| **pytest** | Python testing |
| **jira-task** | Crear tareas Jira |
| **jira-epic** | Crear epics Jira |
| **pr-review** | Revisiones de PR |
| **skill-creator** | Crear nuevos skills |

### Instalar Skills de Gentleman.Dots

```bash
# Clonar repositorio
git clone https://github.com/Gentleman-Programming/Gentleman.Dots.git /tmp/gentleman-dots

# Copiar skills a tu directorio
cp -r /tmp/gentleman-dots/GentlemanOpenCode/skill/* ~/.claude/skills/

# O: Copiar configuración de OpenCode
cp /tmp/gentleman-dots/GentlemanOpenCode/opencode.json ~/.config/opencode/opencode-gentleman.json
```

### Estructura de Skills

```
GentlemanOpenCode/
├── opencode.json          # Configuración de OpenCode
├── skill/
│   ├── sdd-*/            # Skills SDD
│   ├── react-19/        # Skill React 19
│   ├── nextjs-15/       # Skill Next.js 15
│   ├── typescript/      # Skill TypeScript
│   ├── tailwind-4/      # Skill Tailwind
│   ├── zod-4/           # Skill Zod
│   ├── zustand-5/       # Skill Zustand
│   ├── ai-sdk-5/        # Skill AI SDK
│   ├── django-drf/      # Skill Django
│   ├── playwright/      # Skill Playwright
│   ├── pytest/          # Skill Pytest
│   ├── jira-task/       # Skill Jira Tasks
│   ├── jira-epic/       # Skill Jira Epics
│   ├── pr-review/       # Skill PR Review
│   └── skill-creator/   # Skill Creator
└── themes/              # Temas de OpenCode
```

### Comparación: Tus Skills vs Gentleman.Dots

| Tu Setup Actual | Gentleman.Dots | Recomendación |
|-----------------|---------------|---------------|
| 9 skills sdd-* | 9 skills sdd-* | ✅ Ya tienes |
| react-19 | react-19 | ✅ Ya tienes |
| nextjs-15 | nextjs-15 | ✅ Ya tienes |
| typescript | typescript | ✅ Ya tienes |
| tailwind-4 | tailwind-4 | ✅ Ya tienes |
| zod-4 | zod-4 | ✅ Ya tienes |
| zustand-5 | zustand-5 | ✅ Ya tienes |
| ai-sdk-5 | ai-sdk-5 | ✅ Ya tienes |
| django-drf | django-drf | ✅ Ya tienes |
| pytest | pytest | ✅ Ya tienes |
| playwright | playwright | ✅ Ya tienes |
| github-pr | pr-review | 🔄 Considera |
| jira-task | jira-task | ✅ Ya tienes |
| jira-epic | jira-epic | ✅ Ya tienes |
| skill-creator | skill-creator | ✅ Ya tienes |
| angular-core | ❌ | ➕ Considera agregar |
| angular-forms | ❌ | ➕ Considera agregar |
| angular-performance | ❌ | ➕ Considera agregar |
| angular-architecture | ❌ | ➕ Considera agregar |
| clean-architecture | ❌ | ➕ Considera agregar |
| agile | ❌ | ➕ Considera agregar |
| fastapi | ❌ | ➕ Considera agregar |
| supabase | ❌ | ➕ Considera agregar |
| tdd | ❌ | ➕ Considera agregar |
| encryption | ❌ | ➕ Considera agregar |
| security | ❌ | ➕ Considera agregar |
| flutter | ❌ | ➕ Considera agregar |
| astro | ❌ | ➕ Considera agregar |
| clean-code | ❌ | ➕ Considera agregar |
| devsecops | ❌ | ➕ Considera agregar |
| docker | ❌ | ➕ Considera agregar |
| electron | ❌ | ➕ Considera agregar |
| java-21 | ❌ | ➕ Considera agregar |
| elixir-antipatterns | ❌ | ➕ Considera agregar |
| hexagonal-architecture-layers-java | ❌ | ➕ Considera agregar |
| react-native | ❌ | ➕ Considera agregar |
| +32 skills seguridad | ❌ | ➕ Tienes más skills de seguridad |

---

## 🏗️ Setup Recomendado: SDD + GGA + Engram

### Arquitectura Completa

```
┌─────────────────────────────────────────────────────────────────┐
│                    GENTLEMAN PROGRAMMING FLOW                  │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌──────────────┐     ┌──────────────┐     ┌─────────────┐  │
│   │   OpenCode   │────▶│    SDD       │────▶│  Engram     │  │
│   │   (Agent)    │     │   Workflow   │     │  (Memory)   │  │
│   └──────────────┘     └──────────────┘     └─────────────┘  │
│          │                    │                    │          │
│          │                    │                    │          │
│          ▼                    ▼                    ▼          │
│   ┌──────────────┐     ┌──────────────┐     ┌─────────────┐  │
│   │    Skills    │     │   Specs &    │     │  Context   │  │
│   │  (22+)       │     │   Design     │     │  Learning  │  │
│   └──────────────┘     └──────────────┘     └─────────────┘  │
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐  │
│   │              Gentleman Guardian Angel (GGA)             │  │
│   │  git commit → AI Review → AGENTS.md → PASS/FAIL       │  │
│   └─────────────────────────────────────────────────────────┘  │
│                              │                                  │
│                              ▼                                  │
│   ┌─────────────────────────────────────────────────────────┐  │
│   │                      CI/CD Pipeline                      │  │
│   │  GGA --pr-mode → Tests → Security Scan → Deploy        │  │
│   └─────────────────────────────────────────────────────────┘  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Flujo de Trabajo Diario

```bash
# 1. Iniciar proyecto
cd ~/Projects/mi-proyecto
opencode

# 2. En OpenCode: crear propuesta
> sdd-propose "Agregar autenticación OAuth2"

# 3. Especificar
> sdd-spec

# 4. Explorar código existente (Engram busca contexto)
> sdd-explore

# 5. Diseñar
> sdd-design

# 6. Desglosar tareas
> sdd-tasks

# 7. Implementar
> sdd-apply

# 8. Commit (GGA revisa automáticamente)
git add .
git commit -m "feat: implement OAuth2 authentication"

# 9. Verificar
> sdd-verify

# 10. Archivar
> sdd-archive

# 11. Push (GGA en CI revisa el PR completo)
git push
# En CI: gga run --pr-mode
```

---

## 📚 Referencias

### Video Original
- **Título**: Cómo ser TONY STARK con IA: Agentes, Subagentes, Memoria y Skills
- **Canal**: Gentleman Programming
- **URL**: https://youtu.be/SOxuW5K2FFY
- **Duración**: 01:07:10

### Repositorios
- **Engram**: https://github.com/Gentleman-Programming/engram
- **Gentleman Guardian Angel**: https://github.com/Gentleman-Programming/gentleman-guardian-angel
- **Gentleman.Dots**: https://github.com/Gentleman-Programming/Gentleman.Dots
- **Skills**: https://github.com/anthropics/skills
- **MCP Spec**: https://modelcontextprotocol.io

### Documentación
- **Spec Driven Development**: ~/.claude/skills/sdd-*/SKILL.md
- **Engram Protocol**: ~/.config/opencode/plugins/engram.ts (MEMORY_INSTRUCTIONS)
- **MCP Config**: ~/.config/opencode/opencode.json
- **GGA Config**: .gga en cada proyecto

---

## 🔧 Troubleshooting

### Engram no guarda memorias
```bash
# Verificar que el servidor está corriendo
curl http://127.0.0.1:7437/health

# Si no responde, reiniciar
pkill -f "engram start"
engram start > /dev/null 2>&1 &
```

### OpenCode no ve los skills SDD
```bash
# Verificar ubicación
ls ~/.claude/skills/ | grep sdd

# Debería mostrar 9 skills sdd-*
```

### MCP server no funciona
```bash
# Verificar configuración
cat ~/.config/opencode/opencode.json

# Verificar que engram start --mcp-only funciona
engram start --mcp-only
```

### GGA no funciona
```bash
# Verificar instalación
gga version

# Verificar provider
which claude  # o gemini, opencode, etc.

# Probar provider
echo "hello" | claude --print
```

### Base de datos corrupta
```bash
# Backup
engram export backup.json

# Eliminar DB
rm ~/.engram/engram.db

# Restaurar
engram import backup.json
```

---

*Última actualización: 2026-02-26*
*Basado en el curso de Gentleman Programming - Febrero 2026*
*Incluye: Engram, SDD, Skills, GGA, Gentleman.Dots*
