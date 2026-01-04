-- [TOOLS] tmux.nvim: Integración perfecta entre Neovim y Tmux
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
    end,
  },
}