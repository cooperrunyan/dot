local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

treesitter.setup({
  highlight = {
    enable = true,
  },
  indent = { enable = true },
  autotag = { enable = true },
  ensure_installed = {
    "json",
    "javascript",
    "typescript",
    "tsx",
    "yaml",
    "html",
    "css",
    "markdown",
    "bash",
    "lua",
    "vim",
    "dockerfile",
    "gitignore",
    "rust",
    "toml",
    "ron",
    "diff",
    "git_config",
    "gitignore",
    "latex",
    "markdown_inline",
    "prisma",
    "regex",
    "scss",
    "sql",
    "ssh_config",
    "terraform",
    "toml",
  },
})
