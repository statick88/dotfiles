-- tmux.nvim: Integración perfecta entre Neovim y Tmux
-- Permite usar Ctrl+h/j/k/l para moverse entre splits de nvim y panes de tmux
-- Elimina la necesidad de cambiar atajos entre Neovim y Tmux
return {
  {
    "aserowy/tmux.nvim",
    config = function()
      require("tmux").setup({
        copy_sync = {
          enable = true,                                       -- Sincronizar clipboard bidireccionalmente
          direction = "both",                                   -- Copiar de nvim a tmux y viceversa
        },
        navigation = {
          enable = true,                                       -- Habilitar navegación entre aplicaciones
          cyclic_navigation = true,                              -- Volver al inicio si no hay más paneles
        },
        resize = {
          enable = true,                                       -- Redimensionar tmux desde nvim
        },
      })

      -- Navegación seamless entre Neovim y Tmux (mismo atajo que nvim splits)
      vim.keymap.set("n", "<C-h>", [[<cmd>lua require("tmux").move_left()<cr>]], { silent = true })
      vim.keymap.set("n", "<C-j>", [[<cmd>lua require("tmux").move_bottom()<cr>]], { silent = true })
      vim.keymap.set("n", "<C-k>", [[<cmd>lua require("tmux").move_top()<cr>]], { silent = true })
      vim.keymap.set("n", "<C-l>", [[<cmd>lua require("tmux").move_right()<cr>]], { silent = true })

      -- Redimensionar paneles de Tmux desde Neovim
      vim.keymap.set("n", "<C-Left>", [[<cmd>lua require("tmux").resize_left()<cr>]], { silent = true })
      vim.keymap.set("n", "<C-Down>", [[<cmd>lua require("tmux").resize_bottom()<cr>]], { silent = true })
      vim.keymap.set("n", "<C-Up>", [[<cmd>lua require("tmux").resize_top()<cr>]], { silent = true })
      vim.keymap.set("n", "<C-Right>", [[<cmd>lua require("tmux").resize_right()<cr>]], { silent = true })
    end,
  },
}