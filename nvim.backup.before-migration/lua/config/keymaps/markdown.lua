---@desc Markdown and documentation keymaps

-- Render markdown keymaps
local render_markdown_ok, render_markdown = pcall(require, "render-markdown")
if render_markdown_ok then
  vim.keymap.set("n", "<leader>mr", function()
    render_markdown.toggle()
  end, { desc = "Toggle render markdown" })

  vim.keymap.set("n", "<leader>me", function()
    render_markdown.enable()
  end, { desc = "Enable render markdown" })

  vim.keymap.set("n", "<leader>md", function()
    render_markdown.disable()
  end, { desc = "Disable render markdown" })
end

-- Markdown preview keymaps
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle markdown preview" })
vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreview<cr>", { desc = "Start markdown preview" })
vim.keymap.set("n", "<leader>mq", "<cmd>MarkdownPreviewStop<cr>", { desc = "Stop markdown preview" })
