-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.defer_fn(function()
  local lsp_integration_ok, lsp_integration = pcall(require, "config.copilot-lsp-integration")
  if lsp_integration_ok then
    lsp_integration.setup()
  end
end, 100)

-- Load all keymap modules
require("config.keymaps.core")
require("config.keymaps.telescope")
require("config.keymaps.flash")
require("config.keymaps.lsp")
require("config.keymaps.git")
require("config.keymaps.testing")
require("config.keymaps.persistence")
require("config.keymaps.formatting")
require("config.keymaps.markdown")
require("config.keymaps.quarto")
require("config.keymaps.docker")
require("config.keymaps.ai")
require("config.keymaps.productivity")
require("config.keymaps.refactoring")
require("config.keymaps.flutter")
