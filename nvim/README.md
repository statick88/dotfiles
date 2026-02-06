# Neovim Configuration - Full Stack Developer & Educator

Modern Neovim configuration powered by LazyVim with AI integration, Flutter/Dart support, and productivity tools.

<!--toc:start-->
- [Quick Reference](#quick-reference)
- [Keymaps](#keymaps)
  - [AI](#ai)
  - [Fuzzy Finder](#fuzzy-finder)
  - [Debugging](#debugging)
  - [Productivity](#productivity)
  - [Refactoring](#refactoring)
  - [Flutter](#flutter)
  - [Git](#git)
  - [Formatting](#formatting)
- [Plugins](#plugins)
  - [AI Integration](#ai-integration)
  - [Fuzzy Finder](#fuzzy-finder-plugins)
  - [Debugging](#debugging-plugins)
  - [Productivity](#productivity-plugins)
  - [Documentation](#documentation)
- [Commands](#commands)
- [Requirements](#requirements)
- [Installation](#installation)
<!--toc:end-->

---

## Quick Reference

| Category | Action | Keybinding | Mode |
|----------|--------|------------|------|
| **AI** | Blink autocomplete | `<C-Space>` | i |
| | Codecompanion chat | `<leader>aa` | n/v |
| | Avante toggle | `<leader>at` | n/v |
| **Fuzzy Finder** | Find files | `<leader>ff` | n |
| | Live grep | `<leader>fg` | n |
| | Buffers | `<leader>fb` | n |
| | Recent files | `<leader>fr` | n |
| **Debugging** | Toggle breakpoint | `<leader>db` | n |
| | Continue | `<leader>dc` | n |
| | Step over | `<leader>ds` | n |
| | Step into | `<leader>di` | n |
| | Run tests | `<leader>tr` | n |
| **Productivity** | Snacks picker | `<leader>sp` | n |
| | Oil file manager | `<leader>o` | n |
| | Harpoon menu | `<leader>hh` | n |

---

## Keymaps

### AI

```vim
<C-Space>     " Blink autocomplete show
<C-j>         " Select next (blink)
<C-k>         " Select prev (blink)
<C-J>         " Copilot Accept (insert mode)
<leader>aa    " Codecompanion chat
<leader>ae    " Codecompanion explain
<leader>ar    " Codecompanion review
<leader>at    " Avante toggle
```

### Fuzzy Finder (Telescope)

```vim
<leader>ff   " Find files
<leader>fg   " Live grep
<leader>fb   " Buffers
<leader>fh   " Help tags
<leader>fc   " Commands
<leader>fr   " Recent files
<leader>fd   " Diagnostics
<leader>fs   " LSP document symbols
<leader>fS   " LSP workspace symbols
```

### Debugging

```vim
<leader>db   " Dap toggle breakpoint
<leader>dc   " Dap continue
<leader>ds   " Dap step over
<leader>di   " Dap step into
<leader>do   " Dap step out
<leader>dr   " Dap run to cursor
<leader>tr   " Neotest run nearest
<leader>tf   " Neotest run file
<leader>ts   " Neotest toggle summary
<leader>to   " Neotest toggle output
```

### Productivity

```vim
<leader>sp   " Snacks picker
<leader>o    " Oil file manager
<leader>hh   " Harpoon menu
<leader>ha   " Harpoon add file
<leader>h1-4 " Harpoon jump to file 1-4
<C-a>        " Increment (dial)
<C-x>        " Decrement (dial)
```

### Refactoring

```vim
<leader>re   " Refactor extract (visual)
<leader>rf   " Refactor function (visual)
<leader>rv   " Refactor extract variable (visual)
<leader>rn   " Rename symbol (IncRename)
<leader>cs   " Code symbols outline
```

### Flutter

```vim
<leader>fr   " Flutter hot reload
<leader>fs   " Flutter run
<leader>fq   " Flutter quit
<leader>fd   " Flutter DevTools
<leader>fo   " Flutter outline
```

### Git

```vim
<leader>gg   " LazyGit
<leader>gf   " GrugFar (search/replace)
<leader>gd   " Diffview open
<leader>gdc  " Diffview close
<leader>gs   " Git status
```

### Formatting

```vim
<leader>fm   " Format buffer (Conform)
<leader>ll   " Run linter (nvim-lint)
<leader>lt   " TODO/FIXME telescope
```

---

## Plugins

### AI Integration

| Plugin | Purpose | Provider |
|--------|---------|----------|
| **blink.cmp** | Modern autocomplete with Copilot ghost text | GitHub Copilot |
| **copilot.vim** | GitHub Copilot integration | GitHub Copilot |
| **codecompanion** | Chat + inline edits + agent flows | Claude API |
| **avante** | Cursor-like editing, diff/apply | Claude API |

**Configuration:**
```bash
export ANTHROPIC_API_KEY="your-claude-api-key"
```

### Fuzzy Finder (Telescope)

| Plugin | Purpose |
|--------|---------|
| **telescope.nvim** | Fuzzy finder (primary) |
| **nvim-web-devicons** | File icons |

### Debugging Plugins

| Plugin | Purpose |
|--------|---------|
| **nvim-dap** | Debug Adapter Protocol client |
| **nvim-dap-ui** | DAP user interface |
| **nvim-dap-python** | Python debugging support |
| **neotest** | Test runner UI |
| **neotest-python** | Python test adapter |
| **nvim-coverage** | Code coverage display |

### Productivity Plugins

| Plugin | Purpose |
|--------|---------|
| **snacks.nvim** | Dashboard, picker, notifier |
| **oil.nvim** | File explorer (edit filesystem) |
| **harpoon** | Quick file switching |
| **flash.nvim** | Enhanced motion/jump |
| **inc-rename** | Rename with preview |
| **mini.bracketed** | Navigate brackets/errors |
| **dial.nvim** | Smart increment/decrement |

### Documentation

| Plugin | Purpose |
|--------|---------|
| **marksman** | Markdown LSP |
| **markdown-preview** | Markdown preview in browser |
| **neorg** | Notes and organization |
| **quarto-nvim** | Quarto documentation |

### Flutter/Dart

| Plugin | Purpose |
|--------|---------|
| **flutter-tools.nvim** | Flutter IDE support |
| **dart-vim-plugin** | Dart syntax/formatting |
| **dart_style** | Dart formatter |

### UI

| Plugin | Purpose |
|--------|---------|
| **snacks.nvim** | UI enhancements |
| **dressing.nvim** | UI for vim.ui |
| **noice.nvim** | Messages/cmdline UI |
| **lualine.nvim** | Statusline |

---

## Commands

### Health Checks

```bash
# Overall Neovim health
nvim --headless -c "checkhealth" -c "q"

# LazyVim health
nvim --headless -c "checkhealth lazyvim" -c "q"

# Plugin-specific health
nvim --headless -c "checkhealth blink_cmp" -c "q"
nvim --headless -c "checkhealth telescope" -c "q"
nvim --headless -c "checkhealth neotest" -c "q"
nvim --headless -c "checkhealth dap" -c "q"
```

### Plugin Management (in Neovim)

```vim
:Lazy              " Open Lazy.nvim interface
:Lazy update       " Update all plugins
:Lazy install      " Install missing plugins
:Lazy clean        " Clean unused plugins
:Lazy sync         " Sync from lockfile
:Lazy log          " View plugin logs
```

### Configuration Validation

```bash
# Test if config loads
nvim --headless -c "lua print('Config loaded successfully')" -c "q"

# Test specific module
nvim --headless -c "lua require('config.lazy')" -c "q"

# Profile startup time
nvim --startuptime /tmp/startup.log
```

### Flutter Commands (in Neovim)

```vim
:FlutterDoctor        " Run flutter doctor
:FlutterRun           " Run current app
:FlutterDevTools      " Open DevTools
:FlutterHotReload     " Hot reload
:FlutterHotRestart    " Hot restart
:FlutterQuit          " Quit running app
:FlutterOutline       " Toggle widget outline
```

### LSP Commands

```vim
:LspInfo             " LSP server info
:LspRestart          " Restart LSP servers
:Mason               " Open Mason (LSP installer)
:MasonInstall <pkg>  " Install LSP/formatter
:MasonUpdate         " Update Mason packages
```

### Testing Commands

```vim
:Neotest         " Open test UI
:NeotestNearest  " Run nearest test
:NeotestFile     " Run file tests
:NeotestSummary  " Toggle test summary
```

### Git Commands

```vim
:LazyGit         " Open LazyGit
:GrugFar         " Open GrugFar (search/replace)
:DiffviewOpen    " Open diffview
:DiffviewClose   " Close diffview
```

### Formatting

```vim
:Format          " Format current buffer
:FormatInfo      " Show formatter info
```

### Shell Commands

```bash
# Format Lua files
stylua .

# Format check
stylua --check .

# Verify installation
./verify.sh
```

---

## Requirements

- **Neovim** >= 0.9.0 (recommended 0.10+)
- **Git**
- **Lua** >= 5.1
- **ANTHROPIC_API_KEY** - For Claude AI plugins (optional)
- **Flutter SDK** - For Flutter development (optional)
- **Python** >= 3.8 - For Python LSP and debugging
- **Node.js** >= 18 - For JavaScript/TypeScript tools

### Optional Tools

```bash
# Fuzzy finder and utilities (recommended)
brew install fzf fd ripgrep bat

# For Neovim from source (optional)
brew install neovim
```

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

## Installation

### Fresh Installation

```bash
# 1. Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# 2. Clone this repository
git clone https://github.com/statick88/nvim ~/.config/nvim

# 3. Start Neovim (plugins install automatically)
nvim

# 4. Or install plugins manually
nvim --headless -c "Lazy install" -c "q"
```

### Set API Key (for AI plugins)

```bash
# Add to your shell profile (~/.zshrc or ~/.bashrc)
export ANTHROPIC_API_KEY="your-claude-api-key"
```

### Install Dependencies

```bash
# Using Homebrew (macOS)
brew install fzf fd ripgrep bat

# Verify installation
./verify.sh
```

### Update Configuration

```bash
cd ~/.config/nvim
git pull origin main
nvim --headless -c "Lazy sync" -c "q"
```

---

## Troubleshooting

### Plugins not loading

```vim
:Lazy log      " Check plugin logs
:Lazy clean    " Clean unused plugins
:Lazy sync     " Sync from lockfile
```

### LSP not working

```vim
:LspInfo       " Check LSP status
:Mason         " Verify LSPs installed
:LspRestart    " Restart LSP
```

### Flutter issues

```bash
# Verify Flutter SDK path
export PATH="$PATH:$HOME/Development/flutter/bin"

# Check Flutter doctor
~/Development/flutter/bin/flutter doctor -v
```

### Reset Configuration

```bash
# Full reset (backup first!)
rm -rf ~/.local/share/nvim/lazy
nvim --headless -c "Lazy install" -c "q"
```

---

## File Structure

```
nvim/
├── init.lua                    # Entry point
└── lua/
    ├── config/
    │   ├── lazy.lua           # Lazy.nvim bootstrap
    │   ├── options.lua        # Neovim options
    │   ├── keymaps.lua        # Keymaps loader
    │   ├── autocmds.lua       # Auto commands
    │   └── keymaps/           # Keymap modules
    │       ├── ai.lua
    │       ├── finder.lua
    │       ├── productivity.lua
    │       ├── debugging.lua
    │       ├── refactoring.lua
    │       ├── flutter.lua
    │       ├── git.lua
    │       ├── formatting.lua
    │       └── quarto.lua
    └── plugins/
        ├── ai.lua             # AI assistants
        ├── productivity.lua   # Navigation tools
        ├── debugging.lua      # Debugging tools
        ├── documentation.lua  # Documentation tools
        ├── formatting.lua     # Formatters/linters
        ├── git.lua           # Git tools
        ├── refactoring.lua   # Refactor tools
        ├── organization.lua  # Notes/docs
        ├── ui.lua            # UI enhancements
        ├── development.lua   # Flutter/Dart
        └── *.lua             # Additional plugins
```

---

**Maintained by:** Diego Medardo Saavedra García  
**Last Updated:** February 2026
