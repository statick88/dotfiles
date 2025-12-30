-- quarto-nvim: Plugin oficial de Quarto para Neovim
-- Proporciona herramientas para trabajar con documentos Quarto (.qmd)
-- Ejecución de celdas, navegación entre chunks, previsualización, etc.
return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "hrsh7th/nvim-cmp",                      -- Para autocompletado en archivos Quarto
      "nvim-treesitter/nvim-treesitter",        -- Para resaltado sintáctico
      "neovim/nvim-lspconfig",                -- Para soporte LSP en Quarto
      "nvim-lua/plenary.nvim",                -- Dependencia requerida
      "benlubas/otter.nvim",                   -- Para ejecución de código en Quarto
      "jmbuhr/otter.nvim",                   -- Alternativa mejorada para otter
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

      -- Keymaps para navegación y ejecución de celdas Quarto
      -- Estos usan <localleader> que es "\" por defecto
      
      -- Navegación entre celdas
      vim.keymap.set("n", "]b", [[<cmd>lua require("quarto.navigator").next()<cr>]], 
                   { desc = "Next Quarto cell", silent = true })
      vim.keymap.set("n", "[b", [[<cmd>lua require("quarto.navigator").previous()<cr>]], 
                   { desc = "Previous Quarto cell", silent = true })
      
      -- Ejecución de código en celdas
      local runner = require("quarto.runner")
      vim.keymap.set("n", "<localleader>rc", runner.run_cell,  
                   { desc = "Run current cell", silent = true })
      vim.keymap.set("n", "<localleader>ra", runner.run_above,  
                   { desc = "Run cell and above", silent = true })
      vim.keymap.set("n", "<localleader>rA", runner.run_all,   
                   { desc = "Run all cells", silent = true })
      vim.keymap.set("n", "<localleader>rl", runner.run_line,  
                   { desc = "Run current line", silent = true })
      vim.keymap.set("v", "<localleader>r", runner.run_range, 
                   { desc = "Run visual range", silent = true })
      vim.keymap.set("n", "<localleader>RA", function()
        runner.run_all(true)  -- Ejecutar todas las celdas de todos los lenguajes
      end, { desc = "Run all cells of all languages", silent = true })
      
      -- Comandos de previsualización
      vim.keymap.set("n", "<localleader>pp", [[<cmd>QuartoPreview<cr>]], 
                   { desc = "Quarto preview", silent = true })
      vim.keymap.set("n", "<localleader>ps", [[<cmd>QuartoPreviewStop<cr>]], 
                   { desc = "Stop Quarto preview", silent = true })
      
      -- Comandos útiles para desarrollo con Quarto
      vim.keymap.set("n", "<localleader>qi", [[<cmd>QuartoInspect<cr>]], 
                   { desc = "Inspect Quarto document", silent = true })
      vim.keymap.set("n", "<localleader>qf", [[<cmd>QuartoFormat<cr>]], 
                   { desc = "Format Quarto document", silent = true })
    end,
  },
}