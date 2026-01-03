vim.g.mapleader = " "
local keymap = vim.keymap

-- Salir del modo insertar rápido
keymap.set("i", "jj", "<ESC>")

-- LSP - Language Server Protocol
keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- Explorador de archivos (Neo-tree)
keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })

-- Telescope - Búsqueda
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help tags" })

-- Flash - Navegación rápida
keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
keymap.set({ "n", "o", "x" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })

-- Trouble - Lista de diagnósticos
keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ... (Trouble)" })

 -- OpenCode - Clean Architecture (plugin desactivado temporalmente)
-- Nota: Usa lazy.nvim para cargar estos plugins solo cuando se usen

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

-- Python Development (lazy loading)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "Select Virtual Env", buffer = true })
    keymap.set("n", "<leader>nd", function() require("neogen").generate() end, { desc = "Generate docstring", buffer = true })
  end,
})

-- Testing (lazy loading)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "javascript", "typescript", "ruby", "go", "rust", "lua" },
  callback = function()
    keymap.set("n", "<leader>tn", "<cmd>TestNearest<cr>", { desc = "Test nearest", buffer = true })
    keymap.set("n", "<leader>tf", "<cmd>TestFile<cr>", { desc = "Test file", buffer = true })
    keymap.set("n", "<leader>ts", "<cmd>TestSuite<cr>", { desc = "Test suite", buffer = true })
    keymap.set("n", "<leader>tv", "<cmd>TestVisit<cr>", { desc = "Test visit", buffer = true })
    keymap.set("n", "<leader>tg", "<cmd>TestGo<cr>", { desc = "Test go", buffer = true })
  end,
})

-- Excalidraw - Diagramas en Markdown (lazy loading)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "quarto" },
  callback = function()
    keymap.set("n", "<leader>ed", "<cmd>Excalidraw open<cr>", { desc = "Open Excalidraw link", buffer = true })
    keymap.set("n", "<leader>ec", "<cmd>Excalidraw create<cr>", { desc = "Create Excalidraw scene", buffer = true })
    keymap.set("n", "<leader>et", "<cmd>Excalidraw create_from_template<cr>", { desc = "Create from template", buffer = true })
    keymap.set("n", "<leader>ef", "<cmd>Excalidraw find_scenes<cr>", { desc = "Find saved scenes", buffer = true })
    keymap.set("n", "<leader>el", "<cmd>Excalidraw find_scenes_in_buffer<cr>", { desc = "List buffer links", buffer = true })
  end,
})

 -- nvim-cmp (autocompletado) - configurado en completions.lua
