-- Minka plugin configuration for lazy.nvim
return {
  "statick88/minka",
  ft = { "python", "lua", "markdown", "yaml" },
  keys = {
    { "<leader>me", ":MinkaExperts ", silent = false, desc = "Search expert" },
    { "<leader>mc", ":MinkaCase ", silent = false, desc = "Get case study" },
    { "<leader>mq", ":MinkaQuote<CR>", silent = false, desc = "Get quote" },
    { "<leader>mn", ":MinkaNarrative ", silent = false, desc = "Generate narrative" },
    { "<leader>mv", ":MinkaVuln ", silent = false, desc = "Search vulnerability" },
    { "<leader>mu", ":MinkaUCM ", silent = false, desc = "UCM module" },
    { "<leader>ma", ":MinkaAISecurity ", silent = false, desc = "AI security paper" },
    { "<leader>ml", ":MinkaCleanArch ", silent = false, desc = "Clean architecture" },
  },
  config = function()
    require("minka").setup({
      cwd = "/Users/statick/Minka",
    })
  end,
}
