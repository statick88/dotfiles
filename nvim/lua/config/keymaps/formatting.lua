---@desc Formatting keymaps

local conform_ok, conform = pcall(require, "conform")
if conform_ok then
  vim.keymap.set("", "<leader>fm", function()
    conform.format({ async = true, lsp_fallback = true })
  end, { desc = "Format buffer" })
end
