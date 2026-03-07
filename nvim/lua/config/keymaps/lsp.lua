---@desc LSP (Language Server Protocol) keymaps

-- Navigation
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "Go to type definition" })

-- Documentation
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature help" })
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })

-- Code actions
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>cR", function()
  vim.lsp.buf.rename(vim.fn.expand("%:t:r"))
end, { desc = "Rename to filename" })

-- Formatting
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format code" })
vim.keymap.set("n", "<leader>cF", function()
  require("conform").format({ formatters = { "injected" } })
end, { desc = "Format injected languages" })

-- Diagnostics
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
vim.keymap.set("n", "<leader>cD", function()
  vim.diagnostic.open_float(nil, { scope = "buffer" })
end, { desc = "Buffer diagnostics" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]e", function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = true })
end, { desc = "Next error" })
vim.keymap.set("n", "[e", function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = true })
end, { desc = "Prev error" })
vim.keymap.set("n", "]w", function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN, float = true })
end, { desc = "Next warning" })
vim.keymap.set("n", "[w", function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN, float = true })
end, { desc = "Prev warning" })

-- Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble diagnostics" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Trouble buffer diagnostics" })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Trouble loclist" })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Trouble quickfix" })
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "Trouble LSP" })

-- Symbols
vim.keymap.set("n", "<leader>cs", "<cmd>SymbolsOutline<cr>", { desc = "Symbols outline" })

-- LSP Info
vim.keymap.set("n", "<leader>cli", "<cmd>LspInfo<cr>", { desc = "LSP info" })
vim.keymap.set("n", "<leader>clI", "<cmd>LspInstall<cr>", { desc = "LSP install" })
vim.keymap.set("n", "<leader>clr", "<cmd>LspRestart<cr>", { desc = "LSP restart" })
