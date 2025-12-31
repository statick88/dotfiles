-- LSP (Language Server Protocol): Configuración de servidores LSP
-- Lenguajes configurados: Lua, TypeScript/JavaScript, Python, HTML, CSS, Tailwind, Dart
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- Inicializar Mason (gestor de herramientas de desarrollo)
    require("mason").setup()
    local mason_lspconfig = require("mason-lspconfig")

    -- Configurar qué servidores LSP instalar automáticamente
    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "pyright",
        "html",
        "cssls",
        "tailwindcss",
        "dartls",
      },
      automatic_installation = true,
    })

    -- Habilitar capacidades avanzadas para autocompletado
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Configurar servidores LSP
    local lspconfig = require("lspconfig")

    -- Lua (para archivos de configuración nvim)
    lspconfig.lua_ls({
      settings = {
        Lua = {
          diagnostics = {
            enable = false,
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
          },
        },
      },
    })

    -- TypeScript/JavaScript (configuración para ts_ls)
    lspconfig.ts_ls({
      settings = {
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
          },
        },
        },
      },
    })

    -- Python (configuración para pyright)
    lspconfig.pyright({
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            autoImportCompletions = true,
            typeCheckingMode = "basic",
            diagnosticSeverity = {
              error = "Error",
              warning = "Warning",
              information = "Information",
            },
          },
        },
      },
    })

    -- HTML
    lspconfig.html({})

    -- CSS
    lspconfig.cssls({})

    -- Tailwind CSS
    lspconfig.tailwindcss({
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = "class\\s*((?:[a-zA-Z]+[a-z0-9]*)+",
          },
        },
      },
    })

    -- Dart/Flutter
    lspconfig.dartls({
      cmd = { "dart", "language-server", "--protocol=lsp" },
      filetypes = { "dart" },
      init_options = {
        onlyAnalyzeProjectsWithOpenFiles = true,
        suggestFromUnimportedLibraries = true,
        closingLabels = true,
        outline = true,
      },
      settings = {
        dart = {
          completeFunctionCalls = true,
          showTodos = true,
        },
      },
    })

    -- Keymaps de LSP
    local keymap = vim.keymap

    keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
    keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
    keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
    keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
    keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
    keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
  end,
}
