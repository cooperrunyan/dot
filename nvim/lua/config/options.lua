vim.opt.confirm = false
vim.opt.updatetime = 200

-- vim.opt.autochdir = true
vim.opt.pumblend = 0
vim.opt.splitright = true
vim.opt.splitbelow = true

-- vim.opt.hidden = true

vim.opt.swapfile = false

-- vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.scrolloff = 4
-- vim.opt.sidescrolloff = 0

vim.opt.breakindent = true

vim.opt.autoindent = true
vim.opt.gdefault = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autowrite = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
-- vim.opt.wrap = true
-- vim.opt.mousescroll = "ver:3,hor:0"
vim.opt.fillchars = "eob: "
vim.opt.signcolumn = "yes:1"
vim.opt.showmatch = true

-- vim.opt.background = "dark"

vim.g.vimtex_syntax_enabled = 0

vim.filetype.add({
  extension = {
    urdf = "xml",
    xacro = "xml",
  },
})

vim.diagnostic.config({
  icons = {
    [vim.diagnostic.severity.ERROR] = " ",
    [vim.diagnostic.severity.WARN] = " ",
    [vim.diagnostic.severity.HINT] = " ",
    [vim.diagnostic.severity.INFO] = " ",
  },
  underline = true,
  update_in_insert = true,
  -- virtual_lines = {
  --   current_line = false,
  --   format = function(diagnostic)
  --     if diagnostic.source == "rustc" then
  --       return nil
  --     end
  --     return diagnostic.message
  --   end,
  -- },
  virtual_text = {
    current_line = false,
    prefix = "",
    -- format = function(diagnostic)
    --   if diagnostic.source ~= "rustc" then
    --     return nil
    --   end
    --   return diagnostic.message
    -- end,
  },
  float = {
    border = "rounded",
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
    linehl = {
      -- [vim.diagnostic.severity.ERROR] = "DiagnosticErrorLine",
      -- [vim.diagnostic.severity.WARN] = "DiagnosticWarnLine",
      -- [vim.diagnostic.severity.HINT] = "DiagnosticHintLine",
      -- [vim.diagnostic.severity.INFO] = "DiagnosticInfoLine",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticErrorNumLine",
      [vim.diagnostic.severity.WARN] = "DiagnosticWarnNumLine",
      [vim.diagnostic.severity.HINT] = "DiagnosticHintNumLine",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfoNumLine",
    },
  },
})

-- vim.opt.iskeyword:append("-")
-- vim.opt.shortmess:append({ I = true })

-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
-- 	border = "rounded",
-- })
--
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
-- 	border = "rounded",
-- })
