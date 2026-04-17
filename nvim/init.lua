require("vim._core.ui2").enable({})

vim.g.mapleader = " "

vim.opt.confirm = false
vim.opt.updatetime = 200

-- vim.opt.autocomplete = true

vim.opt.pumblend = 0
vim.opt.splitright = true

vim.opt.foldlevel = 99
vim.opt.splitbelow = true

vim.opt.swapfile = false

vim.opt.autocomplete = false
vim.opt.completeopt = "fuzzy,menuone,noselect,popup"
vim.opt.complete = "o,.,w,b,u,t"

-- vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.scrolloff = 4
-- vim.opt.sidescrolloff = 0

vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true

vim.opt.gdefault = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.infercase = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.expandtab = true
-- vim.opt.autowrite = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.wrap = false
-- vim.opt.mousescroll = "ver:3,hor:0"
vim.opt.fillchars = "eob: "
vim.opt.signcolumn = "yes:1"
vim.opt.showmatch = false

vim.g.vimtex_syntax_enabled = 0

vim.opt.winborder = "rounded"

vim.filetype.add({
  extension = {
    urdf = "xml",
    xacro = "xml",
  },
})

vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  update_in_insert = true,
  float = { border = "rounded" },
  severity_sort = true,
})
