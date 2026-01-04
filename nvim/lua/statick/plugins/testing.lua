-- [DEV] Testing & Quality Assurance - Plugins para testing (versión sin nvim-nio)
-- TDD, BDD, test runners - usa vim-test directamente
return {
  -- Test result display
  {
    "vim-test/vim-test",
    dependencies = { "vim-airline/vim-airline" },
    ft = { "python", "javascript", "typescript", "ruby", "go", "rust", "lua" },
  },
}
