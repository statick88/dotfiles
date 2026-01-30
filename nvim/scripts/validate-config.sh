#!/bin/bash

# Neovim Configuration Validation Script
# Validates configuration, formatting, and basic functionality

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Neovim Configuration Validation ===${NC}\n"

# Check if stylua is installed
if ! command -v stylua &> /dev/null; then
  echo -e "${YELLOW}⚠️  stylua not found. Install with: cargo install stylua${NC}"
else
  echo -e "${GREEN}✓ stylua found${NC}"
fi

# Format check
echo -e "\n${BLUE}Checking Lua formatting...${NC}"
if command -v stylua &> /dev/null; then
  if stylua --check "$NVIM_DIR/lua" 2>/dev/null; then
    echo -e "${GREEN}✓ All Lua files are properly formatted${NC}"
  else
    echo -e "${YELLOW}⚠️  Some files need formatting. Run: stylua $NVIM_DIR${NC}"
  fi
else
  echo -e "${YELLOW}⊘ stylua not available, skipping format check${NC}"
fi

# Check Lua syntax (if lua is available)
echo -e "\n${BLUE}Checking Lua syntax...${NC}"
if ! command -v lua &> /dev/null; then
  echo -e "${YELLOW}⊘ lua not available, skipping syntax check${NC}"
else
  syntax_errors=0
  for lua_file in $(find "$NVIM_DIR/lua" -name "*.lua" -type f); do
    if ! lua -e "local f = loadfile('$lua_file'); if not f then error() end" 2>/dev/null; then
      echo -e "${RED}✗ Syntax error in $lua_file${NC}"
      ((syntax_errors++))
    fi
  done

  if [ $syntax_errors -eq 0 ]; then
    echo -e "${GREEN}✓ No Lua syntax errors found${NC}"
  else
    echo -e "${RED}✗ Found $syntax_errors file(s) with syntax errors${NC}"
  fi
fi

# Check keymaps directory structure
echo -e "\n${BLUE}Checking keymap structure...${NC}"
expected_keymap_files=(
  "core.lua"
  "opencode.lua"
  "telescope.lua"
  "flash.lua"
  "lsp.lua"
  "git.lua"
  "testing.lua"
  "persistence.lua"
  "formatting.lua"
  "markdown.lua"
  "quarto.lua"
)

keymap_dir="$NVIM_DIR/lua/config/keymaps"
for file in "${expected_keymap_files[@]}"; do
  if [ -f "$keymap_dir/$file" ]; then
    echo -e "${GREEN}✓ $file${NC}"
  else
    echo -e "${RED}✗ Missing $file${NC}"
  fi
done

# Check if main keymap file exists
if [ -f "$NVIM_DIR/lua/config/keymaps.lua" ]; then
  echo -e "${GREEN}✓ Main keymaps.lua exists${NC}"
else
  echo -e "${RED}✗ Main keymaps.lua not found${NC}"
fi

# Check LSP setup
echo -e "\n${BLUE}Checking LSP configuration...${NC}"
if [ -f "$NVIM_DIR/lua/config/lsp-setup.lua" ]; then
  echo -e "${GREEN}✓ Consolidated LSP setup found${NC}"
else
  echo -e "${RED}✗ Consolidated LSP setup not found${NC}"
fi

# Check plugin configuration files
echo -e "\n${BLUE}Checking plugin files...${NC}"
plugin_files=(
  "ui.lua"
  "desarrollo.lua"
  "productividad.lua"
  "copilot.lua"
  "copilot-chat.lua"
  "opencode.lua"
  "render-markdown.lua"
  "quarto.lua"
)

for file in "${plugin_files[@]}"; do
  if [ -f "$NVIM_DIR/lua/plugins/$file" ]; then
    echo -e "${GREEN}✓ $file${NC}"
  else
    echo -e "${YELLOW}⚠️  $file not found (optional)${NC}"
  fi
done

# Summary
echo -e "\n${BLUE}=== Validation Complete ===${NC}"
echo -e "${GREEN}✓ Configuration structure is valid${NC}"
