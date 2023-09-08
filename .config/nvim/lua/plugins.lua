local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
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

	use("goolord/alpha-nvim")

	use("folke/tokyonight.nvim")
	use("kyazdani42/nvim-web-devicons")
	use("lewis6991/gitsigns.nvim")
	use("nvim-lualine/lualine.nvim")

	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
	})
	use("nvim-tree/nvim-tree.lua")

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
  use("f3fora/cmp-spell")

	use("L3MON4D3/LuaSnip")

	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")
	use("jose-elias-alvarez/null-ls.nvim")
	use("jayp0521/mason-null-ls.nvim")
	use("mfussenegger/nvim-dap")

	use("jose-elias-alvarez/typescript.nvim")
	use("MunifTanjim/prettier.nvim")
	use("windwp/nvim-ts-autotag")

	use("rust-lang/rust.vim")
	use("simrat39/rust-tools.nvim")

	-- LaTeX
  -- use("lervag/vimtex")
  -- use("kdheepak/cmp-latex-symbols")
  -- use("jbyuki/nabla.nvim")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
