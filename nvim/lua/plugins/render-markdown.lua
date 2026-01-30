return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  lazy = false,
  priority = 50,
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
    
    -- Helper function to check if current file is markdown
    local function is_markdown()
      local ft = vim.bo.filetype
      local filename = vim.fn.expand("%:t")
      local ext = vim.fn.expand("%:e")
      
      return ft == "markdown" or 
             ext == "md" or 
             filename:match("README") or 
             filename:match("%.md$")
    end
    
    -- Enable rendering when entering markdown file
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = { "*.md", "README*" },
      callback = function()
        vim.bo.filetype = "markdown"
        vim.defer_fn(function()
          if is_markdown() then
            require("render-markdown").enable()
          end
        end, 50)
      end,
    })
    
    -- Enable on FileType markdown
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "quarto" },
      callback = function()
        vim.defer_fn(function()
          require("render-markdown").enable()
        end, 50)
      end,
    })
    
    -- Enable on BufRead for all markdown files
    vim.api.nvim_create_autocmd("BufRead", {
      pattern = { "*.md", "README*" },
      callback = function()
        vim.bo.filetype = "markdown"
        vim.defer_fn(function()
          require("render-markdown").enable()
        end, 100)
      end,
    })
    
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