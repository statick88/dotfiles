-- Web Development - Plugins especializados para desarrollo web
-- Solo se carga cuando se detectan archivos web (JS/TS/HTML/CSS)
return {
  -- Emmet - Expansión rápida de HTML/CSS
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" },
    event = "InsertEnter",
  },

  -- Tailwind CSS - Autocompletado para clases Tailwind
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "typescriptreact", "javascriptreact", "vue", "svelte", "html", "css" },
    event = "BufReadPost",
    opts = {},
  },

  -- React/Next.js snippets
  {
    "dsznajder/vscode-es7-javascript-react-snippets",
    run = "yarn install --frozen-lockfile && yarn build",
    ft = { "javascriptreact", "typescriptreact", "javascript", "typescript" },
  },

  -- TypeScript/JavaScript additional tools
  {
    "jose-elias-alvarez/typescript.nvim",
    ft = { "typescript", "typescriptreact" },
    event = "BufReadPost",
    opts = {
      server = "tsserver",
      debug = false,
    },
  },

  -- HTML/JSX/TSX tag closing
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "xml", "javascriptreact", "typescriptreact", "vue", "svelte" },
    event = "BufReadPost",
    opts = {},
  },

  -- Auto-close HTML/XML tags (alternativa más ligera)
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "xml", "javascriptreact", "typescriptreact", "vue", "svelte" },
    event = "BufReadPost",
    opts = {},
  },
}
