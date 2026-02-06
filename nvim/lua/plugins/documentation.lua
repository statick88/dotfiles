return {
  {
    "artempyanykh/marksman",
    ft = { "markdown" },
    config = function()
      require("lspconfig").marksman.setup({})
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "quarto" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.icons",
    },
    opts = {
      headings = {
        icons = true,
      },
      bullet = {
        icons = { "●", "○", "◆", "○" },
      },
      callouts = {
        icons = { "Info", "Tip", "Warning", "Caution", "Important", "Note" },
        style = "coloured",
      },
    },
  },
}
