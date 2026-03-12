-- Snacks UI Handlers - Diego Saavedra
-- Configure vim.ui handlers to use Snacks

-- Use VeryLazy event to ensure Snacks is loaded before setting handlers
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- Safely set vim.ui.input
    pcall(function()
      vim.ui.input = require("snacks.input").input
    end)

    -- Safely set vim.ui.select
    pcall(function()
      vim.ui.select = require("snacks.picker").select
    end)
  end,
  group = vim.api.nvim_create_augroup("snacks_ui_handlers", { clear = true }),
  desc = "Configure Snacks UI handlers after VeryLazy",
})
