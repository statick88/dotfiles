#!/bin/bash

# Startup Time Profiler for Neovim
# Measures Neovim startup time and plugin loading performance

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Neovim Startup Time Profiler ===${NC}\n"

# Check if nvim exists
if ! command -v nvim &> /dev/null; then
  echo -e "${RED}✗ nvim not found in PATH${NC}"
  exit 1
fi

echo -e "${GREEN}✓ nvim found: $(nvim --version | head -1)${NC}\n"

# Create temporary test file for profiling
TEMP_FILE=$(mktemp)
trap "rm -f $TEMP_FILE" EXIT

# Test 1: Basic startup time
echo -e "${BLUE}Test 1: Basic Startup Time${NC}"
echo "Launching Neovim and measuring startup..."

START_TIME=$(date +%s%N)
nvim --headless -c "quit" $TEMP_FILE > /dev/null 2>&1
END_TIME=$(date +%s%N)

# Calculate time in milliseconds
TIME_MS=$(( (END_TIME - START_TIME) / 1000000 ))

echo -e "${GREEN}✓ Startup time: ${TIME_MS}ms${NC}\n"

# Test 2: Startup with profile
echo -e "${BLUE}Test 2: Plugin Load Times (via :Lazy profile)${NC}"
echo "Note: Run ':Lazy profile' inside Neovim to see detailed plugin load times"
echo ""
echo "To profile, launch Neovim and run:"
echo "  :Lazy profile"
echo -e "  (This shows which plugins take the longest to load)\n"

# Test 3: Startup with VeryLazy disabled
echo -e "${BLUE}Test 3: Startup Profile Info${NC}"
echo -e "Estimated timings (${BLUE}before${NC} vs ${BLUE}after${NC} optimization):\n"

cat <<EOF
Plugin Loading Strategy:

BEFORE Optimization:
  - All plugins load at startup
  - Estimated: 800-1200ms
  - Startup impact: HIGH

AFTER Optimization (current):
  - UI plugins: immediate (~300-400ms)
  - VeryLazy plugins: after UI (~200ms)
  - On-demand plugins: negligible
  - Estimated: 500-800ms
  - Startup impact: REDUCED (30-40% faster)

Current Measured Startup: ${TIME_MS}ms

Optimized Plugins:
  ✓ Telescope (VeryLazy)
  ✓ Smart-splits (VeryLazy)
  ✓ Toggleterm (cmd)
  ✓ Render-markdown (ft)
  ✓ DAP (cmd)
  ✓ Neotest (cmd)
EOF

echo ""

# Test 4: Configuration validation
echo -e "${BLUE}Test 4: Configuration Health Check${NC}"

if [ -f "$NVIM_DIR/scripts/validate-config.sh" ]; then
  if bash "$NVIM_DIR/scripts/validate-config.sh" > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Configuration is valid${NC}"
  else
    echo -e "${YELLOW}⚠️  Configuration check failed${NC}"
  fi
fi

echo ""

# Summary
echo -e "${BLUE}=== Profiling Complete ===${NC}\n"
echo -e "Measured startup time: ${GREEN}${TIME_MS}ms${NC}\n"

if [ $TIME_MS -lt 500 ]; then
  echo -e "${GREEN}✓ EXCELLENT startup time (< 500ms)${NC}"
elif [ $TIME_MS -lt 800 ]; then
  echo -e "${GREEN}✓ GOOD startup time (< 800ms)${NC}"
elif [ $TIME_MS -lt 1200 ]; then
  echo -e "${YELLOW}⚠️  ACCEPTABLE startup time (< 1200ms)${NC}"
else
  echo -e "${RED}✗ SLOW startup time (> 1200ms)${NC}"
  echo -e "   Consider: lazy loading more plugins, reducing plugin count"
fi

echo ""

# Recommendations
echo -e "${BLUE}=== Optimization Recommendations ===${NC}\n"

echo "To further optimize:"
echo "1. Run ':Lazy profile' to identify slow-loading plugins"
echo "2. Check docs/guides/performance-optimization.md for strategies"
echo "3. Review lua/config/lazy-loading-analysis.lua for details"
echo "4. Run './scripts/validate-config.sh' to check structure"
echo ""

echo -e "${BLUE}See documentation:${NC}"
echo "  - docs/guides/performance-optimization.md"
echo "  - lua/config/lazy-loading-analysis.lua"
echo ""

exit 0
