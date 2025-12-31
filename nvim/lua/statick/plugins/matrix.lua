-- Statick Matrix Theme: Tema visual profesional basado en principios del libro
-- Colores inspirados en Clean Architecture y code quality metrics
return {
  {
    "folke/tokyonight.nvim",
    name = "matrix",
    priority = 1000,
    opts = {
      -- Paleta de colores basada en principios de Clean Architecture
      on_colors = function(colors)
        local p = {
          -- Base Matrix clásico con significado arquitectónico
          bg = "#0a0e14",                    -- Fondo oscuro profesional
          fg = "#00ff41",                   -- Verde Matrix principal
          terminal = "#00cc33",             -- Verde terminal

          -- Colores según principios Statick
          blue = "#0066ff",                   -- Azul para dominio puro
          cyan = "#00cccc",                    -- Cian para inmutabilidad
          green = "#00cc44",                  -- Verde para interfaces limpias
          magenta = "#9933ff",               -- Púrpura para testing de calidad
          orange = "#ff8800",                -- Naranja para adaptadores
          red = "#ff0000",                    -- Rojo para code smells y errores
          yellow = "#ffd700",                 -- Oro para decisiones de Statick

          -- Colores para patrones de diseño
          purple = "#8844ff",                -- Púrpura para patrones
          comment = "#88ff88",                -- Verde claro para comentarios arquitectónicos
          warning = "#ffaa00",               -- Naranja para advertencias
          info = "#00aaff",                   -- Azul para información

          -- UI elements con significado arquitectónico
          border = "#00ff41",                -- Borde verde para código limpio
          highlight = "#ffd700",             -- Resaltado dorado para decisiones
          gutter = "#004411",                  -- Gutter oscuro para líneas de código
          selection = "#008822",             -- Selección verde oscuro
          visual = "#00aa44"                  -- Visual verde mediano
        }

        -- Sobreescrituras para destacar principios de Clean Architecture
        p.normal = {
          a = { fg = p.blue },
          b = { fg = p.cyan },
          c = { fg = p.green },
          d = { fg = p.yellow },
          e = { fg = p.magenta },
          f = { fg = p.orange },
          g = { fg = p.red },
          h = { fg = p.comment },
          i = { fg = p.blue, bold = true },
          j = { fg = p.cyan, bold = true },
          k = { fg = p.green, bold = true },
          l = { fg = p.yellow, bold = true },
          m = { fg = p.magenta, bold = true },
          n = { fg = p.orange, bold = true },
          o = { fg = p.red, bold = true },
          p = { fg = p.comment, bold = true },
          q = { fg = p.info, bold = true },
          r = { fg = p.info, italic = true },
          s = { fg = p.warning, bold = true },
          t = { fg = p.warning, italic = true },
          u = { fg = p.warning, bold = true },
          v = { fg = p.warning, bold = true },
          w = { fg = p.warning, bold = true },
          x = { fg = p.warning, italic = true },
          y = { fg = p.warning, bold = true },
          z = { fg = p.warning, italic = true }
        }

        -- Sobreescrituras para resaltar patrones y principios
        p.visual = {
          a = { bg = p.blue, fg = p.bg },
          b = { bg = p.cyan, fg = p.bg },
          c = { bg = p.green, fg = p.bg },
          d = { bg = p.yellow, fg = p.bg },
          e = { bg = p.magenta, fg = p.bg },
          f = { bg = p.orange, fg = p.bg }
        }

        return p
      end
    },
    config = function()
      vim.cmd.colorscheme "tokyonight"

      -- Configurar highlights personalizados para principios
      vim.api.nvim_set_hl(0, "StatickRobotPrefix", { fg = "#00ff41", bold = true })
      vim.api.nvim_set_hl(0, "StatickStatickPrefix", { fg = "#ffd700", bold = true })

      -- Configurar highlights para Clean Architecture
      vim.api.nvim_set_hl(0, "SOLIDHighlight", { fg = "#9933ff", bold = true })
      vim.api.nvim_set_hl(0, "PatternHighlight", { fg = "#8844ff", bold = true })
      vim.api.nvim_set_hl(0, "ArchitectureViolation", { fg = "#ff0000", undercurl = true })
      vim.api.nvim_set_hl(0, "QualityMetric", { fg = "#00aaff", bold = true })
      vim.api.nvim_set_hl(0, "StatickDecision", { fg = "#ffd700", bold = true })
      vim.api.nvim_set_hl(0, "CleanCode", { fg = "#00cc44", bold = true })
    end
  }
}