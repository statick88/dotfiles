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
    local mason_lspconfig = require("mason-lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason").setup()

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

    local servers = {
      lua_ls = {
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
      },
      ts_ls = {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionLikeTypeHints = "all",
            },
          },
        },
      },
      pyright = {
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
      },
      html = {},
      cssls = {},
      tailwindcss = {},
      dartls = {
        cmd = { "dart", "language-server", "--protocol=lsp" },
        filetypes = { "dart" },
        settings = {
          dart = {
            completeFunctionCalls = true,
            showTodos = true,
          },
        },
      },
    }

    local server_map = {
      lua = "lua_ls",
      typescript = "ts_ls",
      typescriptreact = "ts_ls",
      javascript = "ts_ls",
      javascriptreact = "ts_ls",
      python = "pyright",
      html = "html",
      css = "cssls",
      htmldjango = "html",
      jinja2 = "html",
      dart = "dartls",
    }

    for server_name, server_config in pairs(servers) do
      server_config.capabilities = capabilities
      vim.lsp.config(server_name, server_config)
    end

    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "lua,typescript,typescriptreact,javascript,javascriptreact,python,html,css,htmldjango,jinja2,dart",
      callback = function(event)
        local server = server_map[event.match] or vim.bo.filetype
        vim.lsp.start({ name = server })
      end,
    })
  end,
}
