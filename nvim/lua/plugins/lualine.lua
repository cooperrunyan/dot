return {
	"nvim-lualine/lualine.nvim",
	config = function(_, opts)
		local lazy_status = require("lazy.status")
		opts.sections.lualine_x = {
			{ lazy_status.updates, cond = lazy_status.has_updates },
		}
		require("lualine").setup(opts)
	end,
	event = "VeryLazy",
	opts = {
		options = {
			disabled_filetypes = {
				ToggleTerm = {},
			},
			theme = "github_dark_default",
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = {
				{
					"mode",
					right_padding = 2,
					fmt = function(str)
						return str:sub(1, 1)
					end,
				},
			},
			lualine_b = { {
				"branch",
				icons_enabled = true,
				icon = "",
			} },
			lualine_c = {
				"location",
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					sections = { "error", "warn", "hint", "info" },
					-- symbols = { error = " ", warn = " ", hint = "󰌶 ", info = "󰋽 " },
					symbols = { error = " ", warn = " ", info = " ", hint = "󰌶 " },
					colored = true,
					update_in_insert = true,
					-- always_visible = true,
				},
			},
			lualine_x = {},
			lualine_y = { "filetype" },
			lualine_z = { "filename" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filetype" },
			lualine_x = { "filename" },
			lualine_y = {},
			lualine_z = {},
		},
		extensions = {
			"neo-tree",
			"mason",
			"trouble",
			"man",
			"nvim-dap-ui",
			"lazy",
			"quickfix",
			"toggleterm",
		},
	},
}
