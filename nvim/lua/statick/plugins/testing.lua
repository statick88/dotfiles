-- Testing & Quality Assurance - Plugins para testing (versión sin nvim-nio)
-- TDD, BDD, test runners - usa vim-test directamente
return {
  -- Test result display
  {
    "vim-test/vim-test",
    dependencies = { "vim-airline/vim-airline" },
    ft = { "python", "javascript", "typescript", "ruby", "go", "rust", "lua" },
    keys = {
      { "<leader>tn", "<cmd>TestNearest<cr>", desc = "Test nearest" },
      { "<leader>tf", "<cmd>TestFile<cr>", desc = "Test file" },
      { "<leader>ts", "<cmd>TestSuite<cr>", desc = "Test suite" },
      { "<leader>tv", "<cmd>TestVisit<cr>", desc = "Test visit" },
      { "<leader>tg", "<cmd>TestGo<cr>", desc = "Test go" },
    },
  },
}
