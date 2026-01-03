# Neovim Configuration: Statick 🚀

Configuración personalizada de Neovim desarrollada por **Statick Medardo Saavedra García**, profesional de TI con más de 8 años de experiencia en desarrollo **Fullstack** y **Educación Superior**.

---

## 📋 Tabla de Contenidos

- [🎯 Guía Rápida](#-guía-rápida)
- [🛠️ Stack Tecnológico](#-stack-tecnológico)
- [⌨️ Atajos de Teclado](#-atajos-de-teclado)
- [🤖 Gentleman Guardian Angel (GGA)](#-gentleman-guardian-angel-gga)
- [📁 Estructura del Proyecto](#-estructura-del-proyecto)
- [🚀 Instalación](#-instalación)
- [🔧 Solución de Problemas](#-solución-de-problemas)

---

## 🎯 Guía Rápida

### Modos de Neovim

| Modo | Tecla | Descripción |
|------|-------|-------------|
| Normal | `Esc` | Navegar y ejecutar comandos |
| Insert | `i` | Escribir texto |
| Visual | `v` | Seleccionar texto |
| Command | `:` | Ejecutar comandos |

### Comandos Esenciales

| Comando | Acción |
|---------|--------|
| `:w` | Guardar |
| `:q` | Salir |
| `:wq` | Guardar y salir |
| `:q!` | Salir sin guardar |
| `u` | Deshacer |
| `Ctrl+r` | Rehacer |

### Navegación Basic

| Tecla | Acción |
|-------|--------|
| `h/j/k/l` | Izquierda/Abajo/Arriba/Derecha |
| `w` | Siguiente palabra |
| `b` | Palabra anterior |
| `dd` | Borrar línea |
| `yy` | Copiar línea |
| `p` | Pegar |

---

## 🛠️ Stack Tecnológico

### Core

| Herramienta | Descripción |
|-------------|-------------|
| [Lazy.nvim](https://github.com/folke/lazy.nvim) | Gestor de plugins moderno |
| [Which-key.nvim](https://github.com/folke/which-key.nvim) | Menú visual de atajos |
| [Catppuccin](https://github.com/catppuccin/nvim) | Tema visual moderno |
| [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Resaltado de sintaxis avanzado |

### Desarrollo

| Herramienta | Descripción |
|-------------|-------------|
| [Mason.nvim](https://github.com/williamboman/mason.nvim) | Gestión de servidores LSP |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Configuración LSP |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletado |
| [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Búsqueda inteligente |

### Herramientas Especializadas

| Herramienta | Descripción |
|-------------|-------------|
| [Neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | Explorador de archivos |
| [Quarto.nvim](https://github.com/quarto-dev/quarto-nvim) | Documentos científicos |
| [Gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Integración Git |
| [Tmux.nvim](https://github.com/aserowy/tmux.nvim) | Integración tmux |
| [Diffview.nvim](https://github.com/sindrets/diffview.nvim) | Visualización de diffs |
| [Git-conflict.nvim](https://github.com/akinsho/git-conflict.nvim) | Resolver conflictos |
| [Excalidraw.nvim](https://github.com/CRAG666/excalidraw.nvim) | Diagramas visuales |
| [Flash.nvim](https://github.com/folke/flash.nvim) | Navegación rápida |
| [Trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnósticos y errores |
| [GGA](https://github.com/Gentleman-Programming/gentleman-guardian-angel) | Revisión de código con IA |

---

## ⌨️ Atajos de Teclado

### Atajos Principales

| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `<leader>` | Menú | Mostrar todos los atajos |
| `<leader>e` | Neo-tree | Abrir/cerrar explorador |
| `<leader>ff` | Telescope | Buscar archivos |
| `<leader>fg` | Telescope | Buscar texto |
| `<leader>fb` | Telescope | Buscar buffers |
| `<leader>fh` | Telescope | Buscar ayuda |
| `gd` | LSP | Ir a definición |
| `gr` | LSP | Buscar referencias |
| `K` | LSP | Ver documentación |
| `]d` / `[d` | LSP | Siguiente/anterior diagnóstico |

### Navegación

| Atajo | Acción |
|-------|--------|
| `s` | Flash (navegación rápida) |
| `S` | Flash Treesitter |
| `Ctrl+h/j/k/l` | Navegar tmux |

### Git

| Atajo | Acción |
|-------|--------|
| `<leader>gg` | LazyGit |
| `<leader>gvo` | Diffview Open |
| `<leader>gvc` | Diffview Close |
| `]c` / `[c` | Siguiente/anterior hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |

### Quarto (`.qmd`)

| Atajo | Acción |
|-------|--------|
| `]b` / `[b` | Navegar celdas |
| `<localleader>rc` | Ejecutar celda |
| `<localleader>rA` | Ejecutar todas |
| `<localleader>pp` | Previsualizar |

### Flutter

| Atajo | Acción |
|-------|--------|
| `<leader>F` | Run Flutter |
| `<leader>D` | Devices |
| `<leader>R` | Hot Reload |
| `<leader>H` | Hot Restart |

### Python

| Atajo | Acción |
|-------|--------|
| `<leader>vs` | Select Virtual Env |
| `<leader>nd` | Generate Docstring |

### Testing

| Atajo | Acción |
|-------|--------|
| `<leader>tn` | Test nearest |
| `<leader>tf` | Test file |
| `<leader>ts` | Test suite |

---

## 🤖 Gentleman Guardian Angel (GGA)

**Revisión de código con IA** - Enforces tus estándares de código automáticamente.

### ¿Qué es GGA?

GGA es una herramienta CLI que revisa tu código usando cualquier IA (Claude, Gemini, Ollama, etc.) antes de cada commit. Funciona como un "revisor de código senior" automático.

```
┌─────────────────┐     ┌──────────────┐     ┌─────────────────┐
│   git commit    │ ──▶ │  AI Review   │ ──▶ │  ✅ Pass/Fail   │
│  (staged files) │     │  (any LLM)   │     │  (with details) │
└─────────────────┘     └──────────────┘     └─────────────────┘
```

### Instalación de GGA (ya instalado en el sistema)

```bash
# Verificar instalación
gga version
# Output: gga v2.6.1

# Ver estado actual
gga config
```

**Proveedores disponibles en tu sistema:**

| Proveedor | Estado | Comando |
|-----------|--------|---------|
| Claude | ❌ No instalado | `npm install -g @anthropic-ai/claude-code` |
| Gemini | ❌ No instalado | `brew install google-gemini/gemini/gemini-cli` |
| Ollama | ✅ Instalado | `ollama run <model>` |
| OpenCode | ❌ No instalado | `opencode.ai` |

### Modelos Ollama disponibles

```bash
ollama list
# NAME            ID              SIZE      MODIFIED     
# gemma3:4b       a2af6cc3eb7f    3.3 GB    4 hours ago     
# gpt-oss:20b     17052f91a42e    13 GB    14 hours ago    
```

### Configuración de GGA en tu proyecto

```bash
# 1. Ir a tu proyecto
cd ~/tu-proyecto

# 2. Inicializar configuración
gga init

# 3. Editar .gga para usar Ollama
cat > .gga << 'EOF'
PROVIDER="ollama:gemma3:4b"
FILE_PATTERNS="*.ts,*.tsx,*.js,*.jsx,*.py,*.go,*.lua"
EXCLUDE_PATTERNS="*.test.ts,*.spec.ts,*.d.ts,node_modules/*"
RULES_FILE="AGENTS.md"
STRICT_MODE="true"
EOF

# 4. Crear archivo de reglas
touch AGENTS.md
```

### Archivo AGENTS.md (Ejemplo)

```markdown
# Reglas de Revisión de Código

## TypeScript/TypeScript
REJECT if:
- `any` type sin justificación
- Missing return types en funciones públicas
- `import * as React` → usar `import { useState }`

PREFER:
- Named exports sobre default exports
- Funciones pequeñas con una sola responsabilidad

## General
REJECT if:
- `console.log` en producción
- `console.error` sin manejo de errores

## Python
REQUIRE:
- Type hints en funciones públicas
- Docstrings en clases/métodos públicos

REJECT if:
- Bare `except:` sin excepción específica
- `print()` en lugar de logger
```

### Comandos GGA

| Comando | Descripción |
|---------|-------------|
| `gga init` | Crear archivo `.gga` de ejemplo |
| `gga install` | Instalar pre-commit hook |
| `gga uninstall` | Remover hook de git |
| `gga run` | Revisar archivos staged |
| `gga run --ci` | Revisar último commit (para CI) |
| `gga run --no-cache` | Forzar revisión sin caché |
| `gga config` | Mostrar configuración actual |
| `gga cache status` | Ver estado del caché |
| `gga cache clear` | Limpiar caché del proyecto |

### Integración con Neovim

```bash
# 1. Instalar el hook en tu proyecto
cd ~/.config/nvim
gga init
gga install

# 2. Probar revisión
echo "console.log('test')" > test.lua
git add test.lua
gga run

# 3. Ver resultado
# STATUS: FAILED - console.log en código
```

### Integración con Git

```bash
# Hook pre-commit automático
gga install

# Ahora cada commit será revisado:
git add archivo.ts
git commit -m "feat: nuevo feature"
# → GGA revisa automáticamente
# → Si falla, el commit se bloquea
```

### Bypasear revisión (emergencias)

```bash
# Saltar el hook de pre-commit
git commit --no-verify -m "wip: emergency fix"
# o
git commit -n -m "hotfix"
```

### Integración con Neovim (Práctica)

```vim
" En lua/statick/core/keymaps.lua
" Revisar archivo actual con GGA
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.keymap.set("n", "<leader>ar", function()
      local handle = io.popen("gga run --no-cache 2>&1")
      local result = handle:read("*a")
      handle:close()
      vim.notify(result, vim.log.levels.INFO)
    end, { desc = "GGA: Review current file" })
  end,
})
```

---

## 📁 Estructura del Proyecto

```
~/.config/nvim/
├── init.lua                    # Punto de entrada
├── lazy-lock.json              # Versiones de plugins
└── lua/
    └── statick/
        ├── core/
        │   ├── options.lua     # Opciones de Neovim
        │   └── keymaps.lua     # Atajos de teclado
        └── plugins/
            ├── autopairs.lua   # Pares automáticos
            ├── colorscheme.lua # Tema visual
            ├── completions.lua # Autocompletado
            ├── excalidraw.lua  # Diagramas
            ├── flutter-dev.lua # Flutter (configuración mínima)
            ├── git.lua         # Git integration (gitsigns, lazygit, diffview, conflict, blamer)
            ├── gga.lua         # GGA - AI Code Review
            ├── help.lua        # Which-key
            ├── lsp.lua         # LSP servers (lua_ls, ts_ls, pyright, html, cssls, tailwindcss, dartls)
            ├── markdown.lua    # Markdown render
            ├── neotree.lua     # Explorador
            ├── opencode.lua    # Clean Architecture Assistant (deshabilitado)
            ├── productivity.lua
            ├── python-dev.lua
            ├── quarto.lua      # Quarto
            ├── telescope.lua   # Búsqueda
            ├── testing.lua     # Testing
            ├── tmux.lua        # Tmux
            ├── treesitter.lua  # Syntax
            ├── web-dev.lua     # Web dev
            └── ...             # Más plugins especializados
```

---

## 🚀 Instalación

### Requisitos Previos

- **Neovim >= 0.9.0**
- **Git**
- **Nerd Font** (para iconos)
- **Tmux** (opcional, para integración)

### Instalación

```bash
# 1. Respaldar configuración anterior
mv ~/.config/nvim ~/.config/nvim.bak

# 2. Clonar esta configuración
git clone <URL> ~/.config/nvim

# 3. Abrir Neovim (Lazy instalará plugins automáticamente)
nvim

# 4. Instalar servidores LSP (dentro de nvim)
:LspInstall lua_ls ts_ls pyright html cssls tailwindcss dartls
```

### Instalar GGA (si no está instalado)

```bash
# Con Homebrew (recomendado)
brew install gentleman-programming/tap/gga

# Verificar
gga version
# Output: gga v2.6.1
```

### Actualizar Plugins

```bash
# Dentro de nvim
:Lazy
# O en terminal
nvim +Lazy sync
```

---

## 📝 Tutorial de Uso

### Día 1: Primeros Pasos

1. **Abrir Neovim**
   ```bash
   nvim
   ```

2. **Explorar el menú de atajos**
   - Presiona `<leader>` (Espacio)
   - Verás todas las categorías de atajos

3. **Abrir un archivo**
   ```bash
   nvim archivo.py
   ```

4. **Guardar y salir**
   - Modo Normal: `:wq` + Enter

### Día 2: Navegación y Búsqueda

1. **Buscar archivos (`<leader>ff`)**
   - Presiona `<leader>ff`
   - Escribe parte del nombre
   - Enter para abrir

2. **Buscar texto (`<leader>fg`)**
   - Presiona `<leader>fg`
   - Escribe el texto a buscar
   - Enter para ver resultados

3. **Explorador de archivos (`<leader>e`)**
   - Presiona `<leader>e`
   - Navega con las flechas
   - `a` para crear archivo
   - `d` para borrar

### Día 3: LSP y Autocompletado

1. **Ir a definición (`gd`)**
   - Colócate sobre una función
   - Presiona `gd`
   - Neovim saltará a la definición

2. **Ver documentación (`K`)**
   - Colócate sobre una función
   - Presiona `K`
   - Verás la documentación

3. **Renombrar símbolo (`<leader>rn`)**
   - Colócate sobre una variable
   - Presiona `<leader>rn`
   - Escribe el nuevo nombre

### Día 4: Git Integration

1. **Abrir LazyGit (`<leader>gg`)**
   - Presiona `<leader>gg`
   - Interfaz visual de Git

2. **Ver diffs (`<leader>gvo`)**
   - Presiona `<leader>gvo`
   - Visualiza cambios lado a lado

3. **Navegar cambios (`]c` / `[c`)**
   - `]c` → siguiente cambio
   - `[c` → cambio anterior

### Día 5: GGA - Revisión de Código con IA

1. **Configurar GGA en tu proyecto**
   ```bash
   cd ~/tu-proyecto
   gga init
   ```

2. **Crear reglas de código (`AGENTS.md`)**
   ```markdown
   # AGENTS.md
   REJECT if:
   - `any` type en TypeScript
   - `console.log` en producción
   ```

3. **Instalar hook**
   ```bash
   gga install
   ```

4. **Probar con un commit**
   ```bash
   git add .
   git commit -m "feat: nuevo"
   # GGA revisará automáticamente
   ```

---

## 🔧 Solución de Problemas

### "No funciona autocompletado"

```bash
:LspInfo          # Verificar LSP activo
:LspRestart       # Reiniciar LSP
```

### "No se ven los colores"

```bash
:TSInstallInfo    # Ver parsers instalados
:TSInstall python # Instalar parser de Python
```

### "Which-key no aparece"

```bash
:Lazy             # Verificar instalación
# Presionar <leader> lentamente
```

### "Tmux navigation no funciona"

```bash
# Verificar que estás en tmux
tmux ls

# Verificar plugin cargado
:checkhealth tmux
```

### Error de LSP

```bash
# Verificar servidores instalados
:Mason

# Instalar servidor faltante
:LspInstall <nombre>
```

### GGA no funciona

```bash
# Verificar instalación
which gga
gga version

# Verificar proveedor
gga config

# Probar manualmente
gga run
```

---

## 🔄 Cambios Recientes

### v3.1 - Enero 2026

- ✅ LSP actualizado con capacidades de cmp-nvim-lsp
- ✅ Git plugins ampliados: Diffview, Git-conflict, Blamer, Dockerfile
- ✅ Lazygit configurado con Telescope integration
- ✅ Eliminados plugins no usados: matrix.lua, git-docker.lua, flutter-dev.lua
- ✅ Nuevos plugins: Excalidraw, GGA (configurado)
- ✅ Productividad: Flash, Trouble, Neogen integrados

### v3.0 - Enero 2026

- ✅ Migrado a `vim.lsp.config()` (nueva API LSP)
- ✅ Eliminado `tailwind-tools.nvim` (conflictos)
- ✅ GGA deshabilitado en Neovim (plugin no disponible)
- ✅ GGA CLI instalado y funcional (v2.6.1)
- ✅ LSP directo para Tailwind (sin plugins intermediarios)
- ✅ Documentación completa de GGA

---

## 📚 Recursos

- [Documentación Neovim](https://neovim.io/doc/)
- [Vimtutor](https://tutor.dev/) - Tutorial interactivo
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Quarto](https://quarto.org/)
- [GGA Repo](https://github.com/Gentleman-Programming/gentleman-guardian-angel)
- [GGA Documentación](https://github.com/Gentleman-Programming/gentleman-guardian-angel?tab=readme-ov-file#-providers)

---

**Statick Medardo Saavedra García** - 2026
