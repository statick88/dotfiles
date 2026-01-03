-- which-key.nvim: Guía completa de uso de Neovim y plugins
-- Muestra ayuda contextual cuando presionas teclas y comandos
return {
  {
    "folke/which-key.nvim",
    event = "verylazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "i", "v" },
        ["<leader>"] = { name = "+leader", _ = "which_key_ignore" },
      },
      plugins = {
        spelling = { enabled = true },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
    end,
  },
}
