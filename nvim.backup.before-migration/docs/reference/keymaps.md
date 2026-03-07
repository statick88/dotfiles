# Keyboard Shortcuts Reference

All keyboard shortcuts organized by category. The `<leader>` key is mapped to the spacebar by default.

## OpenCode AI Assistant

| Keymap | Description |
|--------|-------------|
| `<leader>oa` | Ask OpenCode with current context |
| `<leader>os` | Select OpenCode action from menu |
| `<leader>or` | Add range to OpenCode prompt |
| `<leader>ot` | Toggle OpenCode session window |
| `<leader>ol` | Add current line to OpenCode |
| `<leader>ou` | Scroll up in OpenCode session |
| `<leader>oj` | Scroll down in OpenCode session |

## Window & Navigation

| Keymap | Description |
|--------|-------------|
| `<C-h>` | Move cursor left / left window |
| `<C-j>` | Move cursor down / down window |
| `<C-k>` | Move cursor up / up window |
| `<C-l>` | Move cursor right / right window |
| `<C-left>` | Resize window left |
| `<C-down>` | Resize window down |
| `<C-up>` | Resize window up |
| `<C-right>` | Resize window right |
| `<c-\>` | Toggle terminal |

## Telescope (Fuzzy Finder)

| Keymap | Description |
|--------|-------------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text) |
| `<leader>fb` | Find open buffers |
| `<leader>fh` | Help tags |
| `<leader>fc` | Find commands |

## Flash Motion

| Keymap | Description |
|--------|-------------|
| `s` | Flash jump (go to any character) |
| `S` | Flash Treesitter (navigate by AST) |

## LSP (Language Server)

| Keymap | Description |
|--------|-------------|
| `<leader>gd` | Go to definition |
| `<leader>gr` | Go to references |
| `<leader>gi` | Go to implementation |
| `<leader>k` | Show hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>e` | Show diagnostics |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

## Git Integration

### Fugitive (Git operations)
| Keymap | Description |
|--------|-------------|
| `<leader>gs` | Git status |
| `<leader>gc` | Git commit |
| `<leader>gp` | Git push |
| `<leader>gl` | Git pull |

### Gitsigns (Hunk management)
| Keymap | Description |
|--------|-------------|
| `]c` | Next git hunk |
| `[c` | Previous git hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage entire buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hR` | Reset entire buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Show blame |
| `<leader>hd` | Diff this hunk |
| `<leader>hD` | Diff against last commit |

## Testing & Debugging

### Neotest (Run tests)
| Keymap | Description |
|--------|-------------|
| `<leader>tt` | Run file tests |
| `<leader>tn` | Run nearest test |
| `<leader>ts` | Toggle test summary |
| `<leader>to` | Show test output |

### DAP (Debugger)
| Keymap | Description |
|--------|-------------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue execution |
| `<leader>do` | Step over |
| `<leader>di` | Step into |
| `<leader>dO` | Step out |
| `<leader>dr` | Open REPL |
| `<leader>dl` | Run last |

## Formatting

| Keymap | Description |
|--------|-------------|
| `<leader>fm` | Format buffer |

## Markdown & Documentation

| Keymap | Description |
|--------|-------------|
| `<leader>mr` | Toggle render markdown |
| `<leader>me` | Enable render markdown |
| `<leader>md` | Disable render markdown |
| `<leader>mp` | Toggle markdown preview |
| `<leader>ms` | Start markdown preview |
| `<leader>mq` | Stop markdown preview |

## Quarto & Literate Programming

| Keymap | Description |
|--------|-------------|
| `<leader>qp` | Preview Quarto document |
| `<leader>qc` | Run current code cell |
| `<leader>qa` | Run all code cells |
| `<leader>oo` | Enable Otter language support |
| `<leader>od` | Disable Otter language support |
| `<leader>og` | Otter hover/ask |

## Sessions & Persistence

| Keymap | Description |
|--------|-------------|
| `<leader>qs` | Restore session |
| `<leader>ql` | Restore last session |
| `<leader>qd` | Don't save session |

---

## Notes

- The `<leader>` key is typically the spacebar
- All shortcuts are in Normal mode unless specified otherwise
- Some shortcuts work in multiple modes (n=normal, v=visual, x=visual block)
- Check individual plugin documentation for additional keymaps

## Related Files

- See `lua/config/keymaps/` for the actual keymap definitions
- Check individual plugin specs for plugin-specific keymaps
