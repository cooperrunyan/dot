vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	use("folke/tokyonight.nvim")
<<<<<<< HEAD:.config/nvim/lua/cooperrunyan/plugins-setup.lua
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
	})
	use("christoomey/vim-tmux-navigator")
	use("szw/vim-maximizer")
	use("tpope/vim-surround")
	use("vim-scripts/ReplaceWithRegister")
	use("numToStr/Comment.nvim")
=======
>>>>>>> 3f20c270 (Update nvim config):.config/nvim/lua/plugins-setup.lua
	use("nvim-tree/nvim-tree.lua")
	use("kyazdani42/nvim-web-devicons")
	use("nvim-lualine/lualine.nvim")
	use("BurntSushi/ripgrep")
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")
	use("simrat39/rust-tools.nvim")
	use("jose-elias-alvarez/typescript.nvim")
	use("MunifTanjim/prettier.nvim")
	use("jose-elias-alvarez/null-ls.nvim")
	use("jayp0521/mason-null-ls.nvim")
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")
	use("numToStr/Comment.nvim")
	use("lewis6991/gitsigns.nvim")
	use("mfussenegger/nvim-dap")
	use("voldikss/vim-floaterm")
	use("rust-lang/rust.vim")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
