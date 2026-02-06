return {
  -- blink.cmp: Modern autocomplete replacement for copilot.lua
  {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "L3MON4D3/LuaSnip",
    },
    opts = {
      keymap = {
        preset = "enter",
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-j>"] = { "select_next", "snippet_forward", "fallback" },
        ["<C-k>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-c>"] = { "hide", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
      completion = {
        ghost = {
          enabled = true,
          select_on_complete = false,
        },
        accept = {
          auto_brackets = {
            enabled = true,
            override_event_handlers = {},
          },
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
        menu = {
          draw = {
            components = {
              kind_icon = {
                width = 1.5,
                align = "left",
                padding = 0,
              },
            },
          },
        },
        documentation = {
          window = {
            border = "single",
          },
        },
      },
      signature = {
        enabled = true,
        window = {
          border = "single",
        },
      },
      sources = {
        default = { "lsp", "path", "snip", "buffer", "copilot" },
        providers = {
          copilot = {
            name = "Copilot",
            module = "blink-cmp.copilot",
            score_offset = -1,
          },
        },
      },
      appearance = {
        kind_icons = {
          Copilot = "",
          Text = "",
          Method = "ƒ",
          Function = "ƒ",
          Constructor = "",
          Field = "",
          Variable = "",
          Class = "",
          Interface = "",
          Module = "",
          Property = "",
          Unit = "",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "",
          Event = "",
          Operator = "",
          TypeParameter = "",
        },
      },
    },
  },
  -- Copilot.vim: Mantener para ghost text
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_enabled = 1
      vim.g.copilot_assume_mapped = false
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        desc = "Copilot Accept",
      })
      vim.keymap.set("i", "<C-K>", "copilot#Previous()", { expr = true, desc = "Copilot Previous" })
      vim.keymap.set("i", "<C-L>", "copilot#Next()", { expr = true, desc = "Copilot Next" })
      vim.keymap.set("i", "<C-]>", "copilot#Dismiss()", { expr = true, desc = "Copilot Dismiss" })
    end,
  },
  -- Codecompanion: AI chat and inline edits
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
  -- Avante: Cursor-like editing with Claude
  {
    "yetone/avante.nvim",
    cmd = { "Avante" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/oil.nvim",
      "nvim-tree/nvim-web-devicons",
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
