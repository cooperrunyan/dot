return {
	"kylechui/nvim-surround",
	dependencies = {
		{
			"folke/which-key.nvim",
			optional = true,
			config = function(_, opts)
				local wk = require("which-key")
				wk.setup(opts)
				wk.add({
					{ mode = { "n", "x" }, "ms", desc = "Add surround" },
					{ mode = { "n", "x" }, "mS", desc = "Block-Add surround" },
					{ mode = { "n", "x" }, "mr", desc = "Replace surround" },
					{ mode = { "n", "x" }, "mR", desc = "Block-Replace surround" },
					{ mode = { "n", "x" }, "md", desc = "Delete surround" },
				})
			end,
		},
	},
	-- version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	opts = function()
		local surround = require("nvim-surround")

		return {
			indent_lines = false,
			keymaps = {
				normal = "ms",
				-- normal_cur = "",
				normal_line = "mS",
				-- normal_cur_line = "",
				visual = "ms",
				visual_line = "mS",
				delete = "md",
				change = "mr",
				change_line = "mR",
			},
			highlight = {
				duration = 500,
			},
			move_cursor = "sticky",
			-- indent_lines = false,
			aliases = {
				["a"] = ">",
				["b"] = { ")", "]", "}" },
				["q"] = { '"', "'", "`" },
				["'"] = { '"', "'", "`" },
				["s"] = { "}", "]", ")", ">", '"', "'", "`" },
			},
			surrounds = {
				["("] = {
					add = { "(", ")" },
					find = function()
						return surround.get_selection({ motion = "a(" })
					end,
					delete = "^(.)().-(.)()$",
				},
				["{"] = {
					add = { "{", "}" },
					find = function()
						return surround.get_selection({ motion = "a{" })
					end,
					delete = "^(.)().-(.)()$",
				},
				["<"] = {
					add = { "<", ">" },
					find = function()
						return surround.get_selection({ motion = "a<" })
					end,
					delete = "^(.)().-(.)()$",
				},
				["["] = {
					add = { "[", "]" },
					find = function()
						return surround.get_selection({ motion = "a[" })
					end,
					delete = "^(.)().-(.)()$",
				},
			},
		}
	end,
}
