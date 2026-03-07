-- Plugins extra inspirados en Gentleman.Dots
return {
  -- veil.nvim: Ocultar secretos en archivos .env (de Gentleman.Dots)
  {
    "Gentleman-Programming/veil.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      patterns = {
        { pattern = "(KEY)=.+", replacement = "%1=🔒" },
        { pattern = "(SECRET)=.+", replacement = "%1=🔒" },
        { pattern = "(PASSWORD)=.+", replacement = "%1=🔒" },
        { pattern = "(TOKEN)=.+", replacement = "%1=🔒" },
        { pattern = "(API_KEY)=.+", replacement = "%1=🔒" },
      },
    },
  },

  -- todo-comments.nvim: Resaltar TODO, FIXME, etc.
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        keywords = {
          FIX = { icon = "", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
          TODO = { icon = "", color = "info" },
          HACK = { icon = "", color = "warning" },
          WARN = { icon = "", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = "", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = "", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
      })
    end,
  },

  -- trouble.nvim: Mejor visualización de diagnostics
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        auto_open = false,
        auto_close = true,
        auto_preview = true,
        auto_fold = false,
        signs = {
          error = "",
          warning = "",
          hint = "",
          information = "",
        },
      })
    end,
  },

  -- persistence.nvim: Session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
        pre_save = nil,
      })

      -- Keymaps para sessions
      vim.keymap.set("n", "<leader>qs", function()
        require("persistence").load()
      end, { desc = "Restore Session" })
      vim.keymap.set("n", "<leader>ql", function()
        require("persistence").load({ last = true })
      end, { desc = "Restore Last Session" })
      vim.keymap.set("n", "<leader>qd", function()
        require("persistence").stop()
      end, { desc = "Don't Save Current Session" })
    end,
  },

  -- vim-illuminate: Resaltar palabras bajo el cursor
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("illuminate").configure({
        delay = 200,
        large_file_cutoff = 2000,
        large_file_overrides = {
          providers = { "lsp" },
        },
      })
    end,
  },

  -- nvim-surround: Manipular surroundings fácilmente
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
        },
      })
    end,
  },

  -- nvim-spectre: Buscar y reemplazar potente
  {
    "nvim-pack/nvim-spectre",
    cmd = { "Spectre" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("spectre").setup({
        color_devicons = true,
        open_cmd = "vnew",
        live_update = false,
        line_sep_start = "┌-----------------------------------------",
        result_padding = "¦  ",
        line_sep = "└-----------------------------------------",
        highlight = {
          ui = "String",
          search = "DiffChange",
          replace = "DiffDelete",
        },
      })
    end,
  },

  -- which-key.nvim: Mostrar keymaps disponibles
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
        window = {
          border = "single",
          position = "bottom",
          margin = { 1, 0, 1, 0 },
          padding = { 2, 2, 2, 2 },
          winblend = 0,
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 3,
          align = "left",
        },
        show_help = true,
        show_keys = true,
      })
    end,
  },

  -- indent-blankline.nvim: Líneas de indentación
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    config = function()
      require("ibl").setup({
        indent = {
          char = "▏",
          tab_char = "▏",
        },
        scope = {
          enabled = true,
          show_start = true,
          show_end = false,
        },
        exclude = {
          filetypes = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        },
      })
    end,
  },
}
