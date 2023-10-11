local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer")
  vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local ok, packer = pcall(require, "packer")
if not ok then
  return
end

vim.cmd([[packadd packer.nvim]])

return packer.startup(function(use)
  use("wbthomason/packer.nvim")
  use("nvim-lua/plenary.nvim")
  use("windwp/nvim-autopairs")
  use("numToStr/Comment.nvim")
  use("voldikss/vim-floaterm")
  use("lewis6991/impatient.nvim")

  use("folke/tokyonight.nvim")
  use("kyazdani42/nvim-web-devicons")
  use("lewis6991/gitsigns.nvim")
  use("nvim-lualine/lualine.nvim")
  use({ "akinsho/bufferline.nvim", tag = "*", requires = "nvim-tree/nvim-web-devicons" })

  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
  })

  use("BurntSushi/ripgrep")
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/vim-vsnip")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-omni")

  use("rafamadriz/friendly-snippets")

  use({
    "L3MON4D3/LuaSnip",
    run = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  })

  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("neovim/nvim-lspconfig")
  use("jose-elias-alvarez/null-ls.nvim")
  use("jayp0521/mason-null-ls.nvim")
  use("mfussenegger/nvim-dap")

  use("jose-elias-alvarez/typescript.nvim")
  use("windwp/nvim-ts-autotag")

  use("rust-lang/rust.vim")
  use("simrat39/rust-tools.nvim")

  use("folke/trouble.nvim")
  use({
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  })
  use({
    "amrbashir/nvim-docs-view",
    opt = true,
    cmd = { "DocsViewToggle" },
  })
  use("nvim-tree/nvim-tree.lua")
  use({ "toppair/peek.nvim", run = "deno task --quiet build:fast" })
  use({
    "samodostal/image.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })

  use("saecki/crates.nvim")
  use({
    "kdheepak/lazygit.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })
  use("alec-gibson/nvim-tetris")
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>")
    end,
  })

  use({
    "abecodes/tabout.nvim",
    wants = { "nvim-treesitter" }, -- or require if not used so far
    after = { "nvim-cmp" },      -- if a completion plugin is using tabs load it before
  })

  use({
    "folke/noice.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
    },
  })

  if packer_bootstrap then
    require("packer").sync()
  end
end)
