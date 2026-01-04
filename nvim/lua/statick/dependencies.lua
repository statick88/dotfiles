-- Dependencias del Proyecto Neovim Config
-- Este archivo documenta las dependencias externas requeridas para el funcionamiento completo

local M = {}

return {
  description = "Dependencias externas requeridas por los plugins de Neovim",

  dependencies = {
    -- Herramientas de línea de comandos (CLI)
    {
      name = "git",
      required_by = { "git.lua", "gitsigns.nvim" },
      install = "brew install git",
      description = "Control de versiones - requerido por plugins de Git"
    },
    {
      name = "tmux",
      required_by = { "tmux.nvim" },
      install = "brew install tmux",
      description = "Terminal multiplexer - para integración tmux.nvim"
    },

    -- Servidores LSP (instalados por Mason, pero pueden requerir instalación previa)
    {
      name = "lua-language-server",
      required_by = { "lsp.lua" },
      install = ":MasonInstall lua_ls",
      description = "Servidor LSP para Lua - instalado por Mason"
    },
    {
      name = "typescript-language-server",
      required_by = { "lsp.lua" },
      install = ":MasonInstall ts_ls",
      description = "Servidor LSP para TypeScript/JavaScript - instalado por Mason"
    },
    {
      name = "pyright",
      required_by = { "lsp.lua" },
      install = ":MasonInstall pyright",
      description = "Servidor LSP para Python - instalado por Mason"
    },
    {
      name = "dart",
      required_by = { "lsp.lua", "flutter-dev.lua" },
      install = "brew install dart",
      description = "SDK de Dart - requerido para Flutter y DartLS"
    },
    {
      name = "flutter",
      required_by = { "flutter-dev.lua" },
      install = "brew install flutter",
      description = "SDK de Flutter - para desarrollo móvil"
    },

    -- Python: pip install
    {
      name = "python3",
      required_by = { "python-dev.lua" },
      install = "brew install python3",
      description = "Python 3 - requerido para desarrollo Python"
    },
    {
      name = "black",
      required_by = { "python-dev.lua" },
      install = "pip3 install black",
      description = "Formatter de Python - opcional"
    },
    {
      name = "flake8",
      required_by = { "python-dev.lua" },
      install = "pip3 install flake8",
      description = "Linter de Python - opcional"
    },

    -- Web development
    {
      name = "node",
      required_by = { "web-dev.lua", "telescope-fzf-native" },
      install = "brew install node",
      description = "Node.js - requerido para desarrollo web y plugins JS"
    },
    {
      name = "npm",
      required_by = { "web-dev.lua", "telescope-fzf-native" },
      install = "brew install npm",
      description = "Gestor de paquetes de Node.js"
    },

    -- Docker
    {
      name = "docker",
      required_by = { "git.lua (Dockerfile.vim)" },
      install = "brew install --cask docker",
      description = "Docker - para desarrollo con contenedores"
    },

    -- Herramientas de IA (opcionales)
    {
      name = "ollama",
      required_by = { "opencode.lua (si se usa Ollama)" },
      install = "brew install ollama",
      description = "Motor LLM local - opcional, requiere configuración en opencode.lua"
    },
    {
      name = "gga",
      required_by = { "gga.lua" },
      install = "brew install gentleman-programming/tap/gga",
      description = "Gentleman Guardian Angel - AI Code Review (plugin deshabilitado)"
    },
  },

  plugin_tree = {
    {
      category = "CORE",
      plugins = {
        "lazy.nvim",
        "which-key.nvim",
        "catppuccin.nvim",
        "nvim-treesitter",
      }
    },
    {
      category = "LANG",
      plugins = {
        "python-dev.lua",
        "flutter-dev.lua",
        "web-dev.lua",
      }
    },
    {
      category = "DEV",
      plugins = {
        "lsp.lua",
        "completions.lua",
        "telescope.lua",
        "testing.lua",
      }
    },
    {
      category = "UX",
      plugins = {
        "autopairs.lua",
        "colorscheme.lua",
        "treesitter.lua",
        "neotree.lua",
        "markdown.lua",
        "help.lua",
        "productivity.lua",
      }
    },
    {
      category = "DOC",
      plugins = {
        "obsidian.lua",
        "quarto.lua",
        "excalidraw.lua",
      }
    },
    {
      category = "TOOLS",
      plugins = {
        "git.lua",
        "tmux.lua",
      }
    },
    {
      category = "AI",
      plugins = {
        "opencode.lua",
        "gga.lua",
      }
    },
  },

  installation_guide = [[
  Guía de Instalación de Dependencias Externas

  1. Instalar Homebrew (si no está instalado):
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  2. Instalar dependencias básicas:
     brew install git tmux python3 node npm

  3. Instalar LSPs (via Mason en Neovim):
     :MasonInstall lua_ls ts_ls pyright html cssls tailwindcss dartls

  4. Instalar Python tools (opcional):
     pip3 install black flake8

  5. Instalar Dart/Flutter (opcional, para desarrollo móvil):
     brew install dart
     brew install flutter

  6. Instalar Docker (opcional):
     brew install --cask docker

  7. Instalar Ollama (opcional, para IA local):
     brew install ollama
     ollama pull deepseek-coder

  Notas:
  - La mayoría de LSPs se instalan automáticamente por Mason
  - Las herramientas opcionales se pueden instalar según necesidades
  - Verifica las instalaciones con :Mason en Neovim
  ]],
}
