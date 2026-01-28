# AGENTS.md

This file contains guidelines and commands for agentic coding agents working in this dotfiles repository.

## Project Overview

This is a personal dotfiles repository containing:
- **Neovim Configuration** (primary) - LazyVim-based setup with OpenCode.nvim integration
- **OpenCode AI Assistant** - Node.js project using Bun package manager
- **Supporting tool configs** - Kitty terminal, htop, Tmux, etc.

## Build/Lint/Test Commands

### Neovim Configuration (Lua)
```bash
# Code Formatting
stylua .                    # Format all Lua files
stylua --check .           # Check formatting without changes
stylua lua/config/lazy.lua # Format specific file

# Plugin Management (run within Neovim)
:Lazy                      # Open Lazy.nvim interface
:Lazy update              # Update all plugins
:Lazy install             # Install missing plugins
:Lazy clean               # Clean unused plugins

# Health Checks
:checkhealth              # Overall Neovim health
:checkhealth lazyvim      # LazyVim specific health

# Configuration Validation
nvim --headless -c "lua print('Config loaded successfully')" -c "q"
nvim --headless -c "lua require('config.lazy')" -c "q"
```

### OpenCode Project (Node.js/Bun)
```bash
bun install               # Install dependencies
# No build/test scripts currently defined
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
- Each plugin file returns a Lazy.nvim spec table: `return { "plugin/name", ... }`
- Plugin config in `config = function()` block
- Dependencies in `dependencies = { ... }` table
- Import system: `{ import = "plugins" }` for custom plugins

### Naming Conventions
- **Files**: lowercase with underscores (snake_case)
- **Variables**: snake_case for local variables
- **Functions**: snake_case for local functions
- **Global variables**: `vim.g.variable_name` for configuration
- **Keymaps**: Descriptive names in `desc` field

### Import/Require Patterns
```lua
-- Require Lua modules
require("module.path")

-- LazyVim plugins
{ import = "lazyvim.plugins" }

-- Custom plugins  
{ import = "plugins" }
```

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

## Development Principles (from model.md)

### Clean Architecture
- Separate layers clearly: domain, application, infrastructure
- Dependencies point inward (core doesn't depend on details)
- Keep framework-independent code in the center

### Clean Code
- Use meaningful names that reveal intent
- Write small functions that do one thing
- Avoid flag arguments
- Follow DRY principle (no duplication)
- Add comments only when necessary
- Handle errors explicitly and appropriately

### SOLID Principles
- **S** - Single Responsibility: Each component has one reason to change
- **O** - Open/Closed: Open for extension, closed for modification
- **L** - Liskov Substitution: Subtypes must be substitutable for base types
- **I** - Interface Segregation: Specific interfaces over general ones
- **D** - Dependency Inversion: Depend on abstractions, not concretions

### TDD (Test Driven Development)
- Red: Write failing test
- Green: Write minimal code to pass
- Refactor: Improve code while keeping tests green
- Focus on unit, integration, and e2e tests

## Performance Guidelines

### Plugin Loading
- Use lazy loading for non-essential plugins
- Disable unused runtime plugins in lazy config
- Configure required dependencies in `opts` parameter
- Prefer `vim.fn.stdpath()` for cross-platform paths

### Code Organization
- Separate concerns: options, keymaps, autocmds in different files
- Group related functionality in the same file
- Use local variables for frequently accessed APIs
- Keep plugin configurations focused and minimal

### Async Operations
- Use `vim.uv` (or `vim.loop`) for async operations
- Avoid blocking operations in startup code
- Use `vim.defer_fn()` for non-critical startup tasks

## Testing Strategy

This configuration uses validation through:
1. **Configuration Loading**: Ensure Neovim starts without errors
2. **Health Checks**: Use `:checkhealth` for plugin validation
3. **Manual Testing**: Verify key mappings and functionality
4. **Plugin Loading**: Check Lazy.nvim status with `:Lazy`

## Common Tasks

### Adding a New Plugin
1. Create `lua/plugins/plugin-name.lua`
2. Return Lazy.nvim spec with plugin configuration
3. Add dependencies if needed
4. Configure with `opts` or `config` function
5. Run `stylua .` to format

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

## Security Best Practices

### General Security
- Never commit secrets or API keys
- Use environment variables for sensitive configuration
- Regularly update dependencies for security patches
- Follow principle of least privilege

### DevSecOps Integration
- Integrate security scanning in development workflow
- Use static analysis tools for vulnerability detection
- Implement proper secret management
- Follow secure coding practices

## Workflow Commands

### Before Making Changes
```bash
# Ensure clean state
git status
nvim --headless -c "lua print('Config OK')" -c "q"
```

### After Making Changes
```bash
# Format code
stylua .

# Test configuration
nvim --headless -c "lua print('Config loaded')" -c "q"

# Check plugin health
nvim --headless -c "checkhealth lazyvim" -c "q"
```

### When Adding Plugins
```bash
# Install new plugin
nvim --headless -c "Lazy install" -c "q"

# Check health
nvim --headless -c "checkhealth" -c "q"

# Format new configuration
stylua lua/plugins/new-plugin.lua
```

Remember to run `stylua .` after making changes to maintain consistent code formatting.