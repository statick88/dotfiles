return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    -- He añadido markdown para compatibilidad con el nuevo plugin sugerido
    ensure_installed = { "lua", "python", "javascript", "typescript", "tsx", "html", "css", "markdown", "markdown_inline" },
    highlight = { enable = true },
    indent = { enable = true },
  },
}
