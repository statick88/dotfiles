---@desc Flash motion keymaps for fast navigation

local flash_ok, flash = pcall(require, "flash")
if flash_ok then
  vim.keymap.set({ "n", "x", "o" }, "s", function()
    flash.jump()
  end, { desc = "Flash" })

  vim.keymap.set({ "n", "x", "o" }, "S", function()
    flash.treesitter()
  end, { desc = "Flash Treesitter" })
end
