return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  event = { "BufReadPre *.md", "BufReadPre *.qmd" },
  config = function()
    require("render-markdown").setup({
      auto_enable = true,
      file_types = { "markdown", "quarto" },
      enable_by_default = true,
    })
  end,
}