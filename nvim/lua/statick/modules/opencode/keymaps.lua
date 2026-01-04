-- OpenCode.nvim: Keymaps del Arquitecto Asistente
local M = {}

function M.get_keymaps()
  return {
    { "<leader>acr", function() require("opencode").clean_architecture_review() end, desc = "Clean Architecture Review" },
    { "<leader>sca", function() require("opencode").separation_concerns_analysis() end, desc = "Separation of Concerns Analysis" },
    { "<leader>cd", function() require("opencode").domain_independence_check() end, desc = "Domain Independence Check" },
    { "<leader>ci", function() require("opencode").dependency_inversion_audit() end, desc = "Dependency Inversion Audit" },

    { "<leader>spl", function() require("opencode").solid_principles_check() end, desc = "SOLID Principles Check" },
    { "<leader>ssr", function() require("opencode").single_responsibility() end, desc = "Single Responsibility Analysis" },
    { "<leader>soc", function() require("opencode").open_closed_check() end, desc = "Open/Closed Principle" },
    { "<leader>sli", function() require("opencode").liskov_check() end, desc = "Liskov Substitution" },
    { "<leader>sii", function() require("opencode").interface_segregation() end, desc = "Interface Segregation" },
    { "<leader>sdi", function() require("opencode").dependency_inversion() end, desc = "Dependency Inversion" },

    { "<leader>pf", function() require("opencode").suggest_pattern("factory") end, desc = "Suggest Factory Pattern" },
    { "<leader>pr", function() require("opencode").suggest_pattern("repository") end, desc = "Suggest Repository Pattern" },
    { "<leader>po", function() require("opencode").suggest_pattern("observer") end, desc = "Suggest Observer Pattern" },
    { "<leader>pst", function() require("opencode").suggest_pattern("strategy") end, desc = "Suggest Strategy Pattern" },
    { "<leader>pa", function() require("opencode").suggest_pattern("adapter") end, desc = "Suggest Adapter Pattern" },

    { "<leader>tb", function() require("opencode").behavior_test_setup() end, desc = "Setup Behavior Tests" },
    { "<leader>tc", function() require("opencode").contract_test_generate() end, desc = "Generate Contract Tests" },
    { "<leader>tu", function() require("opencode").use_case_testing() end, desc = "Use Case Testing" },
    { "<leader>tcov", function() require("opencode").test_coverage_analysis() end, desc = "Test Coverage Analysis" },

    { "<leader>ad", function() require("opencode").statick_architectural_decision() end, desc = "👤 Statick Architectural Decision" },
    { "<leader>al", function() require("opencode").log_statick_decision() end, desc = "Log Architectural Decision" },
    { "<leader>ar", function() require("opencode").review_past_decisions() end, desc = "Review Past Decisions" },

    { "<leader>as", function() require("opencode").ask_sisyphus_options() end, desc = "Ask 🤖 Sisyphus for options" },
    { "<leader>ao", function() require("opencode").ask_oracle_advice() end, desc = "Ask 🤖 Oracle for advice" },
    { "<leader>alb", function() require("opencode").ask_librarian_guidance() end, desc = "Ask 🤖 Librarian for guidance" },
    { "<leader>af", function() require("opencode").ask_frontend_consultation() end, desc = "Ask 🤖 Frontend for consultation" },

    { "<leader>qc", function() require("opencode").refactor_to_clean_code() end, desc = "Refactor to Clean Code" },
    { "<leader>qn", function() require("opencode").improve_descriptive_names() end, desc = "Improve Descriptive Names" },
    { "<leader>qm", function() require("opencode").make_immutable() end, desc = "Make Code Immutable" },

    { "<leader>td", function() require("opencode").template_with_statick_approval("technical") end, desc = "Technical Docs (awaiting 👤 Statick approval)" },
    { "<leader>tp", function() require("opencode").template_with_statick_approval("presentation") end, desc = "Presentation (awaiting 👤 Statick approval)" },
    { "<leader>te", function() require("opencode").template_with_statick_approval("educational") end, desc = "Educational (awaiting 👤 Statick approval)" },

    { "<leader>osb", function() require("opencode").open_statick_sidebar() end, desc = "Open 🤖↔👤 Statick Sidebar" },
    { "<leader>oh", function() require("opencode").show_decision_history() end, desc = "Show 👤 Statick Decision History" },
    { "<leader>cqs", function() require("opencode").request_code_quality_scan() end, desc = "Request Code Quality Scan" }
  }
end

return M
