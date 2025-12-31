vim.g.mapleader = " "
local keymap = vim.keymap

-- Salir del modo insertar rápido
keymap.set("i", "jj", "<ESC>")

-- Explorador de archivos (Neo-tree)
keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })

-- Telescope - Búsqueda
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help tags" })

-- OpenCode - Clean Architecture (plugin desactivado temporalmente)
-- keymap.set("n", "<leader>ca", function() require("opencode").clean_architecture_review() end, { desc = "Clean Architecture Review" })
-- keymap.set("n", "<leader>cs", function() require("opencode").separation_concerns_analysis() end, { desc = "Separation of Concerns Analysis" })
-- keymap.set("n", "<leader>cd", function() require("opencode").domain_independence_check() end, { desc = "Domain Independence Check" })
-- keymap.set("n", "<leader>ci", function() require("opencode").dependency_inversion_audit() end, { desc = "Dependency Inversion Audit" })

-- OpenCode - SOLID Principles (plugin desactivado temporalmente)
-- keymap.set("n", "<leader>spl", function() require("opencode").solid_principles_check() end, { desc = "SOLID Principles Check" })
-- keymap.set("n", "<leader>ssr", function() require("opencode").single_responsibility() end, { desc = "Single Responsibility Analysis" })
-- keymap.set("n", "<leader>soc", function() require("opencode").open_closed_check() end, { desc = "Open/Closed Principle" })
-- keymap.set("n", "<leader>sli", function() require("opencode").liskov_check() end, { desc = "Liskov Substitution" })
-- keymap.set("n", "<leader>sii", function() require("opencode").interface_segregation() end, { desc = "Interface Segregation" })
-- keymap.set("n", "<leader>sdi", function() require("opencode").dependency_inversion() end, { desc = "Dependency Inversion" })

-- OpenCode - Design Patterns (plugin desactivado temporalmente)
-- keymap.set("n", "<leader>pf", function() require("opencode").suggest_pattern("factory") end, { desc = "Suggest Factory Pattern" })
-- keymap.set("n", "<leader>pr", function() require("opencode").suggest_pattern("repository") end, { desc = "Suggest Repository Pattern" })
-- keymap.set("n", "<leader>po", function() require("opencode").suggest_pattern("observer") end, { desc = "Suggest Observer Pattern" })
-- keymap.set("n", "<leader>pst", function() require("opencode").suggest_pattern("strategy") end, { desc = "Suggest Strategy Pattern" })
-- keymap.set("n", "<leader>pa", function() require("opencode").suggest_pattern("adapter") end, { desc = "Suggest Adapter Pattern" })

-- OpenCode - Testing (plugin desactivado temporalmente)
-- keymap.set("n", "<leader>tb", function() require("opencode").behavior_test_setup() end, { desc = "Setup Behavior Tests" })
-- keymap.set("n", "<leader>tc", function() require("opencode").contract_test_generate() end, { desc = "Generate Contract Tests" })
-- keymap.set("n", "<leader>tu", function() require("opencode").use_case_testing() end, { desc = "Use Case Testing" })
-- keymap.set("n", "<leader>tcov", function() require("opencode").test_coverage_analysis() end, { desc = "Test Coverage Analysis" })

-- OpenCode - Architectural Decisions (plugin desactivado temporalmente)
-- keymap.set("n", "<leader>ad", function() require("opencode").statick_architectural_decision() end, { desc = "👤 Statick Architectural Decision" })
-- keymap.set("n", "<leader>al", function() require("opencode").log_statick_decision() end, { desc = "Log Architectural Decision" })
-- keymap.set("n", "<leader>ar", function() require("opencode").review_past_decisions() end, { desc = "Review Past Decisions" })

-- OpenCode - AI Agents (plugin desactivado temporalmente)
-- keymap.set("n", "<leader>as", function() require("opencode").ask_sisyphus_options() end, { desc = "Ask 🤖 Sisyphus for options" })
-- keymap.set("n", "<leader>ao", function() require("opencode").ask_oracle_advice() end, { desc = "Ask 🤖 Oracle for advice" })
-- keymap.set("n", "<leader>alb", function() require("opencode").ask_librarian_guidance() end, { desc = "Ask 🤖 Librarian for guidance" })
-- keymap.set("n", "<leader>af", function() require("opencode").ask_frontend_consultation() end, { desc = "Ask 🤖 Frontend for consultation" })

-- OpenCode - Code Quality (plugin desactivado temporalmente)
-- keymap.set("n", "<leader>qc", function() require("opencode").refactor_to_clean_code() end, { desc = "Refactor to Clean Code" })
-- keymap.set("n", "<leader>qn", function() require("opencode").improve_descriptive_names() end, { desc = "Improve Descriptive Names" })
-- keymap.set("n", "<leader>qm", function() require("opencode").make_immutable() end, { desc = "Make Code Immutable" })

-- OpenCode - Templates (plugin desactivado temporalmente)
-- keymap.set("n", "<leader>td", function() require("opencode").template_with_statick_approval("technical") end, { desc = "Technical Docs (awaiting 👤 Statick approval)" })
-- keymap.set("n", "<leader>tp", function() require("opencode").template_with_statick_approval("presentation") end, { desc = "Presentation (awaiting 👤 Statick approval)" })
-- keymap.set("n", "<leader>te", function() require("opencode").template_with_statick_approval("educational") end, { desc = "Educational (awaiting 👤 Statick approval)" })

-- OpenCode - UI (plugin desactivado temporalmente)
-- keymap.set("n", "<leader>osb", function() require("opencode").open_statick_sidebar() end, { desc = "Open 🤖↔👤 Statick Sidebar" })
-- keymap.set("n", "<leader>oh", function() require("opencode").show_decision_history() end, { desc = "Show 👤 Statick Decision History" })
-- keymap.set("n", "<leader>oc", function() require("opencode").request_code_quality_scan() end, { desc = "Request Code Quality Scan" })

-- Quarto - Navegación entre celdas (lazy loading)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "quarto", "markdown" },
  callback = function()
    if pcall(require, "quarto.navigator") then
      vim.keymap.set("n", "]b", [[<cmd>lua require("quarto.navigator").next()<cr>]], { desc = "Next Quarto cell", silent = true, buffer = true })
      vim.keymap.set("n", "[b", [[<cmd>lua require("quarto.navigator").previous()<cr>]], { desc = "Previous Quarto cell", silent = true, buffer = true })
    end
    if pcall(require, "quarto.runner") then
      local runner = require("quarto.runner")
      vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "Run current cell", silent = true, buffer = true })
      vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "Run cell and above", silent = true, buffer = true })
      vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "Run all cells", silent = true, buffer = true })
      vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "Run current line", silent = true, buffer = true })
      vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "Run visual range", silent = true, buffer = true })
      vim.keymap.set("n", "<localleader>RA", function() runner.run_all(true) end, { desc = "Run all cells of all languages", silent = true, buffer = true })
      vim.keymap.set("n", "<localleader>pp", [[<cmd>QuartoPreview<cr>]], { desc = "Quarto preview", silent = true, buffer = true })
      vim.keymap.set("n", "<localleader>ps", [[<cmd>QuartoPreviewStop<cr>]], { desc = "Stop Quarto preview", silent = true, buffer = true })
      vim.keymap.set("n", "<localleader>qi", [[<cmd>QuartoInspect<cr>]], { desc = "Inspect Quarto document", silent = true, buffer = true })
      vim.keymap.set("n", "<localleader>qf", [[<cmd>QuartoFormat<cr>]], { desc = "Format Quarto document", silent = true, buffer = true })
    end
  end,
})

-- Tmux - Navegación
keymap.set("n", "<C-h>", [[<cmd>lua require("tmux").move_left()<cr>]], { silent = true })
keymap.set("n", "<C-j>", [[<cmd>lua require("tmux").move_bottom()<cr>]], { silent = true })
keymap.set("n", "<C-k>", [[<cmd>lua require("tmux").move_top()<cr>]], { silent = true })
keymap.set("n", "<C-l>", [[<cmd>lua require("tmux").move_right()<cr>]], { silent = true })

-- Tmux - Redimensionar
keymap.set("n", "<C-Left>", [[<cmd>lua require("tmux").resize_left()<cr>]], { silent = true })
keymap.set("n", "<C-Down>", [[<cmd>lua require("tmux").resize_bottom()<cr>]], { silent = true })
keymap.set("n", "<C-Up>", [[<cmd>lua require("tmux").resize_top()<cr>]], { silent = true })
keymap.set("n", "<C-Right>", [[<cmd>lua require("tmux").resize_right()<cr>]], { silent = true })

-- Git - Gitsigns (lazy loading)
vim.api.nvim_create_autocmd("User", {
  pattern = "GitsignsAttach",
  callback = function()
    vim.keymap.set("n", "]c", function() require("gitsigns").next_hunk() end, { desc = "Next Git hunk", silent = true })
    vim.keymap.set("n", "[c", function() require("gitsigns").prev_hunk() end, { desc = "Previous Git hunk", silent = true })
    vim.keymap.set("n", "<leader>hs", function() require("gitsigns").stage_hunk() end, { desc = "Stage hunk", silent = true })
    vim.keymap.set("n", "<leader>hr", function() require("gitsigns").reset_hunk() end, { desc = "Reset hunk", silent = true })
  end,
})

-- Git - lazygit
keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- Git - diffview
keymap.set("n", "<leader>gv", "<cmd>DiffviewOpen<cr>", { desc = "Open diff view" })
keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "Close diff view" })
keymap.set("n", "<leader>gf", "<cmd>DiffviewToggleFile<cr>", { desc = "Toggle diff view file" })
keymap.set("n", "<leader>gk", "<cmd>DiffviewFocusFiles<cr>", { desc = "Focus diff files" })

-- Git - conflicts (git-conflict.nvim)
vim.api.nvim_create_autocmd("User", {
  pattern = "GitConflict",
  callback = function()
    vim.keymap.set("n", "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", { desc = "Choose ours", silent = true })
    vim.keymap.set("n", "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", { desc = "Choose theirs", silent = true })
    vim.keymap.set("n", "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", { desc = "Choose both", silent = true })
    vim.keymap.set("n", "<leader>gc0", "<cmd>GitConflictChooseNone<cr>", { desc = "Choose none", silent = true })
  end,
})



-- Docker - nui-docker
keymap.set("n", "<leader>du", function() require("nui-docker").toggle() end, { desc = "Toggle Docker UI" })

-- Flutter Development (lazy loading)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "dart", "flutter" },
  callback = function()
    keymap.set("n", "<leader>F", "<cmd>FlutterRun<cr>", { desc = "Run Flutter app", buffer = true })
    keymap.set("n", "<leader>D", "<cmd>FlutterDevices<cr>", { desc = "List Flutter devices", buffer = true })
    keymap.set("n", "<leader>Q", "<cmd>FlutterQuit<cr>", { desc = "Quit Flutter app", buffer = true })
    keymap.set("n", "<leader>R", "<cmd>FlutterHotReload<cr>", { desc = "Hot reload", buffer = true })
    keymap.set("n", "<leader>H", "<cmd>FlutterHotRestart<cr>", { desc = "Hot restart", buffer = true })
  end,
})

-- Testing (lazy loading - ya configurado en testing.lua
-- vim-test y neotest tienen sus propios keymaps definidos en testing.lua

-- nvim-cmp (autocompletado) - configurado en completions.lua
