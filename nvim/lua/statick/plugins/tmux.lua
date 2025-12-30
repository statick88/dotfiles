return {
  {
    "aserowy/tmux.nvim",
    config = function()
      require("tmux").setup({
        -- Configuración de navegación entre tmux y neovim
        copy_sync = {
          -- Habilita sincronización de clipboard entre tmux y neovim
          enable = true,
          -- Dirección de sincronización (both, tmux_to_neovim, neovim_to_tmux)
          direction = "both",
        },
        navigation = {
          -- Habilita navegación seamless entre tmux y neovim splits
          enable = true,
          -- Ciclo de navegación (solo si no hay más splits en esa dirección)
          cyclic_navigation = true,
        },
        resize = {
          -- Habilita redimensionado de tmux panes desde neovim
          enable = true,
        },
      })

      -- Keymaps para navegación tmux-neovim
      vim.keymap.set("n", "<C-h>", [[<cmd>lua require("tmux").move_left()<cr>]], { silent = true })
      vim.keymap.set("n", "<C-j>", [[<cmd>lua require("tmux").move_bottom()<cr>]], { silent = true })
      vim.keymap.set("n", "<C-k>", [[<cmd>lua require("tmux").move_top()<cr>]], { silent = true })
      vim.keymap.set("n", "<C-l>", [[<cmd>lua require("tmux").move_right()<cr>]], { silent = true })

      -- Keymaps para redimensionado
      vim.keymap.set("n", "<C-Left>", [[<cmd>lua require("tmux").resize_left()<cr>]], { silent = true })
      vim.keymap.set("n", "<C-Down>", [[<cmd>lua require("tmux").resize_bottom()<cr>]], { silent = true })
      vim.keymap.set("n", "<C-Up>", [[<cmd>lua require("tmux").resize_top()<cr>]], { silent = true })
      vim.keymap.set("n", "<C-Right>", [[<cmd>lua require("tmux").resize_right()<cr>]], { silent = true })
    end,
  },
}