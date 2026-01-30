-- Quarto keymaps - Ejecutar código, renderizar documentos, etc.
-- Keymaps are automatically loaded on the VeryLazy event

local quarto_ok, quarto = pcall(require, "quarto")
if quarto_ok then
  -- Renderizar documento Quarto
  vim.keymap.set("n", "<leader>qr", function()
    quarto.quartoPreview()
  end, { desc = "Quarto: Render document" })

  -- Ejecutar chunk actual
  vim.keymap.set("n", "<leader>qc", function()
    quarto.runCodeCell()
  end, { desc = "Quarto: Run code cell" })

  -- Ejecutar todos los chunks
  vim.keymap.set("n", "<leader>qa", function()
    quarto.runAll()
  end, { desc = "Quarto: Run all code cells" })
end

-- Otter keymaps - Soporte de múltiples lenguajes en archivos Quarto
local otter_ok, otter = pcall(require, "otter")
if otter_ok then
  -- Activar soporte de Otter para edición mejorada
  vim.keymap.set("n", "<leader>oo", function()
    otter.enable()
  end, { desc = "Otter: Enable language support" })

  -- Desactivar Otter
  vim.keymap.set("n", "<leader>od", function()
    otter.disable()
  end, { desc = "Otter: Disable language support" })

  -- Ir a definición en código embebido
  vim.keymap.set("n", "<leader>og", function()
    otter.ask_hover()
  end, { desc = "Otter: Ask hover" })
end
