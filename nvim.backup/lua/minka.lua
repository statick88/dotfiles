-- Minka Neovim Integration
-- GitHub Copilot MCP Tools for Cybersecurity

local M = {}

M.config = {
  use_docker = true,
  docker_container = "minka-mcp-server",
  cwd = "/Users/statick/Minka",
  keybindings = {
    normal = {
      ["<leader>me"] = "Search expert",
      ["<leader>mc"] = "Get case study",
      ["<leader>mq"] = "Get quote",
      ["<leader>mn"] = "Generate narrative",
      ["<leader>mv"] = "Search vulnerability",
      ["<leader>mu"] = "UCM module",
      ["<leader>ma"] = "AI security paper",
      ["<leader>ml"] = "Clean architecture",
      ["<leader>mm"] = "MITRE ATT&CK technique",
    },
    visual = {
      ["<leader>me"] = "Search expert (visual)",
      ["<leader>mn"] = "Generate narrative (visual)",
    },
  },
}

function M.setup(opts)
  opts = opts or {}
  M.config = vim.tbl_deep_extend("force", M.config, opts)

  -- Create commands
  vim.api.nvim_create_user_command("MinkaExperts", function(args)
    M.search_experts(args.args)
  end, { nargs = "*", complete = "file" })

  vim.api.nvim_create_user_command("MinkaCase", function(args)
    M.get_case(args.args)
  end, { nargs = "*", complete = "file" })

  vim.api.nvim_create_user_command("MinkaQuote", function(args)
    M.get_quote(args.args)
  end, { nargs = "?" })

  vim.api.nvim_create_user_command("MinkaNarrative", function(args)
    M.generate_narrative(args.args)
  end, { nargs = "*" })

  vim.api.nvim_create_user_command("MinkaVuln", function(args)
    M.search_vuln(args.args)
  end, { nargs = "*" })

  vim.api.nvim_create_user_command("MinkaUCM", function(args)
    M.get_ucm_module(args.args)
  end, { nargs = "*" })

  vim.api.nvim_create_user_command("MinkaAISecurity", function(args)
    M.search_ai_security(args.args)
  end, { nargs = "*" })

  vim.api.nvim_create_user_command("MinkaCleanArch", function(args)
    M.get_clean_arch(args.args)
  end, { nargs = "*" })

  vim.api.nvim_create_user_command("MinkaMitre", function(args)
    M.get_mitre(args.args)
  end, { nargs = "*" })

  -- Set keybindings
  M.set_keybindings()

  print("Minka loaded! Use :Minka* commands or <leader>m* keybindings")
end

function M.set_keybindings()
  local prefix = "<leader>m"

  vim.keymap.set("n", prefix .. "e", ":MinkaExperts ", { silent = false, desc = "Search expert" })
  vim.keymap.set("n", prefix .. "c", ":MinkaCase ", { silent = false, desc = "Get case study" })
  vim.keymap.set("n", prefix .. "q", ":MinkaQuote<CR>", { silent = false, desc = "Get quote" })
  vim.keymap.set("n", prefix .. "n", ":MinkaNarrative ", { silent = false, desc = "Generate narrative" })
  vim.keymap.set("n", prefix .. "v", ":MinkaVuln ", { silent = false, desc = "Search vulnerability" })
  vim.keymap.set("n", prefix .. "u", ":MinkaUCM ", { silent = false, desc = "UCM module" })
  vim.keymap.set("n", prefix .. "a", ":MinkaAISecurity ", { silent = false, desc = "AI security paper" })
  vim.keymap.set("n", prefix .. "l", ":MinkaCleanArch ", { silent = false, desc = "Clean architecture" })
  vim.keymap.set("n", prefix .. "mm", ":MinkaMitre ", { silent = false, desc = "MITRE ATT&CK technique" })
end

-- Tool functions (call MCP server via API or subprocess)
function M.search_experts(query)
  if query == "" then
    query = vim.fn.input("Search expert: ")
  end
  local result = M.call_mcp("minka-experts", { query = query, format = "brief" })
  M.show_result("Expert", result)
end

function M.get_case(case_name)
  if case_name == "" then
    case_name = vim.fn.input("Case name: ")
  end
  local result = M.call_mcp("minka-cases", { case = case_name })
  M.show_result("Case Study", result)
end

function M.get_quote(type)
  type = type or "mitnick"
  local result = M.call_mcp("minka-quote", { type = type })
  M.show_result("Quote", result)
end

function M.generate_narrative(concept)
  if concept == "" then
    concept = vim.fn.input("Concept: ")
  end
  local result = M.call_mcp("minka-narrative", { concept = concept, audience = "intermediate", format = "mixed" })
  M.show_result("Narrative", result)
end

function M.search_vuln(cve)
  if cve == "" then
    cve = vim.fn.input("CVE/vulnerability: ")
  end
  local result = M.call_mcp("minka-vuln", { cve = cve })
  M.show_result("Vulnerability", result)
end

function M.get_ucm_module(module)
  if module == "" then
    module = vim.fn.input("UCM module: ")
  end
  local result = M.call_mcp("minka-ucm", { module = module })
  M.show_result("UCM Module", result)
end

function M.search_ai_security(query)
  if query == "" then
    query = vim.fn.input("Search AI security: ")
  end
  local result = M.call_mcp("minka-ai-security", { query = query })
  M.show_result("AI Security", result)
end

function M.get_clean_arch(topic)
  if topic == "" then
    topic = vim.fn.input("Topic: ")
  end
  local result = M.call_mcp("minka-cleanarch", { topic = topic })
  M.show_result("Clean Architecture", result)
end

function M.get_mitre(technique)
  if technique == "" then
    technique = vim.fn.input("MITRE technique: ")
  end
  local result = M.call_mcp("minka-mitre", { technique = technique, format = "brief" })
  M.show_result("MITRE ATT&CK", result)
end

function M.call_mcp(tool_name, args)
  local container = M.config.docker_container

  if M.config.use_docker then
    local tool_func = M.get_function(tool_name)
    local module = M.get_module(tool_name)
    local query_arg = args.query or args.case or args.module or args.topic or args.concept or ""

    local cmd = string.format(
      "docker exec %s python -c 'import asyncio; from %s import %s; asyncio.run(%s(\"%s\"))' 2>/dev/null || echo 'Error: MCP server not running. Run: docker-compose up -d'",
      container,
      module,
      tool_func,
      tool_func,
      query_arg
    )

    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()

    return result:gsub("%s+$", "")
  else
    local cmd = string.format(
      "cd %s && source venv/bin/activate && python -m mcp_server.tools.%s %s 2>/dev/null || echo 'Error calling MCP'",
      M.config.cwd,
      M.get_module(tool_name),
      args.query or args.case or args.module or args.topic or args.concept or ""
    )

    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()

    return result:gsub("%s+$", "")
  end
end

function M.get_module(tool_name)
  local modules = {
    ["minka-experts"] = "experts",
    ["minka-cases"] = "cases",
    ["minka-quote"] = "quotes",
    ["minka-narrative"] = "narrative",
    ["minka-vuln"] = "vulnerabilities",
    ["minka-ucm"] = "ucm_curriculum",
    ["minka-ai-security"] = "ai_security",
    ["minka-cleanarch"] = "clean_architecture",
    ["minka-mitre"] = "mitre_attack",
  }
  return modules[tool_name] or "tools"
end

function M.get_function(tool_name)
  local functions = {
    ["minka-experts"] = "search_experts",
    ["minka-cases"] = "get_case_study",
    ["minka-quote"] = "get_quote",
    ["minka-narrative"] = "generate_narrative",
    ["minka-vuln"] = "get_cve_info",
    ["minka-ucm"] = "get_ucm_module",
    ["minka-ai-security"] = "search_ai_security",
    ["minka-cleanarch"] = "get_clean_arch_info",
    ["minka-mitre"] = "get_mitre_technique",
  }
  return functions[tool_name] or "search"
end

function M.show_result(title, content)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(content, "\n"))
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = math.min(80, vim.o.columns - 10),
    height = math.min(20, vim.o.lines - 10),
    row = 5,
    col = 5,
    style = "minimal",
    border = "rounded",
    title = " " .. title .. " ",
    title_pos = "center",
  })

  vim.api.nvim_create_autocmd("BufWipeout", {
    buffer = buf,
    callback = function()
      pcall(vim.api.nvim_win_close, 0, true)
    end,
  })
end

return M
