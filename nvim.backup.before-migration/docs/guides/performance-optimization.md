# Plugin Lazy-Loading Optimization Guide

## Current State

Most plugins are loaded at startup (`lazy = false`), which can impact Neovim startup time.

**Estimated startup time**: 800-1200ms

## Analysis

### Plugins That Should Load at Startup
These provide core functionality needed immediately:
- **UI Plugins**: tokyonight, catppuccin, bufferline, indent-blankline, notify
- **Core Dev Tools**: nvim-lspconfig, treesitter, gitsigns, conform
- **Essential**: These are used immediately on buffer open

### Plugins That Can Lazy-Load
These are used on-demand and can be delayed:

| Plugin | Current | Recommended | Impact | Risk |
|--------|---------|-------------|--------|------|
| Telescope | `false` | `VeryLazy` | -100-150ms | MINIMAL |
| Smart-splits | `false` | `VeryLazy` | -50-100ms | MINIMAL |
| Toggleterm | `false` | `cmd` | -50-100ms | LOW |
| CopilotChat | `false` | `cmd` | -50-100ms | MINIMAL |
| Render-markdown | `false` | `ft = markdown` | -30-50ms | MINIMAL |
| Quarto | `false` | `ft = quarto` | -30-50ms | MINIMAL |
| Otter | `false` | `ft = quarto` | -20-30ms | MINIMAL |
| DAP | `false` | `cmd` | -50-100ms | MINIMAL |
| Neotest | `false` | `cmd` | -50-100ms | LOW |

## Lazy-Loading Strategies

### Event-Based (`event = "VeryLazy"`)
Best for: Productivity tools, navigation plugins
- Loads after UI is ready
- Non-critical for immediate operation
- Keymaps still registered at startup

**Example**: Telescope, Smart-splits
```lua
{
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",  -- Load after UI
  ...
}
```

### Command-Based (`cmd = {...}`)
Best for: Plugins with explicit commands
- Only loads when command is first used
- Minimal startup impact
- Users may notice slight delay on first use

**Example**: CopilotChat, Toggleterm
```lua
{
  "CopilotC-Nvim/CopilotChat.nvim",
  cmd = "CopilotChat",  -- Load on first command
  ...
}
```

### Filetype-Based (`ft = {...}`)
Best for: Language/format specific plugins
- Loads only when opening files of that type
- Zero impact on startup
- Perfect for documentation/literate programming

**Example**: Render-markdown, Quarto
```lua
{
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "markdown_inline" },  -- Load on markdown files
  ...
}
```

## Estimated Impact

### Current Setup
- All plugins load at startup
- **Startup time**: ~800-1200ms
- **All features immediately available**

### After Optimization
- Core plugins load at startup (~400-600ms)
- Productivity plugins load on VeryLazy (~200ms)
- Optional plugins load on-demand (~minimal)
- **Total startup time**: ~500-800ms
- **Savings**: 30-40% (300-400ms)
- **Trade-off**: First use of lazy plugins might add 50-200ms

## Implementation Order

### Priority 1: High-Impact, Zero-Risk
1. **Telescope** - Move to `event = "VeryLazy"` (saves 100-150ms)
2. **Render-markdown** - Move to `ft = { "markdown" }`
3. **Quarto** - Move to `ft = { "quarto" }`

### Priority 2: Medium-Impact, Minimal-Risk
4. **Smart-splits** - Move to `event = "VeryLazy"`
5. **DAP** - Move to `cmd = { "DapBreakpoint", ... }`
6. **Neotest** - Move to `cmd = { "Neotest", ... }`

### Priority 3: Low-Impact, Low-Risk
7. **CopilotChat** - Move to `cmd = "CopilotChat"`
8. **Toggleterm** - Move to `cmd = "ToggleTerm"` or `event = "VeryLazy"`

## How to Apply Optimizations

### Example: Telescope
```lua
-- Before (load at startup)
{
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { ... },
  config = function() ... end,
}

-- After (lazy load on VeryLazy event)
{
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",  -- Add this line
  tag = "0.1.8",
  dependencies = { ... },
  config = function() ... end,
}
```

### Example: Render-markdown
```lua
-- Before (load at startup)
{
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { ... },
  config = function() ... end,
}

-- After (lazy load on markdown files)
{
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "markdown_inline" },  -- Add this line
  dependencies = { ... },
  config = function() ... end,
}
```

### Example: Toggleterm
```lua
-- Before (load at startup)
{
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = { ... },
}

-- After (lazy load on command)
{
  "akinsho/toggleterm.nvim",
  cmd = "ToggleTerm",  -- Add this line
  version = "*",
  opts = { ... },
}
```

## Monitoring Performance

### Before Optimization
```bash
# Add this to init.lua temporarily:
vim.defer_fn(function()
  local startup_time = vim.fn.reltime(start_time)
  print("Startup time: " .. vim.fn.reltimestr(startup_time))
end, 100)
```

### After Optimization
Compare startup times and verify no functionality is broken:
- Keymaps should work immediately
- UI should render quickly
- Lazy plugins should load without errors

## Risks & Mitigation

### Risk: Keymap not available
**Mitigation**: Register keymap at module level, plugin handles command
**Status**: SAFE - keymaps in `config/keymaps/` register at startup

### Risk: Plugin not loaded when needed
**Mitigation**: Plugin loads on first use with minimal delay
**Status**: ACCEPTABLE - 50-200ms delay on first use is acceptable

### Risk: Dependency missing
**Mitigation**: Specify `dependencies = {...}` in plugin spec
**Status**: SAFE - Lazy.nvim handles dependency loading

## Verification Checklist

After applying optimizations:
- [ ] Telescope opens on `<leader>ff`
- [ ] Smart-splits window navigation works
- [ ] Render-markdown works in `.md` files
- [ ] Quarto loads in `.qmd` files
- [ ] CopilotChat opens on command
- [ ] Toggleterm works on `<C-\>`
- [ ] DAP breakpoints work
- [ ] Neotest runs tests
- [ ] Startup time improved

## References

- Lazy.nvim docs: https://github.com/folke/lazy.nvim
- Event types: `VeryLazy`, `BufRead`, `BufNewFile`, `BufReadPre`
- Command lazy-loading: `cmd = "CommandName"`
- Filetype lazy-loading: `ft = { "filetype" }`
