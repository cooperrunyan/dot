return {
	{
		"andrewferrier/wrapping.nvim",
		opts = {},
	},
	{ "j-hui/fidget.nvim", event = { "VeryLazy" } },
	{
		"akinsho/toggleterm.nvim",
		keys = { "<c-t>", desc = "Open terminal" },
		opts = {
			open_mapping = "<c-t>",
			direction = "horizontal",
		},
	},
	{ "yorickpeterse/nvim-pqf", event = { "VeryLazy" } },
	{
		"echasnovski/mini.ai",
		opts = {
			custom_textobjects = {
				["'"] = { { "%b''", '%b""', "%b``" }, "^.().*().$" },
			},
		},
	},
	{
		"echasnovski/mini.comment",
		event = "BufRead",
		keys = {
			{ "<leader>C" },
			{ "<leader>c" },
			{ "<leader>c", mode = "v" },
		},
		opts = {
			options = {},
			mappings = {
				comment = "<leader>C",
				comment_line = "<leader>c",
				comment_visual = "<leader>c",
			},
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
		},
	},
	{
		"folke/trouble.nvim",
		opts = {
			modes = {
				lsp = {
					win = { position = "right" },
					preview = {
						type = "split",
						position = "right",
						size = 0.3,
					},
				},
			},
		}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Open Diagnostics",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List",
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			disable_in_macro = true,
			ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
			-- check_ts = true,
			break_undo = true,
			enable_check_bracket_line = true,
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", desc = "Toggle git blame" },
			{
				"<leader>gd",
				":Gitsigns toggle_numhl<CR>:Gitsigns toggle_linehl<CR>",
				desc = "Toggle git diff highlights",
			},
		},
		opts = {
			current_line_blame_opts = {
				virt_text_pos = "right_align",
				delay = 0,
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Next Hunk")
				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Prev Hunk")
				map("n", "]H", function()
					gs.nav_hunk("last")
				end, "Last Hunk")
				map("n", "[H", function()
					gs.nav_hunk("first")
				end, "First Hunk")
				map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
				map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end, "Blame Line")
				map("n", "<leader>ghB", function()
					gs.blame()
				end, "Blame Buffer")
				map("n", "<leader>ghd", gs.diffthis, "Diff This")
				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end, "Diff This ~")
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},
}
