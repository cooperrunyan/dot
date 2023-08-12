local null_ls = require("null-ls")
local mason_null_ls = require("mason-null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local actions = null_ls.builtins.code_actions

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		formatting.stylua,
		actions.gitsigns,
		actions.shellcheck,
		diagnostics.actionlint,
		diagnostics.deno_lint,
		diagnostics.dotenv_linter,
		diagnostics.shellcheck,
		diagnostics.zsh,
		formatting.deno_fmt,
		formatting.deno_fmt.with({ filetypes = { "markdown" } }),
		formatting.prettierd,
		formatting.prismaFmt,
		formatting.shfmt,
		formatting.sqlfmt,
		formatting.yamlfmt,
	},

	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format()
				end,
			})
		end
	end,
})

mason_null_ls.setup({
	ensure_installed = {
		"shfmt",
		"sqlfmt",
		"prettier",
		"prettierd",
		"stylua",
		"tsserver",
		"html",
		"cssls",
		"denols",
		"dockerls",
		"jsonls",
		"lua_ls",
		"rust_analyzer",
		"prismals",
		"bashls",
		"yamlls",
		"sqls",
		"codelldb",
		"docker-compose-language-service",
		"shellcheck",
		"tree-sitter-cli",
	},
})
