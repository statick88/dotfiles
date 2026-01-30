return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown", "quarto" },
  lazy = false,
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
    
    -- Enable on markdown files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "quarto" },
      callback = function()
        require("render-markdown").enable()
      end,
    })
    
    -- Enable on buffer read for README files
    vim.api.nvim_create_autocmd("BufRead", {
      pattern = { "*.md", "README*" },
      callback = function()
        if vim.bo.filetype == "markdown" or vim.fn.expand("%:e") == "md" then
          require("render-markdown").enable()
        end
      end,
    })
    
    -- Keymaps for toggling
    local opts_map = { noremap = true, silent = true, desc = "" }
    
    -- Toggle rendering
    vim.keymap.set("n", "<leader>mr", function()
      require("render-markdown").toggle()
    end, { noremap = true, silent = true, desc = "Markdown: Toggle rendering" })
    
    -- Enable rendering
    vim.keymap.set("n", "<leader>me", function()
      require("render-markdown").enable()
    end, { noremap = true, silent = true, desc = "Markdown: Enable rendering" })
    
    -- Disable rendering
    vim.keymap.set("n", "<leader>md", function()
      require("render-markdown").disable()
    end, { noremap = true, silent = true, desc = "Markdown: Disable rendering" })
  end,
}