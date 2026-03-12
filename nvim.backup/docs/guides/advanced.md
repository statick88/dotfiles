# Advanced Neovim Configuration

Advanced topics for experienced users and developers.

## Architecture Overview

### Directory Structure
```
lua/
├── config/              # Core configuration
│   ├── lazy.lua         # Lazy.nvim bootstrap
│   ├── options.lua      # Editor options
│   ├── keymaps.lua      # Main keymap loader
│   ├── keymaps/         # Organized keymaps by category
│   ├── autocmds.lua     # Auto commands
│   ├── lsp-setup.lua    # LSP configuration
│   └── copilot-*        # Copilot integrations
└── plugins/             # Plugin specifications
    ├── ui.lua           # UI/theme plugins
    ├── desarrollo.lua   # LSP, Git, Debugging
    ├── productividad.lua # Search, Navigation, Terminal
    ├── opencode.lua     # OpenCode AI
    ├── copilot*.lua     # Copilot plugins
    ├── quarto.lua       # Literate programming
    └── render-markdown.lua # Markdown rendering
```

### Lazy.nvim Plugin Manager

Lazy.nvim handles plugin management with lazy loading support.

**Key Features**:
- Lazy loading by event, command, filetype
- Automatic dependency resolution
- Plugin specifications in Lua
- Plugin lockfile (`lazy-lock.json`)

### Configuration Flow

1. `init.lua` - Entry point
2. `lazy.lua` - Bootstrap Lazy.nvim
3. `options.lua` - Editor settings
4. `keymaps.lua` - Load keymap modules
5. `autocmds.lua` - Setup auto commands
6. Plugins load via Lazy.nvim

## Plugin Configuration Patterns

### Basic Plugin Spec
```lua
{
  "author/plugin-name",
  -- When to load
  event = "VeryLazy",      -- Load after UI
  cmd = "PluginCommand",   -- Load on command
  ft = "filetype",         -- Load on filetype
  
  -- Dependencies
  dependencies = { "other/plugin" },
  
  -- Setup
  opts = { ... },          -- Options table
  config = function()      -- Custom config
    require("plugin").setup(...)
  end,
}
```

### Lazy Loading Strategies

#### Event-Based
```lua
{
  "plugin/name",
  event = "VeryLazy",  -- After UI initialization
}
```

Available events: `VeryLazy`, `BufRead`, `BufNewFile`, `BufReadPre`, `FileType`

#### Command-Based
```lua
{
  "plugin/name",
  cmd = "PluginCommand",  -- Single command
  -- or
  cmd = { "Cmd1", "Cmd2" },  -- Multiple commands
}
```

#### Filetype-Based
```lua
{
  "plugin/name",
  ft = "markdown",  -- Single type
  -- or
  ft = { "markdown", "quarto" },  -- Multiple types
}
```

#### Key-Based
```lua
{
  "plugin/name",
  keys = {
    { "<leader>k", "<cmd>PluginCommand<cr>", desc = "Description" },
  },
}
```

## LSP Configuration

### Adding a New LSP Server

Edit `lua/config/lsp-setup.lua`:

```lua
-- In setup_mason() - add server to install list
local servers_to_install = {
  "lua_ls",
  "pyright",
  "new_server",  -- Add here
}

-- In M.setup() - add server configuration
local servers = {
  lua_ls = {},
  pyright = {},
  new_server = {
    settings = { ... },  -- Optional settings
  },
}
```

Then restart Neovim - Mason will auto-install.

### Configuring LSP Capabilities

Add plugins capabilities to LSP setup:

```lua
-- In lsp-setup.lua
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Add plugins capabilities
local cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end
```

## Keymap Organization

### Creating a New Keymap File

Create `lua/config/keymaps/mycustom.lua`:

```lua
---@desc My custom keymaps

-- Example keymap
vim.keymap.set("n", "<leader>mc", function()
  print("Hello from my keymap!")
end, { desc = "My custom command" })
```

Then add to `lua/config/keymaps.lua`:
```lua
require("config.keymaps.mycustom")
```

### Keymap Best Practices

```lua
-- Always include description
vim.keymap.set("n", "<leader>x", ..., { desc = "Clear description" })

-- Use buffer-local for plugin-specific
vim.keymap.set("n", "<leader>x", ..., { buffer = bufnr })

-- Use silent for non-interactive
vim.keymap.set("n", "<leader>x", ..., { silent = true })

-- Use expr for complex operations
vim.keymap.set("n", "<leader>x", function() ... end, { expr = true })

-- Support multiple modes
vim.keymap.set({ "n", "v", "x" }, "<leader>x", ...)
```

## Custom Autocommands

Edit `lua/config/autocmds.lua`:

```lua
-- Example: Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.lua", "*.py" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Example: Set options for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.bo.textwidth = 80
  end,
})
```

## Performance Optimization

### Plugin Lazy-Loading

See `docs/guides/performance-optimization.md` for detailed strategies.

Quick summary:
- UI plugins: `lazy = false`
- Core tools: `lazy = false`
- Productivity: `event = "VeryLazy"`
- Optional: `cmd` or `ft`

### Startup Profiling

Check startup time:
```lua
-- In init.lua (temporary)
local start_time = vim.fn.reltime()

-- At end
vim.defer_fn(function()
  local elapsed = vim.fn.reltimestr(vim.fn.reltime(start_time))
  print("Startup time: " .. elapsed .. "ms")
end, 100)
```

### Profiling Plugins

```lua
-- View plugin load times
:Lazy profile
```

## Testing Configuration

Run tests:
```bash
./scripts/run-tests.sh
```

Validate configuration:
```bash
./scripts/validate-config.sh
```

## Debugging Tips

### Check What's Loaded
```lua
:Lazy           -- View plugins
:checkhealth    -- Diagnose issues
:LspInfo        -- LSP status
:Mason          -- LSP servers
```

### View Error Messages
```lua
:messages       -- Recent messages
:map <leader>   -- View keymaps
```

### Debug Keymaps
```lua
-- Inside Neovim
:verbose nmap <leader>ff  -- Show keymap source

-- Check which-key registration
:WhichKey
```

## Custom Functions & Utilities

### Creating Helper Functions

Create `lua/utils/myutils.lua`:

```lua
local M = {}

---Do something useful
function M.my_function()
  -- Implementation
end

return M
```

Use it:
```lua
local utils = require("utils.myutils")
utils.my_function()
```

### Extending Plugins

Extend existing functionality:

```lua
-- Hook into plugin events
local telescope = require("telescope.builtin")

-- Custom telescope wrapper
local function my_telescope_search()
  telescope.live_grep({
    prompt_title = "My Search",
    -- ... options
  })
end

vim.keymap.set("n", "<leader>ms", my_telescope_search, { desc = "My search" })
```

## Best Practices

### Code Organization
- Keep related functionality together
- Use meaningful variable names
- Add documentation (LuaDoc comments)
- Avoid global state when possible

### Performance
- Use `lazy = true` when appropriate
- Profile startup regularly
- Use `event = "VeryLazy"` for non-critical plugins
- Avoid heavy computations in config

### Maintainability
- Keep configuration modular
- Use consistent naming conventions
- Update documentation with changes
- Test configuration changes

### Security
- Don't hardcode API keys
- Use environment variables for secrets
- Keep plugins updated
- Review plugin source code

## Resources

- **Neovim API**: `:help api`
- **Lua 5.1 Guide**: https://www.lua.org/manual/5.1/
- **LazyVim Docs**: https://www.lazyvim.org/
- **Lazy.nvim**: https://github.com/folke/lazy.nvim
- **Community Plugins**: https://neovim.io/community/

## Common Customizations

### Change Colorscheme
Edit `lua/plugins/ui.lua` and modify color scheme preference.

### Add New LSP Server
Add to `lua/config/lsp-setup.lua` and restart Neovim.

### Create Custom Keymap
Add file to `lua/config/keymaps/` and require it in `lua/config/keymaps.lua`.

### Disable Plugin
Remove or comment plugin spec in `lua/plugins/*.lua`.

### Change Terminal
Edit `lua/plugins/productividad.lua` toggleterm configuration.

---

**Happy hacking!** 🎓
