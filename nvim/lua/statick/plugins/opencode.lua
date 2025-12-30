return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recomendado para mejor input de prompts y terminal embebida
      { "folke/snacks.nvim", opts = { input = { enabled = true } } },
    },
    ---@type opencode.Opts
    opts = {
      -- Configuración básica para desarrollo profesional
      prompts = {
        -- Prompts personalizados para tareas comunes de desarrollo
        explain_code = "Explica este código de forma clara y concisa, considerando el contexto actual del proyecto.",
        optimize_code = "Optimiza este código para mejor rendimiento y mantenibilidad, explicando los cambios realizados.",
        debug_help = "Ayúdame a encontrar y solucionar posibles errores en este código.",
        refactor = "Refactoriza este código siguiendo las mejores prácticas y patrones de diseño.",
      },
      ui = {
        -- Configuración de la interfaz de usuario
        show_line_numbers = true,
        show_cursor_line = true,
        wrap_lines = false,
      },
    },
    keys = {
      -- Keymaps principales para interactuar con opencode
      { "<leader>oA", function() require("opencode").ask() end, desc = "Ask opencode", mode = { "n", "v" } },
      { "<leader>oa", function() require("opencode").ask("@cursor: ") end, desc = "Ask about cursor", mode = "n" },
      { "<leader>oa", function() require("opencode").ask("@selection: ") end, desc = "Ask about selection", mode = "v" },
      { "<leader>ot", function() require("opencode").toggle() end, desc = "Toggle opencode window" },
      { "<leader>on", function() require("opencode").command("session_new") end, desc = "New session" },
      { "<leader>oy", function() require("opencode").command("messages_copy") end, desc = "Copy last message" },
      
      -- Navegación en mensajes
      { "<S-C-u>", function() require("opencode").command("messages_half_page_up") end, desc = "Scroll messages up" },
      { "<S-C-d>", function() require("opencode").command("messages_half_page_down") end, desc = "Scroll messages down" },
      { "<leader>op", function() require("opencode").select_prompt() end, desc = "Select prompt", mode = { "n", "v" } },
      
      -- Prompts personalizados con shortcuts
      { "<leader>oe", function() require("opencode").prompt("Explica @cursor y su contexto en este proyecto") end, desc = "Explain code near cursor" },
      { "<leader>od", function() require("opencode").prompt("Ayúdame a depurar @cursor: posibles errores y soluciones") end, desc = "Debug code at cursor" },
      { "<leader>or", function() require("opencode").prompt("Refactoriza @cursor aplicando mejores prácticas") end, desc = "Refactor code at cursor" },
    },
  },
}