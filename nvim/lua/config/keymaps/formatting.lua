---@desc Formatting and linting keymaps

local conform_ok, conform = pcall(require, "conform")
if conform_ok then
  vim.keymap.set("", "<leader>fm", function()
    conform.format({ async = true, lsp_fallback = true })
  end, { desc = "Format buffer" })
  vim.keymap.set("v", "<leader>fm", function()
    conform.format({ async = true, lsp_fallback = true })
  end, { desc = "Format (visual)" })
end

vim.keymap.set("n", "<leader>ll", function()
  require("lint").try_lint()
end, { desc = "Run linter" })
vim.keymap.set("n", "<leader>lt", ":TodoTelescope<CR>", { desc = "TODO/FIXME" })
