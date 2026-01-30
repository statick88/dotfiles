return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  dependencies = {
    { "github/copilot.vim" },
    { "nvim-lua/plenary.nvim" },
  },
  build = "make tiktoken",
  cmd = { "CopilotChat", "CopilotChatToggle", "CopilotChatExplain", "CopilotChatReview" },
  keys = {
    { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat Toggle", mode = { "n", "v" } },
    { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "Copilot Explain", mode = { "n", "v" } },
    { "<leader>cr", "<cmd>CopilotChatReview<cr>", desc = "Copilot Review", mode = { "n", "v" } },
    { "<leader>cd", "<cmd>CopilotChatFix<cr>", desc = "Copilot Fix", mode = { "v" } },
    { "<leader>co", "<cmd>CopilotChatOptimize<cr>", desc = "Copilot Optimize", mode = { "v" } },
  },
  config = function()
    -- Load project-specific prompts
    local prompts = require("config.copilot-prompts")

    require("CopilotChat").setup({
      debug = false,
      show_help = true,
      question_header = "  User ",
      answer_header = "烙  Copilot ",
      error_header = "  Error ",
      separator = "---",
      auto_insert_mode = false,
      insert_at_start = false,
      chat_autocomplete = true,
      log_level = "INFO",
      proxy = nil,
      show_system_prompt = false,
      model = "gpt-4o",
      prompts = prompts.prompts,
    })

    -- Telescope integration if available
    if pcall(require, "telescope") then
      local telescope = require("CopilotChat.integrations.telescope")

      -- Basic history picker
      vim.keymap.set("n", "<leader>ch", telescope.pick, { desc = "Copilot Chat History" })

      -- Help actions
      vim.keymap.set("n", "<leader>cah", function()
        local actions = require("CopilotChat.actions")
        telescope.pick(actions.help_actions())
      end, { desc = "CopilotChat - Help actions" })

      -- Prompt actions
      vim.keymap.set("n", "<leader>cap", function()
        local actions = require("CopilotChat.actions")
        telescope.pick(actions.prompt_actions())
      end, { desc = "CopilotChat - Prompt actions" })
    end

    -- Which-key integration for better keymap discovery
    local wk_ok, wk = pcall(require, "which-key")
    if wk_ok then
      wk.add({
        {
          "<leader>c",
          group = "Copilot Chat",
          icon = { icon = "󰚀", color = "cyan" },
        },
        {
          "<leader>ca",
          group = "Copilot Actions",
          icon = { icon = "⚙️", color = "yellow" },
        },
      })
    end
  end,
}
