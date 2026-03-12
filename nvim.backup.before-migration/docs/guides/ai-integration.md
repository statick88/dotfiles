# AI Integration Guide

Using AI assistants (OpenCode & GitHub Copilot) in your Neovim configuration.

## Overview

Your configuration includes two AI assistants:
- **OpenCode**: Advanced AI with multiple models
- **GitHub Copilot**: Code completion and chat

## OpenCode AI Assistant

### What is OpenCode?

OpenCode is an advanced AI coding assistant that runs in your terminal with:
- Multiple model support (Claude, GPT-4, etc.)
- Context-aware suggestions
- Chat interface
- Terminal integration
- Custom prompts

### Quick Start

#### Launch OpenCode
```
<leader>oa  -- Ask with context
<leader>os  -- Select action from menu
<leader>ot  -- Toggle chat window
<leader>ol  -- Add current line to context
```

#### Example Usage

1. Select code: `v` to enter visual mode, select code
2. Ask: `<leader>oa` - type your question
3. Get answer in split window

### Keymaps Reference

| Keymap | Action |
|--------|--------|
| `<leader>oa` | Ask question with current context |
| `<leader>os` | Select predefined action |
| `<leader>or` | Add selected range to prompt |
| `<leader>ot` | Toggle chat window |
| `<leader>ol` | Add current line to prompt |
| `<leader>ou` | Scroll up in chat |
| `<leader>oj` | Scroll down in chat |

### Alternative Keymaps (Commented)

For shorter keys, edit `lua/config/keymaps/opencode.lua`:

```lua
-- Uncomment for shorter keys:
vim.keymap.set({ "n", "x" }, "<C-a>", function()
  require("opencode").ask("@this: ", { submit = true })
end, { desc = "Ask opencode…" })

vim.keymap.set({ "n", "x" }, "<C-x>", function()
  require("opencode").select()
end, { desc = "Execute opencode action…" })

vim.keymap.set({ "n", "t" }, "<C-.>", function()
  require("opencode").toggle()
end, { desc = "Toggle opencode" })
```

### Model Switching

OpenCode includes a model switcher plugin:

**Default**: Claude 3.5 Sonnet

To switch models:
1. Edit `lua/plugins/opencode-model-switcher.lua`
2. Or create custom keymaps for model selection

### Custom Prompts

Create custom prompts in `lua/config/copilot-prompts.lua`:

```lua
local prompts = {
  ["MYCOMMAND"] = {
    prompt = "Your custom instruction",
    description = "Description",
  },
}

return { prompts = prompts }
```

Then use: `/MYCOMMAND` in OpenCode chat

### Tips & Tricks

- **Add Context**: Use `<leader>or` to add relevant code
- **Ask Questions**: Be specific about what you need
- **Review Code**: Ask to review selected code
- **Generate Code**: Ask to generate functions/classes
- **Explain Code**: Select code and ask for explanation
- **Optimize**: Ask for performance improvements

### Troubleshooting

**OpenCode not responding**
- Check internet connection
- Verify API key is set
- Check `:messages` for errors

**Model not available**
- Configure API keys for desired model
- Check model switcher configuration

**Chat window not showing**
- Try `<leader>ot` to toggle
- Check window manager (Kitty required for full features)

## GitHub Copilot

### What is GitHub Copilot?

GitHub Copilot is an AI code completion system that:
- Suggests code as you type
- Includes CopilotChat for conversations
- Integrates with LSP
- Works across languages

### Installation

Requires GitHub Account with Copilot subscription:

1. Get auth token: https://github.com/login/device
2. Inside Neovim: `:Copilot auth`
3. Follow authentication flow
4. Restart Neovim

### Usage

#### Auto-Completion
- Start typing code
- Copilot suggests completions
- `<Tab>` to accept, `<C-]>` to dismiss

#### CopilotChat

| Keymap | Action |
|--------|--------|
| `<leader>cc` | Toggle Copilot Chat |
| `<leader>ce` | Explain code |
| `<leader>cr` | Review code |
| `<leader>cd` | Fix code (visual mode) |
| `<leader>co` | Optimize code (visual mode) |

### Example Workflow

1. **Get Explanation**
   - Select code: `v` (visual mode)
   - `<leader>ce` - explains selected code

2. **Fix Issues**
   - Select problematic code
   - `<leader>cd` - get fix suggestions

3. **Review Code**
   - `<leader>cr` - full code review

### LSP Integration

Copilot Chat integrates with LSP:
- Uses diagnostics for context
- Understands code structure
- Provides language-aware suggestions

Setup details in: `lua/config/copilot-lsp-integration.lua`

### Custom Prompts

Edit Copilot prompts in `lua/config/copilot-prompts.lua`:

```lua
local M = {}

M.prompts = {
  ["/CUSTOM"] = {
    description = "Custom command",
    prompt = "Your custom prompt",
  },
}

return M
```

### Tips & Tricks

- **Accept Partial**: Use `<C-w>` to accept word by word
- **View Alternatives**: Use keys to cycle through suggestions
- **Quick Fix**: Select error, use `<leader>cd`
- **Code Review**: Use `<leader>cr` on entire file/function
- **Explain**: Use `<leader>ce` to understand code

### Troubleshooting

**Copilot not suggesting**
- Check authentication: `:Copilot status`
- Reload: `:Copilot disable` then `:Copilot enable`
- Ensure file type is recognized

**Chat not opening**
- Try `<leader>cc`
- Check window size
- Look at `:messages` for errors

## OpenCode vs Copilot

### Comparison

| Feature | OpenCode | Copilot |
|---------|----------|---------|
| **Models** | Multiple (Claude, GPT-4, etc.) | GPT-4 family |
| **Completion** | No (chat only) | Yes (inline) |
| **Chat** | Yes | Yes |
| **Cost** | Model-dependent | Subscription |
| **Speed** | Variable | Fast |
| **Accuracy** | Very high | High |

### When to Use

**Use OpenCode For**:
- Detailed explanations
- Complex problem-solving
- Code generation
- Architecture discussions
- Model experimentation

**Use Copilot For**:
- Quick completions
- Fast suggestions
- Inline code generation
- Real-time while typing

### Combined Workflow

1. **Quick suggestion**: Use Copilot completion
2. **More context needed**: Ask OpenCode
3. **Detailed review**: Use CopilotChat review
4. **Deep understanding**: Switch to OpenCode

## Environment Setup

### API Keys

**For OpenCode** (if using external models):
```bash
export OPENCODE_API_KEY="your-key"
export OPENCODE_MODEL="gpt-4"
```

**For Copilot**:
- Authenticate: `:Copilot auth`
- Auto-managed after authentication

### Configuration Files

- OpenCode config: `lua/plugins/opencode.lua`
- Copilot config: `lua/plugins/copilot.lua`
- Chat config: `lua/plugins/copilot-chat.lua`
- Prompts: `lua/config/copilot-prompts.lua`
- LSP integration: `lua/config/copilot-lsp-integration.lua`

## Advanced: Custom Integration

### Using OpenCode Programmatically

```lua
-- Get OpenCode reference
local opencode = require("opencode")

-- Ask with custom context
opencode.ask("Optimize this code", { submit = true })

-- Use with range
opencode.operator("@range ")

-- Execute command
opencode.command("session.clear")
```

### Using Copilot Programmatically

```lua
-- Get Copilot Chat reference
local copilot = require("CopilotChat")

-- Ask question
copilot.ask("Explain this code")

-- Run custom command
copilot.ask("/COPILOT_FIX")
```

## Best Practices

### With OpenCode
- Be specific in questions
- Provide context with `<leader>or`
- Use for complex problems
- Review suggestions before accepting

### With Copilot
- Accept completions carefully
- Don't rely solely on suggestions
- Review generated code
- Train it by accepting good suggestions

### General AI Usage
- Always review AI suggestions
- Don't blindly accept code
- Understand what AI generated
- Test thoroughly before committing
- Use as tool, not replacement

## Security Considerations

### API Keys
- Never commit API keys to git
- Use `.env` files (not tracked)
- Use environment variables
- Rotate keys regularly

### Data Privacy
- Be careful with sensitive code
- Don't share credentials via AI
- Review data sent to services
- Read provider privacy policies

### Code Quality
- AI suggestions may have bugs
- Always test generated code
- Review security implications
- Follow your coding standards

## Troubleshooting

### Both AI Tools

**No response from AI**
- Check internet connection
- Verify API access
- Check authentication status
- Review rate limits

**Slow responses**
- Network latency
- Server load
- Model complexity
- Try simpler queries

**Wrong suggestions**
- Provide better context
- Be more specific
- Add more code examples
- Try different approach

### Getting Help

1. Check error messages: `:messages`
2. Review plugin status: `:Lazy`
3. Read plugin docs: `:help copilot`
4. Check plugin repositories

## References

- **OpenCode**: Check `OPENCODE_IMPLEMENTATION.md`
- **Copilot**: `COPILOT_VALIDATION_REPORT.md`
- **Integration**: `lua/config/copilot-lsp-integration.lua`
- **Prompts**: `lua/config/copilot-prompts.lua`

---

**Happy coding with AI!** 🤖
