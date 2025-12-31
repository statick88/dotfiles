-- which-key.nvim: Muestra las opciones disponibles al presionar la tecla leader
-- Similar a LazyVim, muestra un menú visual con todos los atajos organizados
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["<leader>"] = {
          ["<leader>"] = { name = "+lazy", _ = "which_key_ignore" },

          -- Explorador de archivos
          e = { name = "+explorer" },

          -- Telescope - Búsqueda
          f = {
            name = "+find",
            f = { "Find files" },
            g = { "Live grep" },
            b = { "Find buffers" },
            h = { "Help tags" },
          },

          -- Productividad
          p = {
            name = "+productivity",
            s = { "Flash search" },
            t = { "Todo comments" },
            x = { "Trouble (diagnostics)" },
          },

          -- Web Development (React, TS, HTML, CSS)
          w = {
            name = "+web",
            e = { "Emmet expansion" },
            t = { "Tailwind tools" },
            l = { "ESLint" },
            p = { "Prettier format" },
          },

          -- Python Development (Django, FastAPI, PyTest)
          y = {
            name = "+python",
            v = { "Select virtual env" },
            tr = { "PyTest run nearest" },
            tf = { "PyTest run file" },
            ts = { "PyTest stop" },
            to = { "PyTest output" },
            d = { "Generate docstring" },
          },

          -- Flutter & Mobile
          f = {
            name = "+flutter",
            r = { "Run app" },
            d = { "List devices" },
            q = { "Quit app" },
            h = { "Hot reload" },
          },

          -- Git Avanzado
          g = {
            name = "+git",
            g = { "LazyGit" },
            vo = { "Open diffview" },
            vc = { "Close diffview" },
            vf = { "File history" },
            co = { "Conflict: Choose ours" },
            ct = { "Conflict: Choose theirs" },
            cb = { "Conflict: Choose both" },
            c0 = { "Conflict: Choose none" },
            cn = { "Conflict: Next" },
            cp = { "Conflict: Previous" },
            b = { "Git blame" },
          },

          -- Docker
          d = {
            name = "+docker",
            u = { "Docker UI" },
          },

          -- Testing
          t = {
            name = "+testing",
            n = { "Test nearest" },
            f = { "Test file" },
            s = { "Test suite" },
            v = { "Test visit" },
            g = { "Test go" },
          },

          -- Quarto - Navegación (pre-configurado en keymaps.lua)
          -- Usar ]b y [b para moverse entre celdas

          -- Quarto - Ejecución (pre-configurado en keymaps.lua)
          -- Usar <localleader>r* para ejecutar código

          -- Quarto - Previsualización (pre-configurado en keymaps.lua)
          -- Usar <localleader>p* para previsualizar

          -- Git - Gitsigns
          h = { name = "+git_hunk" },
          r = { name = "+git_reset" },

          -- LSP - Language Server Protocol
          n = { name = "+lsp" },
        },

        -- Comandos de Quarto (localleader)
        ["<localleader>"] = {
          r = {
            name = "+run",
            c = { "Run current cell" },
            a = { "Run cell and above" },
            A = { "Run all cells" },
            l = { "Run current line" },
          },
          p = {
            name = "+preview",
            p = { "Quarto preview" },
            s = { "Stop preview" },
          },
          q = {
            name = "+quarto",
            i = { "Inspect document" },
            f = { "Format document" },
          },
        },

        -- Navegación LSP
        g = {
          name = "+goto",
          d = { "Go to definition" },
          r = { "Go to references" },
          i = { "Go to implementation" },
          D = { "Go to type definition" },
        },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
}
