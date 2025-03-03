return {
	{
		"hat0uma/csvview.nvim",
		ft = "csv",
		opts = {
			parser = {
				comments = { "#", "//" },
				async_chunksize = 500,
			},
			keymaps = {
				textobject_field_inner = { "if", mode = { "o", "x" } },
				textobject_field_outer = { "af", mode = { "o", "x" } },
				jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
				jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
				jump_next_row = { "<Enter>", mode = { "n", "v" } },
				jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
			},
			view = {
				display_mode = "border",
			},
		},
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
		keys = {
			{
				"<leader>vv",
				":CsvViewToggle<CR>",
				desc = "Toggle preview",
				ft = "csv",
			},
		},
		init = function()
			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = "csv",
				callback = function()
					vim.cmd("setlocal nowrap")
					local ok, csv = pcall(require, "csvview")
					if not ok or csv.is_enabled() then
						return
					end
					csv.enable()
				end,
			})
		end,
	},
}
