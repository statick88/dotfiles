return {
  {
    "folke/snacks.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("snacks").setup({
        dashboard = {
          enable = true,
          sections = {
            { section = "keys", pane = 1 },
            { section = "recent_files", cwd = true, limit = 10 },
            { section = "projects", limit = 5 },
            { section = "快捷键", pane = 2, align = "center" },
          },
        },
        picker = {
          enabled = true,
        },
        notifier = {
          enabled = true,
          timeout = 3000,
        },
      })
    end,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({
        input = {
          winblend = 10,
        },
        select = {
          backend = { "telescope", "fzf_lua", "fzf", "builtin" },
        },
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VimEnter",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        cmdline = {
          view = "cmdline",
        },
        messages = {
          view = "notify",
        },
        notify = {
          enabled = true,
        },
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
          },
        },
      })
    end,
  },
}
