---@desc Session and persistence keymaps

local persistence_ok, persistence = pcall(require, "persistence")
if persistence_ok then
  vim.keymap.set("n", "<leader>qs", function()
    persistence.load()
  end, { desc = "Restore Session" })

  vim.keymap.set("n", "<leader>ql", function()
    persistence.load({ last = true })
  end, { desc = "Restore Last Session" })

  vim.keymap.set("n", "<leader>qd", function()
    persistence.stop()
  end, { desc = "Don't Save Current Session" })
end
