-- Python Development - Plugins especializados para Python
-- Django, FastAPI, Data Science - sin nvim-nio dependency
return {
  -- Python LSP ya configurado en lsp.lua (pyright)

  -- Virtual environment selector
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-telescope/telescope.nvim" },
    },
    branch = "regexp",
    opts = {
      settings = {
        options = {
          notify_user_on_venv_activation = true,
        },
      },
    },
    ft = "python",
    keys = { { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Virtual Env" } },
  },

  -- Python docstring generator
  {
    "danymat/neogen",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = true,
    ft = "python",
    keys = {
      { "<leader>nd", function() require("neogen").generate() end, desc = "Generate docstring" },
    },
  },

  -- Django templates support
  {
    "andymass/vim-matchup",
    ft = { "html", "htmldjango", "jinja2" },
  },
}
