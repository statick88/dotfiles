---@desc Core navigation and window management keymaps

-- Smart splits keymaps for window navigation and resizing
local smart_splits_ok, smart_splits = pcall(require, "smart-splits")
if smart_splits_ok then
  vim.keymap.set("n", "<C-h>", smart_splits.move_cursor_left, { desc = "Move cursor left" })
  vim.keymap.set("n", "<C-j>", smart_splits.move_cursor_down, { desc = "Move cursor down" })
  vim.keymap.set("n", "<C-k>", smart_splits.move_cursor_up, { desc = "Move cursor up" })
  vim.keymap.set("n", "<C-l>", smart_splits.move_cursor_right, { desc = "Move cursor right" })
  vim.keymap.set("n", "<C-left>", smart_splits.resize_left, { desc = "Resize left" })
  vim.keymap.set("n", "<C-down>", smart_splits.resize_down, { desc = "Resize down" })
  vim.keymap.set("n", "<C-up>", smart_splits.resize_up, { desc = "Resize up" })
  vim.keymap.set("n", "<C-right>", smart_splits.resize_right, { desc = "Resize right" })
end

-- Toggle terminal
vim.keymap.set("n", "<c-\\>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
