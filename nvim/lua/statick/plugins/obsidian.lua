-- [DOC] Obsidian.nvim: Integración completa con Obsidian para gestión de notas
-- Compatible con Obsidian app y standalone
-- Funcionalidades: notas diarias, búsqueda, plantillas, links, backlinks, etc.
return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    event = {
      "BufReadPre ~/Documents/notes/**/*.md",
      "BufNewFile ~/Documents/notes/**/*.md",
      "BufReadPre ~/Documents/vault/**/*.md",
      "BufNewFile ~/Documents/vault/**/*.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      dir = "~/Documents/notes",
      daily_notes = {
        folder = "daily",
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
        default_tags = { "daily" },
        template = nil,
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      new_notes_location = "notes_subdir",
      note_id_func = function(title)
        local suffix = ""
        if title ~= nil then
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,
      note_path_func = function(spec)
        local path = spec.dir / tostring(spec.id)
        return path:with_suffix(".md")
      end,
      wiki_link_func = function(opts)
        return require("obsidian.util").wiki_link_id_prefix(opts)
      end,
      markdown_link_func = function(opts)
        return require("obsidian.util").markdown_link(opts)
      end,
      preferred_link_style = "wiki",
      disable_frontmatter = false,
      note_frontmatter_func = function(note)
        if note.title then
          note:add_alias(note.title)
        end
        local out = { id = note.id, aliases = note.aliases, tags = note.tags }
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        substitutions = {},
      },
      follow_url_func = function(url)
        vim.fn.jobstart({ "open", url })
      end,
      follow_img_func = function(img)
        vim.fn.jobstart({ "qlmanage", "-p", img })
      end,
      use_advanced_uri = false,
      open_app_foreground = false,
      picker = {
        name = "telescope.nvim",
        note_mappings = {
          new = "<C-x>",
          insert_link = "<C-l>",
        },
        tag_mappings = {
          tag_note = "<C-x>",
          insert_tag = "<C-l>",
        },
      },
      sort_by = "modified",
      sort_reversed = true,
      search_max_lines = 1000,
      open_notes_in = "current",
      callbacks = {
        post_setup = function(client) end,
        enter_note = function(client, note) end,
        leave_note = function(client, note) end,
        pre_write_note = function(client, note) end,
        post_set_workspace = function(client, workspace) end,
      },
      ui = {
        enable = true,
        update_debounce = 200,
        max_file_length = 5000,
        checkboxes = {
          [" "] = { char = "", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianInProgress" },
          ["~"] = { char = "", hl_group = "ObsidianTilde" },
          ["!"] = { char = "", hl_group = "ObsidianImportant" },
          ["-"] = { char = "", hl_group = "ObsidianHyphen" },
          ["?"] = { char = "", hl_group = "ObsidianQuestion" },
        },
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        hl_groups = {
          ObsidianTodo = { fg = "#f78c6c" },
          ObsidianDone = { fg = "#89ddff" },
          ObsidianInProgress = { fg = "#e0af68" },
          ObsidianTilde = { fg = "#7dcfff" },
          ObsidianImportant = { fg = "#ff9e64" },
          ObsidianHyphen = { fg = "#9ece6a" },
          ObsidianBullet = { fg = "#7dcfff" },
          ObsidianRefText = { fg = "#c099ff" },
          ObsidianHighlightText = { bg = "#75662a" },
          ObsidianTag = { fg = "#9ece6a", bold = true },
          ObsidianExtLinkIcon = { fg = "#c099ff" },
        },
      },
      attachments = {
        img_folder = "assets/imgs",
        confirm_img_paste = false,
      },
    },
    keys = {
      { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New Obsidian note" },
      { "<leader>oo", "<cmd>ObsidianSearch<cr>", desc = "Search Obsidian notes" },
      { "<leader>os", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch Obsidian notes" },
      { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Today's note" },
      { "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Yesterday's note" },
      { "<leader>om", "<cmd>ObsidianTomorrow<cr>", desc = "Tomorrow's note" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks" },
      { "<leader>ol", "<cmd>ObsidianLinks<cr>", desc = "Links in current note" },
      { "<leader>oc", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
      { "<leader>oi", "<cmd>ObsidianPasteImg<cr>", desc = "Paste image" },
      { "<leader>ota", "<cmd>ObsidianTOC<cr>", desc = "Table of contents" },
      { "<leader>otp", "<cmd>ObsidianTemplate<cr>", desc = "Insert template" },
    },
  },
}
