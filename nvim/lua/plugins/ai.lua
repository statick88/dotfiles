return {
  {
    "olimorris/codecompanion.nvim",
    cmd = { "Codecompanion", "CodecompanionChat" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "stevearc/dressing.nvim" },
    },
    config = function()
      require("codecompanion").setup({
        adapter = "anthropic",
        display = {
          chat = {
            show_system_prompt = true,
            show_user = true,
          },
        },
        anthropic = {
          api_key = function()
            return os.getenv("ANTHROPIC_API_KEY")
          end,
          model = "claude-sonnet-4-20250520",
        },
        prompts = {
          explain = "Explain this code clearly as if teaching a bootcamp student. Focus on learning principles.",
          review = "Review this code following SOLID principles and clean architecture patterns.",
          debug = "Help me debug this issue. Provide step-by-step diagnostic suggestions.",
          optimize = "Optimize this code for performance and readability.",
        },
      })
    end,
  },
  {
    "yetone/avante.nvim",
    cmd = { "Avante" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/oil.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("avante").setup({
        provider = "anthropic",
        anthropic = {
          api_key = function()
            return os.getenv("ANTHROPIC_API_KEY")
          end,
          model = "claude-sonnet-4-20250520",
        },
        behaviour = {
          auto_suggestions = true,
          max_suggestions = 5,
        },
      })
    end,
  },
}
