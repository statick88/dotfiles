#!/bin/bash

# Neovim Configuration Verification Script
# Run this script to verify the installation of all plugins

echo "=========================================="
echo "Neovim Configuration Verification"
echo "=========================================="
echo ""

# Check if fzf is installed
echo "Checking fzf..."
if command -v fzf &> /dev/null; then
    echo "✓ fzf is installed: $(fzf --version)"
else
    echo "✗ fzf not found - install with: brew install fzf"
fi
echo ""

# Check if fd is installed
echo "Checking fd..."
if command -v fd &> /dev/null; then
    echo "✓ fd is installed: $(fd --version | head -1)"
else
    echo "✗ fd not found - optional: brew install fd"
fi
echo ""

# Check if ripgrep is installed
echo "Checking ripgrep..."
if command -v rg &> /dev/null; then
    echo "✓ ripgrep is installed: $(rg --version | head -1)"
else
    echo "✗ ripgrep not found - optional: brew install ripgrep"
fi
echo ""

echo "Checking bat..."
if command -v bat &> /dev/null; then
    echo "✓ bat is installed: $(bat --version | head -1)"
else
    echo "✗ bat not found - optional: brew install bat"
fi
echo ""

echo "Checking Telescope (fuzzy finder)..."
if command -v nvim &> /dev/null; then
    # Check if telescope plugin is available
    if [ -d "$HOME/.local/share/nvim/lazy/telescope.nvim" ]; then
        echo "✓ Telescope is installed (fuzzy finder)"
    else
        echo "⚠ Telescope not found - will be installed by LazyVim"
    fi
else
    echo "✓ Neovim is installed: $(nvim --version | head -1)"
else
    echo "✗ Neovim not found - install from https://neovim.io/"
    exit 1
fi
echo ""

# Check configuration files
echo "Checking configuration files..."
CONFIG_DIR="$HOME/.config/nvim"

if [ -d "$CONFIG_DIR/lua/plugins" ]; then
    echo "✓ Plugins directory exists"
else
    echo "✗ Plugins directory not found"
fi

if [ -f "$CONFIG_DIR/lua/plugins/ai.lua" ]; then
    echo "✓ ai.lua exists"
else
    echo "✗ ai.lua not found"
fi

if [ -f "$CONFIG_DIR/lua/plugins/productivity.lua" ]; then
    echo "✓ productivity.lua exists"
else
    echo "✗ productivity.lua not found"
fi

if [ -f "$CONFIG_DIR/lua/plugins/debugging.lua" ]; then
    echo "✓ debugging.lua exists"
else
    echo "✗ debugging.lua not found"
fi

if [ -f "$CONFIG_DIR/lua/plugins/ui.lua" ]; then
    echo "✓ ui.lua exists"
else
    echo "✗ ui.lua not found"
fi

if [ -f "$CONFIG_DIR/lua/plugins/documentation.lua" ]; then
    echo "✓ documentation.lua exists"
else
    echo "✗ documentation.lua not found"
fi
echo ""

# Check keymaps
echo "Checking keymaps..."
if [ -f "$CONFIG_DIR/lua/config/keymaps/finder.lua" ]; then
    echo "✓ finder.lua exists"
else
    echo "✗ finder.lua not found"
fi
echo ""

# Environment variables check
echo "Checking environment variables..."
if [ -n "$ANTHROPIC_API_KEY" ]; then
    echo "✓ ANTHROPIC_API_KEY is set"
else
    echo "⚠ ANTHROPIC_API_KEY not set - Claude AI plugins won't work"
fi
echo ""

echo "=========================================="
echo "To run full health checks in Neovim:"
echo "=========================================="
echo ""
echo "1. Open Neovim:"
echo "   nvim"
echo ""
echo "2. Run health checks:"
echo "   :checkhealth lazyvim"
echo "   :checkhealth blink_cmp"
echo "   :checkhealth telescope"
echo "   :checkhealth neotest"
echo "   :checkhealth dap"
echo ""
echo "3. Sync plugins:"
echo "   :Lazy sync"
echo ""
echo "=========================================="
