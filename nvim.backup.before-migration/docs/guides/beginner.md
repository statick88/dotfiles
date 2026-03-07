# Getting Started with Neovim LazyVim

Welcome to your LazyVim Neovim configuration! This guide will help you get started.

## Prerequisites

- **Neovim** (v0.10.0 or later)
- **Git** (for cloning plugins)
- **Node.js** (for some LSP servers)
- **Python 3** (for Python support)
- **Basic terminal knowledge**

### Installation

#### macOS (Homebrew)
```bash
brew install neovim
brew install git nodejs python3
```

#### Ubuntu/Debian
```bash
sudo apt-get install neovim git nodejs python3 python3-pip
```

#### Fedora
```bash
sudo dnf install neovim git nodejs python3
```

## Configuration Location

Your Neovim configuration is located at:
```bash
~/.config/nvim/
```

The main entry point is `init.lua`.

## First Launch

When you launch Neovim for the first time:

1. **Lazy.nvim** will install all plugins automatically
2. **Mason** will auto-install LSP servers
3. **Treesitter** will install language parsers
4. Wait for the setup to complete (~1-2 minutes)

```bash
# Launch Neovim
nvim

# Inside Neovim, wait for plugins to install
# Press Ctrl+C if needed, or just wait
# Once done, you can start editing!
```

## Key Concepts

### Leader Key
The **leader key** is mapped to the **spacebar** (`<Space>`). Many shortcuts start with this key.

Example: `<leader>ff` means `Space` + `f` + `f` to find files.

### Modes
- **Normal Mode**: Navigate and edit (default mode)
- **Insert Mode**: Type text (press `i` to enter)
- **Visual Mode**: Select text (press `v` to enter)
- **Command Mode**: Run commands (press `:` to enter)

### Essential Keymaps

| Key | Action |
|-----|--------|
| `hjkl` | Move cursor (left, down, up, right) |
| `i` | Enter Insert mode |
| `Esc` | Return to Normal mode |
| `v` | Enter Visual mode |
| `:w` | Save file |
| `:q` | Quit Neovim |
| `:wq` | Save and quit |

## Finding Your Way

### Help System
```bash
# Inside Neovim:
:help keyword        # Get help on a topic
:Telescope help_tags # Search help with Telescope
```

### Documentation
- **Quick Reference**: `DOCUMENTATION.md` in project root
- **All Keymaps**: `docs/reference/keymaps.md`
- **Plugin List**: `docs/reference/plugins.md`

### In-Editor Help
Press `<leader>` (spacebar) and wait - which-key will show available commands!

## Basic Editing

### Creating & Editing Files
```lua
-- Open a file
nvim myfile.lua

-- Edit
-- Press 'i' to insert, type, press 'Esc' to exit insert mode
i
type your code here
Esc

-- Save
:w

-- Save and quit
:wq
```

### Moving Around
```lua
h    -- Move left
j    -- Move down
k    -- Move up
l    -- Move right

w    -- Jump to next word
b    -- Jump to previous word
0    -- Jump to start of line
$    -- Jump to end of line
gg   -- Jump to start of file
G    -- Jump to end of file
```

### Selecting & Editing
```lua
v       -- Start visual selection
yy      -- Copy line
dd      -- Delete line
p       -- Paste
u       -- Undo
Ctrl+r  -- Redo
```

## Using Plugins

### Telescope (Fuzzy Finder)
Find files, buffers, text, and more:
```
<leader>ff  -- Find files
<leader>fg  -- Search text (grep)
<leader>fb  -- Find buffers
<leader>fc  -- Find commands
```

### Flash (Quick Navigation)
Jump to any character:
```
s   -- Start flash jump, type character, press Enter
S   -- Jump to AST nodes (Treesitter)
```

### LSP (Language Features)
Get code intelligence:
```
<leader>gd  -- Go to definition
<leader>gr  -- Find references
<leader>rn  -- Rename symbol
<leader>ca  -- Code action
<leader>k   -- Show documentation
```

### Git Integration
Work with Git:
```
<leader>gs  -- Git status
<leader>gc  -- Git commit
]c          -- Next git change
[c          -- Previous git change
<leader>hs  -- Stage hunk
```

### AI Assistant (OpenCode)
Get help from AI:
```
<leader>oa  -- Ask OpenCode
<leader>os  -- Select action
<leader>ot  -- Toggle chat
```

## Customizing Your Config

### Directory Structure
```
~/.config/nvim/
├── lua/
│   ├── config/           # Configuration
│   │   ├── options.lua   # Editor settings
│   │   ├── keymaps.lua   # Main keymaps (loads subdirectories)
│   │   ├── keymaps/      # Organized keymaps
│   │   └── ...
│   └── plugins/          # Plugin specifications
│       ├── ui.lua        # UI/theme plugins
│       ├── desarrollo.lua # Development tools
│       └── ...
└── init.lua              # Entry point
```

### Adding a New Keymap
Edit `lua/config/keymaps.lua` or create a new file in `lua/config/keymaps/`:

```lua
-- Example: adding a keymap
vim.keymap.set("n", "<leader>xt", function()
  -- Your code here
end, { desc = "My new command" })
```

### Installing a New Plugin
Create a new file in `lua/plugins/` or edit `plugins/desarrollo.lua`:

```lua
{
  "github/plugin-name",
  event = "VeryLazy",  -- When to load
  config = function()
    -- Setup code
  end,
}
```

Then run `:Lazy update` in Neovim.

## Troubleshooting

### Plugins Not Loading
```lua
-- Check plugin status
:Lazy

-- Update plugins
:Lazy update

-- Check health
:checkhealth
```

### LSP Not Working
```lua
-- Check LSP status
:LspInfo

-- Mason servers
:Mason

-- Install missing server
:MasonInstall python-lsp-server
```

### Colors Look Wrong
```lua
-- Reset colorscheme
:colorscheme tokyonight

-- Or try
:colorscheme catppuccin
```

## Next Steps

1. **Learn the basics**: Navigate, edit, save (hjkl, i, Esc, :w)
2. **Explore plugins**: Try Telescope, Flash, LSP features
3. **Customize keymaps**: Add your own shortcuts
4. **Read documentation**: Check `docs/` folder
5. **Join community**: Check Neovim community resources

## Resources

- **Neovim Official**: https://neovim.io/
- **LazyVim**: https://www.lazyvim.org/
- **Lua Guide**: https://www.lua.org/manual/5.1/
- **Vim Tutorial**: `:tutor` inside Neovim
- **Community**: https://neovim.io/community/

## Getting Help

Inside Neovim:
```bash
:help                  # General help
:Telescope help_tags   # Search help
:checkhealth           # Diagnose issues
```

From terminal:
```bash
# View specific documentation
cat ~/.config/nvim/DOCUMENTATION.md
cat ~/.config/nvim/docs/reference/keymaps.md

# Run tests
./scripts/run-tests.sh

# Validate config
./scripts/validate-config.sh
```

---

**Happy coding!** 🚀
