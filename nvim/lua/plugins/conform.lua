return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>tf",
      function()
        vim.b.disable_autoformat = not vim.b.disable_autoformat
      end,
      mode = "n",
      desc = "Toggle format on save (Buffer)",
    },
    {
      "<leader>tF",
      function()
        vim.b.disable_autoformat = not vim.b.disable_autoformat
      end,
      mode = "n",
      desc = "Toggle format on save (Global)",
    },
  },
  opts = {
    formatters_by_ft = {
      tex = { "tex-fmt", "latexindent", stop_after_first = true },
      lua = { "stylua" },
      -- python = { "isort", "black" },
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
      rust = { lsp_format = "prefer" },
      markdown = { "deno_fmt" },
      javascript = { "biome", "prettier", stop_after_first = true },
      typescript = { "biome", "prettier", stop_after_first = true },
      javascriptreact = { "biome", "prettier", stop_after_first = true },
      typescriptreact = { "biome", "prettier", stop_after_first = true },
      json = { "biome", "prettier", stop_after_first = true },
      html = { "biome", "prettier", stop_after_first = true },
      yaml = { "biome", "prettier", stop_after_first = true },
      css = { "biome", "prettier", stop_after_first = true },
      scss = { "biome", "prettier", stop_after_first = true },
    },
    formatters = {
      stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      },
      biome = {
        append_args = { "--indent-style", "space" },
      },
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      return {
        timeout_ms = 500,
        lsp_format = "fallback",
        -- undojoin = true,
      }
    end,
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable format-on-save",
      bang = true,
    })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Enable format-on-save",
    })
  end,
}
