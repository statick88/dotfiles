require("statick.core.options")
require("statick.core.keymaps")

-- Setup de Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Esto buscará automáticamente todos los archivos .lua dentro de lua/statick/plugins/
require("lazy").setup("statick.plugins", {
  rocks = {
    enabled = false,  -- Desactivar rocks.nvim (no usado)
  },
})
