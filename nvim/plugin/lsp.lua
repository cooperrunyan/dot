vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "lua_ls",
    "taplo",
    "yamlls",
    "jsonls",
    "marksman",
    "cmake",
    "cssls",
    "bashls",
    "glsl_analyzer",
    "dockerls",
    "html",
    "pyright",
    "ruff",
    "lemminx",
    "texlab",
    "ts_ls",
    "denols",
    {
      "clangd",
      condition = function()
        local sys = vim.loop.os_uname()
        return sys.machine ~= "aarch64" or sys.sysname == "Darwin"
      end,
    },

    "cpptools",
    "codelldb",
    "tectonic",
    "stylua",
    "shellcheck",
    "mypy",

    "clang-format",
    "shfmt",
    "black",
    "tex-fmt",
    "prettier",

    "tree-sitter-cli",
  },
})
