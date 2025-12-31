-- LSP (Language Server Protocol): Configuración simplificada y robusta
-- Convierte Neovim en un IDE completo sin dependencias complejas
return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Habilitar capacidades para autocompletado
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.config({
      capabilities = capabilities,

      -- Lua (para archivos de configuración nvim)
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { enable = false, globals = { "vim" } },
          },
        },
      },

      -- TypeScript/JavaScript
      ts_ls = {
        settings = {
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
            },
          },
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
            },
          },
        },
      },

      -- Python
      pyright = {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              autoImportCompletions = true,
              typeCheckingMode = "basic",
            },
          },
        },
      },

      -- HTML
      html = {},

      -- CSS
      cssls = {},

      -- Tailwind CSS
      tailwindcss = {
        settings = {},
      },

      -- Dart (para Flutter)
      dartls = {
        cmd = { "dart", "language-server", "--protocol=lsp" },
        filetypes = { "dart" },
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern(".git")(fname) or vim.loop.cwd
        end,
        settings = {
          dart = {
            completeFunctionCalls = true,
            showTodos = true,
          },
        },
      },
    })
  end,
}
