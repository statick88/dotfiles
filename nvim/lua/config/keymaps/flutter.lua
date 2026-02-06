-- Flutter Keymaps
local flutter = {}

function flutter.setup()
  local flutter_ok, _ = pcall(require, "flutter-tools")
  if flutter_ok then
    vim.keymap.set("n", "<leader>fr", function()
      require("flutter_tools").run_hot_reload()
    end, { desc = "Flutter hot reload" })
    vim.keymap.set("n", "<leader>fs", function()
      require("flutter_tools").run_app()
    end, { desc = "Flutter run" })
    vim.keymap.set("n", "<leader>fq", function()
      require("flutter_tools").quit()
    end, { desc = "Flutter quit" })
    vim.keymap.set("n", "<leader>ff", ":Telescope flutter<CR>", { desc = "Flutter commands" })
    vim.keymap.set("n", "<leader>fd", ":FlutterDevtools<CR>", { desc = "Flutter DevTools" })
  end

  vim.keymap.set("n", "<leader>ww", "iw", { desc = "Select word" })
  vim.keymap.set("n", "<leader>ww", "a%", { desc = "Select block" })
end

flutter.setup()

return flutter
