-- Project-specific Copilot Chat prompts configuration
-- These prompts are tailored for your project needs

local M = {}

-- Base prompts configuration
M.prompts = {
  -- Standard prompts (included by default in CopilotChat)
  Explain = {
    prompt = "/COPILOT_EXPLAIN\n\nWriting an explanation for the selected code as if I were a senior developer reviewing a junior dev's work. Assume the selected code is part of a larger project and provide context that would help understand how it fits in.",
    description = "Explain selected code",
  },
  Review = {
    prompt = "/COPILOT_REVIEW\n\nReview the selected code and provide feedback on potential improvements, bugs, or best practices that should be considered. Be thorough but constructive.",
    description = "Review selected code",
  },
  Fix = {
    prompt = "/COPILOT_FIX\n\nThere is a problem in the selected code. Analyze the code, identify the issue, and provide a corrected version that fixes the problem.",
    description = "Fix selected code",
  },
  Optimize = {
    prompt = "/COPILOT_REFACTOR\n\nRefactor the selected code to improve its performance, readability, and maintainability while preserving its functionality.",
    description = "Optimize selected code",
  },
  Docs = {
    prompt = "/COPILOT_GENERATE\n\nGenerate comprehensive documentation for the selected code including purpose, parameters, return values, and usage examples.",
    description = "Generate documentation",
  },
  Tests = {
    prompt = "/COPILOT_TESTS\n\nGenerate comprehensive unit tests for the selected code, covering edge cases and expected behavior.",
    description = "Generate tests",
  },

  -- Project-specific prompts for LazyVim/Neovim configuration
  LazyVimPlugin = {
    prompt = "/COPILOT_EXPLAIN\n\nThis is a LazyVim plugin specification in Lua. Analyze this plugin configuration and explain:\n1. What plugin is being loaded and its purpose\n2. The lazy loading strategy (event, cmd, keys, etc.)\n3. Key dependencies and how they're managed\n4. Any notable configuration options\n5. Best practices for this type of plugin",
    description = "Explain LazyVim plugin",
  },

  PerformanceAudit = {
    prompt = "/COPILOT_REVIEW\n\nPerform a performance audit on the selected code:\n1. Identify any performance bottlenecks\n2. Check for unnecessary allocations or iterations\n3. Look for async/await or lazy loading opportunities\n4. Suggest specific optimizations with code examples\n5. Estimate the performance improvement for each suggestion",
    description = "Performance audit",
  },

  SecurityReview = {
    prompt = "/COPILOT_REVIEW\n\nConduct a security review of the selected code:\n1. Identify potential security vulnerabilities\n2. Check for unsafe patterns or anti-patterns\n3. Verify proper input validation\n4. Look for credential/secret exposure risks\n5. Suggest hardening measures with examples",
    description = "Security review",
  },

  BugAnalysis = {
    prompt = "/COPILOT_FIX\n\nAnalyze the selected code for potential bugs:\n1. Identify edge cases that might cause failures\n2. Check for null/undefined reference errors\n3. Look for off-by-one errors or boundary conditions\n4. Find race conditions or timing issues\n5. Provide fixes with explanations",
    description = "Bug analysis",
  },

  Refactor = {
    prompt = "/COPILOT_REFACTOR\n\nRefactor the selected code for better maintainability:\n1. Simplify complex logic\n2. Extract reusable functions or components\n3. Improve naming for clarity\n4. Remove duplication\n5. Add appropriate error handling",
    description = "Refactor for maintainability",
  },

  TypeScript = {
    prompt = "/COPILOT_EXPLAIN\n\nAnalyze this TypeScript/Lua code:\n1. Verify type correctness\n2. Suggest better type annotations\n3. Check for any type-related issues\n4. Recommend strict typing improvements\n5. Provide refactored version with proper types",
    description = "TypeScript/Type analysis",
  },
}

-- Register project-specific keybindings if CopilotChat is available
function M.setup()
  local ok, copilot_chat = pcall(require, "CopilotChat")
  if not ok then
    return
  end

  -- Note: Additional keybinds can be added here if needed
  -- These would typically be project-specific shortcuts
end

return M
