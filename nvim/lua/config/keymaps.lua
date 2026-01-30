-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Initialize Copilot Chat LSP integration
local lsp_integration_ok, lsp_integration = pcall(require, "config.copilot-lsp-integration")
if lsp_integration_ok then
  lsp_integration.setup()
end

-- OpenCode.nvim keymaps for AI assistant integration
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

  -- Toggle OpenCode session
  vim.keymap.set({ "n", "t" }, "<leader>ot", function()
    opencode.toggle()
  end, { desc = "OpenCode: Toggle" })

  -- Add range to OpenCode prompt (operator)
  vim.keymap.set({ "n", "x" }, "<leader>or", function()
    return opencode.operator("@this ")
  end, { desc = "OpenCode: Add range", expr = true })

  -- Add current line to OpenCode prompt
  -- Uses operator mode with "_" to target the current line specifically
  vim.keymap.set("n", "<leader>ol", function()
    return opencode.operator("@this ") .. "_"
  end, { desc = "OpenCode: Add line", expr = true })

  -- Quick prompts for common actions
  -- These provide one-key access to frequently used AI commands
  vim.keymap.set("n", "<leader>oe", function()
    opencode.prompt("explain")  -- Asks AI to explain selected code
  end, { desc = "OpenCode: Explain code" })

  vim.keymap.set("n", "<leader>of", function()
    opencode.prompt("fix")  -- Asks AI to fix diagnostic errors
  end, { desc = "OpenCode: Fix diagnostics" })

  vim.keymap.set("n", "<leader>ov", function()
    opencode.prompt("review")
  end, { desc = "OpenCode: Review code" })

  vim.keymap.set("n", "<leader>od", function()
    opencode.prompt("document")
  end, { desc = "OpenCode: Add documentation" })

  vim.keymap.set("n", "<leader>op", function()
    opencode.prompt("test")
  end, { desc = "OpenCode: Add tests" })

  -- Navigation controls for OpenCode session
  vim.keymap.set("n", "<leader>ou", function()
    opencode.command("session.half.page.up")
  end, { desc = "OpenCode: Scroll up" })

  vim.keymap.set("n", "<leader>oj", function()
    opencode.command("session.half.page.down")
  end, { desc = "OpenCode: Scroll down" })
end

-- Telescope keymaps
local telescope_ok, telescope = pcall(require, "telescope.builtin")
if telescope_ok then
  vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Find files" })
  vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Live grep" })
  vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Find buffers" })
  vim.keymap.set("n", "<leader>fh", telescope.help_tags, { desc = "Help tags" })
  vim.keymap.set("n", "<leader>fc", telescope.commands, { desc = "Find commands" })
end

-- Flash keymaps
local flash_ok, flash = pcall(require, "flash")
if flash_ok then
  vim.keymap.set({ "n", "x", "o" }, "s", function()
    flash.jump()
  end, { desc = "Flash" })

  vim.keymap.set({ "n", "x", "o" }, "S", function()
    flash.treesitter()
  end, { desc = "Flash Treesitter" })
end

-- LSP keymaps - avoid conflicts by using leader prefixes
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, { desc = "Hover documentation" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Smart splits keymaps
local smart_splits_ok, smart_splits = pcall(require, "smart-splits")
if smart_splits_ok then
  vim.keymap.set("n", "<C-h>", smart_splits.move_cursor_left)
  vim.keymap.set("n", "<C-j>", smart_splits.move_cursor_down)
  vim.keymap.set("n", "<C-k>", smart_splits.move_cursor_up)
  vim.keymap.set("n", "<C-l>", smart_splits.move_cursor_right)
  vim.keymap.set("n", "<C-left>", smart_splits.resize_left)
  vim.keymap.set("n", "<C-down>", smart_splits.resize_down)
  vim.keymap.set("n", "<C-up>", smart_splits.resize_up)
  vim.keymap.set("n", "<C-right>", smart_splits.resize_right)
end

-- Testing keymaps
local neotest_ok, neotest = pcall(require, "neotest")
if neotest_ok then
  vim.keymap.set("n", "<leader>tt", function() 
    neotest.run.run(vim.fn.expand("%")) 
  end, { desc = "Run file tests" })
  
  vim.keymap.set("n", "<leader>tn", function() 
    neotest.run.run() 
  end, { desc = "Run nearest test" })
  
  vim.keymap.set("n", "<leader>ts", function() 
    neotest.summary.toggle() 
  end, { desc = "Toggle test summary" })
  
  vim.keymap.set("n", "<leader>to", function() 
    neotest.output.open({ enter = true }) 
  end, { desc = "Show test output" })
end

-- Git keymaps
vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Git status" })
vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "Git commit" })
vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Git push" })
vim.keymap.set("n", "<leader>gl", "<cmd>Git pull<cr>", { desc = "Git pull" })

-- Gitsigns keymaps
local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
if gitsigns_ok then
  vim.keymap.set("n", "]c", gitsigns.next_hunk, { desc = "Next git hunk" })
  vim.keymap.set("n", "[c", gitsigns.prev_hunk, { desc = "Previous git hunk" })
  vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
  vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
  vim.keymap.set("v", "<leader>hs", function() 
    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) 
  end, { desc = "Stage hunk" })
  vim.keymap.set("v", "<leader>hr", function() 
    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) 
  end, { desc = "Reset hunk" })
  vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
  vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
  vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
  vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
  vim.keymap.set("n", "<leader>hb", function() 
    gitsigns.blame_line({ full = true }) 
  end, { desc = "Blame line" })
  vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this" })
  vim.keymap.set("n", "<leader>hD", function() 
    gitsigns.diffthis("~") 
  end, { desc = "Diff against last commit" })
end

-- Persistence keymaps
local persistence_ok, persistence = pcall(require, "persistence")
if persistence_ok then
  vim.keymap.set("n", "<leader>qs", function()
    persistence.load()
  end, { desc = "Restore Session" })

  vim.keymap.set("n", "<leader>ql", function()
    persistence.load({ last = true })
  end, { desc = "Restore Last Session" })

  vim.keymap.set("n", "<leader>qd", function()
    persistence.stop()
  end, { desc = "Don't Save Current Session" })
end

-- Debugging keymaps
local dap_ok, dap = pcall(require, "dap")
if dap_ok then
  vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
  vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
  vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
  vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
  vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
  vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
  vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last" })
end

-- Format keymaps
local conform_ok, conform = pcall(require, "conform")
if conform_ok then
  vim.keymap.set("", "<leader>fm", function()
    conform.format({ async = true, lsp_fallback = true })
  end, { desc = "Format buffer" })
end

-- Toggleterm keymaps
vim.keymap.set("n", "<c-\\>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })

-- Alternative shortcuts for OpenCode (shorter keys)
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
