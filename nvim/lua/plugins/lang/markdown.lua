return {
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    ft = "markdown",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      require("lazy").load({ plugins = { "markdown-preview.nvim" } })
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>vv",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Toggle Preview",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },
  { "bullets-vim/bullets.vim", lazy = true, ft = "markdown" },
  {
    enabled = false,
    "MeanderingProgrammer/markdown.nvim",
    ft = "markdown",
  },
}
