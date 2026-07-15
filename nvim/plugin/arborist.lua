vim.pack.add({
  "https://github.com/arborist-ts/arborist.nvim",
})

require("arborist").setup({
  overrides = {
    ros2 = {
      url = "https://github.com/ErickKramer/nvim-ros2",
      location = "treesitter-ros2",
    },
  },
})
