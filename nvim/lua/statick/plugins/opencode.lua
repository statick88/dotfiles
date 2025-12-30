-- OpenCode.nvim: Asistente de IA integrado en Neovim para desarrollo inteligente
-- Es como tener ChatGPT/Copilot dentro de tu editor con comandos específicos
-- Ideal para entender código complejo, debuggear, refactorizar, aprender
return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Snacks.nvim: Mejora la experiencia de input/prompt y terminal embebida
      { "folke/snacks.nvim", opts = { input = { enabled = true } } },
    },
    opts = {
      -- Prompts predefinidos para tareas comunes (puedes personalizar)
      prompts = {
        explain_code = "Explica este código de forma clara y concisa, considerando el contexto actual del proyecto.",
        optimize_code = "Optimiza este código para mejor rendimiento y mantenibilidad, explicando los cambios realizados.",
        debug_help = "Ayúdame a encontrar y solucionar posibles errores en este código.",
        refactor = "Refactoriza este código siguiendo las mejores prácticas y patrones de diseño.",
      },
      ui = {
        show_line_numbers = true,                            -- Mostrar números de línea en ventana IA
        show_cursor_line = true,                             -- Resaltar línea actual en ventana IA  
        wrap_lines = false,                                   -- No wrapping para mejor legibilidad
      },
    },
    keys = {
      -- Comandos principales para interactuar con la IA
      { "<leader>oA", function() require("opencode").ask() end, desc = "Ask opencode", mode = { "n", "v" } },
      { "<leader>oa", function() require("opencode").ask("@cursor: ") end, desc = "Ask about cursor", mode = "n" },
      { "<leader>oa", function() require("opencode").ask("@selection: ") end, desc = "Ask about selection", mode = "v" },
      { "<leader>ot", function() require("opencode").toggle() end, desc = "Toggle opencode window" },
      { "<leader>on", function() require("opencode").command("session_new") end, desc = "New session" },
      { "<leader>oy", function() require("opencode").command("messages_copy") end, desc = "Copy last message" },
      
      -- Navegación en la ventana de IA
      { "<S-C-u>", function() require("opencode").command("messages_half_page_up") end, desc = "Scroll messages up" },
      { "<S-C-d>", function() require("opencode").command("messages_half_page_down") end, desc = "Scroll messages down" },
      { "<leader>op", function() require("opencode").select_prompt() end, desc = "Select prompt", mode = { "n", "v" } },
      
      -- Atajos rápidos para tareas específicas (más usados)
      { "<leader>oe", function() require("opencode").prompt("Explica @cursor y su contexto en este proyecto") end, desc = "Explain code near cursor" },
      { "<leader>od", function() require("opencode").prompt("Ayúdame a depurar @cursor: posibles errores y soluciones") end, desc = "Debug code at cursor" },
      { "<leader>or", function() require("opencode").prompt("Refactoriza @cursor aplicando mejores prácticas") end, desc = "Refactor code at cursor" },
    },
  },
}