local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup()
mason_lspconfig.setup({
  ensure_installed = {
    "pyright",
    "ruff",
    "lua_ls",
    "ts_ls",
    "html-lsp",
    "css-lsp",
    "json-lsp",
    "yaml-lsp",
    "bashls",
    "dockerfile-language-server",
    "markdownlint-cli2",
  },
})

vim.notify("LSP servers configured!")
