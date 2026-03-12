-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Set file type for .qmd files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.qmd" },
  callback = function()
    vim.bo.filetype = "quarto"
  end,
  desc = "Set filetype for .qmd files to quarto",
})

-- Set file type for markdown files (including README)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.md", "README*" },
  callback = function()
    vim.bo.filetype = "markdown"
  end,
  desc = "Set filetype for markdown and README files",
})

-- Enable render-markdown by default for markdown files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.md", "*.qmd", "README*" },
  callback = function()
    local ok, render_markdown = pcall(require, "render-markdown")
    if ok then
      vim.defer_fn(function()
        render_markdown.enable()
      end, 150)
    end
  end,
  desc = "Enable render-markdown for markdown, quarto, and README files",
})

-- Ensure markdown filetype renders correctly
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    local ok, render_markdown = pcall(require, "render-markdown")
    if ok then
      vim.defer_fn(function()
        render_markdown.enable()
      end, 100)
    end
  end,
  desc = "Ensure render-markdown is enabled for markdown files",
})
