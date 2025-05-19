return {
	"folke/tokyonight.nvim",
	enabled = false,
	lazy = false,
	priority = 1000,
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd("colorscheme tokyonight")
	end,
	opts = {
		style = "night",
		light_style = "day",
	},
}
