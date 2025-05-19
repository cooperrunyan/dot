return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>Tf",
			function()
				vim.b.disable_autoformat = not vim.b.disable_autoformat
			end,
			mode = "",
			desc = "Toggle format on save (Buffer)",
		},
		{
			"<leader>TF",
			function()
				vim.b.disable_autoformat = not vim.b.disable_autoformat
			end,
			mode = "",
			desc = "Toggle format on save (Global)",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			rust = { lsp_format = "prefer" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			markdown = { "deno_fmt" },
		},
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end

			return {
				timeout_ms = 500,
				lsp_format = "fallback",
				undojoin = true,
			}
		end,
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable format-on-save",
			bang = true,
		})

		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Enable format-on-save",
		})
	end,
}
