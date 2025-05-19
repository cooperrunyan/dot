vim.api.nvim_create_user_command("ColconBuild", function(opts)
	local ok, toggleterm = pcall(require, "toggleterm.terminal")

	if not ok then
		return
	end

	local Terminal = toggleterm.Terminal

	local packages = table.concat(opts.fargs, " ")
	local cmd = "source /opt/ros/install/setup.sh && colcon build --symlink-install"
	if packages ~= "" then
		cmd = cmd .. " --packages-select " .. packages
	end

	local term = Terminal:new({
		cmd = cmd,
		direction = "float",
		env = {
			AMENT_PREFIX_PATH = "",
			COLCON_PREFIX_PATH = "",
			CMAKE_PREFIX_PATH = "",
			GZ_VERSION = "harmonic",
		},
		on_open = function(term)
			vim.keymap.set("n", "q", function()
				term:shutdown()
			end, { noremap = true, silent = true, buffer = term.bufnr })
		end,
	})

	term:open()
end, {})
