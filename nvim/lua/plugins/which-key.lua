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
		spec = {
			{ "<leader>g", group = "Git" },
			{ "<leader>f", group = "Picker" },
			{ "<leader>x", group = "Diagnostic" },
			{ "<leader>T", group = "Toggle" },

			{ "U", ":redo<CR>", mode = "nx", silent = true, desc = "Redo" },
			{ "x", '"_x', mode = "nx", silent = true, desc = "Delete under cursor" },

			{ "ge", "G", mode = "nxo", silent = true, desc = "End of file" },
			{ "L", "g$", mode = "ox", silent = true, desc = "End of line" },
			{ "H", "g^", mode = "ox", silent = true, desc = "Start of line" },
			{ "k", "gk", mode = "nox", silent = true, remap = false },
			{ "j", "gj", mode = "nox", silent = true, remap = false },

			{ "J", ":m '>+1<CR>gv=gv", mode = "x", silent = true, desc = "Move selection up" },
			{ "K", ":m '<-2<CR>gv=gv", mode = "x", silent = true, desc = "Move selection down" },

			{ "<C-q>", ":q<CR>", mode = "nxi", silent = true, desc = "Close buffer" },
			{ "<D-s>", ":w<CR>", mode = "nxic", silent = true, desc = "Write buffer" },

			{ "p", '"_dP', mode = "x", silent = true, desc = "Paste over selection" },
			{ "c", '"_c', mode = "x", silent = true, desc = "Change selection" },
			{ "<D-c>", '"+y', mode = "x", silent = true, desc = "Copy to system clipboard" },
			{ "<D-v>", '"+P', mode = "n", silent = true, desc = "Paste system clipboard" },
			{ "<D-v>", '"_d"+P', mode = "x", silent = true, desc = "Paste system clipboard" },
			{ "<D-v>", '<C-R>+"P', mode = "c", silent = true, desc = "Paste system clipboard" },
			{ "<D-v>", '<ESC>l"+Pli', mode = "i", silent = true, desc = "Paste system clipboard" },

			{ "<leader>r", vim.lsp.buf.rename, mode = "nx", silent = true, desc = "Rename symbol" },
			{ "<leader>a", vim.lsp.buf.code_action, mode = "nx", silent = true, desc = "Code action" },
			{ "gr", vim.lsp.buf.references, silent = true, desc = "Go to references" },
			{ "gd", vim.lsp.buf.declaration, silent = true, desc = "Go to declaration" },
			{ "K", vim.lsp.buf.hover, silent = true, desc = "Hover" },
			{ "H", vim.lsp.buf.signature_help, silent = true, desc = "Signature help" },

			{ "<leader>p", '"+p', mode = "nx", silent = true, desc = "Paste system clipboard" },
			{ "<leader>y", '"+y', mode = "x", silent = true, desc = "Copy to system clipboard" },

			{ "<C-L>", ":wincmd l<CR>", mode = "nxi", silent = true, desc = "Focus left" },
			{ "<C-J>", ":wincmd j<CR>", mode = "nxi", silent = true, desc = "Focus down" },
			{ "<C-K>", ":wincmd k<CR>", mode = "nxi", silent = true, desc = "Focus up" },
			{ "<C-H>", ":wincmd h<CR>", mode = "nxi", silent = true, desc = "Focus right" },

			{ "<leader>s", group = "Split" },
			{ "<leader>ss", "<C-w>v", silent = true, desc = "Split vertically" },
			{ "<leader>se", "<C-w>=", silent = true, desc = "Resize splits" },
			{ "<leader>sq", ":close<CR>", silent = true, desc = "Close splits" },

			{ "<leader>t", group = "Tab" },
			{ "<leader>tt", ":tab split<CR>", silent = true, desc = "Open new tab" },
			{ "<leader>tq", ":tabclose<CR>", silent = true, desc = "Close tab" },
			{ "<leader>to", ":tabo<CR>", silent = true, desc = "Close other tabs" },
			{ "<leader>tn", ":tabn<CR>", silent = true, desc = "Next tab" },
			{ "<leader>tp", ":tabp<CR>", silent = true, desc = "Previous tab" },

			{ "<ESC>", "<C-\\><C-n><C-w><C-p>", mode = "t", silent = true },

			{ ">", ">>", mode = "n", silent = true, remap = false, desc = "Indent" },
			{ "<", "<<", mode = "n", silent = true, remap = false, desc = "Unindent" },
			{ ">", ">gv", mode = "x", silent = true, remap = false, desc = "Indent" },
			{ "<", "<gv", mode = "x", silent = true, remap = false, desc = "Unindent" },
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
