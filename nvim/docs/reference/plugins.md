# Plugins Reference

Complete list of installed plugins with descriptions, categories, and key features.

## AI & Assistant Plugins

### OpenCode.nvim
- **Purpose**: Advanced AI assistant for coding with Custom prompts
- **Repository**: `opencode-ai/opencode.nvim`
- **Status**: Active
- **Key Features**:
  - Multi-model support (Claude, GPT-4, etc.)
  - Context-aware suggestions
  - Terminal-based interface
  - Integration with LSP
- **Keymaps**: `<leader>o*` (see keymaps reference)

### GitHub Copilot
- **Purpose**: AI code completion powered by GitHub
- **Repository**: `github/copilot.vim`
- **Status**: Active
- **Key Features**:
  - Code completion suggestions
  - Accepts/rejects suggestions
  - Works with multiple languages

### CopilotChat.nvim
- **Purpose**: Chat interface for GitHub Copilot
- **Repository**: `CopilotC-Nvim/CopilotChat.nvim`
- **Status**: Active
- **Key Features**:
  - Conversational AI
  - Code review
  - Fix suggestions
  - LSP diagnostics integration

## UI & Theme Plugins

### TokyoNight
- **Purpose**: Modern color scheme
- **Repository**: `folke/tokyonight.nvim`
- **Features**: Dark/light variants, high contrast

### Catppuccin
- **Purpose**: Soothing pastel color scheme
- **Repository**: `catppuccin/nvim`
- **Features**: Multiple flavors, Lualine integration

### Lualine.nvim
- **Purpose**: Statusline configuration
- **Repository**: `nvim-lualine/lualine.nvim`
- **Features**: Customizable status bar, git info, modes

### Which-key.nvim
- **Purpose**: Keymap helper showing available commands
- **Repository**: `folke/which-key.nvim`
- **Usage**: Press `<leader>` to see available keymaps

## Development Tools

### LSP Configuration
**nvim-lspconfig** with **Mason** & **Mason-LSPConfig**
- **Purpose**: Language Server Protocol setup
- **Features**:
  - Auto-install LSP servers
  - Pre-configured servers: Lua, Python, TypeScript, HTML, CSS, JSON, YAML, Bash, Markdown
  - Unified configuration through `config/lsp-setup.lua`
- **See**: `lua/config/lsp-setup.lua` for details

### Treesitter
- **Purpose**: Syntax highlighting and code parsing
- **Repository**: `nvim-treesitter/nvim-treesitter`
- **Features**: Better syntax, code folding, AST navigation

### Conform.nvim
- **Purpose**: Code formatting
- **Formatters**: stylua (Lua), black (Python), prettier (JS/JSON), markdownlint
- **Keymap**: `<leader>fm` format buffer

### Gitsigns.nvim
- **Purpose**: Git integration with visual indicators
- **Features**: Hunk staging, blame, diff preview
- **Keymaps**: `<leader>h*` (see keymaps reference)

### Fugitive.vim
- **Purpose**: Git operations from Neovim
- **Features**: `:Git` command for all git operations
- **Keymaps**: `<leader>g*` (see keymaps reference)

### nvim-dap
- **Purpose**: Debug Adapter Protocol implementation
- **Features**: Breakpoints, stepping, REPL
- **Keymaps**: `<leader>d*` (see keymaps reference)

### Neotest
- **Purpose**: Testing framework
- **Adapters**: Python (via neotest-python)
- **Keymaps**: `<leader>t*` (see keymaps reference)

## Navigation & Search

### Telescope.nvim
- **Purpose**: Fuzzy finder for files, buffers, grep, commands
- **Features**: Powerful search, multiple modes
- **Keymaps**: `<leader>f*` (see keymaps reference)

### Flash.nvim
- **Purpose**: Fast motion navigation
- **Features**: Jump to any character, Treesitter navigation
- **Keymaps**: `s`, `S` (see keymaps reference)

### Smart-splits.nvim
- **Purpose**: Smart window navigation and resizing
- **Keymaps**: `<C-hjkl>`, `<C-arrows>` (see keymaps reference)

## Writing & Documentation

### Render-markdown.nvim
- **Purpose**: Enhanced markdown rendering in editor
- **Features**: Pretty tables, code blocks, lists
- **Keymaps**: `<leader>m*` (see keymaps reference)

### Markdown-preview.nvim
- **Purpose**: Preview markdown in browser
- **Keymaps**: `<leader>mp/ms/mq` (see keymaps reference)

### Quarto.nvim
- **Purpose**: Literate programming support
- **Features**: Execute code cells, render notebooks
- **Keymaps**: `<leader>q*` (see keymaps reference)

### Otter.nvim
- **Purpose**: Multiple language support in documents
- **Features**: Edit code blocks with proper language support
- **Keymaps**: `<leader>o*` (see keymaps reference)

## Session & State Management

### Persistence.nvim
- **Purpose**: Save and restore sessions
- **Features**: Automatic session saving, restore last session
- **Keymaps**: `<leader>qs/ql/qd` (see keymaps reference)

### Toggleterm.nvim
- **Purpose**: Terminal integration
- **Features**: Floating/split terminals
- **Keymap**: `<C-\>` toggle terminal

## Performance & Optimization

### Lazy.nvim
- **Purpose**: Plugin package manager
- **Features**: Lazy loading, dependency management
- **Config**: `lua/config/lazy.lua`

## Plugin Statistics

- **Total Plugins**: 20+
- **Lazy-loaded**: Most plugins (faster startup)
- **Auto-installed Servers**: 9 (via Mason)
- **Formatters**: 5+

## Related Files

- **Configuration**: `lua/plugins/` directory
- **LSP Setup**: `lua/config/lsp-setup.lua`
- **Keymaps**: `lua/config/keymaps/` directory
- **Themes**: `lua/plugins/ui.lua`
