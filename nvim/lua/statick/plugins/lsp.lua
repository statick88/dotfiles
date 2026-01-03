-- LSP (Language Server Protocol): Convierte Neovim en un IDE completo
-- Proporciona inteligencia de lenguaje: autocompletado, diagnóstico, definiciones, etc.
-- Comandos principales: gd (go to definition), gr (references), K (documentation)
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/nvim-cmp" },
  },
  config = function()
    -- Inicializar Mason (gestor de herramientas de desarrollo)
    require("mason").setup()

    local mason_lspconfig = require("mason-lspconfig")

    -- Habilitar capacidades avanzadas para autocompletado
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Configurar qué servidores LSP instalar automáticamente
    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",         -- Servidor para archivos Lua (configuración nvim)
        "ts_ls",          -- Servidor para TypeScript/JavaScript
        "pyright",        -- Servidor para Python
        "html",           -- Servidor para HTML
        "cssls",          -- Servidor para CSS
        "tailwindcss",    -- Servidor para Tailwind CSS
        "dartls",         -- Servidor para Dart (Flutter)
      },
      automatic_installation = true,
    })

    -- Configurar servidores LSP usando vim.lsp.config (nueva API)
    -- Lua (para archivos de configuración nvim)
    vim.lsp.config("lua_ls", {
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
      capabilities = capabilities,
    })

    -- TypeScript/JavaScript
    vim.lsp.config("ts_ls", {
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayFunctionLikeTypeHints = "all",
          },
        },
      },
      capabilities = capabilities,
    })

    -- Python
    vim.lsp.config("pyright", {
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            autoImportCompletions = true,
            typeCheckingMode = "standard",
            diagnosticMode = "workspace",
          },
        },
      },
      capabilities = capabilities,
    })

    -- HTML
    vim.lsp.config("html", {
      capabilities = capabilities,
    })

    -- CSS
    vim.lsp.config("cssls", {
      capabilities = capabilities,
    })

    -- Tailwind CSS
    vim.lsp.config("tailwindcss", {
      capabilities = capabilities,
    })

    -- Dart (Flutter)
    vim.lsp.config("dartls", {
      cmd = { "dart", "language-server", "--protocol=lsp" },
      filetypes = { "dart" },
      settings = {
        dart = {
          completeFunctionCalls = true,
          showTodos = true,
        },
      },
      capabilities = capabilities,
    })

    -- Configurar diagnóstico
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    -- Iniciar LSP para los filetypes configurados
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "lua,typescript,typescriptreact,javascript,javascriptreact,python,html,css,htmldjango,jinja2,dart",
      callback = function(event)
        vim.lsp.start({
          name = vim.bo.filetype,
          cmd = vim.lsp.get_log_path(),
        })
      end,
    })
  end,
}
