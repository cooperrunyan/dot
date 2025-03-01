return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- { "3rd/image.nvim", opts = {} }, -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	keys = {
		{
			"<leader>e",
			function()
				require("neo-tree.command").execute({ action = "focus" })
			end,
			desc = "Focus File Tree",
		},
		{
			"<leader>E",
			function()
				require("neo-tree.command").execute({ toggle = true })
			end,
			desc = "Toggle File Tree",
		},
		-- { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
		-- { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
		-- {
		-- 	"<leader>ge",
		-- 	function()
		-- 		require("neo-tree.command").execute({ source = "git_status", toggle = true })
		-- 	end,
		-- 	desc = "Git Explorer",
		-- },
		-- {
		-- 	"<leader>be",
		-- 	function()
		-- 		require("neo-tree.command").execute({ source = "buffers", toggle = true })
		-- 	end,
		-- 	desc = "Buffer Explorer",
		-- },
	},
	deactivate = function()
		vim.cmd([[Neotree close]])
	end,
	opts = {
		enable_diagnostics = false,
		sources = { "filesystem", "buffers", "git_status" },
		open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
		close_if_last_window = true,
		filesystem = {
			bind_to_cwd = false,
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
			filtered_items = {
				visible = true,
				never_show = {
					".DS_Store",
					".git",
				},
			},
		},
		window = {
			mappings = {
				["l"] = "open",
				["h"] = "close_node",
				["<space>"] = "none",
				["Y"] = {
					function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						vim.fn.setreg("+", path, "c")
					end,
					desc = "Copy Path to Clipboard",
				},
				["O"] = {
					function(state)
						require("lazy.util").open(state.tree:get_node().path, { system = true })
					end,
					desc = "Open with System Application",
				},
				["P"] = { "toggle_preview", config = { use_float = false } },
			},
		},
		default_component_configs = {
			indent = {
				with_expanders = false,
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
			diagnostics = {
				error = " ",
				warn = " ",
				hint = " ",
				info = " ",
			},
			icon = {
				folder_closed = " ",
				folder_open = " ",
				folder_empty = "󰉖 ",
				folder_empty_open = "󰷏 ",
				provider = function(icon, node, _)
					if node.type == "file" or node.type == "terminal" then
						local success, web_devicons = pcall(require, "nvim-web-devicons")
						local name = node.type == "terminal" and "terminal" or node.name
						if success then
							local devicon, hl = web_devicons.get_icon(name)
							icon.text = devicon or icon.text
							if icon.text ~= "" then
								icon.text = icon.text .. " "
							end
							icon.highlight = hl or icon.highlight
						end
					end
				end,
			},
			git_status = {
				symbols = {
					-- Change type
					added = "✚",
					deleted = "✖",
					modified = "",
					renamed = "󰁕",
					-- Status type
					untracked = "",
					ignored = "",
					unstaged = "",
					staged = "",
					conflict = "",
				},
			},
		},
		event_handlers = {
			{
				event = "neo_tree_buffer_enter",
				handler = function()
					-- This effectively hides the cursor
					vim.cmd("highlight! Cursor blend=100")
				end,
			},
			{
				event = "neo_tree_buffer_leave",
				handler = function()
					-- Make this whatever your current Cursor highlight group is.
					vim.cmd("highlight! Cursor guifg=#0d1117 guibg=#e6edf3 blend=0")
				end,
			},
		},
	},
}
