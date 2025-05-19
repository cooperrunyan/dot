return {
	"akinsho/toggleterm.nvim",
	keys = {
		{ "<c-t>", desc = "Open terminal" },
		{ "<leader>gt", desc = "Open Lazygit" },
	},
	opts = {
		open_mapping = "<c-t>",
		direction = "horizontal",
		hide_numbers = true,
	},
	config = function(opts)
		require("toggleterm").setup(opts)

		local Terminal = require("toggleterm.terminal").Terminal

		local lazygit = Terminal:new({
			cmd = "lazygit",
			direction = "float",
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			end,
		})

		vim.keymap.set("n", "<leader>gt", function()
			lazygit:toggle()
		end, { noremap = true, silent = true })
	end,
}
