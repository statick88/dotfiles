#!/bin/bash

# Test Runner Script
# Runs Lua configuration tests

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Neovim Configuration Test Suite ===${NC}\n"

# Check if lua is available
if ! command -v lua &> /dev/null; then
  echo -e "${RED}✗ lua not found in PATH${NC}"
  echo "Install Lua to run tests: brew install lua (macOS) or apt install lua5.1 (Linux)"
  exit 1
fi

echo -e "${GREEN}✓ lua found: $(lua -v)${NC}\n"

# Add nvim lua directory to path for requires
export LUA_PATH="$NVIM_DIR/lua/?.lua;$NVIM_DIR/lua/?/init.lua;$LUA_PATH"

echo -e "${BLUE}Running tests...${NC}\n"

# Run configuration tests
if lua "$NVIM_DIR/tests/test-config.lua"; then
  echo -e "\n${GREEN}✓ All tests passed!${NC}"
  exit 0
else
  echo -e "\n${RED}✗ Tests failed${NC}"
  exit 1
fi
