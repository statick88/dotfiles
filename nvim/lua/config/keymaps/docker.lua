vim.keymap.set("n", "<leader>ld", function()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazydocker = Terminal:new({
    cmd = "lazydocker",
    direction = "float",
    float_opts = {
      border = "rounded",
      width = 80,
      height = 40,
    },
    close_on_exit = true,
  })
  lazydocker:toggle()
end, { desc = "LazyDocker" })
