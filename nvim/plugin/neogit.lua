vim.pack.add({
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/sindrets/diffview.nvim",
})

vim.keymap.set("n", "<leader>gg", ":Neogit<cr>", { silent = true, desc = "Git" })

require("neogit").setup({
  graph_style = "unicode",
  highlight = { italic = false },
  mappings = {
    commit_editor = {
      ["<cr>"] = "Submit",
      ["<esc>"] = "Abort",
    },
    status = {
      ["l"] = "Toggle",
      ["S"] = "StageAll",
    },
  },
  integrations = {
    telescope = false,
  },
})
