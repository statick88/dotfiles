---@desc Telescope fuzzy finder keymaps

local function telescope(keymap, func_name, desc)
  vim.keymap.set("n", keymap, function()
    local ok, telescope = pcall(require, "telescope.builtin")
    if ok and telescope[func_name] then
      telescope[func_name]()
    else
      vim.notify("Telescope not loaded", vim.log.levels.ERROR)
    end
  end, { desc = desc })
end

telescope("<leader>ff", "find_files", "Find files")
telescope("<leader>fg", "live_grep", "Live grep")
telescope("<leader>fb", "buffers", "Find buffers")
telescope("<leader>fh", "help_tags", "Help tags")
telescope("<leader>fc", "commands", "Find commands")
telescope("<leader>fr", "oldfiles", "Recent files")
telescope("<leader>fd", "diagnostics", "Diagnostics")
telescope("<leader>fs", "lsp_document_symbols", "LSP document symbols")
telescope("<leader>fS", "lsp_workspace_symbols", "LSP workspace symbols")
