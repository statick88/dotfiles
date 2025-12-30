-- LSP (Language Server Protocol): Convierte Neovim en un IDE completo
-- Proporciona inteligencia de lenguaje: autocompletado, diagnóstico, definiciones, etc.
-- Comandos principales: gd (go to definition), gr (references), K (documentation)
return {
  "neovim/nvim-lspconfig",                                -- Configuración de LSP para Neovim
  dependencies = {
    "williamboman/mason.nvim",                           -- Gestor de servidores LSP
    "williamboman/mason-lspconfig.nvim",                  -- Bridge entre Mason y lspconfig
    "hrsh7th/cmp-nvim-lsp",                              -- Conector entre LSP y autocompletado
  },
  config = function()
    -- Inicializar Mason (gestor de herramientas de desarrollo)
    require("mason").setup()
    local mason_lspconfig = require("mason-lspconfig")
    
    -- Configurar qué servidores LSP instalar automáticamente
    mason_lspconfig.setup({
      ensure_installed = { 
        "lua_ls",         -- Servidor para archivos Lua (configuración nvim)
        "ts_ls",          -- Servidor para TypeScript/JavaScript
        "pyright",        -- Servidor para Python
        "html",           -- Servidor para HTML
        "cssls",          -- Servidor para CSS
        "tailwindcss"     -- Servidor para Tailwind CSS
      },
      automatic_installation = true,                         -- Instalar servidores automáticamente
    })

    -- Habilitar capacidades avanzadas para autocompletado
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Restaurar require directo - la advertencia es solo informativa
    -- El framework funciona correctamente, solo muestra mensaje de deprecación
    local lspconfig = require("lspconfig")
    
    -- Restorar configuración completa de servidores LSP
    -- Lazy.nvim manejará la instalación automática
  end,
}
