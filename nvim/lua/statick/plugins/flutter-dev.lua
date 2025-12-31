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
    keys = {
      { "<leader>F", "<cmd>FlutterRun<cr>", desc = "Run Flutter app" },
      { "<leader>D", "<cmd>FlutterDevices<cr>", desc = "List Flutter devices" },
      { "<leader>Q", "<cmd>FlutterQuit<cr>", desc = "Quit Flutter app" },
      { "<leader>R", "<cmd>FlutterHotReload<cr>", desc = "Hot reload" },
      { "<leader>H", "<cmd>FlutterHotRestart<cr>", desc = "Hot restart" },
    },
  },

  -- Dart LSP (ya configurado en lsp.lua con dartls)
}
