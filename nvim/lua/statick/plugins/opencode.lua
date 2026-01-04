-- [AI] OpenCode.nvim: Arquitecto Asistente para Statick siguiendo principios de Clean Architecture
-- Integración completa con filosofía Statick Programming
return {
  {
    "NickvanDyke/opencode.nvim",
    enabled = true,
    lazy = true,
    cmd = {
      "CleanArchitectureReview",
      "SeparationConcernsAnalysis",
      "DomainIndependenceCheck",
      "DependencyInversionAudit",
    },
    dependencies = {
      { "folke/snacks.nvim", opts = { input = { enabled = true } } },
      { "nvim-treesitter/nvim-treesitter" },
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-lua/plenary.nvim" }
    },
    config = function()
      local opencode_config = require("statick.modules.opencode.config")
      require("opencode").setup(opencode_config)
    end,
    keys = function()
      return require("statick.modules.opencode.keymaps").get_keymaps()
    end,
  }
}
