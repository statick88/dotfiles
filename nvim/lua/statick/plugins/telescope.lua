-- Telescope.nvim: Buscador fuzzy potente para encontrar archivos, texto y más
-- Es como tener "Ctrl+Shift+F" de VSCode pero mucho más potente
-- Uso principal: <leader>pf para buscar archivos, <leader>pg para buscar texto
return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",                                   -- Versión estable para evitar breaking changes
    dependencies = { "nvim-lua/plenary.nvim" },       -- Dependencia requerida para funciones utilitarias
    config = function()
      require("telescope").setup({})                   -- Configuración básica, se expandirá en keymaps.lua
    end,
  },
}
