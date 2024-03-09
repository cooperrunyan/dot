vim.opt.confirm = false
vim.opt.updatetime = 200

vim.opt.autochdir = true
vim.opt.pumblend = 0
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.hidden = true

vim.opt.swapfile = false

vim.opt.iskeyword:append("-")
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
