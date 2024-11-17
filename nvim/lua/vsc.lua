-- vim.opt.hlsearch = false

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'Search', timeout = 200 }
  end,
})

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
