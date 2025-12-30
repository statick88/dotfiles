vim.g.mapleader = " "
local keymap = vim.keymap

-- Salir del modo insertar rápido
keymap.set("i", "jj", "<ESC>")

-- Manejo de archivos y ventanas
keymap.set("n", "<leader>e", ":Neotree toggle<CR>") -- Abrir explorador
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>") -- Buscar archivos
keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>") -- Buscar texto

