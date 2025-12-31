-- Git & Docker - Plugins mejorados con lazygit
-- Solo se cargan según el tipo de archivo
return {
  -- lazygit - Interfaz TUI para Git
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
    },
    cmd = "LazyGit",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- diffview.nvim - Visualización de diffs mejorada
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {},
    keys = {
      { "<leader>gvo", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
      { "<leader>gvc", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
      { "<leader>gvf", "<cmd>DiffviewFileHistory<cr>", desc = "File history" },
    },
  },

  -- git-conflict.nvim - Resolver conflictos Git
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "BufReadPost",
    opts = {
      default_mappings = true,
      disable_diagnostics = true,
    },
    keys = {
      { "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", desc = "Choose ours" },
      { "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose theirs" },
      { "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose both" },
      { "<leader>gc0", "<cmd>GitConflictChooseNone<cr>", desc = "Choose none" },
      { "<leader>gcn", "<cmd>GitConflictNextConflict<cr>", desc = "Next conflict" },
      { "<leader>gcp", "<cmd>GitConflictPrevConflict<cr>", desc = "Previous conflict" },
    },
  },

  -- blamer.nvim - Git blame inline
  {
    "APZelos/blamer.nvim",
    event = "BufReadPost",
    opts = {
      enabled = true,
      date_format = "%Y-%m-%d %H:%M:%S",
    },
  },

  -- Docker syntax highlighting
  {
    "ekalinin/Dockerfile.vim",
    ft = { "Dockerfile", "docker-compose.yml", "docker-compose.yaml" },
  },
}
