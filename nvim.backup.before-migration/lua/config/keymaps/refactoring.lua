-- Refactoring Keymaps
local refactor = {}

function refactor.setup()
  local refactoring_ok, _ = pcall(require, "refactoring")
  if refactoring_ok then
    vim.keymap.set("v", "<leader>re", ":Refactor extract ", { desc = "Extract" })
    vim.keymap.set("v", "<leader>rf", ":Refactor function ", { desc = "Extract function" })
    vim.keymap.set("v", "<leader>rv", ":Refactor extract_var ", { desc = "Extract variable" })
    vim.keymap.set("v", "<leader>rb", ":Refactor extract_block ", { desc = "Extract block" })
  end

  local symbols_ok, _ = pcall(require, "symbols-outline")
  if symbols_ok then
    vim.keymap.set("n", "<leader>cs", ":SymbolsOutline<CR>", { desc = "Code symbols" })
  end

  vim.keymap.set("n", "<leader>rn", ":IncRename ", { desc = "Rename symbol" })
  vim.keymap.set("n", "<leader>gf", vim.lsp.buf.references, { desc = "Go to references" })
  vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
  vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
  vim.keymap.set("n", "<leader>gr", ":Telescope lsp_references<CR>", { desc = "References" })
  vim.keymap.set("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", { desc = "File symbols" })
  vim.keymap.set("n", "<leader>ws", ":Telescope lsp_workspace_symbols<CR>", { desc = "Workspace symbols" })
end

refactor.setup()

return refactor
