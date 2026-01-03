-- excalidraw.nvim: Diagramas Excalidraw en archivos Markdown
-- Plugin para gestionar diagramas Excalidraw directamente desde Neovim
return {
  "marcocofano/excalidraw.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  ft = { "markdown", "quarto" },
  config = function()
    require("excalidraw").setup({
      storage_dir = "~/.excalidraw",
      templates_dir = "~/.excalidraw/templates",
      open_on_create = true,
      relative_path = true,
      picker = {
        link_scene_mapping = "<C-l>",
      },
    })
  end,
}
