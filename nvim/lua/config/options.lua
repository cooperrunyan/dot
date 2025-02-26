vim.opt.confirm = false
vim.opt.updatetime = 200

-- vim.opt.autochdir = true
vim.opt.pumblend = 0
vim.opt.splitright = true
vim.opt.splitbelow = true

-- vim.opt.hidden = true

vim.opt.swapfile = false

vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 0

vim.opt.autoindent = true
vim.opt.gdefault = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autowrite = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.wrap = true
vim.opt.mousescroll = "ver:3,hor:0"
vim.opt.fillchars = "eob: "
vim.opt.expandtab = true
vim.opt.signcolumn = "yes:1"
vim.opt.showmatch = true

-- vim.opt.iskeyword:append("-")
vim.opt.shortmess:append({ I = true })

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

vim.diagnostic.config({
	update_in_insert = true,
	float = { border = "rounded" },
})
