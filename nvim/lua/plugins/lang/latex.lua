return {
	{
		"lervag/vimtex",
		lazy = false, -- lazy-loading will disable inverse search
		config = function()
			vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }
			vim.g.vimtex_view_method = "skim"
			vim.g.vimtex_view_enabled = 1
			vim.g.vimtex_view_automatic = 1
			vim.g.vimtex_skim_sync = 1
			vim.g.vimtex_view_general_options = "-r @line @pdf @tex"
			vim.g.vimtex_quickfix_open_on_warning = 0
			vim.g.vimtex_compiler_latexmk = {
				aux_dir = "build/artifacts",
				out_dir = "build",
				callback = 1,
				continuous = 1,
				executable = "latexmk",
				hooks = {},
				options = {
					"-pdf",
					"-interaction=nonstopmode",
					"-synctex=1",
					"-auxdir=build/artifacts",
					"-outdir=build",
				},
			}

			vim.cmd("filetype plugin indent on")
			vim.cmd("syntax enable")

			local group = vim.api.nvim_create_augroup("vimtex_mac", {})

			vim.api.nvim_create_autocmd("BufWritePost", {
				group = group,
				desc = "Build on save",
				pattern = { "*.tex" },
				command = "VimtexCompile",
			})

			vim.api.nvim_create_autocmd("User", {
				group = group,
				pattern = "VimtexEventQuit",
				callback = function()
					local cmd = [[  
            tell application "Skim"	
              close (every document whose name is "]] .. vim.b.vimtex.name .. [[.pdf") 
              if (count of documents) is 0 then quit 
            end tell 
          ]]
					vim.system({ "osascript", "-e", cmd }):wait()
				end,
			})
		end,
		keys = {
			{ "<leader>v", group = "Preview" },
			{ "<localLeader>l", "", desc = "+vimtex", ft = "tex" },
			{ "<leader>vv", ":VimtexView<CR>", desc = "Latex view", ft = "tex" },
		},
	},
}
