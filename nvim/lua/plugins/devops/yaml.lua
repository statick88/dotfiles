-- YAML/DevOps - Diego Saavedra
-- Kubernetes (ocasional), GitHub Actions, Ansible

return {
  {
    "someone-stole-my-name/yaml-companion.nvim",
    ft = "yaml",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      builtin_matchers = {
        kubernetes = { enabled = true },
        cloud_init = { enabled = true },
      },
      schemas = {
        {
          name = "GitHub Action",
          uri = "https://json.schemastore.org/github-action.json",
        },
        {
          name = "GitHub Workflow",
          uri = "https://json.schemastore.org/github-workflow.json",
        },
        {
          name = "Docker Compose",
          uri = "https://json.schemastore.org/docker-compose.json",
        },
      },
    },
    config = function(_, opts)
      require("telescope").load_extension("yaml_schema")
      local cfg = require("yaml-companion").setup(opts)
      require("lspconfig")["yamlls"].setup(cfg)
    end,
  },
}
