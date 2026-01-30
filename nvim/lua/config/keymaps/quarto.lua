---@desc Quarto and literate programming keymaps

-- Quarto keymaps - Execute code, render documents, etc.
local quarto_ok, quarto = pcall(require, "quarto")
if quarto_ok then
  -- Preview/Render document Quarto
  vim.keymap.set("n", "<leader>qp", function()
    quarto.quartoPreview()
  end, { desc = "Quarto: Preview document" })

  -- Run code cell
  vim.keymap.set("n", "<leader>qc", function()
    quarto.runCodeCell()
  end, { desc = "Quarto: Run code cell" })

  -- Run all code cells
  vim.keymap.set("n", "<leader>qa", function()
    quarto.runAll()
  end, { desc = "Quarto: Run all code cells" })
end

-- Otter keymaps - Support for multiple languages in Quarto files
local otter_ok, otter = pcall(require, "otter")
if otter_ok then
  -- Enable Otter for enhanced language support
  vim.keymap.set("n", "<leader>oo", function()
    otter.enable()
  end, { desc = "Otter: Enable language support" })

  -- Disable Otter
  vim.keymap.set("n", "<leader>od", function()
    otter.disable()
  end, { desc = "Otter: Disable language support" })

  -- Go to definition in embedded code
  vim.keymap.set("n", "<leader>og", function()
    otter.ask_hover()
  end, { desc = "Otter: Ask hover" })
end
