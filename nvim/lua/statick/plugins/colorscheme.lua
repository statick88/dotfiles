-- [UX] Catppuccin: Tema visual moderno y cuidado para Neovim
-- Esquema de colores suave pero con buen contraste para trabajar largas horas
-- Variantes disponibles: catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",                                  -- Nombre corto para lazy.nvim
    priority = 1000,                                       -- Cargar primero para evitar parpadeo
    config = function()
      vim.cmd.colorscheme("catppuccin")                    -- Aplicar tema automáticamente
    end,
  },
}
