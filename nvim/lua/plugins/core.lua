return {
  "folke/lazy.nvim",
  opts = {
    defaults = {
      lazy = true,
      version = false,
    },
    install = {
      colorscheme = { "tokyonight", "catppuccin" },
    },
    checker = {
      enabled = true,
      notify = false,
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  },
}
