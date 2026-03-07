# OpenCode Refactorización Completa

**Fecha**: 7 de Marzo 2026  
**Status**: Proposal  
**Scope**: Core architecture, plugin system, configuration management  

---

## 📋 Problemas Identificados

### 1. **Arquitectura del Plugin System (engram.ts)**
- ❌ **Error handling débil**: Fallos silenciosos (catch sin log)
- ❌ **Falta de validación**: Sessions y data no validadas antes de enviar
- ❌ **Type safety incompleto**: Propiedades `as any` en eventos
- ❌ **Magic strings**: ENGRAM_TOOLS hardcodeado
- ❌ **Memory leak potencial**: `knownSessions` crece indefinidamente
- ❌ **No retry logic**: Si engram falla, no reintentos

### 2. **Configuración (opencode.json)**
- ❌ **Prompt duplicado**: Agent "gentleman" y "sdd-orchestrator" comparten prompt (lines 176-177 y 183-186)
- ❌ **MCP servers no validados**: Ningún schema de validación
- ❌ **Hardcoded URLs/ports**: ENGRAM_PORT en engram.ts, context7 URL en config
- ❌ **Permission rules complejas**: Difícil de mantener/auditar
- ❌ **Falta secrets management**: Token env vars sin validación

### 3. **Package.json y Dependencies**
- ❌ **Dependencias mínimas**: Solo @opencode-ai/plugin
- ❌ **Sin scripts ni build**: Ningún comando de lint, test, build
- ❌ **Sin versioning strategy**: package.json sin version

### 4. **Documentación y Mantenimiento**
- ❌ **MEMORY_INSTRUCTIONS hardcoded**: Debería estar en archivo separado
- ❌ **Falta de comentarios de architecture**: Código no auto-explicable
- ❌ **Sin changelog**: Cambios no documentados
- ❌ **No tenemos testing**: Cero tests

---

## 🎯 Objetivos de Refactorización

1. **Seguridad**: Validación + error handling robusto
2. **Mantenibilidad**: Separar concerns, reducir duplication
3. **Testability**: Funciones puras, inyección de dependencias
4. **Developer Experience**: CLI clara, logs útiles, debugging fácil
5. **Escalabilidad**: Soporte para múltiples proyectos, sesiones concurrentes

---

## 📐 Nueva Arquitectura Propuesta

```
opencode/
├── src/
│   ├── core/
│   │   ├── config.ts          # Schema + loader
│   │   ├── constants.ts       # Magic strings centralizados
│   │   └── types.ts           # Tipos compartidos
│   │
│   ├── plugins/
│   │   ├── index.ts           # Plugin registry
│   │   ├── engram/
│   │   │   ├── plugin.ts      # Main plugin
│   │   │   ├── client.ts      # HTTP client con retry
│   │   │   ├── session.ts     # Session manager
│   │   │   ├── events.ts      # Event handlers
│   │   │   ├── logger.ts      # Structured logging
│   │   │   └── validation.ts  # Data validation
│   │   └── (otros plugins)
│   │
│   ├── utils/
│   │   ├── logger.ts          # Log levels, formatting
│   │   ├── error.ts           # Custom error types
│   │   ├── retry.ts           # Retry strategy
│   │   └── validation.ts      # Zod schemas
│   │
│   └── cli/
│       ├── index.ts           # CLI entry
│       ├── commands/
│       │   ├── config.ts      # config verify, update
│       │   ├── plugin.ts      # plugin list, install
│       │   ├── debug.ts       # debug engram, mcp
│       │   └── refactor.ts    # interactive refactoring
│       └── prompts.ts         # Interactive prompts
│
├── tests/
│   ├── plugins/
│   │   ├── engram/
│   │   │   ├── client.test.ts
│   │   │   ├── session.test.ts
│   │   │   └── events.test.ts
│   │   └── config.test.ts
│   └── utils/
│       ├── logger.test.ts
│       └── validation.test.ts
│
├── config/
│   ├── default.json           # Defaults
│   ├── schema.json            # JSON Schema
│   └── templates/
│       ├── agent.prompt.md
│       ├── memory.instructions.md
│       └── security-rules.json
│
├── docs/
│   ├── ARCHITECTURE.md
│   ├── PLUGIN_DEVELOPMENT.md
│   ├── MIGRATION_GUIDE.md
│   └── TROUBLESHOOTING.md
│
├── package.json               # Con scripts
├── tsconfig.json
├── bun.lockb
└── opencode.json             # Limpio, sin duplicación
```

---

## 🔧 Cambios Específicos

### A. Config Management (Priority: 🔴 HIGH)

**Antes**:
```json
{
  "provider": { "anthropic": {...}, "ollama": {...} },
  "mcp": {...},
  "agent": {...}
}
```

**Después**:
```typescript
// src/core/config.ts
import { z } from "zod"

const ConfigSchema = z.object({
  provider: z.object({
    anthropic: z.object({
      name: z.string(),
      models: z.record(z.string()),
    }),
  }),
  mcp: z.record(z.object({
    type: z.enum(["local", "remote"]),
    enabled: z.boolean().default(true),
    command: z.array(z.string()).optional(),
    url: z.string().url().optional(),
  })),
  // ...
})

export async function loadConfig(path: string): Promise<Config> {
  const raw = await readJSON(path)
  return ConfigSchema.parse(raw)
}
```

**Archivo de config limpio** (`opencode.json`):
```json
{
  "$schema": "./config/schema.json",
  "extends": "./config/default.json",
  "overrides": {
    "provider": { "anthropic": {...} },
    "mcp": { "engram": {...} }
  }
}
```

---

### B. Plugin System (Priority: 🔴 HIGH)

**engram.ts refactorizado** en módulos:

```typescript
// src/plugins/engram/plugin.ts
import { Plugin } from "@opencode-ai/plugin"
import { SessionManager } from "./session"
import { EventHandler } from "./events"
import { EngramClient } from "./client"
import { Logger } from "../../utils/logger"

export class EngramPlugin implements Plugin {
  private client: EngramClient
  private sessions: SessionManager
  private events: EventHandler
  private logger: Logger

  async initialize(ctx: PluginContext): Promise<void> {
    this.client = new EngramClient(ctx.config.engram)
    this.sessions = new SessionManager(this.client, this.logger)
    this.events = new EventHandler(this.sessions, this.logger)
    
    // Startup checks
    await this.healthCheck()
  }

  private async healthCheck(): Promise<void> {
    const healthy = await this.client.health()
    if (!healthy) {
      this.logger.warn("Engram not responding, attempting startup...")
      await this.client.startServer()
    }
  }

  // Event handlers registrados limpiamente
  handlers() {
    return {
      "session.created": (input) => this.events.onSessionCreated(input),
      "session.deleted": (input) => this.events.onSessionDeleted(input),
      "message.updated": (input) => this.events.onUserMessage(input),
      "tool.execute.after": (input, output) => this.events.onToolExecute(input, output),
    }
  }
}
```

**Client con retry + error handling**:
```typescript
// src/plugins/engram/client.ts
export class EngramClient {
  async fetch<T>(path: string, opts?: FetchOpts): Promise<T | null> {
    return withRetry(
      async () => {
        const res = await fetch(`${this.url}${path}`, opts)
        if (!res.ok) {
          throw new EngramError(`HTTP ${res.status}`, { path, status: res.status })
        }
        return res.json()
      },
      { maxRetries: 3, backoff: "exponential" }
    )
  }

  async startServer(): Promise<void> {
    this.logger.info("Starting engram server...", { port: this.port })
    Bun.spawn([this.bin, "serve"], { stdio: "pipe" })
    await this.waitForHealthy(5000)
  }
}
```

---

### C. Logging Strutturato (Priority: 🟡 MEDIUM)

**Antes**: Nada, fallos silenciosos

**Después**:
```typescript
// src/utils/logger.ts
export class Logger {
  debug(msg: string, context?: Record<string, any>): void
  info(msg: string, context?: Record<string, any>): void
  warn(msg: string, context?: Record<string, any>): void
  error(msg: string, err?: Error, context?: Record<string, any>): void
}

// Usage
logger.info("Session created", { sessionId, project })
logger.error("Failed to save memory", err, { sessionId, attempted: 3 })
```

---

### D. Testing (Priority: 🟡 MEDIUM)

```typescript
// tests/plugins/engram/client.test.ts
describe("EngramClient", () => {
  it("retries on transient failures", async () => {
    const client = new EngramClient(config)
    const fetchMock = vi.spyOn(global, "fetch")
      .mockResolvedValueOnce(new Response("", { status: 500 }))
      .mockResolvedValueOnce(new Response(JSON.stringify({ ok: true })))
    
    const result = await client.fetch("/sessions")
    
    expect(result).toEqual({ ok: true })
    expect(fetchMock).toHaveBeenCalledTimes(2)
  })

  it("throws after max retries exceeded", async () => {
    const client = new EngramClient(config)
    vi.spyOn(global, "fetch").mockRejectedValue(new Error("Connection refused"))
    
    await expect(client.fetch("/sessions")).rejects.toThrow()
  })
})
```

---

### E. CLI Tools (Priority: 🟡 MEDIUM)

```bash
# Verify configuration is valid
opencode config verify

# Show what would change
opencode refactor --dry-run

# List installed plugins
opencode plugin list

# Debug engram connection
opencode debug engram --verbose

# View logs from last session
opencode logs --session recent --tail 50
```

---

## 📊 Fases de Ejecución

### **Fase 1: Foundation (1-2 semanas)**
- [ ] Crear estructura src/
- [ ] Zod schemas para config + types
- [ ] Logger util
- [ ] Error handling base

**Output**: `src/core/` y `src/utils/` listos para usar

---

### **Fase 2: Plugin Refactor (2-3 semanas)**
- [ ] Extraer engram.ts en módulos
- [ ] EngramClient con retry
- [ ] SessionManager
- [ ] EventHandler

**Output**: engram plugin funcionando 100% con mejor arquitectura

---

### **Fase 3: Testing (1 semana)**
- [ ] Unit tests para client, session, events
- [ ] Integration tests
- [ ] Fixtures + mocks

**Output**: >80% code coverage

---

### **Fase 4: CLI + Docs (1 semana)**
- [ ] CLI commands
- [ ] ARCHITECTURE.md
- [ ] MIGRATION_GUIDE.md

**Output**: Fácil onboarding para nuevos devs

---

## ✅ Criterios de Éxito

- [ ] Cero fallos silenciosos (todos los errores logeados)
- [ ] TypeScript strict con 0 `any`
- [ ] >80% test coverage
- [ ] Config validada al startup
- [ ] Retry automático para fallos transientes
- [ ] Performance: <100ms overhead por sesión
- [ ] Documentación completa (ARCHITECTURE.md)

---

## 🚀 Próximos Pasos

1. Confirmar esta estrategia contigo
2. Empezar por Fase 1 (foundation)
3. Usar SDD (Spec-Driven Development) para cada módulo
4. Session summaries después de cada fase

¿Vamos?
