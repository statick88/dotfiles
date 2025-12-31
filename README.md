# Statick's Dotfiles 🚀

Configuración personalizada de entorno de desarrollo optimizada para macOS con más de 8 años de experiencia profesional en desarrollo Fullstack y Educación Superior.

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
├── README.md              # Este archivo - descripción general del proyecto
├── nvim/                 # 🎯 Configuración completa de Neovim
│   ├── Readme.md         # 📖 Documentación detallada para principiantes
│   ├── init.lua          # ⚙️ Punto de entrada principal
│   └── lua/             # 📁 Configuración modular de plugins
├── opencode/             # 🤖 Configuración de OpenCode AI Assistant
│   ├── README.md         # 📖 Documentación específica de OpenCode
│   ├── package.json      # 📦 Dependencias y plugins
│   └── node_modules/    # 📁 Módulos instalados
├── kitty/                # 🐱 Configuración del terminal Kitty
├── ghostty/              # 👻 Configuración del terminal Ghostty  
├── htop/                # 📊 Configuración del monitor de recursos
└── tmux/                # 🪟 Configuración del multiplexor de terminal
```

---

## 🎯 **Subproyectos Principales**

### **🤖 OpenCode AI Assistant - Clean Architecture**
Configuración avanzada basada en principios de Clean Architecture y filosofía Gentleman Programming:

**📋 Características Principales:**
-   🤖 **4 Agentes Especializados**: Sisyphus (orquestador), Oracle (Clean Architecture), Librarian (IEEE/ACM), Frontend (UI/UX)
-   🏗️ **Clean Architecture Completa**: Separación de preocupaciones, SOLID, patrones de diseño
-   🧪 **TDD y Testing de Comportamientos**: Red-Green-Refactor, pruebas contractuales
-   🎨 **Gentleman Matrix Theme**: Visual profesional con identidad Diego + Robot
-   👤 **Autoridad de Diego**: Control final con sistema de aprobación
-   📋 **Templates Académicos**: Technical Docs, Presentations, Educational Materials
-   🔄 **Workflow Profesional**: Robot analiza → Diego decide → Robot implementa

### **Neovim Configuration**
El componente principal y más completo de estos dotfiles es la configuración de **Neovim**.
**📋 Características Principales:**

-   🔍 **Telescope.nvim** - Búsqueda fuzzy potente
-   🌳 **Treesitter** - Resaltado sintáctico avanzado
-   🔬 **Quarto.nvim** - Integración para documentos científicos
-   🤖 **OpenCode.nvim** - Asistente de IA con Clean Architecture
-   🪟 **Tmux.nvim** - Integración seamless con terminal
-   🔧 **LSP completo** - Soporte para múltiples lenguajes
-   📝 **Git integrado** - Control de versiones desde editor

**📖 Documentación Completa:**
→ [nvim/Readme.md](./nvim/Readme.md) - Guía completa para principiantes y uso avanzado

**🚀 Inicio Rápido:**
```bash
# Clonar configuración de Neovim
git clone https://github.com/statick88/dotfiles.git ~/.config/nvim

# Iniciar Neovim (instalación automática de plugins)
nvim
```

---

## 🛠️ **Herramientas y Tecnologías**

| Componente | Herramienta | Versión Recomendada | Uso Principal |
|---|---|---|---|
| **Editor** | Neovim | ≥0.9.0 | Entorno de desarrollo principal |
| **Asistente IA Arquitectónico** | OpenCode + Clean Architecture | ≥1.0.212 | IA con principios SOLID y Gentleman Programming |
| **Terminal** | Kitty / Ghostty | Latest | Terminal moderna con GPU acceleration |
| **Multiplexor** | Tmux | ≥3.2 | Gestión de sesiones y paneles |
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
brew install neovim tmux kitty htop quarto

# 3. Instalar Quarto para documentos científicos
# Usando cask para instalación GUI
brew install --cask quarto

# 4. Instalar OpenCode con Clean Architecture
# Instalar con soporte para desarrollo guiado por principios SOLID
curl -fsSL https://opencode.ai/install.sh | bash

# 5. Configurar API key de OpenCode (opcional)
export ANTHROPIC_API_KEY="tu-api-key-aquí"
echo 'export ANTHROPIC_API_KEY="tu-api-key-aquí"' >> ~/.zshrc

# 6. Configurar Zsh (si aplica)
echo 'export EDITOR=nvim' >> ~/.zshrc
source ~/.zshrc
```

---

## 📚 **Documentación por Componente**

- 🤖 **[Configuración de OpenCode + Clean Architecture](./opencode/README.md)** - Asistente IA con principios SOLID y Gentleman Programming
- 🎯 **[Configuración de Neovim](./nvim/Readme.md)** - Documentación completa y guías
- 🤖 **[Configuración de OpenCode + Clean Architecture](./opencode/README.md)** - Asistente IA con principios SOLID y Gentleman Programming
- 🔬 **[Configuración de Quarto](./nvim/Readme.md#-instalación-y-configuración-de-quarto)** - Documentos científicos y notebooks
- 🐱 **[Configuración de Kitty](./kitty/README.md)** - Terminal moderna y eficiente
- 👻 **Configuración de Ghostty** - Terminal alternativa de alto rendimiento  
- 🪟 **Configuración de Tmux** - Multiplexor de terminal potente
- 📊 **Configuración de htop** - Monitorización de recursos del sistema

---

## 🤝 **Contribución y Filosofía**

Estos dotfiles están diseñados siguiendo principios de Clean Architecture y Gentleman Programming:

- **🏗️ Clean Architecture** - Separación de preocupaciones, SOLID, patrones de diseño modernos
- **🧪 TDD y Testing de Comportamientos** - Tests primero, cobertura completa, métricas objetivas
- **🎓 Educación Transferible** - Cada configuración está documentada para facilitar el aprendizaje
- **🔧 Productividad Optimizada** - Flujo de trabajo eficiente con IA asistente
- **📐 Estandarización Profesional** - IEEE/ACM compliance, principios SOLID
- **🔄 Actualización Constante** - Incorporación de nuevas herramientas y mejores prácticas

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