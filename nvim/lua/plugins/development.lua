return {
  {
    "dart-lang/dart-vim-plugin",
    ft = "dart",
    config = function()
      vim.g.dart_format_on_save = 1
      vim.g.dart_html_in_string = "{b}"
    end,
  },
  {
    "akinsho/flutter-tools.nvim",
    ft = { "dart", "flutter" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("flutter-tools").setup({
        lsp = {
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<leader>fr", function()
              require("flutter_tools").run_hot_reload()
            end, { desc = "Flutter hot reload", buffer = bufnr })
            vim.keymap.set("n", "<leader>fs", function()
              require("flutter_tools").run_app()
            end, { desc = "Flutter run", buffer = bufnr })
            vim.keymap.set("n", "<leader>fq", function()
              require("flutter_tools").quit()
            end, { desc = "Flutter quit", buffer = bufnr })
          end,
          settings = {
            dart = {
              analyzeAllProjects = true,
              showTodos = true,
              enableSdkFormatter = true,
              lineLength = 120,
            },
          },
        },
        debugger = {
          enabled = true,
          run_via_dap = true,
        },
        decorations = {
          widget_guide = {
            enable = true,
          },
          virtual_text = {
            enable = true,
          },
        },
        outline = {
          enable = true,
          auto_open = false,
        },
      })
    end,
  },
  {
    "dart-lang/dart_style",
    ft = "dart",
  },
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = { "rcarriga/nvim-dap-ui" },
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "andythigpen/nvim-coverage",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("coverage").setup()
    end,
  },
}
