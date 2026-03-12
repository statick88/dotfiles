-- Streaming/Presentation - Diego Saavedra
-- Screenkey - displays keys on screen for courses/streaming

return {
  "NStefan002/screenkey.nvim",
  cmd = "Screenkey",
  keys = {
    { "<leader>usk", "<cmd>Screenkey toggle<cr>", desc = "Toggle Screenkey" },
  },
  opts = {
    win_opts = {
      relative = "editor",
      anchor = "SE",
      row = 1,
      col = 1,
      border = "single",
      title = "Screenkey",
      title_pos = "center",
      style = "minimal",
      focusable = false,
      noautocmd = true,
    },
    compress_after = 3,
    clear_after = 3,
    disable = {
      filetypes = {},
      buftypes = {},
      events = {},
    },
    show_leader = true,
    group_mappings = false,
    display_events = true,
    filter = function(event)
      local excluded_keys = {
        "CursorHold",
        "CursorHoldI",
        "CursorMoved",
        "CursorMovedI",
      }
      return not vim.tbl_contains(excluded_keys, event)
    end,
  },
}
