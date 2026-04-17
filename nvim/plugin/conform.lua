vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.keymap.set(
  "n",
  "<leader>Tf",
  function() vim.b.disable_autoformat = not vim.b.disable_autoformat end,
  { desc = "Toggle format on save (Buffer)", silent = true }
)

vim.keymap.set(
  "n",
  "<leader>TF",
  function() vim.g.disable_autoformat = not vim.g.disable_autoformat end,
  { desc = "Toggle format on save (Global)", silent = true }
)

vim.keymap.set("n", "<leader>ff", function() require("conform").format({ async = true }) end, { desc = "Format file" })

require("conform").setup({
  formatters_by_ft = {
    tex = { "tex-fmt", "latexindent" },
    lua = { "stylua", stop_after_first = false },
    -- python = { "isort", "black", stop_after_first = false },
    -- python = { "ruff_fix", "ruff_format", "ruff_organize_imports", stop_after_first = false },
    python = { "ruff_format" },
    rust = { lsp_format = "prefer" },
    markdown = { "prettier", "deno_fmt" },
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
      prepend_args = { "--indent-type", "Spaces", "--indent-width", "2", "--collapse-simple-statement", "Always" },
    },
    biome = {
      append_args = { "--indent-style", "space" },
    },
    ruff_format = {
      -- append_args = { "--enable-unstable-feature", "hug_parens_with_braces_and_square_brackets" },
      append_args = { "--preview" },
    },
    prettier = {
      append_args = function(_, ctx)
        if vim.bo[ctx.buf].filetype == "markdown" then
          return {
            "--prose-wrap=always",
            -- "--tab-width=4",
          }
        end

        return {
          "--object-wrap=collapse",
          "--arrow-parens=avoid",
        }
      end,
      options = {
        ext_parsers = {
          urdf = "xml",
          xacro = "xml",
        },
      },
    },
  },
  format_on_save = function(bufnr)
    if not vim.g.disable_autoformat and not vim.b[bufnr].disable_autoformat then return {} end
  end,
  default_format_opts = {
    timeout_ms = 500,
    lsp_format = "fallback",
    stop_after_first = true,
    -- undojoin = true,
  },
})
