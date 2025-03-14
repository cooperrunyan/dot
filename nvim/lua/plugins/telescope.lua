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
			{ "<leader>ff", ":Telescope find_files<cr>", desc = "Find files", silent = true },
			{ "<leader>fG", ":Telescope git_files<cr>", desc = "Git files", silent = true },
			{ "<leader>fg", ":Telescope live_grep<cr>", desc = "Live grep", silent = true },
			{ "<leader>fb", ":Telescope buffers<cr>", desc = "Buffers", silent = true },
			{ "<leader>fh", ":Telescope help_tags<cr>", desc = "Help", silent = true },
			{ "<leader>fi", ":Telescope highlights<cr>", desc = "Highlights", silent = true },
			{ "<leader>fa", ":Telescope builtin<cr>", desc = "Pickers", silent = true },
			{ "<leader>fD", ":Telescope diagnostics<cr>", desc = "Diagnostics", silent = true },
			{ "<leader>fk", ":Telescope keymaps<cr>", desc = "Keymaps", silent = true },
			{ "<leader>fr", ":Telescope registers<cr>", desc = "Registers", silent = true },
			{ "<leader>fo", ":Telescope vim_options<cr>", desc = "Options", silent = true },
			{ "<leader>fc", ":Telescope commands<cr>", desc = "Commands", silent = true },
			{ "<leader>fC", ":Telescope autocommands<cr>", desc = "Autocommands", silent = true },
			{ "<leader>fT", ":Telescope colorscheme<cr>", desc = "Theme", silent = true },
			{ "<leader>fm", ":Telescope marks<cr>", desc = "Marks", silent = true },
			{ "<leader>fM", ":Telescope man_pages<cr>", desc = "Man", silent = true },
			{ "<leader>fH", ":Telescope command_history<cr>", desc = "Command history", silent = true },
			{ "<leader>fs", ":Telescope symbols<cr>", desc = "Symbols", silent = true },
			{ "gr", ":Telescope lsp_references<cr>", desc = "Go to references", silent = true },
			{ "gi", ":Telescope lsp_implementations<cr>", desc = "Go to implementation", silent = true },
			{ "gd", ":Telescope lsp_definitions<cr>", desc = "Go to definition", silent = true },
			{ "gt", ":Telescope lsp_type_definitions<cr>", desc = "Go to type definition", silent = true },
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
