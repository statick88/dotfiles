#!/bin/bash

# Test script for Kitty configuration
# Verifica que la configuración de Kitty sea correcta

echo "🐱 Testing Kitty configuration..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print test results
print_test() {
    local test_name="$1"
    local result="$2"
    
    if [ "$result" -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $test_name"
    else
        echo -e "${RED}✗${NC} $test_name"
    fi
}

# Test 1: Check if kitty is installed
echo ""
echo "Test 1: Checking if Kitty is installed..."
if command -v kitty &> /dev/null; then
    KITTY_VERSION=$(kitty --version)
    print_test "Kitty is installed ($KITTY_VERSION)" 0
else
    print_test "Kitty is not installed" 1
    echo -e "${YELLOW}⚠${NC} Please install Kitty first:"
    echo "  macOS: brew install kitty"
    echo "  Ubuntu: sudo apt install kitty"
    echo "  Arch: sudo pacman -S kitty"
    exit 1
fi

# Test 2: Check if config directory exists
echo ""
echo "Test 2: Checking config directory..."
CONFIG_DIR="$HOME/.config/kitty"
if [ -d "$CONFIG_DIR" ]; then
    print_test "Config directory exists: $CONFIG_DIR" 0
else
    print_test "Config directory missing: $CONFIG_DIR" 1
fi

# Test 3: Check if config file exists
echo ""
echo "Test 3: Checking config file..."
CONFIG_FILE="$CONFIG_DIR/kitty.conf"
if [ -f "$CONFIG_FILE" ]; then
    print_test "Config file exists: $CONFIG_FILE" 0
else
    print_test "Config file missing: $CONFIG_FILE" 1
    exit 1
fi

# Test 4: Validate config syntax
echo ""
echo "Test 4: Validating config syntax..."
# Check if config has valid structure (basic checks)
if grep -q "^font_family" "$CONFIG_FILE" && grep -q "^font_size" "$CONFIG_FILE" && grep -q "^foreground" "$CONFIG_FILE" && grep -q "^background" "$CONFIG_FILE"; then
    print_test "Config file has basic required sections" 0
    
    # Check for common syntax errors
    if grep -E "^[a-zA-Z_]+[[:space:]]+$" "$CONFIG_FILE" &> /dev/null; then
        print_test "Found lines with missing values" 1
    else
        print_test "No obvious syntax errors found" 0
    fi
else
    print_test "Config file missing basic sections" 1
fi

# Test 5: Check essential config options
echo ""
echo "Test 5: Checking essential config options..."

# Check font configuration
if grep -q "^font_family" "$CONFIG_FILE"; then
    FONT_FAMILY=$(grep "^font_family" "$CONFIG_FILE" | cut -d' ' -f2-)
    print_test "Font family configured: $FONT_FAMILY" 0
else
    print_test "Font family not configured" 1
fi

if grep -q "^font_size" "$CONFIG_FILE"; then
    FONT_SIZE=$(grep "^font_size" "$CONFIG_FILE" | cut -d' ' -f2)
    print_test "Font size configured: $FONT_SIZE" 0
else
    print_test "Font size not configured" 1
fi

# Check color configuration
if grep -q "^foreground" "$CONFIG_FILE"; then
    print_test "Foreground color configured" 0
else
    print_test "Foreground color not configured" 1
fi

if grep -q "^background" "$CONFIG_FILE"; then
    print_test "Background color configured" 0
else
    print_test "Background color not configured" 1
fi

# Test 6: Check keybindings
echo ""
echo "Test 6: Checking keybindings..."
KEYBINDINGS=(
    "copy_to_clipboard"
    "paste_from_clipboard"
    "new_tab"
)

for binding in "${KEYBINDINGS[@]}"; do
    if grep -q "$binding" "$CONFIG_FILE"; then
        print_test "Keybinding found: $binding" 0
    else
        print_test "Keybinding missing: $binding" 1
    fi
done

# Test 7: Check if README exists
echo ""
echo "Test 7: Checking documentation..."
README_FILE="$CONFIG_DIR/README.md"
if [ -f "$README_FILE" ]; then
    print_test "README file exists" 0
else
    print_test "README file missing" 1
fi

# Test 8: Try to validate configuration by parsing
echo ""
echo "Test 8: Testing configuration syntax validation..."
# Parse configuration for obvious errors
syntax_errors=0

# Check for lines with comments that might be malformed
while IFS= read -r line; do
    # Skip empty lines and comments
    [[ "$line" =~ ^[[:space:]]*$ ]] && continue
    [[ "$line" =~ ^[[:space:]]*# ]] && continue
    
    # Check if line has valid format (key value or key value options)
    if [[ ! "$line" =~ ^[a-zA-Z_][a-zA-Z0-9_]*[[:space:]] ]]; then
        echo "Potentially malformed line: $line"
        ((syntax_errors++))
    fi
done < "$CONFIG_FILE"

if [ "$syntax_errors" -eq 0 ]; then
    print_test "Configuration syntax appears valid" 0
else
    print_test "Found $syntax_errors potential syntax errors" 1
fi

echo ""
echo "🐱 Kitty configuration test completed!"
echo ""
echo "To use this configuration:"
echo "  1. Make sure Kitty is installed"
echo "  2. Configuration should be automatically loaded from ~/.config/kitty/kitty.conf"
echo "  3. Restart Kitty or press Ctrl+Shift+F5 to reload configuration"
echo ""
echo "For more information, see: $README_FILE"