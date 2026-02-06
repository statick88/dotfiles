return {
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    config = function()
      require("oil").setup({
        columns = { "icon" },
        view_options = {
          show_hidden = true,
        },
        float = {
          padding = 2,
          max_width = 80,
        },
      })
    end,
  },
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    config = function()
      require("harpoon").setup({
        global_settings = {
          save_on_toggle = true,
          save_on_change = true,
        },
      })
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = function()
      require("inc_rename").setup()
    end,
  },
  {
    "nvim-mini/mini.bracketed",
    event = "VeryLazy",
    config = function()
      require("mini.bracketed").setup()
    end,
  },
  {
    "uga-rosa/dial.nvim",
    event = "VeryLazy",
    config = function()
      local dial = require("dial")
      vim.keymap.set("n", "<C-a>", dial.increment, { desc = "Increment" })
      vim.keymap.set("n", "<C-x>", dial.decrement, { desc = "Decrement" })
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      require("flash").setup()
    end,
  },
}
