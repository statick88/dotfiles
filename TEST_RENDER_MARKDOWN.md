# Test Render-Markdown Configuration

## How to Verify Render-Markdown Works

### Method 1: Visual Test (Recommended)

1. **Open the README file:**
   ```bash
   nvim ~/.config/nvim/README.md
   ```

2. **Expected behavior:**
   - Headers should be highlighted with colors
   - Tables should have box-drawing characters (┌ ┬ ┐ ├ ┼ ┤ └ ┴ ┘)
   - Code blocks should be indented with borders
   - Lists should be properly formatted

3. **If rendering is NOT showing:**
   - Press `<leader>me` to manually enable rendering
   - Press `<leader>mr` to toggle rendering on/off
   - Press `<leader>md` to disable rendering

### Method 2: Check Configuration

1. **Verify filetype is set:**
   ```vim
   :set filetype?
   " Should output: filetype=markdown
   ```

2. **Check if render-markdown is loaded:**
   ```vim
   :lua require("render-markdown")
   " Should not error
   ```

3. **Check autocmds:**
   ```vim
   :autocmd | grep markdown
   ```

### Method 3: Manual Enable

If auto-detection doesn't work, you can manually enable rendering:

```vim
" In normal mode, press:
<leader>me  " Enable render-markdown

" Or use the command:
:Glow

" Or toggle:
<leader>mr  " Toggle rendering on/off
```

## Configuration Files

### Primary Configuration:
- `~/.config/nvim/lua/plugins/render-markdown.lua`
  - Removed `ft` lazy-loading constraint
  - Added `lazy = false` and `priority = 50`
  - Multiple autocmds for file detection

### Autocmd Configuration:
- `~/.config/nvim/lua/config/autocmds.lua`
  - Sets filetype for README* files to "markdown"
  - Enables render-markdown on BufRead/BufNewFile
  - Ensures markdown filetype triggers rendering

## Features

| Feature | Command | Mode |
|---------|---------|------|
| Toggle Rendering | `<leader>mr` | Normal |
| Enable Rendering | `<leader>me` | Normal |
| Disable Rendering | `<leader>md` | Normal |

## Troubleshooting

### Render-markdown not showing:

1. **Check filetype:**
   ```vim
   :echo vim.bo.filetype
   ```
   Should output: `markdown`

2. **Manually set filetype:**
   ```vim
   :set filetype=markdown
   ```

3. **Enable manually:**
   ```vim
   :lua require("render-markdown").enable()
   ```

4. **Check plugin is loaded:**
   ```vim
   :Lazy | search render-markdown
   ```

### Still not working?

- Update plugins: `:Lazy update`
- Restart Neovim
- Check if render-markdown dependencies are installed:
  - `nvim-treesitter`
  - `nvim-web-devicons`

## Expected Output

When render-markdown is working on README.md, you should see:

```
╭─ Headers with colors and formatting
│
├─ Formatted tables with box drawing characters
│
│  ┌──────────────────────────────────┐
│  │ Table content rendered properly  │
│  └──────────────────────────────────┘
│
└─ Code blocks with syntax highlighting
  and proper indentation
```

---

**Created:** 2026-01-30
**Last Updated:** 2026-01-30
