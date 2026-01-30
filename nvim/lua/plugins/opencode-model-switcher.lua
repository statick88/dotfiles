return {
  "opencode-model-switcher",
  dir = "~/.opencode/config",
  lazy = false,
  priority = 100,
  config = function()
    -- Load model switcher
    local switcher = require("model-switcher")

    -- Setup keymaps
    local opts = { noremap = true, silent = true }

    -- Ctrl+A: Claude 3.5 Sonnet (main)
    vim.keymap.set("n", "<C-a>", function()
      switcher.switch_model("sonnet")
    end, vim.tbl_extend("force", opts, { desc = "Claude 3.5 Sonnet (main)" }))

    -- Ctrl+H: Claude 3.5 Haiku (fast)
    vim.keymap.set("i", "<C-h>", function()
      switcher.switch_model("haiku")
    end, vim.tbl_extend("force", opts, { desc = "Claude 3.5 Haiku (fast)" }))

    -- Ctrl+Shift+O: Claude 3 Opus (deep)
    vim.keymap.set("n", "<C-o>", function()
      switcher.switch_model("opus")
    end, vim.tbl_extend("force", opts, { desc = "Claude 3 Opus (deep analysis)" }))

    -- Leader+am: Show model menu
    vim.keymap.set("n", "<leader>am", function()
      switcher.show_menu()
    end, vim.tbl_extend("force", opts, { desc = "AI: Show model menu" }))

    -- Leader+as: Show AI status
    vim.keymap.set("n", "<leader>as", function()
      vim.notify(
        "Current AI Model: " .. switcher.get_status() .. "\n\nMetrics:\n" .. vim.inspect(switcher.get_metrics()),
        vim.log.levels.INFO
      )
    end, vim.tbl_extend("force", opts, { desc = "AI: Show status" }))

    -- Auto-switch commands
    vim.api.nvim_create_user_command("AISwitchSonnet", function()
      switcher.switch_model("sonnet")
    end, { desc = "Switch to Claude 3.5 Sonnet" })

    vim.api.nvim_create_user_command("AISwitchHaiku", function()
      switcher.switch_model("haiku")
    end, { desc = "Switch to Claude 3.5 Haiku" })

    vim.api.nvim_create_user_command("AISwitchOpus", function()
      switcher.switch_model("opus")
    end, { desc = "Switch to Claude 3 Opus" })

    vim.api.nvim_create_user_command("AIMenu", function()
      switcher.show_menu()
    end, { desc = "Show AI model selection menu" })

    -- Activity shortcuts
    vim.api.nvim_create_user_command("AITeaching", function()
      switcher.auto_switch_activity("bootcamp_teaching")
      vim.notify("📚 Teaching mode activated - using Sonnet", vim.log.levels.INFO)
    end, { desc = "Activate teaching mode" })

    vim.api.nvim_create_user_command("AIDevelopment", function()
      switcher.auto_switch_activity("fullstack_development")
      vim.notify("💻 Development mode activated - using Sonnet", vim.log.levels.INFO)
    end, { desc = "Activate development mode" })

    vim.api.nvim_create_user_command("AIContent", function()
      switcher.auto_switch_activity("content_creation")
      vim.notify("📝 Content creation mode activated - using Sonnet", vim.log.levels.INFO)
    end, { desc = "Activate content creation mode" })

    vim.api.nvim_create_user_command("AIDevOps", function()
      switcher.auto_switch_activity("devops_infrastructure")
      vim.notify("🏗️  DevOps mode activated - using Sonnet", vim.log.levels.INFO)
    end, { desc = "Activate DevOps mode" })

    vim.api.nvim_create_user_command("AIDeepAnalysis", function()
      switcher.auto_switch_activity("deep_architecture")
      vim.notify("🔬 Deep analysis mode activated - using Opus", vim.log.levels.INFO)
    end, { desc = "Activate deep analysis mode" })

    -- Default to Sonnet on startup
    switcher.switch_model("sonnet")
  end,
}
