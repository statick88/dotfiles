# Neovim Configuration - Full Stack Developer & Educator

<!--toc:start-->
- [Quick Reference](#quick-reference)
- [Keymaps](#keymaps)
  - [Navigation](#navigation)
  - [AI](#ai)
  - [Productivity](#productivity)
  - [Refactoring](#refactoring)
  - [Flutter](#flutter)
  - [Git](#git)
  - [Formatting](#formatting)
- [Plugins](#plugins)
  - [AI Integration](#ai-integration)
  - [Productivity](#productivity-plugins)
  - [Organization](#organization)
  - [Refactoring](#refactoring-plugins)
  - [Development](#development)
<!--toc:end-->

## Quick Reference

| Category | Action | Keybinding | Mode |
|----------|--------|------------|------|
| **Navigation** | Find files | `<leader>ff` | n |
| | Live grep | `<leader>fg` | n |
| | Buffers | `<leader>ls` | n |
| **AI** | Codecompanion | `<leader>aa` | n/v |
| | Avante | `<leader>at` | n/v |
| | Parrot | `<leader>ap` | n |
| **Productivity** | Oil (file manager) | `<leader>o` | n |
| | Harpoon menu | `<leader>hh` | n |
| | Harpoon add | `<leader>ha` | n |
| **Refactoring** | Extract | `<leader>re` | v |
| | Rename symbol | `<leader>rn` | n |
| | Code symbols | `<leader>cs` | n |
| **Flutter** | Hot reload | `<leader>fr` | n |
| | Run app | `<leader>fs` | n |
| | DevTools | `<leader>fd` | n |
| **Git** | LazyGit | `<leader>gg` | n |
| | GrugFar | `<leader>gf` | n |
| | Diffview | `<leader>gd` | n |
| **Formatting** | Format | `<leader>fm` | n/v |
| | Linter | `<leader>ll` | n |

---

## Keymaps

### Navigation

```vim
<leader>ff  " Telescope find files
<leader>fg  " Telescope live grep
<leader>fb  " Telescope buffers
<leader>fh  " Telescope help tags
<Tab>      " Next buffer
<S-Tab>    " Previous buffer
<leader>1-5 " Go to buffer 1-5
```

### AI

```vim
<leader>aa  " Codecompanion chat
<leader>ae  " Codecompanion explain
<leader>ar  " Codecompanion review
<leader>at  " Avante toggle
<leader>ap  " Parrot chat
```

### Productivity

```vim
<leader>o   " Oil file manager
<leader>ff  " Oil floating
<leader>hh  " Harpoon menu
<leader>ha  " Harpoon add file
<leader>h1-4 " Harpoon jump to file
<C-a>      " Increment (dial)
<C-x>      " Decrement (dial)
```

### Refactoring

```vim
<leader>re  " Refactor extract (visual)
<leader>rf  " Refactor function (visual)
<leader>rv  " Refactor extract variable (visual)
<leader>rn  " Rename symbol
<leader>cs  " Code symbols outline
```

### Flutter

```vim
<leader>fr  " Flutter hot reload
<leader>fs  " Flutter run
<leader>fq  " Flutter quit
<leader>fd  " Flutter DevTools
```

### Git

```vim
<leader>gg  " LazyGit
<leader>gf  " GrugFar (search/replace)
<leader>gd  " Diffview open
<leader>gdc " Diffview close
<leader>gs  " Git status
```

### Formatting

```vim
<leader>fm  " Format buffer
<leader>ll  " Run linter
<leader>lt  " TODO/FIXME telescope
```

---

## Plugins

### AI Integration

| Plugin | Purpose | Provider |
|--------|---------|----------|
| **codecompanion** | Chat + inline edits + agent flows | Claude API |
| **avante** | Cursor-like editing, diff/apply | Claude API |
| **parrot** | Persistent chat, markdown notes | Claude API |

**Configuration:**
- Set `ANTHROPIC_API_KEY` environment variable
- Models: claude-sonnet-4, claude-haiku-3

### Productivity Plugins

| Plugin | Purpose | Lazy Loading |
|--------|---------|--------------|
| **oil.nvim** | File explorer | `cmd = "Oil"` |
| **harpoon** | Quick file switching | `event = "VeryLazy"` |
| **inc-rename** | Rename with preview | `cmd = "IncRename"` |
| **mini.bracketed** | Navigate brackets/errors | `event = "VeryLazy"` |
| **dial.nvim** | Smart increment/decrement | `event = "VeryLazy"` |

### Organization

| Plugin | Purpose |
|--------|---------|
| **neorg** | Notes structured (.norg format) |
| **markdown-preview** | Markdown preview in browser |
| **bufexplorer** | Buffer explorer |

### Refactoring Plugins

| Plugin | Purpose |
|--------|---------|
| **refactoring.nvim** | Refactoring patterns |
| **symbols-outline** | Tree view of code |

### Development

| Plugin | Purpose |
|--------|---------|
| **flutter-tools** | Flutter/Dart support |
| **nvim-dap** | Debug Adapter Protocol |
| **nvim-dap-ui** | DAP user interface |
| **nvim-coverage** | Coverage integration |

---

## Supported Languages

| Category | Languages/Frameworks |
|----------|---------------------|
| **Backend** | Python, Django, FastAPI, Node.js, TypeScript |
| **Frontend** | React, Next.js, Vue, Svelte, HTML, CSS, Tailwind |
| **Mobile** | Flutter, Dart |
| **Data** | SQL, MongoDB |
| **DevOps** | Docker, Kubernetes, Bash |
| **Documentation** | Markdown, Quarto, Neorg |

---

## Configuration Structure

```
nvim/
├── init.lua                    # Entry point
└── lua/
    ├── config/
    │   ├── lazy.lua          # Lazy.nvim bootstrap
    │   ├── options.lua       # Neovim options
    │   ├── keymaps.lua       # Keymaps loader
    │   ├── autocmds.lua      # Auto commands
    │   └── keymaps/          # Keymap modules
    │       ├── ai.lua
    │       ├── productivity.lua
    │       ├── refactoring.lua
    │       ├── flutter.lua
    │       ├── git.lua
    │       └── formatting.lua
    └── plugins/
        ├── core.lua          # Core plugins
        ├── ai.lua            # AI assistants
        ├── productivity.lua  # Navigation tools
        ├── formatting.lua    # Formatters/linters
        ├── organization.lua  # Notes/docs
        ├── refactoring.lua   # Refactor tools
        ├── ui.lua            # UI enhancements
        ├── git.lua           # Git tools
        ├── development.lua   # Language tools
        └── quarto.lua        # Quarto documentation
```

---

## Commands

### Health Checks
```bash
nvim --headless -c "checkhealth lazyvim" -c "q"
nvim --headless -c "checkhealth" -c "q"
```

### Plugin Management
```bash
:Lazy               # Open Lazy.nvim interface
:Lazy update        # Update all plugins
:Lazy sync         # Sync from lockfile
```

### Formatting
```bash
stylua .           # Format all Lua files
stylua --check .   # Check formatting
```

---

## Requirements

- **Neovim** >= 0.9.0
- **Git**
- **ANTHROPIC_API_KEY** - For AI plugins
- **Flutter SDK** - For Flutter development
- **Python** - For Python LSP and linting
- **Node.js** - For JavaScript/TypeScript tools

---

## Installation

1. Backup existing config: `mv ~/.config/nvim ~/.config/nvim.backup`
2. Clone: `git clone https://github.com/statick88/nvim ~/.config/nvim`
3. Install plugins: `nvim --headless -c "Lazy install" -c "q"`
4. Set API key: `export ANTHROPIC_API_KEY="your-key"`
5. Restart Neovim

---

**Last Updated:** February 2026
