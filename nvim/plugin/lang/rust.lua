vim.pack.add({
  "https://github.com/Saecki/crates.nvim",
  { src = "https://github.com/mrcjkb/rustaceanvim", version = "v9.0.2" },
})

require("crates").setup({
  completion = {
    crates = { enabled = true },
  },
  lsp = {
    enabled = true,
    actions = true,
    completion = true,
    hover = true,
  },
})
