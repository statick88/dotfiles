-- Keymaps Init - Diego Saavedra
-- Loads all keymap modules

local keymap_modules = {
  "core",
  "lsp",
  "git",
  "debugging",
  "testing",
  "ai",
  "security",
}

for _, module in ipairs(keymap_modules) do
  local ok, err = pcall(require, "config.keymaps." .. module)
  if not ok then
    vim.notify(
      string.format("Failed to load keymaps/%s: %s", module, err),
      vim.log.levels.WARN
    )
  end
end
