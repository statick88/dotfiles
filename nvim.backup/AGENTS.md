# AGENTS.md

This file contains guidelines and commands for agentic coding agents working in this Neovim configuration repository.

## Project Overview

This is a LazyVim-based Neovim configuration for Full Stack Development and Education. Focus on:
- **Languages**: Python (Django, FastAPI), TypeScript (React, Next.js), Flutter, Lua
- **Architecture**: Clean Architecture / Domain-Driven Design
- **Workflow**: AI-assisted coding with Claude API, productivity tools, and documentation

## Supported Languages

| Category | Languages/Frameworks |
|----------|---------------------|
| **Backend** | Python, Django, FastAPI, Node.js, TypeScript |
| **Frontend** | React, Next.js, Vue, Svelte, HTML, CSS, Tailwind |
| **Mobile** | Flutter, Dart |
| **Data** | SQL, MongoDB |
| **DevOps** | Docker, Kubernetes, Bash |
| **Documentation** | Markdown, Quarto, LaTeX |

## Build/Lint/Test Commands

### Code Formatting
```bash
# Format all Lua files
stylua .

# Format specific file
stylua lua/config/lazy.lua

# Check formatting without making changes
stylua --check .
```

### Plugin Management
```bash
# Open Lazy.nvim interface (run from within Neovim)
:Lazy

# Update all plugins
:Lazy update

# Install missing plugins
:Lazy install

# Clean unused plugins
:Lazy clean

# Sync plugins from lockfile
:Lazy sync
```

### Health Checks
```bash
# Check LazyVim health (run from within Neovim)
:checkhealth lazyvim

# Check overall Neovim health
:checkhealth

# Check specific plugin health
:checkhealth <plugin-name>

# Check blink.cmp
:checkhealth blink_cmp

# Check fzf-lua
:checkhealth fzf-lua

# Check neotest
:checkhealth neotest
```

### Configuration Validation
```bash
# Restart Neovim to test configuration changes
nvim --headless -c "lua print('Config loaded successfully')" -c "q"

# Test specific configuration file
nvim --headless -c "lua require('config.lazy')" -c "q"

# Profile startup time
nvim --headless -c "profile start /tmp/profile.log" -c "profile func *" -c "q"
```

## Plugin Architecture

### Core Plugins (lua/plugins/)
- **ai.lua** - AI assistants (blink.cmp, copilot, codecompanion, avante)
- **productividad.lua** - Navigation and productivity (fzf-lua, flash, treesitter)
- **formatting.lua** - Formatters and linters (conform, nvim-lint)
- **debugging.lua** - Debugging tools (dap, dap-ui, dap-python, neotest)
- **documentation.lua** - Documentation tools (marksman, render-markdown)
- **ui.lua** - UI enhancements (snacks, noice, dressing)
- **git.lua** - Git integration (lazygit, diffview, grug-far)
- **refactoring.lua** - Code refactoring tools
- **organization.lua** - Notes and documentation (neorg, quarto)
- **development.lua** - Language-specific tools (Flutter, Python, TypeScript)

### Keymap Modules (lua/config/keymaps/)
- **core.lua** - Core editor navigation
- **finder.lua** - Fzf-lua picker keymaps
- **ai.lua** - AI assistant keymaps
- **productivity.lua** - Navigation keymaps (oil, harpoon)
- **refactoring.lua** - Refactor keymaps
- **git.lua** - Git operations
- **formatting.lua** - Format and lint keymaps
- **lsp.lua** - LSP operations
- **testing.lua** - Testing keymaps
- **flutter.lua** - Flutter-specific keymaps
- **quarto.lua** - Quarto documentation keymaps

## Code Style Guidelines

### Lua Formatting (stylua.toml)
- **Indentation**: 2 spaces
- **Line width**: 120 characters
- **Quote style**: Auto-detected (prefer double quotes for consistency)

### File Structure Conventions
```
lua/
├── config/              # Core configuration
│   ├── lazy.lua        # Lazy.nvim bootstrap
│   ├── options.lua     # Neovim options
│   ├── keymaps.lua    # Key mappings loader
│   ├── autocmds.lua   # Auto commands
│   └── keymaps/       # Keymap modules
└── plugins/            # Plugin configurations
    ├── ai.lua         # AI assistants
    ├── productividad.lua # Navigation tools
    ├── debugging.lua  # Debugging tools
    ├── documentation.lua # Docs tools
    ├── formatting.lua  # Formatters/linters
    ├── git.lua        # Git tools
    ├── refactoring.lua # Refactor tools
    ├── organization.lua # Notes/docs
    ├── ui.lua         # UI enhancements
    └── development.lua # Language tools
```

### Plugin Configuration Patterns
- Each plugin file returns a Lazy.nvim spec table
- Use `return { "plugin/name", ... }` format
- Plugin config should be in a `config = function()` block
- Dependencies go in `dependencies = { ... }` table
- Use lazy loading with events: `event`, `cmd`, `ft`, `VeryLazy`

### Lazy Loading Examples
```lua
-- Load on command
{ "cmd = { "Oil", "FzfLua" } }

-- Load on file type
{ "ft = { "python", "typescript" } }

-- Load on event
{ "event = "BufReadPre" }

-- Load on VeryLazy (after startup)
{ "event = "VeryLazy" }
```

### Naming Conventions
- **Files**: lowercase with underscores (snake_case)
- **Variables**: snake_case for local variables
- **Functions**: snake_case for local functions
- **Global variables**: `vim.g.variable_name` for configuration
- **Keymaps**: Descriptive names in `desc` field

### Import/Require Patterns
- Use `require("module.path")` for requiring Lua modules
- LazyVim plugins imported via `{ import = "lazyvim.plugins" }`
- Custom plugins imported via `{ import = "plugins" }`

## AI Integration

### Supported AI Plugins
| Plugin | Purpose | Provider |
|--------|---------|----------|
| **blink.cmp** | Autocomplete with Copilot ghost text | GitHub Copilot |
| **copilot.vim** | GitHub Copilot ghost text | GitHub Copilot |
| **codecompanion.nvim** | Chat + inline edits + agent flows | Claude API (Anthropic) |
| **avante.nvim** | Cursor-like editing, diff/apply | Claude API |
| **parrot.nvim** | Persistent chat, markdown notes | Claude API (optional) |

### Configuration
AI plugins should be configured with:
- API key via environment variable: `ANTHROPIC_API_KEY`
- Model selection: claude-sonnet-4-20250520, claude-haiku-3
- Temperature settings for different tasks

## Fuzzy Finder

### fzf-lua (Primary)
| Command | Description |
|---------|-------------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |
| `<leader>fc` | Commands |
| `<leader>fr` | Recent files |
| `<leader>fd` | Diagnostics |
| `<leader>fs` | LSP document symbols |
| `<leader>fG` | Git status |
| `<leader>fgc` | Git commits |
| `<leader>fgb` | Git branches |

### Dependencies
- `fzf` (via homebrew: `brew install fzf`)
- `fd` (optional, better find utility)
- `ripgrep` (optional, better grep utility)
- `bat` (optional, syntax highlighted previews)

## Debugging

### nvim-dap
| Command | Description |
|---------|-------------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue/Pause |
| `<leader>ds` | Step over |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dr` | Run to cursor |

### Python Debugging
- Requires `nvim-dap-python`
- Python path: `~/.cache/pypoetry/virtualenvs/*/bin/python`
- pytest integration via `neotest-pytest`

### neotest
| Command | Description |
|---------|-------------|
| `<leader>tr` | Run nearest test |
| `<leader>tf` | Run file tests |
| `<leader>ts` | Toggle test summary |
| `<leader>to` | Toggle output panel |

## Error Handling
- Use `pcall()` for safe plugin loading where needed
- Check `vim.v.shell_error` after system commands
- Use `vim.api.nvim_echo()` for user-facing error messages
- Graceful fallbacks for optional features

## Key Mapping Patterns
- Use `vim.keymap.set()` for all key mappings
- Include descriptive `desc` for all mappings
- Use mode table: `{ "n", "x", "v" }` for multiple modes
- Buffer-local mappings should include `buffer = bufnr`
- Silent mappings for non-interactive commands: `silent = true`

## Performance Guidelines
- Use lazy loading for non-essential plugins
- Disable unused runtime plugins in lazy config
- Prefer `vim.fn.stdpath()` for cross-platform paths
- Use `vim.uv` (or `vim.loop`) for async operations
- Profile startup with `nvim --startuptime /tmp/startup.log`

## Language-Specific Setup

### Python (Django/FastAPI)
- LSP: pyright, ruff
- Formatter: black, isort, ruff
- Linter: ruff, mypy
- Testing: neotest, pytest
- Debugging: nvim-dap-python

### TypeScript (React/Next.js)
- LSP: ts_ls, tailwindcss
- Formatter: prettierd, biome
- Linter: eslint_d
- Testing: vitest

### Flutter
- LSP: flutter-tools
- Formatter: dart-format
- Widget guides, hot reload

## Common Tasks

### Adding a New Plugin
1. Create `lua/plugins/category.lua` with Lazy.nvim spec
2. Add lazy loading strategy (event, cmd, ft)
3. Configure with `opts` or `config` function
4. Add keymaps to appropriate `lua/config/keymaps/*.lua`
5. Run `:checkhealth <plugin-name>` after installation

### Modifying Core Configuration
1. Edit files in `lua/config/`
2. Follow existing patterns for options, keymaps, autocmds
3. Use LazyVim's VeryLazy event for startup-heavy operations
4. Restart Neovim to test changes
5. Run `:checkhealth lazyvim`

### Debugging Configuration Issues
1. Check `:messages` for error messages
2. Run `:checkhealth` for plugin health status
3. Use `:Lazy log` for plugin-related errors
4. Test individual files with `nvim --headless` commands
5. Check startup time: `nvim --startuptime /tmp/startup.log`

### Refactoring Workflow
1. Backup current config
2. Create new plugin file
3. Add to lazy.lua spec
4. Test with `:checkhealth`
5. Add keymaps
6. Verify functionality
7. Run `stylua .` for formatting
8. Commit changes

## Verification Commands

After any plugin installation:
```bash
# Health check
nvim --headless -c "checkhealth <plugin>" -c "q"

# Full health
nvim --headless -c "checkhealth lazyvim" -c "q"

# Config load
nvim --headless -c "lua print('OK')" -c "q"

# Format check
stylua --check lua/
```

## Notes

- This config prioritizes clean architecture and developer productivity
- AI plugins use Claude API (codecompanion, avante) and GitHub Copilot (blink.cmp)
- Flutter support via flutter-tools.nvim
- Documentation via Quarto, Markdown, and Neorg
- All plugins use lazy loading for performance
- fzf-lua is the primary fuzzy finder (replaces telescope)
- Debugging via nvim-dap with dap-ui and dap-python

Remember to run `stylua .` after making changes to maintain consistent code formatting.
