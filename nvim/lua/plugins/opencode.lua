return {
  "NickvanDyke/opencode.nvim",
  config = function()
    -- Configuration for opencode.nvim
    vim.g.opencode_opts = {
      provider = {
        enabled = "kitty",
        kitty = {
          command = "opencode",
          args = { "--port", "0" },
        }
      },
      events = {
        reload = true,
      },
      prompts = {
        -- Default prompts are included, you can add custom ones here
      }
    }

    -- Enable auto-reload
    vim.o.autoread = true

    -- Statusline integration simplified
    -- Statusline handled by lualine config in ui.lua
  end,
}