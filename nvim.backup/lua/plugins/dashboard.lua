return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      "                                              ",
      "  ██╗      █████╗ ███████╗██╗   ██╗██╗     ██╗     ",
      "  ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║     ██║     ",
      "  ██║     ███████║  ███╔╝  ╚████╔╝ ██║     ██║     ",
      "  ██║     ██╔══██║ ███╔╝    ╚██╔╝  ██║     ██║     ",
      "  █████╗ ██║  ██║███████╗   ██║   █████╗ █████╗   ",
      "  ╚═════╝ ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═════╝ ╚═════╝   ",
      "                                              ",
      "              Statick Developer               ",
      "                                              ",
    }
    return opts
  end,
}
