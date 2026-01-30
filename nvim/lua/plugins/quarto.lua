return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "quarto", "markdown" },
    config = function()
      local quarto = require("quarto")

      quarto.setup({
        lspfeatures = {
          enabled = true,
          languages = { "r", "python", "julia", "bash", "html", "lua", "sql", "sql_r" },
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
      })
    end,
  },
  -- Molten plugin temporarily disabled - repo not found
  -- Use Quarto's built-in runner instead with: quarto preview
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
