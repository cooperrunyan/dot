return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"nvim-tree/nvim-web-devicons",
			"micangl/cmp-vimtex",
			{ "xzbdmw/colorful-menu.nvim" },
		},
		version = "*",
		opts = {
			keymap = {
				preset = "super-tab",
				-- preset = "enter",
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-h>"] = { "show_signature", "hide_signature", "fallback" },
				["<down>"] = { "select_next", "fallback" },
				["<up>"] = { "select_prev", "fallback" },
				-- ["<tab>"] = { "accept", "snippet_forward", "fallback" },
				-- ["<esc>"] = { "cancel", "fallback" },
			},
			term = { enabled = true },
			cmdline = {
				enabled = true,
				keymap = {
					preset = "cmdline",
					["<C-j>"] = { "select_next" },
					["<C-k>"] = { "select_prev" },
					["<C-space>"] = { "show", "cancel" },
					["<down>"] = { "select_next", "fallback" },
					["<up>"] = { "select_prev", "fallback" },
					-- ["<tab>"] = { "accept", "fallback" },
					["<tab>"] = { "show", "select_and_accept" },
				},
				completion = {
					-- menu = { auto_show = true },
				},
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				nerd_font_variant = "normal",
			},
			-- snippets = {
			-- 	preset = "luasnip",
			-- },
			signature = {
				enabled = true,
				window = { border = "rounded", show_documentation = true },
				trigger = {
					enabled = true,
					show_on_insert = true,
				},
			},
			completion = {
				accept = { auto_brackets = { enabled = false } },
				menu = {
					scrollbar = false,
					border = "rounded",
					-- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
					winhighlight = "Normal:NormalFloat",
					draw = {
						columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },

						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},
				ghost_text = { enabled = true },
				documentation = {
					window = { border = "rounded" },
					auto_show = true,
				},
				list = {
					selection = {
						preselect = function()
							return not require("blink.cmp").snippet_active()
						end,
						auto_insert = false,
					},
				},
				trigger = {
					-- show_in_snippet = false
				},
			},
			sources = {
				default = {
					"lsp",
					-- "cmdline",
					"omni",
					"vimtex",
					"buffer",
					"path",
					"snippets",
				},
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
