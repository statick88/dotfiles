-- Frontend Development - Diego Saavedra
-- React, Next.js, Angular, Vue, Svelte, Tailwind

return {
  -- Auto close/rename HTML/JSX tags
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = false,
    },
  },

  -- Tailwind CSS Color Preview
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    ft = { "css", "html", "tsx", "jsx", "vue", "svelte" },
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end,
  },

  -- Emmet support
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "scss", "javascriptreact", "typescriptreact", "vue", "svelte" },
    init = function()
      vim.g.user_emmet_leader_key = "<C-e>"
      vim.g.user_emmet_mode = "i"
    end,
  },
}
