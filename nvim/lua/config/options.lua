-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Fira Code Nerd Font configuration
-- 
-- IMPORTANT: Make sure Fira Code Nerd Font is installed on your system:
-- macOS: brew tap homebrew/cask-fonts && brew install --cask font-fira-code-nerd-font
-- Linux: sudo apt-get install fonts-firacode-nerd-font
-- Or download from: https://www.nerdfonts.com/font-downloads
vim.opt.guifont = "Fira Code Nerd Font:h12"
vim.opt.linespace = 0

-- Ensure proper rendering for Fira Code
vim.opt.termguicolors = true
vim.opt.lazyredraw = false

-- Font settings for different environments
if vim.fn.has("gui_running") == 1 then
  -- GUI Neovim (like Neovide, Neovim-Qt)
  vim.opt.guifont = "Fira Code Nerd Font:h12"
elseif vim.fn.has("nvim-0.8") == 1 then
  -- Modern terminal Neovim with font support
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_font_family = "Fira Code Nerd Font"
  vim.g.neovide_font_size = 12
end

-- Set terminal title to show current file
vim.opt.title = true
vim.opt.titlestring = "Neovim - %t"

-- Disable problematic providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 1
