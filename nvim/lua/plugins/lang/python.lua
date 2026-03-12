-- Python Development - Diego Saavedra
-- Full Stack Developer + Docente

return {
  -- Virtual Environment Management
  {
    "HallerPatrick/py_lsp.nvim",
    ft = "python",
    opts = {
      language_server = "pylsp",
      source_strategies = { "poetry", "default", "system" },
    },
  },

  -- Python Debugging
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local path = vim.fn.exepath("python")
      if path ~= "" then
        require("dap-python").setup(path)
      end
    end,
    keys = {
      { "<leader>dpr", function() require("dap-python").test_method() end, desc = "Python test method" },
      { "<leader>dpc", function() require("dap-python").test_class() end, desc = "Python test class" },
    },
  },

  -- Type Hints Auto-completion
  {
    "dumidusw/python-type-hints.nvim",
    ft = "python",
    opts = {},
  },

  -- Django Template Support
  {
    "tweekmonster/django-plus.vim",
    ft = { "python", "htmldjango" },
  },
}
