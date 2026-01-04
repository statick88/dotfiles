-- [UX] nvim-autopairs: Cierra automáticamente paréntesis, llaves, comillas
-- Escribe '(' -> automáticamente se convierte en '()' con cursor dentro
-- Funciona con todos los pares: (), [], {}, "", '', ``
return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",                                 -- Cargar solo al entrar a modo Insert
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,                                     -- Usar Treesitter para contexto inteligente
        disable_filetype = { "TelescopePrompt" },             -- Evitar conflictos en prompts de búsqueda
      })
    end,
  },
}
