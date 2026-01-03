-- Flutter Development - Plugins para Flutter y Dart
-- Solo se carga cuando se detectan archivos Dart o Flutter
return {
  -- Flutter tools
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
      { "stevearc/dressing.nvim" },
    },
    ft = { "dart", "flutter" },
    event = "BufReadPost",
    opts = {
      ui = {
        border = "rounded",
        notification_style = "native",
      },
      decorations = {
        statusline = {
          app_version = true,
        },
      },
      debugger = {
        enabled = true,
        run_via_dap = true,
      },
      closing_tags = {
        highlight = "ErrorMsg",
        prefix = " ",
      },
    },
  },

  -- Dart LSP (ya configurado en lsp.lua con dartls)
}
