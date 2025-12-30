-- Treesitter: Resaltado de sintaxis avanzado basado en estructura del código
-- Entiende la diferencia entre función, variable, string, comentario, etc.
-- Comandos útiles: :TSInstall <lang>, :TSInfo, :TSUpdate
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",                                    -- Actualizar parsers automáticamente
  opts = {
    -- Lenguajes instalados para resaltado y análisis sintáctico
    ensure_installed = { 
      "lua",                    -- Para archivos de configuración
      "python",                 -- Para desarrollo backend
      "javascript", "typescript", -- Para desarrollo frontend
      "tsx",                    -- Para React con TypeScript
      "html", "css",            -- Para desarrollo web
      "markdown", "markdown_inline" -- Para documentación
    },
    highlight = { enable = true },                          -- Habilitar resaltado sintáctico
    indent = { enable = true },                             -- Sangría inteligente
  },
}
