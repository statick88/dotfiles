-- Utils: Abstracciones comunes para la configuración de Neovim

local M = {}

-- Configura keymaps para un tipo de archivo específico
function M.ft_keymaps(ft, keymaps)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    callback = function()
      for lhs, rhs in pairs(keymaps) do
        local mode = rhs.mode or "n"
        local opts = rhs.opts or {}
        opts.buffer = true
        if opts.silent == nil then
          opts.silent = true
        end
        vim.keymap.set(mode, lhs, rhs.rhs, opts)
      end
    end,
  })
end

-- Configura keymaps múltiples para varios tipos de archivo
function M.ft_keymaps_multiple(ft_list, keymaps)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft_list,
    callback = function()
      for lhs, rhs in pairs(keymaps) do
        local mode = rhs.mode or "n"
        local opts = rhs.opts or {}
        opts.buffer = true
        if opts.silent == nil then
          opts.silent = true
        end
        vim.keymap.set(mode, lhs, rhs.rhs, opts)
      end
    end,
  })
end

-- Configura keymaps en evento User específico
function M.user_event_keymaps(event_name, keymaps)
  vim.api.nvim_create_autocmd("User", {
    pattern = event_name,
    callback = function()
      for lhs, rhs in pairs(keymaps) do
        local mode = rhs.mode or "n"
        local opts = rhs.opts or {}
        if opts.silent == nil then
          opts.silent = true
        end
        vim.keymap.set(mode, lhs, rhs.rhs, opts)
      end
    end,
  })
end

-- Carga configuración estándar de plugin
function M.plugin_setup(plugin_name, opts)
  if opts == nil then
    opts = {}
  end
  pcall(function()
    require(plugin_name).setup(opts)
  end)
end

-- Muestra notificación informativa
function M.notify(message, level)
  level = level or vim.log.levels.INFO
  vim.notify(message, level, {
    title = "Neovim Config",
    icon = "⚙️",
    timeout = 3000,
  })
end

-- Muestra notificación de éxito
function M.notify_success(message)
  M.notify(message, vim.log.levels.INFO)
end

-- Muestra notificación de error
function M.notify_error(message)
  M.notify(message, vim.log.levels.ERROR)
end

-- Muestra notificación de advertencia
function M.notify_warn(message)
  M.notify(message, vim.log.levels.WARN)
end

return M
