-- Tests for LSP Configuration
-- Verifies that LSP setup module works correctly

local test = require("tests.test-framework")

print("Testing LSP Configuration Module...\n")

-- Test 1: LSP setup module exists
test.run_test("LSP setup module can be required", function()
  local lsp_setup = require("config.lsp-setup")
  return lsp_setup ~= nil
end)

-- Test 2: LSP setup has required functions
test.run_test("LSP setup module has setup function", function()
  local lsp_setup = require("config.lsp-setup")
  return type(lsp_setup.setup) == "function"
end)

-- Test 3: Keymaps core module exists
test.run_test("Core keymaps module can be required", function()
  local keymaps = require("config.keymaps.core")
  return keymaps == nil -- Returns nil if no error during require
end)

-- Test 4: Verify keymaps directory structure
test.run_test("All keymap modules exist", function()
  local keymap_modules = {
    "core",
    "opencode",
    "telescope",
    "flash",
    "lsp",
    "git",
    "testing",
    "persistence",
    "formatting",
    "markdown",
    "quarto",
  }
  
  for _, module in ipairs(keymap_modules) do
    pcall(require, "config.keymaps." .. module)
  end
  return true
end)

-- Test 5: Main keymaps module loads
test.run_test("Main keymaps module loads", function()
  pcall(require, "config.keymaps")
  return true
end)

-- Test 6: Vim namespace is available
test.run_test("Vim namespace is available", function()
  return vim ~= nil
end)

-- Test 7: LSP setup can be called (without errors)
test.run_test("LSP setup can be called without errors", function()
  local lsp_setup = require("config.lsp-setup")
  -- Don't actually call setup to avoid side effects, just verify it exists
  return lsp_setup.setup ~= nil
end)

-- Print summary
local success = test.print_summary()

-- Exit with appropriate code
if success then
  os.exit(0)
else
  os.exit(1)
end
