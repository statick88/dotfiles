return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    require("mason").setup()
    local mason_lspconfig = require("mason-lspconfig")
    
    mason_lspconfig.setup({
      ensure_installed = { "lua_ls", "ts_ls", "pyright", "html", "cssls", "tailwindcss" },
      automatic_installation = true,
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    mason_lspconfig.setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup({
          capabilities = capabilities,
          settings = { 
            Lua = { 
              diagnostics = { globals = { "vim" } } 
            } 
          },
        })
      end,
    })
  end, -- Cierra la función 'config' de la línea 9
} -- Cierra el return principal
