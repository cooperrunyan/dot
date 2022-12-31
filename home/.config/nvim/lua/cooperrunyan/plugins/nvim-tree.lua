local nvimtree = require("nvim-tree")

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

nvimtree.setup({
	renderer = {
		icons = {
			glyphs = {
				folder = {
					arrow_closed = " ",
					arrow_open = " ",
				},
			},
		},
	},
	view = {
		mappings = {
			list = {
				{ key = "r", action = "full_rename" },
				{ key = "l", action = "edit" },
				{ key = "h", action = "close_node" },
			},
		},
	},
	actions = {
		open_file = {
			quit_on_open = true,
			window_picker = {
				enable = false,
			},
		},
	},
	filters = {
		--		dotfiles = true,
		custom = {
			".DS_Store",
			"yarn.lock",
			"package-lock.json",
			".git",
		},
	},
})
