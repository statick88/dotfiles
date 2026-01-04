-- [UX] which-key.nvim: Guía completa de Neovim con descripciones detalladas de todos los plugins
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = function()
      local wk = require("which-key")

      wk.add({
        mode = { "n", "i", "v" },
        ["<leader>"] = { name = "+leader", _ = "which_key_ignore" },
        ["<leader>a"] = { name = "+android", icon = "📱 " },
        ["<leader>e"] = { name = "+explorer", icon = " " },
        ["<leader>f"] = { name = "+find", icon = " " },
        ["<leader>g"] = { name = "+git", icon = " " },
        ["<leader>o"] = { name = "+obsidian", icon = " " },
        ["<leader>p"] = { name = "+productivity", icon = "⚡ " },
        ["<leader>q"] = { name = "+quit/session", icon = " " },
        ["<leader>s"] = { name = "+search", icon = "🔍 " },
        ["<leader>t"] = { name = "+test", icon = "🧪 " },
        ["<leader>x"] = { name = "+trouble", icon = "⚠️ " },
        ["<localleader>"] = { name = "+local" },
      })

      wk.register({
        ["<leader>ff"] = { desc = "Find files in project" },
        ["<leader>fg"] = { desc = "Live grep - search text in files" },
        ["<leader>fb"] = { desc = "Find open buffers" },
        ["<leader>fh"] = { desc = "Search help tags" },
        ["<leader>gd"] = { desc = "Go to definition" },
        ["<leader>gr"] = { desc = "Go to references" },
        ["<leader>rn"] = { desc = "Rename symbol" },
        ["<leader>ca"] = { desc = "Code actions" },
        ["<leader>xx"] = { desc = "Trouble diagnostics" },
        ["<leader>xX"] = { desc = "Buffer diagnostics" },
        ["<leader>cs"] = { desc = "Trouble symbols" },
        ["<leader>cl"] = { desc = "Trouble LSP" },
        ["<leader>gg"] = { desc = "Open LazyGit" },
        ["<leader>gv"] = { desc = "Open Diffview" },
        ["<leader>gq"] = { desc = "Close Diffview" },
        ["<leader>gf"] = { desc = "Toggle diff file" },
        ["<leader>gk"] = { desc = "Focus diff files" },
        -- Flutter keybindings
        ["<leader>F"] = { desc = "Run Flutter app" },
        ["<leader>D"] = { desc = "List Flutter devices" },
        ["<leader>Q"] = { desc = "Quit Flutter app" },
        ["<leader>R"] = { desc = "Hot reload" },
        ["<leader>H"] = { desc = "Hot restart" },
        -- Android ADB WiFi keybindings
        ["<leader>aw"] = { desc = "Connect Android via WiFi" },
        ["<leader>ad"] = { desc = "List ADB devices" },
        ["<leader>af"] = { desc = "Run Flutter on WiFi device" },
        ["<leader>ar"] = { desc = "Reconnect ADB device" },
        ["<leader>aq"] = { desc = "Disconnect ADB device" },
      }, { mode = "n" })

      return {
        plugins = {
          spelling = { enabled = true },
          presets = {
            operators = false,
            motions = false,
            text_objects = false,
            windows = false,
            nav = false,
            z = false,
            g = false,
          },
        },
        icons = {
          breadcrumb = "»",
          separator = "➜",
          group = "+",
        },
        popup_mappings = {
          scroll_down = "<c-d>",
          scroll_up = "<c-u>",
        },
        window = {
          border = "rounded",
          padding = { 2, 2, 2, 2 },
          winblend = 10,
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 3,
          align = "left",
        },
        ignore_missing = true,
      }
    end,
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      vim.notify("Which-key loaded! Press <Space> to see all keybindings", vim.log.levels.INFO, {
        title = "Neovim Help System",
        icon = "🔑",
        timeout = 3000,
      })
    end,
  },
}
