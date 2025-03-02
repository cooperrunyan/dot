return {
	{ import = "plugins.lang" },
	{
		"neovim/nvim-lspconfig",
		event = { "BufRead", "VeryLazy" },
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {
			diagnostics = {
				icons = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = " ",
					[vim.diagnostic.severity.INFO] = " ",
				},
				underline = true,
				update_in_insert = true,
				virtual_lines = true,
				virtual_text = {
					-- virt_text_pos = "right_align",
					prefix = "",
					-- source = "if_many"
					-- prefix = function(d, i, tot)
					-- 	if tot > 1 then
					-- 		return "󰝤"
					-- 	end
					-- 	return vim.g.diagnostic_icons[d.severity]
					-- end,
				},
				severity_sort = true,
				signs = {
					text = {
						-- [vim.diagnostic.severity.ERROR] = " ",
						-- [vim.diagnostic.severity.WARN] = " ",
						-- [vim.diagnostic.severity.HINT] = " ",
						-- [vim.diagnostic.severity.INFO] = " ",
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.HINT] = "",
						[vim.diagnostic.severity.INFO] = "",
					},
					linehl = {
						[vim.diagnostic.severity.ERROR] = "DiagnosticErrorLine",
						[vim.diagnostic.severity.WARN] = "DiagnosticWarnLine",
						[vim.diagnostic.severity.HINT] = "DiagnosticHintLine",
						[vim.diagnostic.severity.INFO] = "DiagnosticInfoLine",
					},
					numhl = {
						[vim.diagnostic.severity.ERROR] = "DiagnosticErrorNumLine",
						[vim.diagnostic.severity.WARN] = "DiagnosticWarnNumLine",
						[vim.diagnostic.severity.HINT] = "DiagnosticHintNumLine",
						[vim.diagnostic.severity.INFO] = "DiagnosticInfoNumLine",
					},
				},
			},
			inlay_hints = { enabled = false },
			codelens = { enabled = false },
			capabilities = {
				workspace = {
					fileOperations = {
						didRename = true,
						willRename = true,
					},
				},
			},
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
			ensure_installed = {
				"lua_ls",
				"taplo",
				"yamlls",
				"marksman",
				"texlab",
				"biome",
				"clangd",
				"cmake",
				"cssls",
				"denols",
				"bashls",
				"vtsls",
				"glsl_analyzer",
				"efm",
				"html",
				"jsonls",
				"pyright",
			},
			servers = {
				lua_ls = {
					-- keys = {},
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							codeLens = { enable = false },
							completion = { callSnippet = "Replace" },
							doc = { privateName = { "^_" } },
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
						},
					},
				},

				taplo = {
					config_file = {
						enabled = true,
						path = (os.getenv("XDG_CONFIG_HOME") or "~/.config") .. "/taplo.toml",
					},
				},
				yamlls = {},
				marksman = {},
				biome = {},
				cssls = {},
				denols = {},
				bashls = {},
				vtsls = {},
			},
			setup = {
				-- example to setup with typescript.nvim
				-- tsserver = function(_, opts)
				--   require("typescript").setup({ server = opts })
				--   return true
				-- end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
		config = function(_, opts)
			-- diagnostics signs
			-- if vim.fn.has("nvim-0.10.0") == 0 then
			-- 	if type(opts.diagnostics.signs) ~= "boolean" then
			-- 		for severity, icon in pairs(opts.diagnostics.signs.text) do
			-- 			local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
			-- 			name = "DiagnosticSign" .. name
			-- 			vim.fn.sign_define(name, {
			--            text = icon,
			--            texthl = "DiagnosticSign" .. name,
			--            linehl = "DiagnosticLine" .. name,
			--            numhl = "DiagnosticNum" .. name,
			--
			--          })
			-- 		end
			-- 	end
			-- end

			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
			vim.g.diagnostic_icons = opts.diagnostics.icons

			local servers = opts.servers
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			local has_blink, blink = pcall(require, "blink.cmp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				has_cmp and cmp_nvim_lsp.default_capabilities() or {},
				has_blink and blink.get_lsp_capabilities() or {},
				opts.capabilities or {}
			)

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, servers[server] or {})
				if server_opts.enabled == false then
					return
				end

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			-- get all the servers that are available through mason-lspconfig
			local have_mason, mlsp = pcall(require, "mason-lspconfig")
			local all_mslp_servers = {}
			if have_mason then
				all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
			end

			local ensure_installed = opts.ensure_installed or {}
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					if server_opts.enabled ~= false then
						-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
						if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
							setup(server)
						else
							ensure_installed[#ensure_installed + 1] = server
						end
					end
				end
			end

			if have_mason then
				mlsp.setup({
					ensure_installed = ensure_installed,
					handlers = { setup },
				})
			end
		end,
	},
	{

		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts_extend = { "ensure_installed" },
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					-- trigger FileType event to possibly load this newly installed LSP server
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)

			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		opts = function(_, opts)
			if opts.tools == nil then
				opts.tools = {}
			end
			opts.tools.on_initialized = function() end
			return opts
		end,
	},
}
