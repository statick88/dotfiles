-- nvim-cmp: Sistema de autocompletado inteligente para Neovim
-- Sugiere palabras, funciones, variables mientras escribes (como IntelliSense)
-- Uso principal: Ctrl+Space para activar, Tab/Enter para aceptar sugerencias
return {
  {
    "hrsh7th/nvim-cmp",                                   -- Motor principal de autocompletado
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",                            -- Completado desde LSP (inteligencia de lenguaje)
      "hrsh7th/cmp-buffer",                              -- Palabras del buffer actual
      "hrsh7th/cmp-path",                                -- Completado de rutas de archivos
      "L3MON4D3/LuaSnip",                                -- Motor de snippets (fragmentos de código)
      "saadparwaiz1/cmp_luasnip",                        -- Conector entre cmp y LuaSnip
      "rafamadriz/friendly-snippets",                      -- Snippets predefinidos
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer", keyword_length = 3 },
        }),
        formatting = {
          format = function(entry, item)
            item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              buffer = "[Buf]",
              path = "[Path]",
            })[entry.source.name]
            return item
          end,
        },
      })
    end,
  },
}
