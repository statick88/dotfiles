return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main",
  dependencies = {
    { "github/copilot.vim" },
    { "nvim-lua/plenary.nvim" },
  },
  build = "make tiktoken",
  cmd = {
    "CopilotChat",
    "CopilotChatToggle",
    "CopilotChatExplain",
    "CopilotChatReview",
    "CopilotChatFix",
    "CopilotChatOptimize",
  },
  keys = {
    { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat Toggle", mode = { "n", "v" } },
    { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "Copilot Explain", mode = { "n", "v" } },
    { "<leader>cr", "<cmd>CopilotChatReview<cr>", desc = "Copilot Review", mode = { "n", "v" } },
    { "<leader>cd", "<cmd>CopilotChatFix<cr>", desc = "Copilot Fix", mode = { "v" } },
    { "<leader>co", "<cmd>CopilotChatOptimize<cr>", desc = "Copilot Optimize", mode = { "v" } },
  },
  config = function()
    -- Load project-specific prompts with error handling
    local prompts_ok, prompts = pcall(require, "config.copilot-prompts")
    if not prompts_ok then
      prompts = { prompts = {} }
    end

    local config = {
      debug = false,
      show_help = true,
      question_header = "  User ",
      answer_header = "󰚀 Copilot ",
      error_header = "  Error ",
      separator = "---",
      auto_insert_mode = true,
      insert_at_start = true,
      chat_autocomplete = true,
      log_level = "warn",
      show_system_prompt = false,
      model = "gpt-4o",
      prompts = prompts.prompts or {},
      window = {
        layout = "float",
        relative = "cursor",
        width = 0.8,
        height = 0.8,
        row = 1,
      },
    }

    require("CopilotChat").setup(config)

    -- Set chat buffer to modifiable when created
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "copilot-*",
      callback = function(event)
        local bufnr = event.buf
        vim.bo[bufnr].modifiable = true
        vim.bo[bufnr].readonly = false
      end,
      desc = "Make Copilot Chat buffer modifiable",
    })

    -- Telescope integration if available
    local telescope_ok, telescope = pcall(require, "CopilotChat.integrations.telescope")
    if telescope_ok and telescope then
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
