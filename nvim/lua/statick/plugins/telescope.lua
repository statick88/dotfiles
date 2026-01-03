-- Telescope.nvim: Buscador fuzzy potente para encontrar archivos, texto y más
-- Es como tener "Ctrl+Shift+F" de VSCode pero mucho más potente
-- Uso principal: <leader>pf para buscar archivos, <leader>pg para buscar texto
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },       -- Dependencia requerida para funciones utilitarias
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          path_display = { "smart" },
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      })
      telescope.load_extension("fzf")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
}
