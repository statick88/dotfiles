return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "markdown_inline", "quarto" }, -- Optimized: load on markdown files
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  opts = {
    enabled = true,
    max_width = 80,
    padding = { top = 1, bottom = 1 },
    heading = {
      border = false,
      width = "full",
    },
    code = {
      border = "thin",
      language_pad = 2,
      above = "",
      below = "",
      highlight = "RenderMarkdownCode",
      min_width = 80,
      position = "left",
      win_options = { winhl = "Normal:Normal" },
    },
    pipe_table = {
      -- Border array must have exactly 11 elements:
      -- Positions 1-3: top (┌ ┬ ┐)
      -- Positions 4-6: middle (├ ┼ ┤)
      -- Positions 7-9: bottom (└ ┴ ┘)
      -- Position 10: vertical separator (│)
      -- Position 11: horizontal line (─)
      border = {
        "┌",
        "┬",
        "┐",
        "├",
        "┼",
        "┤",
        "└",
        "┴",
        "┘",
        "│",
        "─",
      },
      padding = 1,
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)

    -- Helper function to check if current file is markdown
    local function is_markdown()
      local ft = vim.bo.filetype
      local filename = vim.fn.expand("%:t")
      local ext = vim.fn.expand("%:e")

      return ft == "markdown" or ext == "md" or filename:match("README") or filename:match("%.md$")
    end

    -- Keymaps for manual control
    vim.keymap.set("n", "<leader>mr", function()
      require("render-markdown").toggle()
    end, { noremap = true, silent = true, desc = "Markdown: Toggle rendering" })

    vim.keymap.set("n", "<leader>me", function()
      require("render-markdown").enable()
    end, { noremap = true, silent = true, desc = "Markdown: Enable rendering" })

    vim.keymap.set("n", "<leader>md", function()
      require("render-markdown").disable()
    end, { noremap = true, silent = true, desc = "Markdown: Disable rendering" })
  end,
}
