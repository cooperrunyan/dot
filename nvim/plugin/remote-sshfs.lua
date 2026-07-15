vim.pack.add({
  "https://github.com/nosduco/remote-sshfs.nvim",
})

require("remote-sshfs").setup({
  ui = { picker = "snacks" },
})
