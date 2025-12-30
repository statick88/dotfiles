-- render-markdown.nvim: Renderiza archivos Markdown con formato visual atractivo
-- Convierte # headers, **bold**, *italic*, [links] en formato enriquecido
-- Útil para tomar notas, documentación, README files
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { 
    "nvim-treesitter/nvim-treesitter",                -- Requiere Treesitter para parsear Markdown
    "nvim-tree/nvim-web-devicons"                      -- Iconos para elementos Markdown
  },
  opts = {
    file_types = { "markdown" },                         -- Aplicar solo a archivos .md
  },
}
