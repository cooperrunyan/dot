local ok, rt = pcall(require, "rust-tools")
if not ok then
	return
end

rt.setup({
	inlay_hints = {
		auto = false,
	},
	server = {
		standalone = false,
		on_attach = function(_, bufnr)
			vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
			vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
			vim.keymap.set("n", "<Leader>rc", rt.open_cargo_toml.open_cargo_toml, { buffer = bufnr })
			vim.keymap.set("n", "<Leader>rp", rt.parent_module.parent_module, { buffer = bufnr })
			vim.keymap.set("n", "<Leader>rr", "<cmd>:RustRun<CR>", { buffer = bufnr })
			vim.keymap.set("n", "<Leader>rt", "<cmd>:RustTest!<CR>", { buffer = bufnr })
			-- vim.keymap.set("n", "<C-w>", "<cmd>:RustFmt<CR>", { buffer = bufnr })
		end,
	},
	dap = {
		adapter = {
			type = "executable",
			command = "codelldb",
			name = "rust",
		},
	},
})

-- local dap = require("dap")
--
-- dap.adapters.codelldb = {
-- 	type = "server",
-- 	port = "${port}",
-- 	executable = {
-- 		command = "codelldb",
-- 		args = { "--port", "${port}" },
-- 	},
-- }
--
-- dap.configurations.rust = {
-- 	{
-- 		name = "Launch",
-- 		type = "codelldb",
-- 		request = "launch",
-- 		cwd = "${workspaceFolder}",
-- 		stopOnEntry = false,
-- 		program = function()
-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
-- 		end,
-- 	},
-- }
-- dap.configurations.c = dap.configurations.rust
-- dap.configurations.cpp = dap.configurations.rust
