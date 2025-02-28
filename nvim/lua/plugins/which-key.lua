return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix",
		delay = 0,
		triggers = {
			{ "<auto>", mode = "nixsotc" },
			{ "m", mode = { "n", "x" }, group = "Surround" },
		},
		icons = {
			mappings = false,
		},
	},
	keys = {
		{
			"<leader><leader>",
			function()
				require("which-key").show()
			end,
		},
	},
}
