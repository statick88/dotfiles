-- LSP (Language Server Protocol): Convierte Neovim en un IDE completo
-- Proporciona inteligencia de lenguaje: autocompletado, diagnóstico, definiciones, etc.
-- Comandos principales: gd (go to definition), gr (references), K (documentation)
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    require("mason").setup()
    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "pyright",
        "html",
        "cssls",
        "tailwindcss",
        "dartls",
      },
      automatic_installation = true,
    })
  end,
}
