---@desc Core navigation and window management keymaps

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window resizing
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Buffer navigation
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bD", "<cmd>bdelete!<cr>", { desc = "Delete buffer (force)" })

-- Tab navigation
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Only tab" })
vim.keymap.set("n", "[t", "<cmd>tabprevious<cr>", { desc = "Prev tab" })
vim.keymap.set("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Better paste (no yank)
vim.keymap.set("v", "p", '"_dP', { desc = "Paste without yank" })

-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>noh<cr><Esc>", { desc = "Clear search highlight" })

-- Better search and substitute
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search (centered)" })
vim.keymap.set("n", "*", "*zzzv", { desc = "Search word under cursor (centered)" })
vim.keymap.set("n", "#", "#zzzv", { desc = "Search word under cursor backward (centered)" })

-- Quick fix and location list
vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { desc = "Prev quickfix" })
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
vim.keymap.set("n", "[Q", "<cmd>cfirst<cr>", { desc = "First quickfix" })
vim.keymap.set("n", "]Q", "<cmd>clast<cr>", { desc = "Last quickfix" })
vim.keymap.set("n", "[l", "<cmd>lprev<cr>", { desc = "Prev loclist" })
vim.keymap.set("n", "]l", "<cmd>lnext<cr>", { desc = "Next loclist" })

-- Quick save and quit
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save all files" })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all" })
vim.keymap.set("n", "<leader>x", "<cmd>x<cr>", { desc = "Save and quit" })

-- Terminal
vim.keymap.set("n", "<C-\\>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
vim.keymap.set("t", "<C-\\>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Source current file
vim.keymap.set("n", "<leader>xs", "<cmd>source %<cr>", { desc = "Source current file" })

-- Better undo breakpoints
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")
