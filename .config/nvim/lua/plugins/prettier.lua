local prettier = require("prettier")

prettier.setup({
	bin = "prettier", -- or `'prettierd'` (v0.22+)
	filetypes = {
		"css",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"markdown",
		"scss",
		"typescript",
		"typescriptreact",
		"yaml",
	},
	cli_options = {
		arrow_parens = "avoid",
		bracket_spacing = true,
		bracket_same_line = true,
		embedded_language_formatting = "auto",
		end_of_line = "lf",
		html_whitespace_sensitivity = "css",
		jsx_single_quote = false,
		print_width = 80,
		prose_wrap = "never",
		quote_props = "as-needed",
		semi = true,
		single_attribute_per_line = false,
		single_quote = true,
		tab_width = 2,
		trailing_comma = "all",
		use_tabs = false,
		use_editor_config = false,
	},
})
