return {
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "markdown" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
      "3rd/image.nvim",
    },
    config = function()
      local quarto = require("quarto")

      quarto.setup({
        lspfeatures = {
          enabled = true,
          languages = {
            "r",
            "python",
            "julia",
            "bash",
            "html",
            "lua",
            "sql",
            "sql_r",
            "typescript",
            "javascript",
            "dart",
          },
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        coderunner = {
          enabled = true,
          default_method = "quarto",
        },
        preview = {
          use_quarto = true,
          multiplex = {
            enabled = true,
          },
        },
        keymaps = {
          show_help = "<leader>qh",
          show_usage = "<leader>qu",
        },
      })

      vim.keymap.set("n", "<leader>qp", function()
        quarto.quarto_preview()
      end, { desc = "Quarto preview" })
      vim.keymap.set("n", "<leader>qr", function()
        quarto.render()
      end, { desc = "Quarto render" })
    end,
  },
  {
    "3rd/image.nvim",
    ft = { "quarto", "python", "markdown" },
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          sizing_strategy = "auto",
          download_remote_images = true,
          only_render_image_at_cursor = true,
          filetypes = { "markdown", "quarto" },
        },
      },
      max_width = 100,
      max_height = 12,
      max_width_window_percentage = 80,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "scrollview", "signcolumn" },
    },
  },
}
