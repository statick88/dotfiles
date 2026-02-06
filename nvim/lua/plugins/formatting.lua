return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "black", "isort", "ruff_format" },
          javascript = { "prettierd", "prettier" },
          typescript = { "prettierd", "prettier" },
          javascriptreact = { "prettierd", "prettier" },
          typescriptreact = { "prettierd", "prettier" },
          html = { "prettierd", "prettier" },
          css = { "prettierd", "prettier" },
          scss = { "prettierd", "prettier" },
          json = { "prettierd", "prettier" },
          yaml = { "prettierd", "prettier" },
          markdown = { "prettierd", "prettier" },
          lua = { "stylua" },
          rust = { "rustfmt" },
          go = { "gofmt" },
          dart = { "dart_format" },
        },
        format_on_save = function(bufnr)
          local filetype = vim.bo[bufnr].filetype
          if vim.tbl_contains({ "python" }, filetype) then
            return {
              timeout_ms = 5000,
              lsp_fallback = true,
            }
          end
          return {
            timeout_ms = 500,
            lsp_fallback = true,
          }
        end,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = "BufWritePost",
    config = function()
      require("lint").linters_by_ft = {
        python = { "ruff" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        json = { "jsonlint" },
        yaml = { "yamllint" },
        markdown = { "markdownlint" },
      }
      vim.keymap.set("n", "<leader>ll", function()
        require("lint").try_lint()
      end, { desc = "Run linter" })
    end,
  },
}
