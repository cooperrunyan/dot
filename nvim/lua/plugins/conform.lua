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
    {
      "<leader>ff",
      function()
        require("conform").format({ async = true })
      end,
      mode = "n",
      desc = "Format file",
    },
  },
  opts = {
    log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
      tex = { "tex-fmt", "latexindent" },
      lua = { "stylua", stop_after_first = false },
      -- python = { "isort", "black", stop_after_first = false },
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports", stop_after_first = false },
      rust = { lsp_format = "prefer" },
      markdown = { "deno_fmt" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      html = { "prettier" },
      yaml = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      c = { "clang-format" },
      cpp = { "clang-format" },
    },
    formatters = {
      stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      },
      biome = {
        append_args = { "--indent-style", "space" },
      },
      prettier = {
        options = {
          ext_parsers = {
            urdf = "xml",
            xacro = "xml",
          },
        },
      },
    },
    format_on_save = function(bufnr)
      if not vim.g.disable_autoformat and not vim.b[bufnr].disable_autoformat then
        return {}
      end
    end,
    default_format_opts = {
      timeout_ms = 500,
      lsp_format = "fallback",
      stop_after_first = true,
      -- undojoin = true,
    },
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
