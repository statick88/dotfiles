-- Options - Diego Saavedra
-- Full Stack Developer + Docente + Master Ciberseguridad

-- Font configuration (Fira Code Nerd Font required)
vim.opt.guifont = "Fira Code Nerd Font:h12"
vim.opt.linespace = 0
vim.opt.termguicolors = true
vim.opt.lazyredraw = false

-- GUI-specific settings
if vim.fn.has("gui_running") == 1 then
  vim.opt.guifont = "Fira Code Nerd Font:h12"
elseif vim.fn.exists("g:neovide") == 1 then
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_font_family = "Fira Code Nerd Font"
  vim.g.neovide_font_size = 12
end

-- Title
vim.opt.title = true
vim.opt.titlestring = "Neovim - %t"

-- Disable unused providers
vim.g.loaded_perl_provider = false
vim.g.loaded_ruby_provider = false
vim.g.loaded_node_provider = true

-- Editor behavior
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Indentation (override LazyVim defaults)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Backup and swap
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Clipboard (use system clipboard)
vim.opt.clipboard = "unnamedplus"

-- Split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Performance
vim.opt.redrawtime = 1500
vim.opt.synmaxcol = 250

-- Python configuration
vim.g.python3_host_prog = vim.fn.exepath("python3")

-- Spell checking (disabled by default)
vim.opt.spell = false
vim.opt.spelllang = { "en", "es" }
