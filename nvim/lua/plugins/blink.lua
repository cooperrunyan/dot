return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"nvim-tree/nvim-web-devicons",
			"micangl/cmp-vimtex",
		},
		version = "*",
		opts = {
			keymap = {
				preset = "super-tab",
				-- preset = "enter",
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<down>"] = { "select_next", "fallback" },
				["<up>"] = { "select_prev", "fallback" },
				-- ["<esc>"] = { "cancel", "fallback" },
				["<Tab>"] = {
					function(cmp)
						if require("luasnip").locally_jumpable(1) then
							return cmp.snippet_forward()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
				["<CR>"] = {
					function(cmp)
						if require("luasnip").locally_jumpable(1) then
							return cmp.accept()
						end
					end,
					"fallback",
				},
			},
			term = { enabled = true },
			cmdline = {
				enabled = true,
				keymap = {
					preset = "super-tab",
					["<C-j>"] = { "select_next" },
					["<C-k>"] = { "select_prev" },
				},
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				nerd_font_variant = "normal",
			},
			snippets = {
				preset = "luasnip",
			},
			-- ghost_text = { enabled = true },
			signature = {
				enabled = true,
				window = { border = "rounded" },
			},
			completion = {
				menu = {
					scrollbar = false,
					border = "rounded",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
				},
				documentation = {
					window = { border = "rounded" },
					auto_show = true,
				},
				list = {
					selection = {
						-- preselect = false,
						auto_insert = false,
					},
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "vimtex", "buffer" },
				providers = {
					vimtex = {
						name = "vimtex",
						module = "blink.compat.source",
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	},
	{
		"saghen/blink.compat",
		version = "*",
		lazy = true,
		opts = {},
	},
}
