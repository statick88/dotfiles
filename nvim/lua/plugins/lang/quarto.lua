-- Quarto Scientific Writing - Diego Saavedra
-- Escritura científica con Quarto para eBooks y cursos

return {
  {
    "quarto-dev/quarto-nvim",
    ft = "quarto",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      debug = false,
      closePreviewOnExit = true,
      lspFeatures = {
        enabled = true,
        chunks = "curly",
        languages = { "python", "r", "julia", "bash", "html", "typescript" },
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      codeRunner = {
        enabled = true,
        default_method = "molten",
        ft_runners = {},
        never_run = { "yaml" },
      },
    },
    keys = {
      { "<leader>qp", "<cmd>QuartoPreview<cr>", desc = "Quarto Preview" },
      { "<leader>qr", "<cmd>QuartoRender<cr>", desc = "Quarto Render" },
      { "<leader>qP", "<cmd>QuartoClosePreview<cr>", desc = "Quarto Close Preview" },
      { "<leader>qa", function() require("quarto").activate() end, desc = "Quarto Activate" },
      { "<leader>qc", function() require("quarto").send() end, desc = "Quarto Send Cell", mode = { "n", "v" } },
      { "<leader>qC", function() require("quarto").send_above() end, desc = "Quarto Send Above" },
      { "<leader>qA", function() require("quarto").send_all() end, desc = "Quarto Send All" },
    },
  },

  {
    "jmbuhr/otter.nvim",
    ft = { "quarto", "markdown" },
    opts = {
      buffers = {
        set_filetype = true,
        write_to_disk = false,
      },
      handle_leading_whitespace = true,
    },
  },
}
