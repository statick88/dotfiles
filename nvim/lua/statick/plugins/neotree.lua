-- Neo-tree.nvim: Explorador de archivos visual similar al de VSCode
-- Permite navegar, crear, borrar, mover archivos con atajos de teclado
-- Uso principal: <leader>pv para abrir/cerrar, 'a' para crear, 'd' para borrar
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",                                   -- Rama estable con últimas características
    dependencies = {
      "nvim-lua/plenary.nvim",                         -- Funciones utilitarias requeridas
      "nvim-tree/nvim-web-devicons",                    -- Iconos de archivos (📁 folder, 📄 file, etc.)
      "MunifTanjim/nui.nvim",                         -- Componentes UI para ventanas flotantes
    },
    config = function()
      require("neo-tree").setup({
        window = { width = 30 }                          -- Ancho del explorador (30% de pantalla)
      })
    end,
  },
}
