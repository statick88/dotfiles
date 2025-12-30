-- Plugins Git: Integración completa de control de versiones en Neovim
-- Gitsigns: Muestra cambios, permite stage/unstaged con atajos
-- Lazygit: Interfaz TUI para Git desde Neovim
return {
  { 
    "lewis6991/gitsigns.nvim",                           -- Muestra indicadores de cambios en el gutter
    config = true,                                       -- Usar configuración por defecto (suficiente para empezar)
    -- Comandos útiles: ]c [c para navegar cambios, <leader>hs para staged, <leader>hr para reset
  },
  { 
    "kdheepak/lazygit.nvim"                              -- Interfaz gráfica de Git dentro de Neovim
    -- Comando: :LazyGit para abrir interfaz Git completa
  }
}
