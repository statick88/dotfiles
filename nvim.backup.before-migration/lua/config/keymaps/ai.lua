-- AI Keymaps
local ai = {}

function ai.setup()
  local ok, _ = pcall(require, "codecompanion")
  if ok then
    vim.keymap.set("n", "<leader>aa", ":Codecompanion<CR>", { desc = "AI Chat" })
    vim.keymap.set("v", "<leader>aa", ":Codecompanion<CR>", { desc = "AI Chat (visual)" })
    vim.keymap.set("n", "<leader>ae", ":Codecompanion explain<CR>", { desc = "AI Explain" })
    vim.keymap.set("n", "<leader>ar", ":Codecompanion review<CR>", { desc = "AI Review" })
  end

  local avante_ok, _ = pcall(require, "avante")
  if avante_ok then
    vim.keymap.set("n", "<leader>at", ":AvanteToggle<CR>", { desc = "Avante Toggle" })
    vim.keymap.set("v", "<leader>at", ":AvanteToggle<CR>", { desc = "Avante Toggle (visual)" })
  end

  local parrot_ok, _ = pcall(require, "parrot")
  if parrot_ok then
    vim.keymap.set("n", "<leader>ap", ":Parrot<CR>", { desc = "Parrot Chat" })
  end
end

ai.setup()

return ai
