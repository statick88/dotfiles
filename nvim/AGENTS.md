# AGENTS.md

This file contains guidelines and commands for agentic coding agents working in this Neovim configuration repository.

## Project Overview

This is a LazyVim-based Neovim configuration with OpenCode.nvim integration. The configuration follows LazyVim conventions and uses Lua as the primary configuration language.

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
```

### Health Checks
```bash
# Check LazyVim health (run from within Neovim)
:checkhealth lazyvim

# Check overall Neovim health
:checkhealth
```

### Configuration Validation
```bash
# Restart Neovim to test configuration changes
nvim --headless -c "lua print('Config loaded successfully')" -c "q"

# Test specific configuration file
nvim --headless -c "lua require('config.lazy')" -c "q"
```

## Code Style Guidelines

### Lua Formatting (stylua.toml)
- **Indentation**: 2 spaces
- **Line width**: 120 characters
- **Quote style**: Auto-detected (prefer double quotes for consistency)

### File Structure Conventions
```
lua/
├── config/          # Core configuration files
│   ├── lazy.lua     # Lazy.nvim bootstrap and setup
│   ├── options.lua  # Neovim options
│   ├── keymaps.lua  # Key mappings
│   └── autocmds.lua # Auto commands
└── plugins/         # Plugin configurations
    ├── *.lua        # Individual plugin specs
```

### Plugin Configuration Patterns
- Each plugin file returns a Lazy.nvim spec table
- Use `return { "plugin/name", ... }` format
- Plugin config should be in a `config = function()` block
- Dependencies go in `dependencies = { ... }` table
- Use LazyVim's plugin import system: `{ import = "plugins" }`

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

### Error Handling
- Use `pcall()` for safe plugin loading where needed
- Check `vim.v.shell_error` after system commands
- Use `vim.api.nvim_echo()` for user-facing error messages
- Graceful fallbacks for optional features

### Key Mapping Patterns
- Use `vim.keymap.set()` for all key mappings
- Include descriptive `desc` for all mappings
- Use mode table: `{ "n", "x", "v" }` for multiple modes
- Buffer-local mappings should include `buffer = bufnr`
- Silent mappings for non-interactive commands: `silent = true`

### Configuration Variables
- Global config: `vim.g.config_name = value`
- Buffer-local: `vim.bo[bufnr].option = value`
- Window-local: `vim.wo[winid].option = value`
- Use `vim.opt` for options that support it

### Plugin Dependencies
- Declare all dependencies explicitly
- Use version constraints sparingly (prefer latest)
- Lazy-load heavy plugins when possible
- Configure required dependencies in `opts` parameter

### Performance Guidelines
- Use lazy loading for non-essential plugins
- Disable unused runtime plugins in lazy config
- Prefer `vim.fn.stdpath()` for cross-platform paths
- Use `vim.uv` (or `vim.loop`) for async operations

### Code Organization
- Separate concerns: options, keymaps, autocmds in different files
- Group related functionality in the same file
- Use local variables for frequently accessed APIs
- Keep plugin configurations focused and minimal

## Testing Strategy

This configuration does not include traditional tests. Validation is done through:

1. **Configuration Loading**: Ensure Neovim starts without errors
2. **Health Checks**: Use `:checkhealth` for plugin validation
3. **Manual Testing**: Verify key mappings and functionality work as expected
4. **Plugin Loading**: Check Lazy.nvim status with `:Lazy`

## Common Tasks

### Adding a New Plugin
1. Create `lua/plugins/plugin-name.lua`
2. Return Lazy.nvim spec with plugin configuration
3. Add dependencies if needed
4. Configure with `opts` or `config` function

### Modifying Core Configuration
1. Edit files in `lua/config/`
2. Follow existing patterns for options, keymaps, autocmds
3. Use LazyVim's VeryLazy event for startup-heavy operations
4. Restart Neovim to test changes

### Debugging Configuration Issues
1. Check `:messages` for error messages
2. Run `:checkhealth` for plugin health status
3. Use `:Lazy log` for plugin-related errors
4. Test individual files with `nvim --headless` commands

## Integration Notes

### OpenCode.nvim Integration
- Uses Kitty provider for better terminal integration
- Key mappings: `<C-a>` (ask), `<C-x>` (select), `<C-.>` (toggle)
- Auto-reload enabled for edited buffers
- Statusline integration available with lualine

### LazyVim Base
- Extends LazyVim's default plugin set
- Follows LazyVim's loading conventions
- Compatible with LazyVim's color schemes and themes
- Maintains LazyVim's performance optimizations

Remember to run `stylua .` after making changes to maintain consistent code formatting.