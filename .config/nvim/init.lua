pcall(require, "plugins")

pcall(require, "core.options")
pcall(require, "core.keymaps")
pcall(require, "core.colorscheme")

pcall(require, "plugins.alpha")
pcall(require, "plugins.autopairs")
pcall(require, "plugins.cmp")
pcall(require, "plugins.comment")
pcall(require, "plugins.gitsigns")
pcall(require, "plugins.impatient")
pcall(require, "plugins.lualine")
pcall(require, "plugins.nvim-tree")
pcall(require, "plugins.telescope")
pcall(require, "plugins.treesitter")

pcall(require, "plugins.lsp.lang.rust")

pcall(require, "plugins.lsp.mason")
pcall(require, "plugins.lsp.null-ls")
pcall(require, "plugins.lsp.lspconfig")
