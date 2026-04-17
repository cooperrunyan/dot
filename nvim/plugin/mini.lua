vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.nvim", version = "stable" },
})

require("mini.move").setup()
require("mini.pairs").setup()
require("mini.ai").setup({
  mappings = {
    around_next = "",
    inside_next = "",
    around_last = "",
    inside_last = "",
  },
})
