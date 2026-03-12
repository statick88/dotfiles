-- Productivity Tools - Diego Saavedra
-- Pomodoro timer

return {
  {
    "epwalsh/pomo.nvim",
    version = "*",
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
    dependencies = {
      "rcarriga/nvim-notify",
    },
    opts = {
      update_interval = 1000,
      notifiers = {
        {
          name = "Default",
          opts = {
            sticky = true,
            title_icon = "󱎫",
            text_icon = "󰄉",
          },
        },
        { name = "System" },
      },
      sessions = {
        pomodoro = {
          { name = "Work", duration = "25m" },
          { name = "Short Break", duration = "5m" },
          { name = "Work", duration = "25m" },
          { name = "Short Break", duration = "5m" },
          { name = "Work", duration = "25m" },
          { name = "Long Break", duration = "15m" },
        },
      },
    },
    keys = {
      { "<leader>pt", "<cmd>TimerStart 25m Work<cr>", desc = "Start Pomodoro" },
      { "<leader>ps", "<cmd>TimerSession pomodoro<cr>", desc = "Pomodoro Session" },
      { "<leader>pb", "<cmd>TimerStart 5m Break<cr>", desc = "Short Break" },
      { "<leader>pB", "<cmd>TimerStart 15m 'Long Break'<cr>", desc = "Long Break" },
      { "<leader>px", "<cmd>TimerStop<cr>", desc = "Stop Timer" },
    },
  },
}
