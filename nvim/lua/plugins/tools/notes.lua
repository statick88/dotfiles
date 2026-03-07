-- Notes & Documentation - Diego Saavedra
-- Obsidian para notas, Markdown Preview para cursos/eBooks

return {
  -- Obsidian
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "notes",
          path = "~/Documents/notes",
        },
      },
      completion = {
        nvim_cmp = false,
        min_chars = 2,
      },
      mappings = {
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },
      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },
      new_notes_location = "current_dir",
      wiki_link_func = function(opts)
        if opts.label then
          return string.format("[[%s|%s]]", opts.path, opts.label)
        else
          return string.format("[[%s]]", opts.path)
        end
      end,
      markdown_link_func = function(opts)
        return string.format("[%s](%s)", opts.label, opts.path)
      end,
      preferred_link_style = "wiki",
      disable_frontmatter = false,
      ui = {
        enable = true,
        update_debounce = 200,
        checkboxes = {
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        hl_groups = {
          ObsidianTodo = { bold = true, fg = "#f78c6c" },
          ObsidianDone = { bold = true, fg = "#89ddff" },
          ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
          ObsidianTilde = { bold = true, fg = "#ff5370" },
          ObsidianRefText = { underline = true, fg = "#82aaff" },
          ObsidianExtLinkIcon = { fg = "#82aaff" },
          ObsidianTag = { italic = true, fg = "#ffcb6b" },
          ObsidianHighlightText = { bg = "#6600ff" },
        },
      },
    },
    keys = {
      { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New Obsidian note" },
      { "<leader>oo", "<cmd>ObsidianSearch<cr>", desc = "Search Obsidian notes" },
      { "<leader>os", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch Obsidian" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Obsidian backlinks" },
      { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Obsidian today" },
      { "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Obsidian yesterday" },
      { "<leader>oT", "<cmd>ObsidianTomorrow<cr>", desc = "Obsidian tomorrow" },
    },
  },

  -- Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown", "quarto" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
    },
  },
}
