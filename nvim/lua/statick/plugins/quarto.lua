-- [DOC] quarto-nvim: Plugin oficial de Quarto para Neovim
-- Proporciona herramientas para trabajar con documentos Quarto (.qmd)
-- Ejecución de celdas, navegación entre chunks, previsualización, etc.
return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "nvim-treesitter/nvim-treesitter",
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "benlubas/otter.nvim",
    },
      config = function()
      -- Configuración básica de quarto-nvim con otter integration
      require("quarto").setup({
        -- Configuración de ejecución de código
        debug = false,                                   -- Desactivar debug para mejor rendimiento
        
        -- Configuración de ejecución de celdas
        run_preferences = {
          -- Preferencias para ejecutar celdas de Python/R
          -- Estos ajustes optimizan la ejecución en notebooks Quarto
          quote_vertical_bars = true,                  -- Comillas en barras verticales
        },
        
        -- Configuración de navegación
        navigation = {
          -- Habilitar navegación entre celdas/chunks de código
          enable = true,
          -- Teclas personalizadas para navegación (configuradas en keymaps abajo)
          -- Por defecto usa [b y ]b para anterior/siguiente celda
        },
        
        -- Configuración de LSP para Quarto
        lsp = {
          -- Soporte para autocompletado y diagnósticos
          enable = true,
          -- Configuración de servidores específicos para Quarto
          servers = {
            -- Servidores LSP para diferentes lenguajes en Quarto
            -- Python, R, Julia, etc. se configuran automáticamente
          },
        },
        
        -- Configuración de archivos
        filetypes = {
          -- Tipos de archivo que Quarto manejará
          "quarto", "markdown",
        },
      })
    end,
  },
}