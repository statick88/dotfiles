return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    -- Enable Copilot
    vim.g.copilot_enabled = 1
    vim.g.copilot_assume_mapped = false
    vim.g.copilot_no_tab_map = true

    -- Set up custom key mappings
    vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
      desc = "Copilot Accept",
    })
    vim.keymap.set("i", "<C-K>", "copilot#Previous()", { expr = true, desc = "Copilot Previous" })
    vim.keymap.set("i", "<C-L>", "copilot#Next()", { expr = true, desc = "Copilot Next" })
    vim.keymap.set("i", "<C-]>", "copilot#Dismiss()", { expr = true, desc = "Copilot Dismiss" })

    -- Which-key integration for better keymap discovery in insert mode
    -- Note: which-key doesn't support insert mode directly, but we document it here for reference
    vim.api.nvim_echo(
      { { "Copilot keymaps (Insert mode): <C-J> accept, <C-K> prev, <C-L> next, <C-]> dismiss", "Comment" } },
      false,
      {}
    )
  end,
}
