-- Flutter/Dart Development - Diego Saavedra
-- Mobile Development con Flutter

return {
  {
    "nvim-flutter/flutter-tools.nvim",
    ft = "dart",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    opts = {
      ui = {
        border = "rounded",
      },
      decorations = {
        statusline = {
          app_version = true,
          device = true,
        },
      },
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        highlight = "Comment",
        prefix = "// ",
      },
      dev_log = {
        enabled = true,
        open_cmd = "tabedit",
      },
      dev_tools = {
        autostart = false,
        auto_open_browser = false,
      },
      outline = {
        auto_open = false,
      },
      lsp = {
        color = {
          enabled = true,
          background = false,
          foreground = false,
          virtual_text = true,
          virtual_text_str = "■",
        },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          analysisExcludedFolders = { ".dart_tool", ".fvm", "build" },
          renameFilesWithClasses = "prompt",
          enableSnippets = true,
        },
      },
    },
    keys = {
      { "<leader>Fr", "<cmd>FlutterRun<cr>", desc = "Flutter Run" },
      { "<leader>Fd", "<cmd>FlutterDevices<cr>", desc = "Flutter Devices" },
      { "<leader>Fe", "<cmd>FlutterEmulators<cr>", desc = "Flutter Emulators" },
      { "<leader>Fq", "<cmd>FlutterQuit<cr>", desc = "Flutter Quit" },
      { "<leader>Fh", "<cmd>FlutterReload<cr>", desc = "Flutter Hot Reload" },
      { "<leader>FR", "<cmd>FlutterRestart<cr>", desc = "Flutter Hot Restart" },
      { "<leader>Fp", "<cmd>FlutterPubGet<cr>", desc = "Flutter Pub Get" },
      { "<leader>Fo", "<cmd>FlutterOutlineToggle<cr>", desc = "Flutter Outline" },
      { "<leader>Fl", "<cmd>FlutterLogClear<cr>", desc = "Flutter Log Clear" },
    },
  },

  {
    "dart-lang/dart-vim-plugin",
    ft = "dart",
    init = function()
      vim.g.dart_style_guide = 2
      vim.g.dart_format_on_save = 1
    end,
  },
}
