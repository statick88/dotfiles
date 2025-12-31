-- LSP (Language Server Protocol): Configuración simplificada y robusta
-- Convierte Neovim en un IDE completo sin dependencias complejas
return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Habilitar capacidades para autocompletado
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Lua (para archivos de configuración nvim)
    lspconfig.lua_ls = {
      settings = {
        Lua = {
          diagnostics = { enable = false, globals = { "vim" } },
          workspace = { checkThirdParty = false },
        },
      },
    }

    -- TypeScript/JavaScript
    lspconfig.ts_ls = {
      settings = {
        typescript = {
          inlayHints = { enabled = true },
        },
      },
    }

    -- Python
    lspconfig.pyright = {
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            autoImportCompletions = true,
            typeCheckingMode = "basic",
          },
        },
      },
    }

    -- HTML
    lspconfig.html = {}

    -- CSS
    lspconfig.cssls = {}

    -- Tailwind CSS
    lspconfig.tailwindcss = {
      filetypes = { "css", "scss", "less" },
    },

    -- Dart (para Flutter)
    lspconfig.dartls = {
      cmd = { "dart", "language-server", "--protocol=lsp" },
      filetypes = { "dart" },
      root_dir = function(fname)
        return require("lspconfig.util").root_pattern(".git", ".dart_tool")(fname) or vim.loop.cwd
      end,
      settings = {
        dart = {
          completeFunctionCalls = true,
          showTodos = true,
        },
      },
    },
  },
}
