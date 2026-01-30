---@desc Testing and debugging keymaps

-- DAP (Debug Adapter Protocol) keymaps
local dap_ok, dap = pcall(require, "dap")
if dap_ok then
  vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
  vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
  vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
  vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
  vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
  vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
  vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last" })
end

-- Neotest keymaps for running tests
local neotest_ok, neotest = pcall(require, "neotest")
if neotest_ok then
  vim.keymap.set("n", "<leader>tt", function()
    neotest.run.run(vim.fn.expand("%"))
  end, { desc = "Run file tests" })

  vim.keymap.set("n", "<leader>tn", function()
    neotest.run.run()
  end, { desc = "Run nearest test" })

  vim.keymap.set("n", "<leader>ts", function()
    neotest.summary.toggle()
  end, { desc = "Toggle test summary" })

  vim.keymap.set("n", "<leader>to", function()
    neotest.output.open({ enter = true })
  end, { desc = "Show test output" })
end
