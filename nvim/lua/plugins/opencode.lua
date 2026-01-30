return {
  "NickvanDyke/opencode.nvim",
  config = function()
    -- Configuration for opencode.nvim with Claude 3.5 Sonnet
    vim.g.opencode_opts = {
      provider = {
        enabled = "kitty",
        kitty = {
          command = "opencode",
          args = { "--port", "0" },
          location = "vsplit",  -- Open on right side (vsplit = vertical split right)
        },
      },
      events = {
        reload = true,
      },
      -- Claude 3.5 Sonnet as primary model
      model = "claude-3-5-sonnet-20241022",
      -- Fallback to Haiku if latency is high
      fallback_model = "claude-3-5-haiku-20241022",
      -- Deep analysis with Opus (rarely used)
      secondary_model = "claude-3-opus-20250805",
      prompts = {
        -- Custom prompts for different activities
        teach = "Explain this code clearly as if teaching a bootcamp student. Focus on learning principles.",
        review = "Review this code following SOLID principles and clean architecture patterns.",
        debug = "Help me debug this issue. Provide step-by-step diagnostic suggestions.",
        optimize = "Optimize this code for performance and readability.",
      },
    }

    -- Enable auto-reload
    vim.o.autoread = true

    -- Keymaps for OpenCode with model switching
    local opts = { noremap = true, silent = true }

    -- Toggle sidebar on <leader>t
    vim.keymap.set("n", "<leader>t", function()
      require("opencode").toggle()
    end, vim.tbl_extend("force", opts, { desc = "Toggle OpenCode sidebar" }))

    -- Primary: Claude 3.5 Sonnet (main assistant)
    vim.keymap.set("n", "<C-a>", function()
      vim.cmd("set model=sonnet")
      require("opencode").ask()
    end, vim.tbl_extend("force", opts, { desc = "Ask Claude 3.5 Sonnet" }))

    vim.keymap.set("x", "<C-a>", function()
      vim.cmd("set model=sonnet")
      require("opencode").ask()
    end, vim.tbl_extend("force", opts, { desc = "Ask Claude 3.5 Sonnet (visual)" }))

    -- Fast mode: Claude 3.5 Haiku (quick suggestions)
    vim.keymap.set("i", "<C-h>", function()
      vim.cmd("set model=haiku")
      require("opencode").ask()
    end, vim.tbl_extend("force", opts, { desc = "Quick Haiku suggestion (fast)" }))

    -- Deep analysis: Claude 3 Opus (complex decisions)
    vim.keymap.set("n", "<C-o>", function()
      vim.cmd("set model=opus")
      require("opencode").ask()
    end, vim.tbl_extend("force", opts, { desc = "Deep analysis with Claude 3 Opus" }))

    -- Select code for analysis
    vim.keymap.set("x", "<C-x>", function()
      require("opencode").select()
    end, vim.tbl_extend("force", opts, { desc = "Select code for analysis" }))

    -- Teaching-specific shortcuts
    vim.keymap.set("n", "<leader>oce", function()
      vim.cmd("set model=sonnet")
      vim.g.opencode_prompt = "teach"
      require("opencode").ask()
    end, vim.tbl_extend("force", opts, { desc = "OpenCode: Teach (explain code)" }))

    -- Code review shortcut
    vim.keymap.set("n", "<leader>ocr", function()
      vim.cmd("set model=sonnet")
      vim.g.opencode_prompt = "review"
      require("opencode").ask()
    end, vim.tbl_extend("force", opts, { desc = "OpenCode: Review code" }))

    -- Debug shortcut
    vim.keymap.set("n", "<leader>ocb", function()
      vim.cmd("set model=sonnet")
      vim.g.opencode_prompt = "debug"
      require("opencode").ask()
    end, vim.tbl_extend("force", opts, { desc = "OpenCode: Debug" }))

    -- Optimize shortcut
    vim.keymap.set("n", "<leader>ocx", function()
      vim.cmd("set model=sonnet")
      vim.g.opencode_prompt = "optimize"
      require("opencode").ask()
    end, vim.tbl_extend("force", opts, { desc = "OpenCode: Optimize" }))

    -- Statusline integration simplified
    -- Statusline handled by lualine config in ui.lua
  end,
}
