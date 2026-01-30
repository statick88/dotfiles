local switcher_path = vim.fn.expand("~/.opencode/config/model-switcher.lua")
local switcher_exists = vim.fn.filereadable(switcher_path) == 1

return {
  dir = vim.fn.expand("~/.config/nvim"),
  name = "opencode-model-switcher-config",
  enabled = switcher_exists,
  lazy = false,
  priority = 100,
  config = function()
    -- Load model switcher from ~/.opencode/config
    
    -- Safely load the model switcher module
    local switcher
    local ok, result = pcall(function()
      -- Load the file content
      local content = vim.fn.readfile(switcher_path)
      if not content or #content == 0 then
        return nil
      end
      
      local code = table.concat(content, "\n")
      
      -- Remove shebang if present
      code = code:gsub("^#!.-\n", "")
      
      -- Execute and return the module
      local module = loadstring(code)()
      if not module then
        error("Module returned nil")
      end
      
      return module
    end)
    
    if not ok then
      vim.notify(
        "❌ Error loading model-switcher: " .. tostring(result),
        vim.log.levels.ERROR
      )
      return
    end
    
    switcher = result
    
    if not switcher then
      vim.notify(
        "❌ model-switcher is nil - check file format",
        vim.log.levels.ERROR
      )
      return
    end

    -- Setup keymaps
    local opts = { noremap = true, silent = true }
    
    -- Safely setup keymaps with error handling
    local function safe_keymap(modes, key, fn, desc)
      local ok, err = pcall(function()
        vim.keymap.set(modes, key, fn, vim.tbl_extend("force", opts, { desc = desc }))
      end)
      if not ok then
        vim.notify("Failed to set keymap " .. key .. ": " .. tostring(err), vim.log.levels.WARN)
      end
    end

    -- Ctrl+A: Claude 3.5 Sonnet (main)
    safe_keymap("n", "<C-a>", function()
      if switcher.switch_model then
        switcher.switch_model("sonnet")
      end
    end, "Claude 3.5 Sonnet (main)")

    -- Ctrl+H: Claude 3.5 Haiku (fast)
    safe_keymap("i", "<C-h>", function()
      if switcher.switch_model then
        switcher.switch_model("haiku")
      end
    end, "Claude 3.5 Haiku (fast)")

    -- Ctrl+O: Claude 3 Opus (deep)
    safe_keymap("n", "<C-o>", function()
      if switcher.switch_model then
        switcher.switch_model("opus")
      end
    end, "Claude 3 Opus (deep analysis)")

    -- Leader+am: Show model menu
    safe_keymap("n", "<leader>am", function()
      if switcher.show_menu then
        switcher.show_menu()
      end
    end, "AI: Show model menu")

    -- Leader+as: Show AI status
    safe_keymap("n", "<leader>as", function()
      if switcher.get_status and switcher.get_metrics then
        vim.notify(
          "Current AI Model: " .. (switcher.get_status() or "unknown") ..
          "\n\nMetrics:\n" .. vim.inspect(switcher.get_metrics() or {}),
          vim.log.levels.INFO
        )
      end
    end, "AI: Show status")

    -- Auto-switch commands
    local function safe_command(name, fn, desc)
      local ok, err = pcall(function()
        vim.api.nvim_create_user_command(name, fn, { desc = desc })
      end)
      if not ok then
        vim.notify("Failed to create command " .. name .. ": " .. tostring(err), vim.log.levels.WARN)
      end
    end

    safe_command("AISwitchSonnet", function()
      if switcher.switch_model then
        switcher.switch_model("sonnet")
      end
    end, "Switch to Claude 3.5 Sonnet")

    safe_command("AISwitchHaiku", function()
      if switcher.switch_model then
        switcher.switch_model("haiku")
      end
    end, "Switch to Claude 3.5 Haiku")

    safe_command("AISwitchOpus", function()
      if switcher.switch_model then
        switcher.switch_model("opus")
      end
    end, "Switch to Claude 3 Opus")

    safe_command("AIMenu", function()
      if switcher.show_menu then
        switcher.show_menu()
      end
    end, "Show AI model selection menu")

    -- Activity shortcuts
    safe_command("AITeaching", function()
      if switcher.auto_switch_activity then
        switcher.auto_switch_activity("bootcamp_teaching")
      end
      vim.notify("📚 Teaching mode activated - using Sonnet", vim.log.levels.INFO)
    end, "Activate teaching mode")

    safe_command("AIDevelopment", function()
      if switcher.auto_switch_activity then
        switcher.auto_switch_activity("fullstack_development")
      end
      vim.notify("💻 Development mode activated - using Sonnet", vim.log.levels.INFO)
    end, "Activate development mode")

    safe_command("AIContent", function()
      if switcher.auto_switch_activity then
        switcher.auto_switch_activity("content_creation")
      end
      vim.notify("📝 Content creation mode activated - using Sonnet", vim.log.levels.INFO)
    end, "Activate content creation mode")

    safe_command("AIDevOps", function()
      if switcher.auto_switch_activity then
        switcher.auto_switch_activity("devops_infrastructure")
      end
      vim.notify("🏗️  DevOps mode activated - using Sonnet", vim.log.levels.INFO)
    end, "Activate DevOps mode")

    safe_command("AIDeepAnalysis", function()
      if switcher.auto_switch_activity then
        switcher.auto_switch_activity("deep_architecture")
      end
      vim.notify("🔬 Deep analysis mode activated - using Opus", vim.log.levels.INFO)
    end, "Activate deep analysis mode")

    -- Default to Sonnet on startup
    if switcher.switch_model then
      switcher.switch_model("sonnet")
    end
  end,
}
