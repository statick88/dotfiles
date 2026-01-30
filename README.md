# Statick's Dotfiles 🚀

> 🎯 **NUEVO**: Guía completa de Neovim desde principiante a avanzado → [nvim/README.md](./nvim/README.md)

Configuración personalizada de entorno de desarrollo optimizada para macOS con más de 8 años de experiencia profesional en desarrollo Fullstack y Educación Superior.

**Estado Actual:**
- ✅ Neovim: 0.11.5 con LazyVim v4.0 - Clean Architecture
- ✅ OpenCode.nvim: Integración completa con IA
- ✅ LSP: Configuración optimizada SIN ERRORES NI WARNINGS
- ✅ Tema: Catppuccin (moderno y suave)
- ✅ Arquitectura: Migrada a LazyVim nativo
- ✅ Versión: v4.0 - Configuración 100% estable

---

## 🖥️ **Entorno del Sistema**

**Sistema Operativo:** macOS (Darwin)  
**Arquitectura:** ARM64 (Apple Silicon)  
**Shell:** Zsh con Oh My Zsh  

Este repositorio contiene configuraciones optimizadas específicamente para macOS, aprovechando las características nativas del sistema y las herramientas de desarrollo más modernas.

---

## 📁 **Estructura del Proyecto**

```
~/.config/
├── README.md                    # 📖 Este archivo - descripción general del proyecto
├── AGENTS.md                     # 🤖 Guía para agentes de IA y desarrollo
├── model.md                      # 🏗️ Principios de desarrollo (Clean Architecture, SOLID)
├── nvim/                         # 🎯 Configuración completa de Neovim
│   ├── README.md                 # 📖 GUÍA COMPLETA DESDE PRINCIPIANTE A AVANZADO (RECOMENDADO)
│   ├── NEOVIM_CONFIGURATION.md   # 📖 Documentación técnica detallada de Neovim
│   ├── AGENTS.md                 # 🤖 Guía específica para agentes en Neovim
│   ├── init.lua                  # ⚙️ Punto de entrada principal
│   ├── lua/                      # 📁 Configuración modular
│   │   ├── config/               # Configuración core
│   │   │   ├── lazy.lua          # Bootstrap de Lazy.nvim
│   │   │   ├── options.lua       # Opciones de Neovim
│   │   │   ├── keymaps.lua       # Mapeos de teclas
│   │   │   ├── autocmds.lua      # Autocomandos
│   │   │   ├── copilot-prompts.lua           # Prompts personalizados para Copilot
│   │   │   └── copilot-lsp-integration.lua   # Integración LSP+Copilot
│   │   └── plugins/              # Configuración de plugins
│   │       ├── ui.lua            # Temas e interfaz (TokyoNight, Catppuccin, BufferLine)
│   │       ├── desarrollo.lua    # LSP, formateo, git, testing, debugging
│   │       ├── productividad.lua # Telescope, flash, terminal, markdown
│   │       ├── copilot.lua       # GitHub Copilot autocompletado
│   │       ├── copilot-chat.lua  # Chat avanzado de Copilot
│   │       ├── opencode.lua      # OpenCode.nvim integration
│   │       ├── opencode-model-switcher.lua   # Cambiar modelos AI
│   │       └── render-markdown.lua # Renderizar markdown
├── opencode/                     # 🤖 Configuración de OpenCode AI Assistant
│   ├── package.json              # 📦 Dependencias y plugins
│   └── node_modules/             # 📁 Módulos instalados
├── kitty/                        # 🐱 Configuración del terminal Kitty
├── htop/                         # 📊 Configuración del monitor de recursos
├── karabiner/                    # ⌨️ Configuración de teclado personalizado
└── tmux/                         # 🪟 Configuración del multiplexor de terminal
```

---

## 🚀 **Quick Start - Empezar con Neovim**

### **Si eres Principiante en Vim:**
1. Lee primero: **[nvim/README.md - Conceptos Básicos](./nvim/README.md#conceptos-básicos)**
2. Practica hjkl durante 15 minutos
3. Aprende modos: Normal, Insert, Visual
4. Continúa con la sección de [Movimiento y Navegación](./nvim/README.md#movimiento-y-navegación)

### **Si ya conoces Vim:**
1. Consulta [Quick Reference - Atajos Más Usados](./nvim/README.md#quick-reference---atajos-más-usados)
2. Explora secciones específicas según necesites
3. Usa [Flujo de Trabajo Recomendado](./nvim/README.md#flujo-de-trabajo-recomendado) para tu caso

### **Si vienes de otro editor:**
1. Lee [Por qué Vim motions son poderosos](./nvim/README.md#conceptos-básicos)
2. Sigue [Movimiento y Navegación](./nvim/README.md#movimiento-y-navegación)
3. Aprende [Edición de Texto](./nvim/README.md#edición-de-texto)
4. Domina plugins: [Plugins Avanzados](./nvim/README.md#plugins-avanzados)

---

## 🎓 **Guía Completa de Neovim**

**La guía más completa y práctica disponible:**

📖 **[nvim/README.md - De Principiante a Avanzado](./nvim/README.md)**

Incluye:
- ✅ **Conceptos Básicos**: Modos de Vim, hjkl, y por qué es poderoso
- ✅ **Navegación Completa**: hjkl, palabras, líneas, búsqueda global, Flash.nvim
- ✅ **Edición de Texto**: Insert, Delete, Change, Copy/Paste, Undo/Redo
- ✅ **Búsqueda Avanzada**: Telescope (fuzzy finder), búsqueda básica, reemplazo
- ✅ **Gestión de Buffers**: Bufferline, ventanas, splits, terminal integrado
- ✅ **Plugins Avanzados**: 
  - LSP (Go-to-Definition, References, Rename, Code Actions)
  - Mason (gestor de servidores)
  - Treesitter (sintaxis mejorada)
  - Git (Fugitive + Gitsigns)
  - Formatting automático
  - Debugging (DAP)
  - Testing (Neotest)
  - Markdown Preview y Render
- ✅ **AI & Copilot**:
  - GitHub Copilot (autocompletado)
  - Copilot Chat (conversaciones)
  - OpenCode (asistente avanzado)
  - Cambiar modelos IA
- ✅ **Git Integration**: Status, commit, push, blame, diff
- ✅ **Testing & Debugging**: Paso a paso con breakpoints
- ✅ **Tips & Tricks**: Marks, macros, text objects, registers, sessions
- ✅ **Flujos de Trabajo**: Frontend, Backend, Documentación
- ✅ **Solución de Problemas**: Errores comunes y cómo arreglarse
- ✅ **Quick Reference**: Tabla de atajos más usados

---

### **🎯 Neovim Configuration - El Componente Principal**

La configuración de **Neovim** es el corazón de estos dotfiles, basada en LazyVim con integración completa de OpenCode.nvim.

**📋 Características Principales:**
- 🔍 **Telescope.nvim** - Búsqueda fuzzy potente
- 🌳 **Treesitter** - Resaltado sintáctico avanzado
- 🤖 **OpenCode.nvim** - Asistente de IA con Clean Architecture
- 🪟 **Tmux.nvim** - Integración seamless con terminal
- 🔧 **LSP completo** - Soporte para múltiples lenguajes
- 📝 **Git integrado** - Control de versiones desde editor
- 🎨 **Markdown avanzado** - Renderizado automático y preview
- 🧪 **Testing integrado** - Neotest con múltiples frameworks

**📖 Documentación Completa:**
→ [nvim/NEOVIM_CONFIGURATION.md](./nvim/NEOVIM_CONFIGURATION.md) - Guía completa para principiantes y uso avanzado

### **🤖 OpenCode AI Assistant - Clean Architecture**

Configuración avanzada basada en principios de Clean Architecture y filosofía Gentleman Programming:

**📋 Características Principales:**
- 🤖 **4 Agentes Especializados**: Sisyphus (orquestador), Oracle (Clean Architecture), Librarian (IEEE/ACM), Frontend (UI/UX)
- 🏗️ **Clean Architecture Completa**: Separación de preocupaciones, SOLID, patrones de diseño
- 🧪 **TDD y Testing de Comportamientos**: Red-Green-Refactor, pruebas contractuales
- 🎨 **Statick Matrix Theme**: Visual profesional con identidad Statick
- 👤 **Autoridad de Statick**: Control final con sistema de aprobación
- 📋 **Templates Académicos**: Technical Docs, Presentations, Educational Materials
- 🔄 **Workflow Profesional**: Robot analiza → Statick decide → Robot implementa

---

## 🛠️ **Herramientas y Tecnologías**

| Componente | Herramienta | Versión Recomendada | Uso Principal |
|---|---|---|---|
| **Editor** | Neovim | ≥0.9.0 | Entorno de desarrollo principal |
| **Asistente IA** | OpenCode + Clean Architecture | ≥1.0.212 | IA con principios SOLID y Gentleman Programming |
| **Terminal** | Kitty / Ghostty | Latest | Terminal moderna con GPU acceleration |
| **Multiplexor** | Tmux | ≥3.2 | Gestión de sesiones y paneles |
| **Docker UI** | Lazydocker | Latest | Interfaz TUI para Docker |
| **Publicación** | Quarto | Latest | Documentos científicos y notebooks |
| **Shell** | Zsh + Oh My Zsh | Latest | Entorno de línea de comandos |
| **Monitor** | htop | Latest | Monitor de recursos del sistema |

---

## ⚡ **Instalación**

### **Requisitos Previos:**
- macOS 12.0 (Monterey) o superior
- [Homebrew](https://brew.sh/) instalado
- Git configurado con credenciales SSH
- OpenCode API key (opcional)

### **Instalación Completa:**
```bash
# 1. Clonar el repositorio
git clone git@github.com:statick88/dotfiles.git ~/.config

# 2. Instalar herramientas principales con Homebrew
brew install neovim tmux kitty htop quarto lazydocker

# 3. Instalar OpenCode con Clean Architecture
curl -fsSL https://opencode.ai/install.sh | bash

# 4. Configurar API key de OpenCode (opcional)
export ANTHROPIC_API_KEY="tu-api-key-aquí"
echo 'export ANTHROPIC_API_KEY="tu-api-key-aquí"' >> ~/.zshrc

# 5. Configurar Zsh
echo 'export EDITOR=nvim' >> ~/.zshrc
source ~/.zshrc

# 6. Iniciar Neovim (instalación automática de plugins)
nvim
```

---

## 🎮 **Guía Completa de Neovim**

> ⚠️ **GUÍA DETALLADA DISPONIBLE**: Esta es una introducción rápida. Para una guía completa de **principiante a avanzado**, con ejemplos prácticos y flujos de trabajo, consulta:

### 📖 **[→ nvim/README.md - Guía Completa desde hjkl hasta Plugins Avanzados](./nvim/README.md)**

Esta guía cubre:
- ✅ Conceptos básicos y modos de Vim
- ✅ Movimiento con hjkl y avanzados
- ✅ Edición de texto y transformaciones
- ✅ Búsqueda con Telescope y Flash
- ✅ Gestión de buffers y ventanas
- ✅ LSP completo con Go-to-Definition, References, Refactoring
- ✅ Git integration con Fugitive y Gitsigns
- ✅ Copilot Chat y OpenCode AI
- ✅ Testing y Debugging
- ✅ Markdown avanzado con renderizado
- ✅ Tips, tricks y flujos de trabajo recomendados
- ✅ Quick reference de atajos más usados

---

### **Navegación Esencial (Resumen)**
| Tecla | Movimiento | Descripción |
|-------|------------|-------------|
| `h` | ← | Izquierda |
| `j` | ↓ | Abajo |
| `k` | ↑ | Arriba |
| `l` | → | Derecha |
| `w` | → | Siguiente palabra |
| `b` | ← | Palabra anterior |
| `s` | Flash Jump | Saltar a cualquier lugar (2-3 teclas) |
| `<leader>ff` | Telescope | Buscar archivos |

### **Comandos Fundamentales (Resumen)**
| Comando | Acción |
|---------|--------|
| `:w` | Guardar archivo |
| `:q` | Salir |
| `:wq` | Guardar y salir |
| `i` | Modo inserción |
| `ESC` | Modo normal |
| `dd` | Eliminar línea |
| `yy` | Copiar línea |

### **Atajos Principales (Resumen)**
| Atajo | Acción |
|-------|--------|
| `<leader>ff` | Buscar archivos (Telescope) |
| `<leader>fg` | Buscar en contenido (Live Grep) |
| `<leader>gd` | Ir a definición (LSP) |
| `<leader>rn` | Renombrar símbolo (LSP) |
| `<leader>ca` | Code actions automáticas |
| `<leader>cc` | Copilot Chat |
| `<leader>oa` | Preguntar a OpenCode |
| `<leader>oe` | Explicar código |
| `<leader>fm` | Formatear archivo |

---

## 🤖 **Integración con OpenCode.nvim**

OpenCode.nvim proporciona asistencia con IA directamente en Neovim:

### **Atajos Principales**
| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `<leader>oa` | Ask | Preguntar a OpenCode con contexto actual |
| `<leader>os` | Select | Seleccionar acción de OpenCode desde menú |
| `<leader>ot` | Toggle | Alternar sesión de OpenCode |
| `<leader>oe` | Explain | Explicar código seleccionado |
| `<leader>of` | Fix | Corregir diagnósticos/errores |
| `<leader>op` | Test | Agregar pruebas |

### **Ejemplos de Uso**
1. **Explicar código:** Selecciona código + `<leader>oe`
2. **Corregir errores:** Posiciona en error + `<leader>of`
3. **Agregar pruebas:** Selecciona función + `<leader>op`
4. **Preguntar:** `<leader>oa` + escribe pregunta

---

## 📝 **Markdown Avanzado**

Esta configuración incluye herramientas avanzadas para edición de Markdown:

### **Características Principales**
- ✅ **Renderizado automático** en Neovim
- 🌐 **Preview en navegador** en tiempo real
- 🧠 **LSP inteligente** (Marksman) para enlaces y referencias
- 📊 **Diagramas Mermaid** renderizados
- 🔧 **Formateo automático** con Prettier

### **Atajos Markdown**
| Atajo | Acción |
|-------|--------|
| `<leader>mr` | Toggle render markdown |
| `<leader>mp` | Preview en navegador |
| `<leader>fm` | Formatear archivo |

---

## 📚 **Documentación por Componente**

- 📖 **[Guía Completa de Neovim](./nvim/README.md)** - **RECOMENDADO**: Desde principiante (hjkl) hasta uso avanzado (plugins, AI, debugging)
  - ✅ Conceptos básicos y modos
  - ✅ Navegación con hjkl y movimientos avanzados
  - ✅ Edición, búsqueda y reemplazo
  - ✅ Telescopenavegación avanzada
  - ✅ LSP completo (Go-to-Definition, References, Refactoring)
  - ✅ Copilot Chat y OpenCode
  - ✅ Git Integration
  - ✅ Testing y Debugging
  - ✅ Tips, tricks y flujos de trabajo

- 🎯 **[Configuración de Neovim](./nvim/NEOVIM_CONFIGURATION.md)** - Documentación técnica detallada
- 📸 **[Snapshot de Configuración](./nvim/CONFIGURATION_SNAPSHOT.md)** - Vista detallada del estado actual
- 🤖 **[Configuración de OpenCode](./opencode/)** - Asistente IA con principios SOLID
- 🐱 **[Configuración de Kitty](./kitty/)** - Terminal moderna y eficiente
- 🪟 **[Configuración de Tmux](./tmux/)** - Multiplexor de terminal potente
- 📊 **[Configuración de htop](./htop/)** - Monitorización de recursos

---

## 🤝 **Filosofía de Desarrollo**

Estos dotfiles están diseñados siguiendo principios de Clean Architecture y Gentleman Programming:

- **🏗️ Clean Architecture** - Separación de preocupaciones, SOLID, patrones de diseño modernos
- **🧪 TDD y Testing de Comportamientos** - Tests primero, cobertura completa, métricas objetivas
- **🎓 Educación Transferible** - Cada configuración está documentada para facilitar el aprendizaje
- **🔧 Productividad Optimizada** - Flujo de trabajo eficiente con IA asistente
- **📐 Estandarización Profesional** - IEEE/ACM compliance, principios SOLID
- **🔄 Actualización Constante** - Incorporación de nuevas herramientas y mejores prácticas

---

## 🔧 **Mantenimiento**

### **Actualizar Neovim**
```vim
:Lazy update    # Actualizar todos los plugins
:Lazy clean     # Limpiar plugins no usados
:checkhealth    # Verificar salud de la configuración
```

### **Formatear Código**
```bash
# Formatear todos los archivos Lua
stylua .

# Verificar formato sin cambiar
stylua --check .
```

---

## 📄 **Licencia**

Este proyecto está bajo licencia MIT. Siéntete libre de usar, modificar y distribuir estas configuraciones según tus necesidades.

---

## 🤵 **Contacto**

**Desarrollado por:** Statick Medardo Saavedra García  
**Experiencia:** 8+ años en Desarrollo Fullstack y Educación Superior  
**Especialización:** DevOps, Backend Development, Technical Education

---

*Para explorar cualquier componente específico, navega a los subdirectorios correspondientes donde encontrarás configuración detallada y documentación específica.*