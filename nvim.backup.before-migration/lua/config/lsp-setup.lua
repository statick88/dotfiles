-- Consolidated LSP (Language Server Protocol) configuration
-- This module centralizes all LSP setup logic

local M = {}

---Setup LSP servers with Mason
---@param servers table List of servers to ensure installed
local function setup_mason(servers)
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = servers,
  })
end

---Configure LSP servers
---@param lspconfig table LSP config module
---@param capabilities table Client capabilities
---@param servers table LSP server configurations
local function configure_servers(lspconfig, capabilities, servers)
  for server, config in pairs(servers) do
    config.capabilities = capabilities
    lspconfig[server].setup(config)
  end
end

---Setup function to initialize all LSP configuration
function M.setup()
  -- Setup Mason and ensure servers are installed
  local servers_to_install = {
    "lua_ls",
    "pyright",
    "ts_ls",
    "html",
    "cssls",
    "jsonls",
    "yamlls",
    "bashls",
    "templ",
    "marksman",
  }

  setup_mason(servers_to_install)

  -- Get client capabilities
  local lspconfig = require("lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Define server configurations
  local servers = {
    lua_ls = {},
    pyright = {},
    ts_ls = {},
    html = {},
    cssls = {},
    jsonls = {},
    yamlls = {},
    bashls = {},
    marksman = {},
  }

  -- Configure all servers
  configure_servers(lspconfig, capabilities, servers)
end

return M
