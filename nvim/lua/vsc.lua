vim.opt.hlsearch = false

return {
  { "jghauser/mkdir.nvim" },
  { "wellle/targets.vim" },
  { "tpope/vim-sleuth" },
  { "justinmk/vim-sneak" },
  { "numToStr/Comment.nvim" },
  { "tpope/vim-surround" },
  { "vim-scripts/ReplaceWithRegister" },
  { "othree/eregex.vim" },
  { "j-hui/fidget.nvim" },
  {
    'vscode-neovim/vscode-multi-cursor.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      { "<C-d>", function() require("vscode-multi-cursor").addSelectionToNextFindMatch() end, mode = { "n", "x", "i" } }
    }
  }
}
