-- Copilot Chat LSP Diagnostics Integration
-- This module integrates Copilot Chat with LSP diagnostics for context-aware suggestions

local M = {}

-- Check if there are LSP diagnostics and create a context-aware prompt
function M.create_diagnostic_context()
  local diagnostics = vim.diagnostic.get(0)
  if not diagnostics or #diagnostics == 0 then
    return ""
  end

  local context = "\n\nContext from LSP diagnostics:\n"
  for i, diag in ipairs(diagnostics) do
    if i > 5 then
      context = context .. "\n(and " .. (#diagnostics - 5) .. " more diagnostics...)"
      break
    end

    local severity = vim.diagnostic.severity[diag.severity] or "UNKNOWN"
    context = context .. string.format("\n- Line %d: [%s] %s", diag.lnum + 1, severity, diag.message)
  end

  return context
end

-- Fix diagnostics using Copilot Chat
function M.fix_diagnostics()
  local copilot_chat = require("CopilotChat")
  local diagnostic_context = M.create_diagnostic_context()

  if diagnostic_context == "" then
    vim.notify("No diagnostics to fix", vim.log.levels.INFO)
    return
  end

  local prompt = "/COPILOT_FIX\n\nFix the diagnostics shown in the context. Provide specific fixes for each issue."
    .. diagnostic_context

  copilot_chat.ask(prompt, {
    window = {
      layout = "float",
      width = 0.8,
      height = 0.8,
    },
  })
end

-- Review code with LSP context
function M.review_with_context()
  local copilot_chat = require("CopilotChat")
  local diagnostic_context = M.create_diagnostic_context()

  local prompt =
    "/COPILOT_REVIEW\n\nReview the selected code considering the LSP diagnostics provided in the context. Focus on code quality, best practices, and the issues flagged by LSP."

  if diagnostic_context ~= "" then
    prompt = prompt .. diagnostic_context
  end

  copilot_chat.ask(prompt, {
    window = {
      layout = "float",
      width = 0.8,
      height = 0.8,
    },
  })
end

-- Setup function to add these commands
function M.setup()
  local copilot_chat_ok, copilot_chat = pcall(require, "CopilotChat")
  if not copilot_chat_ok then
    vim.notify("CopilotChat not available yet", vim.log.levels.DEBUG)
    return
  end

  if not copilot_chat or not copilot_chat.ask then
    vim.notify("CopilotChat incomplete, skipping integration", vim.log.levels.WARN)
    return
  end

  -- Add custom commands
  vim.api.nvim_create_user_command("CopilotChatFixDiagnostics", function()
    M.fix_diagnostics()
  end, { desc = "Fix LSP diagnostics with Copilot Chat" })

  vim.api.nvim_create_user_command("CopilotChatReviewWithContext", function()
    M.review_with_context()
  end, { desc = "Review code with LSP context" })

  -- Optional: Add keybindings
  local wk_ok, wk = pcall(require, "which-key")
  if wk_ok then
    wk.add({
      {
        "<leader>cld",
        "<cmd>CopilotChatFixDiagnostics<cr>",
        desc = "Fix diagnostics with Copilot",
        mode = { "n", "v" },
      },
      {
        "<leader>clr",
        "<cmd>CopilotChatReviewWithContext<cr>",
        desc = "Review with LSP context",
        mode = { "n", "v" },
      },
    })
  end
end

return M
