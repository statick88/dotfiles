---@desc OpenCode AI assistant keymaps

local opencode = pcall(require, "opencode")
if opencode then
  opencode = require("opencode")

  -- Ask OpenCode with current context
  vim.keymap.set({ "n", "x" }, "<leader>oa", function()
    opencode.ask("@this: ", { submit = true })
  end, { desc = "OpenCode: Ask" })

  -- Select OpenCode action from menu
  vim.keymap.set({ "n", "x" }, "<leader>os", function()
    opencode.select()
  end, { desc = "OpenCode: Select action" })

  -- Add range to OpenCode prompt (operator)
  vim.keymap.set({ "n", "x" }, "<leader>or", function()
    return opencode.operator("@this ")
  end, { desc = "OpenCode: Add range", expr = true })

  -- Toggle OpenCode session window
  vim.keymap.set({ "n", "t" }, "<leader>ot", function()
    opencode.toggle()
  end, { desc = "OpenCode: Toggle session" })

  -- Add current line to OpenCode prompt
  -- Uses operator mode with "_" to target the current line specifically
  vim.keymap.set("n", "<leader>ol", function()
    return opencode.operator("@this ") .. "_"
  end, { desc = "OpenCode: Add line", expr = true })

  -- Navigation controls for OpenCode session
  vim.keymap.set("n", "<leader>ou", function()
    opencode.command("session.half.page.up")
  end, { desc = "OpenCode: Scroll up" })

  vim.keymap.set("n", "<leader>oj", function()
    opencode.command("session.half.page.down")
  end, { desc = "OpenCode: Scroll down" })
end

-- Alternative shortcuts for OpenCode (shorter keys, currently commented)
-- vim.keymap.set({ "n", "x" }, "<C-a>", function()
--   require("opencode").ask("@this: ", { submit = true })
-- end, { desc = "Ask opencode…" })
--
-- vim.keymap.set({ "n", "x" }, "<C-x>", function()
--   require("opencode").select()
-- end, { desc = "Execute opencode action…" })
--
-- vim.keymap.set({ "n", "t" }, "<C-.>", function()
--   require("opencode").toggle()
-- end, { desc = "Toggle opencode" })
