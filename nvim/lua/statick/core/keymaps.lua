vim.g.mapleader = " "
local keymap = vim.keymap
local utils = require("statick.utils")

-- Salir del modo insertar rápido
keymap.set("i", "jj", "<ESC>")

-- LSP - Language Server Protocol (globales)
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

-- Git - lazygit y diffview
keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
keymap.set("n", "<leader>gv", "<cmd>DiffviewOpen<cr>", { desc = "Open diff view" })
keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "Close diff view" })
keymap.set("n", "<leader>gf", "<cmd>DiffviewToggleFile<cr>", { desc = "Toggle diff view file" })
keymap.set("n", "<leader>gk", "<cmd>DiffviewFocusFiles<cr>", { desc = "Focus diff files" })

-- Git-conflict keymaps
utils.user_event_keymaps("GitConflict", {
  ["<leader>gco"] = { rhs = "<cmd>GitConflictChooseOurs<cr>", desc = "Choose ours" },
  ["<leader>gct"] = { rhs = "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose theirs" },
  ["<leader>gcb"] = { rhs = "<cmd>GitConflictChooseBoth<cr>", desc = "Choose both" },
  ["<leader>gc0"] = { rhs = "<cmd>GitConflictChooseNone<cr>", desc = "Choose none" },
})

-- Quarto keymaps (quarto, markdown)
utils.ft_keymaps_multiple({ "quarto", "markdown" }, {
  ["]b"] = { rhs = [[<cmd>lua require("quarto.navigator").next()<cr>]], desc = "Next Quarto cell" },
  ["[b"] = { rhs = [[<cmd>lua require("quarto.navigator").previous()<cr>]], desc = "Previous Quarto cell" },
})

utils.ft_keymaps_multiple({ "quarto", "markdown" }, {
  ["<localleader>rc"] = { rhs = function() return require("quarto.runner").run_cell end, desc = "Run current cell" },
  ["<localleader>ra"] = { rhs = function() return require("quarto.runner").run_above end, desc = "Run cell and above" },
  ["<localleader>rA"] = { rhs = function() return require("quarto.runner").run_all end, desc = "Run all cells" },
  ["<localleader>rl"] = { rhs = function() return require("quarto.runner").run_line end, desc = "Run current line" },
  ["<localleader>pp"] = { rhs = "<cmd>QuartoPreview<cr>", desc = "Quarto preview" },
  ["<localleader>ps"] = { rhs = "<cmd>QuartoPreviewStop<cr>", desc = "Stop Quarto preview" },
  ["<localleader>qi"] = { rhs = "<cmd>QuartoInspect<cr>", desc = "Inspect Quarto document" },
  ["<localleader>qf"] = { rhs = "<cmd>QuartoFormat<cr>", desc = "Format Quarto document" },
})

-- Flutter Development keymaps
utils.ft_keymaps_multiple({ "dart", "flutter" }, {
  ["<leader>F"] = { rhs = "<cmd>FlutterRun<cr>", desc = "Run Flutter app" },
  ["<leader>D"] = { rhs = "<cmd>FlutterDevices<cr>", desc = "List Flutter devices" },
  ["<leader>Q"] = { rhs = "<cmd>FlutterQuit<cr>", desc = "Quit Flutter app" },
  ["<leader>R"] = { rhs = "<cmd>FlutterHotReload<cr>", desc = "Hot reload" },
  ["<leader>H"] = { rhs = "<cmd>FlutterHotRestart<cr>", desc = "Hot restart" },
})

-- Android ADB WiFi Connection keymaps
-- Reemplaza 192.168.1.100 con la IP de tu dispositivo
keymap.set("n", "<leader>aw", function()
  local ip = vim.fn.input("Enter device IP: ", "192.168.1.100")
  if ip ~= "" then
    vim.fn.system("adb connect " .. ip .. ":5555")
    print("Conectando a " .. ip .. "...")
    vim.defer_fn(function()
      vim.fn.system("adb devices")
    end, 2000)
  end
end, { desc = "Connect Android device via WiFi" })

keymap.set("n", "<leader>ad", function()
  vim.fn.system("adb devices")
end, { desc = "List ADB devices" })

keymap.set("n", "<leader>af", function()
  vim.fn.system("cd /Users/statick/apps/proyectos/task/devstack_tasks && flutter run -d 192.168.1.100:5555")
end, { desc = "Run Flutter on WiFi device" })

keymap.set("n", "<leader>ar", function()
  vim.fn.system("adb reconnect 192.168.1.100:5555")
  print("Reconectando dispositivo...")
end, { desc = "Reconnect ADB device" })

keymap.set("n", "<leader>aq", function()
  vim.fn.system("adb disconnect 192.168.1.100:5555")
  print("Desconectando dispositivo...")
end, { desc = "Disconnect ADB device" })

-- Python Development keymaps
utils.ft_keymaps("python", {
  ["<leader>vs"] = { rhs = "<cmd>VenvSelect<cr>", desc = "Select Virtual Env" },
  ["<leader>nd"] = { rhs = function() require("neogen").generate() end, desc = "Generate docstring" },
})

-- Testing keymaps
utils.ft_keymaps_multiple({ "python", "javascript", "typescript", "ruby", "go", "rust", "lua" }, {
  ["<leader>tn"] = { rhs = "<cmd>TestNearest<cr>", desc = "Test nearest" },
  ["<leader>tf"] = { rhs = "<cmd>TestFile<cr>", desc = "Test file" },
  ["<leader>ts"] = { rhs = "<cmd>TestSuite<cr>", desc = "Test suite" },
  ["<leader>tv"] = { rhs = "<cmd>TestVisit<cr>", desc = "Test visit" },
  ["<leader>tg"] = { rhs = "<cmd>TestGo<cr>", desc = "Test go" },
})

-- Excalidraw keymaps (markdown, quarto)
utils.ft_keymaps_multiple({ "markdown", "quarto" }, {
  ["<leader>ed"] = { rhs = "<cmd>Excalidraw open<cr>", desc = "Open Excalidraw link" },
  ["<leader>ec"] = { rhs = "<cmd>Excalidraw create<cr>", desc = "Create Excalidraw scene" },
  ["<leader>et"] = { rhs = "<cmd>Excalidraw create_from_template<cr>", desc = "Create from template" },
  ["<leader>ef"] = { rhs = "<cmd>Excalidraw find_scenes<cr>", desc = "Find saved scenes" },
  ["<leader>el"] = { rhs = "<cmd>Excalidraw find_scenes_in_buffer<cr>", desc = "List buffer links" },
})

-- nvim-cmp (autocompletado) - configurado en completions.lua
