-- Neovim Configuration Test Suite
-- Simple test framework for Lua configuration

local M = {}

-- Test counter
local tests_run = 0
local tests_passed = 0
local tests_failed = 0
local failed_tests = {}

---Run a test case
---@param test_name string Name of the test
---@param test_fn function Function that should return true if test passes
local function run_test(test_name, test_fn)
  tests_run = tests_run + 1
  
  local success, result = pcall(test_fn)
  
  if success and result then
    tests_passed = tests_passed + 1
    print("✓ " .. test_name)
  else
    tests_failed = tests_failed + 1
    table.insert(failed_tests, test_name)
    print("✗ " .. test_name)
    if not success then
      print("  Error: " .. tostring(result))
    end
  end
end

---Assert that condition is true
---@param condition boolean
---@param message string Error message if condition is false
local function assert_true(condition, message)
  if not condition then
    error(message or "Assertion failed")
  end
  return true
end

---Assert that condition is false
---@param condition boolean
---@param message string Error message if condition is true
local function assert_false(condition, message)
  if condition then
    error(message or "Assertion failed")
  end
  return true
end

---Assert that value equals expected
---@param value any Actual value
---@param expected any Expected value
---@param message string Error message
local function assert_equals(value, expected, message)
  if value ~= expected then
    error((message or "") .. " (got " .. tostring(value) .. ", expected " .. tostring(expected) .. ")")
  end
  return true
end

---Print test summary
local function print_summary()
  print("\n" .. string.rep("=", 50))
  print("Test Summary")
  print(string.rep("=", 50))
  print("Total tests:  " .. tests_run)
  print("Passed:       " .. tests_passed)
  print("Failed:       " .. tests_failed)
  
  if tests_failed > 0 then
    print("\nFailed tests:")
    for _, test_name in ipairs(failed_tests) do
      print("  - " .. test_name)
    end
    print("\nStatus: FAILED")
  else
    print("\nStatus: PASSED")
  end
  print(string.rep("=", 50) .. "\n")
  
  return tests_failed == 0
end

-- Export test utilities
M.run_test = run_test
M.assert_true = assert_true
M.assert_false = assert_false
M.assert_equals = assert_equals
M.print_summary = print_summary

return M
