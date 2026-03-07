-- Autocmds - Diego Saavedra
-- Custom autocommands for enhanced workflow

local augroup = vim.api.nvim_create_augroup("diego_config", { clear = true })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  desc = "Highlight yanked text",
})

-- Auto-resize splits when terminal is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  command = "wincmd =",
  desc = "Auto-resize splits",
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Restore cursor position",
})

-- Close certain filetypes with q
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "startuptime", "tsplayground" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
  desc = "Close with q in certain filetypes",
})

-- Enable spell checking for git commits and markdown
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "gitcommit", "markdown", "quarto" },
  callback = function()
    vim.opt_local.spell = true
  end,
  desc = "Enable spell check for text files",
})

-- Auto-create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
  desc = "Auto-create directories",
})

-- Check for file changes when gaining focus
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup,
  command = "checktime",
  desc = "Check for file changes",
})

-- Set filetypes for specific extensions
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = { "*.env", ".env*" },
  callback = function()
    vim.bo.filetype = "sh"
  end,
  desc = "Set filetype for env files",
})
