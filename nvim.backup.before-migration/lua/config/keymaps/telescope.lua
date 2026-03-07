---@desc Telescope fuzzy finder keymaps

local telescope_ok, telescope = pcall(require, "telescope.builtin")
if telescope_ok then
  vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Find files" })
  vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Live grep" })
  vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Find buffers" })
  vim.keymap.set("n", "<leader>fh", telescope.help_tags, { desc = "Help tags" })
  vim.keymap.set("n", "<leader>fc", telescope.commands, { desc = "Find commands" })
end
