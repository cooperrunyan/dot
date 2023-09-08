local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
  return
end

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

nvim_tree.setup({
	diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
    width = 30,
    side = "left"
  },
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
	actions = {
		open_file = {
			quit_on_open = true,
			window_picker = {
				enable = false,
			},
		},
	},
	git = {
      enable = true,
      ignore = false,
      timeout = 500,
  },
	update_focused_file = {
    enable = true,
    update_cwd = true,
    -- ignore_list = {},
    update_root = true,
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
