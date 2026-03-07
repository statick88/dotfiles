---@desc Security (Semgrep, CodeQL) keymaps
--- Master en Ciberseguridad Defensiva y Ofensiva

-- Semgrep
vim.keymap.set("n", "<leader>ss", function()
  local file = vim.fn.expand("%:p")
  vim.cmd("!" .. vim.fn.exepath("semgrep") .. " --config=auto " .. file)
end, { desc = "Semgrep scan file" })

vim.keymap.set("n", "<leader>sS", function()
  local dir = vim.fn.getcwd()
  vim.cmd("!" .. vim.fn.exepath("semgrep") .. " --config=auto " .. dir)
end, { desc = "Semgrep scan project" })

vim.keymap.set("n", "<leader>si", function()
  local file = vim.fn.expand("%:p")
  vim.cmd("!" .. vim.fn.exepath("semgrep") .. " --config=auto --json " .. file .. " > /tmp/semgrep-results.json")
  vim.cmd("cfile /tmp/semgrep-results.json")
  vim.cmd("copen")
end, { desc = "Semgrep scan to quickfix" })

vim.keymap.set("v", "<leader>ss", function()
  vim.cmd("'<,'>!semgrep --config=auto --json")
end, { desc = "Semgrep scan selection" })

-- CodeQL (if installed)
vim.keymap.set("n", "<leader>sqc", function()
  local db = vim.fn.input("CodeQL database path: ", "", "dir")
  if db ~= "" then
    vim.cmd("!codeql database analyze " .. db .. " --format=csv --output=/tmp/codeql-results.csv")
    vim.cmd("tabnew /tmp/codeql-results.csv")
  end
end, { desc = "CodeQL analyze database" })

-- Security linting
vim.keymap.set("n", "<leader>sl", function()
  require("lint").try_lint("semgrep")
end, { desc = "Security lint (semgrep)" })

-- Quick security checks
vim.keymap.set("n", "<leader>sh", function()
  -- Check for hardcoded secrets
  vim.cmd("noautocmd vimgrep /\\(password\\|secret\\|api_key\\|token\\)\\s*=\\s*['\\\"][^'\\\"]+['\\\"]\\|AKIA[0-9A-Z]\\{16\\}\\|eyJ[A-Za-z0-9-_]*\\.eyJ[A-Za-z0-9-_]*\\.[A-Za-z0-9-_.+/]*/j %")
  vim.cmd("copen")
end, { desc = "Find hardcoded secrets" })

vim.keymap.set("n", "<leader>se", function()
  -- Check for environment exposures
  vim.cmd("noautocmd vimgrep /process\\.env\\./j %")
  vim.cmd("copen")
end, { desc = "Find env exposures" })

vim.keymap.set("n", "<leader>sq", function()
  -- Check for SQL injection patterns
  vim.cmd("noautocmd vimgrep /\\(execute\\|query\\).*\\+.*\\(\\+\\|f['\\\"]\\|%s\\)/j %")
  vim.cmd("copen")
end, { desc = "Find SQL injection risks" })

vim.keymap.set("n", "<leader>sx", function()
  -- Check for XSS patterns
  vim.cmd("noautocmd vimgrep /innerHTML\\|document\\.write\\|dangerouslySetInnerHTML/j %")
  vim.cmd("copen")
end, { desc = "Find XSS risks" })

-- Trivy (container security)
vim.keymap.set("n", "<leader>st", function()
  local image = vim.fn.input("Docker image: ")
  if image ~= "" then
    vim.cmd("!trivy image " .. image)
  end
end, { desc = "Trivy scan image" })

-- GitLeaks
vim.keymap.set("n", "<leader>sg", function()
  vim.cmd("!gitleaks detect --source=" .. vim.fn.getcwd() .. " --no-git")
end, { desc = "GitLeaks scan" })

-- Security report
vim.keymap.set("n", "<leader>sr", function()
  local buf = vim.api.nvim_create_buf(false, true)
  local lines = {
    "# Security Scan Report",
    "",
    "## File: " .. vim.fn.expand("%:p"),
    "",
    "Run the following for comprehensive scan:",
    "```bash",
    "# Semgrep",
    "semgrep --config=auto " .. vim.fn.expand("%:p"),
    "",
    "# GitLeaks",
    "gitleaks detect --source=" .. vim.fn.getcwd(),
    "",
    "# Bandit (Python)",
    "bandit -r " .. vim.fn.expand("%:p"),
    "```",
  }
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
  vim.api.nvim_win_set_buf(0, buf)
end, { desc = "Security report" })
