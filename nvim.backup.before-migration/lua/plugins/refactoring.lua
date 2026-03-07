return {
  {
    "ThePrimeagen/refactoring.nvim",
    cmd = { "Refactor" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("refactoring").setup()
      vim.keymap.set("v", "<leader>re", ":Refactor extract ")
      vim.keymap.set("v", "<leader>rf", ":Refactor function ")
      vim.keymap.set("v", "<leader>rv", ":Refactor extract_var ")
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
    config = function()
      require("symbols-outline").setup()
    end,
  },
}
