-- [TOOLS] Plugins Git & Docker: Integración completa de control de versiones en Neovim
-- Gitsigns: Muestra cambios en el gutter
-- Lazygit: Interfaz TUI para Git
-- Diffview: Visualización de diffs mejorada
-- Git-conflict: Resolver conflictos Git
-- Blamer: Git blame inline
-- Dockerfile: Syntax highlighting para Docker
return {
  -- Gitsigns - Indicadores visuales de cambios en el gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end
        map("n", "]c", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Next Git hunk" })
        map("n", "[c", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Previous Git hunk" })
        map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
      end,
    },
  },

  -- Lazygit - Interfaz TUI para Git
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },

  -- Diffview - Visualización de diffs mejorada
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
  },

  -- Git-conflict - Resolver conflictos Git
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "BufReadPost",
    opts = {
      default_mappings = false,
      disable_diagnostics = true,
    },
  },

  -- Dockerfile.vim - Syntax highlighting para Docker
  {
    "ekalinin/Dockerfile.vim",
    ft = { "Dockerfile", "docker-compose.yml", "docker-compose.yaml" },
  },
}
