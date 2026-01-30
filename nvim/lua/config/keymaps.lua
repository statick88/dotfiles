-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Initialize Copilot Chat LSP integration
-- Defer setup to avoid loading issues with CopilotChat initialization
vim.defer_fn(function()
  local lsp_integration_ok, lsp_integration = pcall(require, "config.copilot-lsp-integration")
  if lsp_integration_ok then
    lsp_integration.setup()
  end
end, 100)

-- Load all keymap modules
require("config.keymaps.core")
require("config.keymaps.opencode")
require("config.keymaps.telescope")
require("config.keymaps.flash")
require("config.keymaps.lsp")
require("config.keymaps.git")
require("config.keymaps.testing")
require("config.keymaps.persistence")
require("config.keymaps.formatting")
require("config.keymaps.markdown")
require("config.keymaps.quarto")
