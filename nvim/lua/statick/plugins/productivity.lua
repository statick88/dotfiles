-- [UX] Productivity - Plugins para mejorar la eficiencia en desarrollo
-- Solo se carga cuando se detecta un archivo relevante
return {
  -- Flash.nvim - Navegación rápida con highlights
  {
    "folke/flash.nvim",
    event = { "BufRead", "BufNewFile" },
    opts = {},
  },

  -- nvim-surround - Manipular texto alrededor (comillas, paréntesis, etc.)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = { "BufRead", "BufNewFile" },
    opts = {},
  },

  -- todo-comments.nvim - Highlight comentarios TODO, FIXME, etc.
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufRead", "BufNewFile" },
    opts = {
      signs = false,
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info", alt = { "PENDING" } },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },
  },

  -- indent-blankline.nvim - Líneas de indentación visual
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufWritePost" },
    opts = {
      indent = { char = "│" },
      scope = { enabled = false },
    },
  },

  -- nvim-colorizer - Muestra colores en código hexadecimal
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufRead", "BufNewFile" },
    ft = { "css", "scss", "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte", "lua", "vim", "markdown" },
    opts = {},
  },

  -- trouble.nvim - Lista de diagnósticos y referencias
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = { "BufRead", "BufNewFile" },
    opts = {},
    cmd = "Trouble",
  },

  -- mini.pairs - Autopares mejorado
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },

  -- comment.nvim - Comentarios inteligentes
  {
    "numToStr/Comment.nvim",
    opts = {
      mappings = {
        basic = true,
        extra = true,
      },
    },
    lazy = false,
  },
}
