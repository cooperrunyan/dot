vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
	pattern = { "*" },
	callback = function()
		if vim.opt.buftype:get() == "terminal" then
			vim.cmd(":startinsert")
		end
	end,
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
	callback = function()
		for _, buffers in ipairs(vim.fn.getbufinfo()) do
			local filetype = vim.api.nvim_buf_get_option(buffers.bufnr, "filetype")
			if filetype == "toggleterm" then
				vim.api.nvim_create_autocmd({ "ExitPre", "QuitPre", "WinClosed" }, {
					buffer = buffers.bufnr,
					command = "q!",
				})
			end
		end
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Hightlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "Yanked",
			timeout = 200,
			priority = 900,
		})
	end,
})
