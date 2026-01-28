# Statick's Dotfiles 🚀

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
│   ├── NEOVIM_CONFIGURATION.md   # 📖 Documentación detallada de Neovim
│   ├── AGENTS.md                 # 🤖 Guía específica para agentes en Neovim
│   ├── init.lua                  # ⚙️ Punto de entrada principal
│   ├── lua/                      # 📁 Configuración modular
│   │   ├── config/               # Configuración core
│   │   │   ├── lazy.lua          # Bootstrap de Lazy.nvim
│   │   │   ├── options.lua       # Opciones de Neovim
│   │   │   ├── keymaps.lua       # Mapeos de teclas
│   │   │   └── autocmds.lua      # Autocomandos
│   │   └── plugins/              # Configuración de plugins
│   │       ├── desarrollo.lua    # LSP, formateo, git, testing
│   │       ├── productividad.lua # Telescope, flash, completion
│   │       ├── ui.lua            # Temas e interfaz
│   │       ├── opencode.lua      # OpenCode.nvim
│   │       └── render-markdown.lua # Markdown avanzado
├── opencode/                     # 🤖 Configuración de OpenCode AI Assistant
│   ├── package.json              # 📦 Dependencias y plugins
│   └── node_modules/             # 📁 Módulos instalados
├── kitty/                        # 🐱 Configuración del terminal Kitty
├── htop/                         # 📊 Configuración del monitor de recursos
├── karabiner/                    # ⌨️ Configuración de teclado personalizado
└── tmux/                         # 🪟 Configuración del multiplexor de terminal
```

---

## 🎯 **Componentes Principales**

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

## 🎮 **Guía Rápida de Neovim**

### **Navegación Esencial**
| Tecla | Movimiento | Descripción |
|-------|------------|-------------|
| `h` | ← | Izquierda |
| `j` | ↓ | Abajo |
| `k` | ↑ | Arriba |
| `l` | → | Derecha |
| `w` | → | Siguiente palabra |
| `b` | ← | Palabra anterior |

### **Comandos Fundamentales**
| Comando | Acción |
|---------|--------|
| `:w` | Guardar archivo |
| `:q` | Salir |
| `:wq` | Guardar y salir |
| `i` | Modo inserción |
| `ESC` | Modo normal |
| `dd` | Eliminar línea |
| `yy` | Copiar línea |

### **Atajos Principales**
| Atajo | Acción |
|-------|--------|
| `<leader>ff` | Buscar archivos |
| `<leader>fg` | Buscar en contenido |
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

- 🎯 **[Configuración de Neovim](./nvim/NEOVIM_CONFIGURATION.md)** - Documentación completa y guías
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