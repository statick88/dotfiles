-- Web Development - Plugins especializados para desarrollo web
-- Solo se carga cuando se detectan archivos web (JS/TS/HTML/CSS)
return {
  -- Emmet - Expansión rápida de HTML/CSS
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" },
    event = "InsertEnter",
  },

  -- React/Next.js snippets
  {
    "dsznajder/vscode-es7-javascript-react-snippets",
    run = "yarn install --frozen-lockfile && yarn build",
    ft = { "javascriptreact", "typescriptreact", "javascript", "typescript" },
  },

  -- HTML/JSX/TSX tag closing
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "xml", "javascriptreact", "typescriptreact", "vue", "svelte" },
    event = "BufReadPost",
    opts = {},
  },
}
