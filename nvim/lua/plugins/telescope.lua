return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-symbols.nvim",
		},
		keys = {
			{ "<leader>ff", ":Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>fG", ":Telescope git_files<cr>", desc = "Git files" },
			{ "<leader>fg", ":Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>fb", ":Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fh", ":Telescope help_tags<cr>", desc = "Help" },
			{ "<leader>fi", ":Telescope highlights<cr>", desc = "Highlights" },
			{ "<leader>fa", ":Telescope builtin<cr>", desc = "Pickers" },
			{ "<leader>fD", ":Telescope diagnostics<cr>", desc = "Diagnostics" },
			{ "<leader>fk", ":Telescope keymaps<cr>", desc = "Keymaps" },
			{ "<leader>fr", ":Telescope registers<cr>", desc = "Registers" },
			{ "<leader>fo", ":Telescope vim_options<cr>", desc = "Options" },
			{ "<leader>fc", ":Telescope commands<cr>", desc = "Commands" },
			{ "<leader>fC", ":Telescope autocommands<cr>", desc = "Autocommands" },
			{ "<leader>fT", ":Telescope colorscheme<cr>", desc = "Theme" },
			{ "<leader>fm", ":Telescope marks<cr>", desc = "Marks" },
			{ "<leader>fM", ":Telescope man_pages<cr>", desc = "Man" },
			{ "<leader>fH", ":Telescope command_history<cr>", desc = "Command history" },
			{ "<leader>fs", ":Telescope symbols<cr>", desc = "Symbols" },
			{ "<leader><space>", false },
		},
		opts = function()
			local actions = require("telescope.actions")

			local layout_strategies = require("telescope.pickers.layout_strategies")
			layout_strategies.horizontal_fused = function(picker, max_columns, max_lines, layout_config)
				local layout = layout_strategies.horizontal(picker, max_columns, max_lines, layout_config)
				layout.prompt.title = ""
				layout.results.title = ""
				layout.results.height = layout.results.height + 1
				layout.results.borderchars = { "─", "│", "─", "│", "╭", "┬", "┤", "├" }
				layout.prompt.borderchars = { "─", "│", "─", "│", "╭", "╮", "┴", "╰" }
				if layout.preview then
					layout.preview.title = ""
					layout.preview.borderchars = { "─", "│", "─", " ", "─", "╮", "╯", "─" }
				end
				return layout
			end

			return {
				pickers = {
					colorscheme = {
						enable_preview = true,
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				defaults = {
					prompt_prefix = " ",
					layout_strategy = "horizontal_fused",
					layout_config = {
						horizontal = {
							prompt_position = "bottom",
						},
					},
					mappings = {
						i = {
							["<ESC>"] = actions.close,
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<ScrollWheelUp>"] = actions.move_selection_previous,
							["<ScrollWheelDown>"] = actions.move_selection_next,
							["<LeftMouse>"] = actions.select_default,
						},
					},
					load_extensions = {
						"ui-select",
						"symbols",
					},
				},
			}
		end,
	},
}
