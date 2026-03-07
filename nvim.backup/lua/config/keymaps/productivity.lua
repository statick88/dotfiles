-- Productivity Keymaps
local prod = {}

function prod.setup()
  local oil_ok, _ = pcall(require, "oil")
  if oil_ok then
    vim.keymap.set("n", "<leader>o", ":Oil<CR>", { desc = "Open Oil (file manager)" })
  end

  local harpoon_ok, _ = pcall(require, "harpoon")
  if harpoon_ok then
    vim.keymap.set("n", "<leader>hh", function()
      require("harpoon.ui"):toggle_quick_menu()
    end, { desc = "Harpoon menu" })
    vim.keymap.set("n", "<leader>ha", function()
      require("harpoon.mark").add_file()
    end, { desc = "Harpoon add file" })
    vim.keymap.set("n", "<leader>h1", function()
      require("harpoon.ui"):nav_file(1)
    end, { desc = "Harpoon file 1" })
    vim.keymap.set("n", "<leader>h2", function()
      require("harpoon.ui"):nav_file(2)
    end, { desc = "Harpoon file 2" })
    vim.keymap.set("n", "<leader>h3", function()
      require("harpoon.ui"):nav_file(3)
    end, { desc = "Harpoon file 3" })
    vim.keymap.set("n", "<leader>h4", function()
      require("harpoon.ui"):nav_file(4)
    end, { desc = "Harpoon file 4" })
  end

  local snacks_ok, _ = pcall(require, "snacks")
  if snacks_ok then
    vim.keymap.set("n", "<leader>sp", function()
      require("snacks.picker"):open()
    end, { desc = "Snacks picker" })
  end

  vim.keymap.set("n", "<leader>ls", ":ls<CR>", { desc = "Buffer list" })
  vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
  vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
  vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Close buffer" })
end

prod.setup()

return prod
