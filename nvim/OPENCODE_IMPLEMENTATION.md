# OpenCode.nvim Implementation Guide

## 📋 Analysis Summary

Based on the repository analysis and your current configuration, here's what I found:

### Current Status

- ✅ OpenCode.nvim is already installed and configured
- ✅ Kitty provider is properly configured
- ✅ Dependencies (snacks.nvim) are set up
- ✅ Auto-reload is enabled
- ✅ Key mappings are defined but can be improved

### Architecture

- **Plugin**: Uses LazyVim's plugin system
- **Provider**: Kitty terminal integration
- **Dependencies**: snacks.nvim for input/picker/terminal
- **Configuration**: Global `vim.g.opencode_opts` setup

## 🔧 Implementation Steps

### 1. Kitty Configuration (Required for MacBook Pro M5)

Add this to your `~/.config/kitty/kitty.conf`:

```bash
# Enable remote control for OpenCode.nvim
allow_remote_control yes
listen_on unix:/tmp/kitty

# Optional: Enable single instance for better integration
single_instance yes
```

**Alternative**: Launch Kitty with these flags: `bash kitty -o allow_remote_control=yes --single-instance --listen-on unix:/tmp/kitty ` ### 2. Plugin Configuration (Already Done) Your current configuration in `lua/plugins/opencode.lua` is correct: ```lua vim.g.opencode_opts = { provider = { enabled = "kitty", kitty = { command = "opencode", args = { "--port", "0" }, -- Auto-port selection }
},
events = {
reload = true,
}
}

````

### 3. Key Mapping Organization (Improved)

I've reorganized your key mappings in `lua/config/keymaps.lua`:

- **Prefix**: `<leader>o` for all OpenCode commands
- **Logical grouping**: Ask, Select, Toggle, Range, Quick actions
- **Descriptive names**: Clear descriptions for each mapping
- **Alternative shortcuts**: Commented out Ctrl-based options

### 4. Key Mapping Reference

| Mapping | Function | Description |
|---------|----------|-------------|
| `<leader>oa` | `ask()` | Ask OpenCode with current context |
| `<leader>os` | `select()` | Select action from menu |
| `<leader>ot` | `toggle()` | Toggle OpenCode session |
| `<leader>or` | `operator()` | Add range to prompt |
| `<leader>ol` | `operator()` | Add line to prompt |
| `<leader>oe` | `prompt("explain")` | Explain current code |
| `<leader>of` | `prompt("fix")` | Fix diagnostics |
| `<leader>or` | `prompt("review")` | Review code |
| `<leader>od` | `prompt("document")` | Add documentation |
| `<leader>ot` | `prompt("test")` | Add tests |
| `<leader>ou` | `command("scroll up")` | Scroll up |
| `<leader>od` | `command("scroll down")` | Scroll down |

## 🚀 Usage Instructions

### Starting OpenCode
1. Ensure Kitty is running with remote control enabled
2. Open Neovim inside Kitty
3. Use `<leader>ot` to toggle OpenCode session
4. Use `<leader>oa` to ask questions about current code

### Context Placeholders
OpenCode understands these placeholders:
- `@this` - Current selection or cursor position
- `@buffer` - Current buffer content
- `@diagnostics` - Current diagnostics
- `@diff` - Git diff
- `@visible` - Visible text

### Common Workflows
1. **Code Review**: Select code → `<leader>or` → `<leader>or` (review)
2. **Bug Fix**: Place cursor on error → `<leader>of` (fix)
3. **Documentation**: Select function → `<leader>od` (document)
4. **Testing**: Select code → `<leader>ot` (test)

## 🔍 Troubleshooting

### Common Issues
1. **Kitty remote control not working**
   - Verify `kitty.conf` has `allow_remote_control yes`
   - Check socket path: `/tmp/kitty`
   - Restart Kitty after config changes

2. **OpenCode not connecting**
   - Ensure OpenCode CLI is installed
   - Check if running inside Kitty
   - Use `:checkhealth opencode` for diagnostics

3. **Key mappings not working**
   - Verify plugin is loaded with `:Lazy`
   - Check for conflicts with other mappings
   - Use `:verbose map <leader>oa` to debug

### Health Check
Run this command in Neovim:
```vim
:checkhealth opencode
````

## 📚 Additional Resources

- [OpenCode.nvim Repository](https://github.com/NickvanDyke/opencode.nvim)
- [Kitty Remote Control](https://sw.kovidgoyal.net/kitty/remote-control/)
- [LazyVim Documentation](https://lazyvim.github.io/)

## ✅ Next Steps

1. Configure Kitty with remote control
2. Restart Kitty to apply changes
3. Test the new key mappings
4. Run health check to verify setup
5. Start using OpenCode for AI-assisted coding

Your implementation is now properly organized and ready for production use!

