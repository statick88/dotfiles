-- Plugins Git & Docker: Integración completa de control de versiones en Neovim
-- Gitsigns: Muestra cambios en el gutter
-- Lazygit: Interfaz TUI para Git
-- Diffview: Visualización de diffs mejorada
-- Git-conflict: Resolver conflictos Git
-- Blamer: Git blame inline
-- Dockerfile: Syntax highlighting para Docker
return {
  -- Gitsigns - Indicadores visuales de cambios en el gutter
  {
    "lewis6991/gitsigns.nvim",
    config = true,
    -- Comandos útiles: ]c [c para navegar cambios
  },

  -- Lazygit - Interfaz TUI para Git
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },

  -- Diffview - Visualización de diffs mejorada
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    cmd = "Diffview",
    keys = {
      { "<leader>gvo", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
      { "<leader>gvc", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
      { "<leader>gvf", "<cmd>DiffviewToggleFile<cr>", desc = "Toggle diff view file" },
      { "<leader>gvk", "<cmd>DiffviewFocusFiles<cr>", desc = "Focus diff files" },
    },
  },

  -- Git-conflict - Resolver conflictos Git
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "BufReadPost",
    opts = {
      default_mappings = true,
      disable_diagnostics = true,
    },
  },

  -- Blamer - Git blame inline
  {
    "APZelos/blamer.nvim",
    event = "BufReadPost",
    config = function()
      vim.g.blamer_enabled = true
      vim.g.blamer_date_format = "%Y-%m-%d %H:%M:%S"
    end,
  },

  -- Dockerfile.vim - Syntax highlighting para Docker
  {
    "ekalinin/Dockerfile.vim",
    ft = { "Dockerfile", "docker-compose.yml", "docker-compose.yaml" },
  },
}
