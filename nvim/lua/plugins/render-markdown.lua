return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown", "quarto" },
  opts = {
    enabled = true,
    max_width = 80,
    padding = { top = 1, bottom = 1 },
    heading = {
      border = false,
      icons = {},
      width = 'full',
    },
    code = {
      border = 'thin',
      language_pad = 2,
      above = '',
      below = '',
      highlight = 'RenderMarkdownCode',
      min_width = 80,
      position = 'left',
      win_options = { winhl = 'Normal:Normal' },
    },
    pipe_table = {
      border = {
        '┌', '┬', '┐',
        '├', '┼', '┤',
        '└', '┴', '┘'
      },
      padding = 1,
      use_virt_lines = true,
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        require("render-markdown").enable()
      end,
    })
  end,
}