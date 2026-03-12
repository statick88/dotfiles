---@desc AI Assistant (OpenCode) keymaps

-- Toggle OpenCode
vim.keymap.set("n", "<leader>aa", function()
  require("opencode").toggle()
end, { desc = "Toggle OpenCode" })

-- Ask with context
vim.keymap.set({ "n", "x" }, "<leader>ai", function()
  require("opencode").ask("", { submit = true })
end, { desc = "OpenCode ask" })
vim.keymap.set({ "n", "x" }, "<leader>aI", function()
  require("opencode").ask("@this: ", { submit = true })
end, { desc = "OpenCode ask with context" })
vim.keymap.set({ "n", "x" }, "<leader>ab", function()
  require("opencode").ask("@file ", { submit = true })
end, { desc = "OpenCode ask about buffer" })

-- Select and send
vim.keymap.set({ "n", "x" }, "<leader>as", function()
  require("opencode").select({ submit = true })
end, { desc = "OpenCode select" })

-- Quick prompts
vim.keymap.set({ "n", "x" }, "<leader>ape", function()
  require("opencode").prompt("explain", { submit = true })
end, { desc = "OpenCode explain" })
vim.keymap.set({ "n", "x" }, "<leader>apf", function()
  require("opencode").prompt("fix", { submit = true })
end, { desc = "OpenCode fix" })
vim.keymap.set({ "n", "x" }, "<leader>apd", function()
  require("opencode").prompt("diagnose", { submit = true })
end, { desc = "OpenCode diagnose" })
vim.keymap.set({ "n", "x" }, "<leader>apr", function()
  require("opencode").prompt("review", { submit = true })
end, { desc = "OpenCode review" })
vim.keymap.set({ "n", "x" }, "<leader>apt", function()
  require("opencode").prompt("test", { submit = true })
end, { desc = "OpenCode test" })
vim.keymap.set({ "n", "x" }, "<leader>apo", function()
  require("opencode").prompt("optimize", { submit = true })
end, { desc = "OpenCode optimize" })
vim.keymap.set({ "n", "x" }, "<leader>apc", function()
  require("opencode").prompt("complexity", { submit = true })
end, { desc = "OpenCode complexity" })
vim.keymap.set({ "n", "x" }, "<leader>aps", function()
  require("opencode").prompt("security", { submit = true })
end, { desc = "OpenCode security" })

-- Custom prompts
vim.keymap.set({ "n", "x" }, "<leader>apD", function()
  local prompt = vim.fn.input("Custom prompt: ")
  if prompt ~= "" then
    require("opencode").prompt(prompt, { submit = true })
  end
end, { desc = "OpenCode custom prompt" })

-- Buffer-specific actions
vim.keymap.set("n", "<leader>ar", function()
  require("opencode").prompt("refactor", { submit = true })
end, { desc = "OpenCode refactor" })
vim.keymap.set("n", "<leader>ad", function()
  require("opencode").prompt("document", { submit = true })
end, { desc = "OpenCode document" })

-- Quick chat
vim.keymap.set("n", "<leader>ac", function()
  require("opencode").chat()
end, { desc = "OpenCode chat" })
