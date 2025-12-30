-- nvim-cmp: Sistema de autocompletado inteligente para Neovim
-- Sugiere palabras, funciones, variables mientras escribes (como IntelliSense)
-- Uso principal: Ctrl+Space para activar, Tab/Enter para aceptar sugerencias
return {
  {
    "hrsh7th/nvim-cmp",                                   -- Motor principal de autocompletado
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",                            -- Completado desde LSP (inteligencia de lenguaje)
      "L3MON4D3/LuaSnip",                                -- Motor de snippets (fragmentos de código)
      "saadparwaiz1/cmp_luasnip",                        -- Conector entre cmp y LuaSnip
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          -- Expande snippets automáticamente cuando se seleccionan
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),        -- Scroll documentación hacia arriba
          ["<C-f>"] = cmp.mapping.scroll_docs(4),         -- Scroll documentación hacia abajo
          ["<C-Space>"] = cmp.mapping.complete(),          -- Activar menú de autocompletado
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirmar selección con Enter
        }),
        sources = cmp.config.sources({
          -- Fuentes principales de autocompletado (en orden de prioridad)
          { name = "nvim_lsp" },                        -- 1️⃣ Sugestiones del servidor LSP
          { name = "luasnip" },                           -- 2️⃣ Snippets de código
        }, {
          { name = "buffer" },                             -- 3️⃣ Palabras del archivo actual
        }),
      })
    end,
  },
}
