# Neovim Configuration: Statick

Esta es la configuración personalizada de Neovim desarrollada por **Diego Medardo Saavedra García**, profesional de TI con más de 8 años de experiencia en desarrollo **Fullstack** y **Educación Superior**. Este entorno está optimizado para la transferencia de conocimiento, la transparencia técnica y el desarrollo profesional.

## 🛠️ Stack Tecnológico y Componentes

| Categoría | Herramienta | Descripción |
| --- | --- | --- |
| **Gestor de Plugins** | [Lazy.nvim](https://github.com/folke/lazy.nvim) | Instalación rápida, gestión de dependencias y carga diferida. |
| **LSP Management** | [Mason.nvim](https://github.com/williamboman/mason.nvim) | Gestión centralizada de servidores LSP, linters y formateadores. |
| **Sintaxis** | [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Resaltado de sintaxis avanzado y análisis de código basado en AST. |
| **Explorador** | [Neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | Navegación de archivos visual y eficiente dentro del editor. |
| **Markdown** | [Render-markdown](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Visualización estética in-editor para documentación técnica. |
| **IA Asistente** | [OpenCode.nvim](https://github.com/NickvanDyke/opencode.nvim) | Asistente de IA para desarrollo, explicación de código y refactorización. |
| **Integración Terminal** | [Tmux.nvim](https://github.com/aserowy/tmux.nvim) | Navegación seamless entre Neovim splits y tmux panes. |

---

## 📂 Estructura del Proyecto

La configuración adopta una arquitectura modular. El punto de entrada `init.lua` delega la carga a módulos específicos ubicados en el directorio `lua/statick/`, asegurando una separación clara entre la configuración base y las extensiones.

A continuación se detalla la estructura exacta del sistema de archivos:

```
~/.config/nvim/
├── init.lua                # Punto de entrada principal: inicializa Lazy.nvim y carga módulos.
├── lazy-lock.json          # Instantánea de versiones exactas de los plugins (garantiza reproducibilidad).
├── Readme.md               # Documentación del proyecto.
└── lua/
    └── statick/            # Namespace principal del usuario.
        ├── core/           # Configuraciones fundamentales de Neovim.
        │   ├── options.lua # Opciones generales (vim.opt).
        │   └── keymaps.lua # Mapeos de teclado globales.
        └── plugins/        # Especificaciones modulares de cada plugin.
            ├── autopairs.lua
            ├── colorscheme.lua
            ├── completions.lua
            ├── git.lua
            ├── lsp.lua     # Configuración crítica de Mason y lspconfig.
            ├── markdown.lua
            ├── neotree.lua
            ├── opencode.lua # Asistente de IA para desarrollo de código.
            ├── telescope.lua
            ├── tmux.lua     # Integración con tmux para terminal workflow.
            └── treesitter.lua

```

*Estructura visual basada en la implementación actual.*

---

## 🚀 Instalación y Requisitos

Para garantizar la veracidad y el correcto funcionamiento del entorno, asegúrese de cumplir con los siguientes requisitos previos:

* **Neovim >= 0.9.0** (Requerido para características modernas de Lua JIT).
* **Git** (Necesario para que Lazy.nvim clone repositorios).
* **Compilador C** (gcc o clang, requerido por Treesitter para compilar parsers).
* **Nerd Font** instalada en su terminal (necesario para los iconos de Neo-tree y línea de estado).

### Pasos de despliegue:

1. **Respaldar configuración existente (si aplica):**
```bash
mv ~/.config/nvim ~/.config/nvim.bak

```


2. **Clonar el repositorio:**
```bash
git clone <URL_DE_TU_REPOSITORIO> ~/.config/nvim

```


3. **Inicialización automática:**
Inicie Neovim (`nvim`). El gestor `Lazy.nvim` detectará la ausencia de plugins y comenzará la instalación y compilación automática de todos los componentes definidos en `lua/statick/plugins/`. Espere a que el proceso finalice.

---

## 📋 Principios de Diseño

* **Transparencia:** Cada plugin tiene su propio archivo de configuración aislado, lo que facilita la auditoría y el ajuste fino sin afectar otras partes del sistema.
* **Precisión Técnica:** La configuración de LSP está ajustada para proporcionar diagnósticos y autocompletado precisos para el stack definido (Lua, Web, Python), evitando configuraciones globales ruidosas.
* **Integración Terminal:** Flujo de trabajo optimizado entre Neovim y tmux para desarrollo eficiente con navegación seamless entre splits y panes.
* **Asistencia IA:** Integración con OpenCode para asistencia inteligente en desarrollo, debugging y refactorización de código.
* **Entorno Educativo:** La claridad del código y la estructura modular están pensadas para servir como ejemplo en entornos de enseñanza universitaria.

---

## 🎯 Plugins Recientes y Funcionalidades

### OpenCode.nvim - Asistente de IA

Integración con OpenCode para asistencia inteligente durante el desarrollo:

**Keymaps principales:**
- `<leader>oA` - Abrir prompt de OpenCode
- `<leader>oa` - Preguntar sobre el código bajo el cursor
- `<leader>ot` - Toggle de ventana de OpenCode
- `<leader>on` - Nueva sesión
- `<leader>oe` - Explicar código en el cursor
- `<leader>od` - Ayuda con debugging en cursor
- `<leader>or` - Refactorizar código en cursor

### Tmux.nvim - Integración Terminal

Navegación seamless entre Neovim y tmux:

**Navegación:**
- `Ctrl+h/j/k/l` - Moverse entre tmux panes y neovim splits
- `Ctrl+Direction Keys` - Redimensionar tmux panes

**Características:**
- Sincronización de clipboard bidireccional
- Navegación cíclica cuando no hay más splits
- Redimensionado de panes desde Neovim

---

## ⚡ Quick Start Keymaps

| Modo | Keymap | Acción |
| --- | --- | --- |
| **Normal** | `<leader>pf` | Buscar archivos (Telescope) |
| **Normal** | `<leader>pv` | Explorador de archivos (Neo-tree) |
| **Normal** | `<leader>oA` | Asistente IA (OpenCode) |
| **Normal** | `Ctrl+h/j/k/l` | Navegación tmux/neovim |
| **Insert** | `C-SPACE` | Autocompletado |
| **Visual** | `<leader>oa` | Preguntar a IA sobre selección |
