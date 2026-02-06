return {
  -- snacks.nvim: Dashboard, picker, notifier
  {
    "folke/snacks.nvim",
    event = "VimEnter",
    priority = 1000,
    config = function()
      require("snacks").setup({
        dashboard = {
          enable = true,
          preset = {
            header = [[
██████╗ ███████╗██╗   ██╗██╗███╗   ███╗ █████╗ ██╗     ██╗██╗███╗   ███╗
██╔══██╗██╔════╝╚██╗ ██╔╝██║████╗ ████║██╔══██╗██║     ██║██║████╗ ████║
██████╔╝█████╗   ╚████╔╝ ██║██╔████╔██║███████║██║     ██║██║██╔████╔██║
██╔══██╗██╔══╝    ╚██╔╝  ██║██║╚██╔╝██║██╔══██║██║     ██║██║██║╚██╔╝██║
██║  ██║███████╗   ██║   ██║██║ ╚═╝ ██║██║  ██║███████╗██║██║██║ ╚═╝ ██║
╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚═╝╚═╝╚═╝     ╚═╝
            ]],
            keys = {
              { icon = " ", key = "ff", desc = "Find Files", action = "FzfLua files" },
              { icon = " ", key = "fg", desc = "Live Grep", action = "FzfLua grep" },
              { icon = " ", key = "fb", desc = "Buffers", action = "FzfLua buffers" },
              { icon = " ", key = "aa", desc = "AI Chat", action = "Codecompanion" },
              { icon = " ", key = "gg", desc = "LazyGit", action = "LazyGit" },
              { icon = " ", key = "o", desc = "Oil", action = "Oil" },
            },
          },
          sections = {
            { section = "header" },
            { section = "keys", gap = 1, padding = 1 },
            { section = "recent_files", cwd = true, limit = 6 },
            { section = "projects", limit = 4 },
            { section = "session", pivot = "bottom" },
          },
        },
        picker = {
          enabled = true,
          mappings = {
            toggle = { "<Esc>", "<C-c>" },
          },
        },
        notifier = {
          enabled = true,
          timeout = 3000,
          top_down = false,
        },
        words = {
          enabled = true,
          hl = {
            { "hl", 0, "SnacksWords" },
          },
        },
      })
    end,
  },
  -- dressing.nvim: UI improvements
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({
        input = {
          winblend = 10,
        },
        select = {
          backend = { "fzf_lua", "fzf", "builtin" },
        },
      })
    end,
  },
  -- noice.nvim: Notification UI
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
        routes = {
          {
            filter = {
              event = "msg_show",
              kind = "",
              find = "written",
            },
            opts = { skip = true },
          },
        },
        presets = {
          lsp_doc_border = true,
        },
      })
    end,
  },
}
