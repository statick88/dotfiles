---@desc Debug Adapter Protocol (DAP) keymaps

-- DAP controls
vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>", { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional breakpoint" })
vim.keymap.set("n", "<leader>dl", function()
  require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "Log point" })
vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<cr>", { desc = "Continue" })
vim.keymap.set("n", "<leader>dC", function()
  require("dap").run_to_cursor()
end, { desc = "Run to cursor" })
vim.keymap.set("n", "<leader>dgi", "<cmd>DapStepInto<cr>", { desc = "Step into" })
vim.keymap.set("n", "<leader>dgo", "<cmd>DapStepOver<cr>", { desc = "Step over" })
vim.keymap.set("n", "<leader>dO", "<cmd>DapStepOut<cr>", { desc = "Step out" })
vim.keymap.set("n", "<leader>dp", "<cmd>DapPause<cr>", { desc = "Pause" })
vim.keymap.set("n", "<leader>dr", "<cmd>DapRestartFrame<cr>", { desc = "Restart frame" })
vim.keymap.set("n", "<leader>dR", "<cmd>DapDisconnect<cr>", { desc = "Disconnect" })
vim.keymap.set("n", "<leader>dx", "<cmd>DapTerminate<cr>", { desc = "Terminate" })

-- DAP UI
vim.keymap.set("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "Toggle DAP UI" })
vim.keymap.set("n", "<leader>de", function()
  require("dapui").eval()
end, { desc = "Evaluate expression" })
vim.keymap.set("n", "<leader>dE", function()
  require("dapui").eval(vim.fn.input("Expression: "))
end, { desc = "Evaluate custom expression" })
vim.keymap.set("v", "<leader>de", function()
  require("dapui").eval()
end, { desc = "Evaluate selection" })

-- Debug hover
vim.keymap.set("n", "<leader>dh", function()
  require("dap.ui.widgets").hover()
end, { desc = "Debug hover" })

-- DAP REPL
vim.keymap.set("n", "<leader>ds", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end, { desc = "Debug scopes" })

-- Clear breakpoints
vim.keymap.set("n", "<leader>dX", function()
  require("dap").clear_breakpoints()
  vim.notify("Breakpoints cleared", vim.log.levels.INFO)
end, { desc = "Clear all breakpoints" })

-- Debug for Python (via dap-python)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.keymap.set("n", "<leader>dpm", function()
      require("dap-python").test_method()
    end, { buffer = true, desc = "Debug Python method" })
    vim.keymap.set("n", "<leader>dpc", function()
      require("dap-python").test_class()
    end, { buffer = true, desc = "Debug Python class" })
    vim.keymap.set("n", "<leader>dps", function()
      require("dap-python").debug_selection()
    end, { buffer = true, desc = "Debug Python selection" })
  end,
})
