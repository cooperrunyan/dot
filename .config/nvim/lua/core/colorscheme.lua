vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true
vim.opt.background = "dark"

local ok, tokyo = pcall(require, "tokyonight")
if not ok then
	return
end

tokyo.setup({
	style = "night",
	transparent = true,
	terminal_colors = true,
	styles = {
		sidebars = "transparent", -- style for sidebars, see below
		floats = "dark", -- style for floating windows
	},
})

vim.cmd([[colorscheme tokyonight]])
