return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "json", "json5", "jsonc" } },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        markdown = { "deno_fmt" },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bufls = {},
        bashls = {},
        biome = {},
        cssls = {},
        denols = {},
        prismals = {},
        sqls = {},
        stylelint_lsp = {},

        tsserver = {
          settings = {
            completions = { completeFunctionCalls = false },
          },
          on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
          end,
        },
        lua_ls = {
          settings = {
            Lua = {
              codeLens = { enable = false },
              telemetry = { enable = false },
              semantic = { enable = false },
              workspace = { checkThirdParty = "Disable" },
              completion = {
                callSnippet = "Disable",
                keywordSnippet = "Disable",
                workspaceWord = false,
              },
            },
          },
        },
        taplo = {
          config_file = {
            enabled = true,
            path = vim.env.XDG_CONFIG_HOME .. "/taplo.toml",
          },
        },
      },
    },
  },
}
