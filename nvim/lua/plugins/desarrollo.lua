return {
  -- LSP (Language Server Protocol)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      require("config.lsp-setup").setup()
    end,
  },

  -- Formateador y linter
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black", "isort" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
      },
    },
  },

  -- Git integrado
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          map("n", "<leader>hs", gs.stage_hunk)
          map("n", "<leader>hr", gs.reset_hunk)
          map("v", "<leader>hs", gs.stage_hunk)
          map("v", "<leader>hr", gs.reset_hunk)
          map("n", "<leader>hS", gs.stage_buffer)
          map("n", "<leader>hR", gs.reset_buffer)
        end,
      })
    end,
  },

  -- Git browser
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    cmd = { "DapBreakpoint", "DapContinue", "DapStepOver", "DapStepInto", "DapStepOut", "DapRepl" },
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      -- Auto abrir/cerrar dapui
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.detach.dapui_config = function()
        dapui.close()
      end
    end,
  },

  -- Testing
  {
    "nvim-neotest/neotest",
    cmd = { "Neotest" },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    config = function()
      local neotest = require("neotest")
      neotest.setup({
        adapters = {
          require("neotest-python")({
            python = "python3",
          }),
        },
      })
    end,
  },
}
