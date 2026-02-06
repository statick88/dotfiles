return {
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
    opts = {
      lazygit = {
        win_config = {
          border = "rounded",
          width = 60,
          height = 30,
          row = 1,
          col = 0,
          relative = "editor",
        },
      },
    },
  },
}
