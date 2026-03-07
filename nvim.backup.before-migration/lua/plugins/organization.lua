return {
  {
    "nvim-neorg/neorg",
    ft = "norg",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
                projects = "~/projects",
              },
            },
          },
        },
      })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "tiagovla/scope.nvim",
    cmd = { "Scope" },
    config = function()
      require("scope").setup()
    end,
  },
}
