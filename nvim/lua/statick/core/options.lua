local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.termguicolors = true
opt.background = "dark"
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.wrap = true         -- Activa el ajuste de texto
opt.linebreak = true    -- No corta palabras a la mitad al ajustar
opt.breakindent = true  -- Mantiene la sangría en las líneas ajustadas

-- Optimizaciones adicionales
opt.signcolumn = "yes"  -- Mostrar siempre la columna de signos
opt.updatetime = 250    -- Tiempo de actualización más rápido
opt.timeoutlen = 300    -- Tiempo para mapeos con secuencias
opt.completeopt = { "menu", "menuone", "noselect" }
opt.clipboard = "unnamedplus"  -- Usar clipboard del sistema
opt.scrolloff = 8      -- Mantener líneas visibles al scroll
opt.sidescrolloff = 8  -- Mantener columnas visibles al scroll
opt.splitbelow = true   -- Split horizontales abajo
opt.splitright = true   -- Split verticales a la derecha
opt.mouse = "a"        -- Habilitar ratón
opt.conceallevel = 0    -- Mostrar todos los caracteres
opt.showmode = false    -- Ya lo muestra el tema
