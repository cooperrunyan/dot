local sys = vim.loop.os_uname()
local use_mason_clangd = sys.machine ~= "aarch64" or sys.sysname == "Darwin"

return {
  { import = "plugins.lang" },
  {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "VeryLazy" },
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = { library = vim.api.nvim_get_runtime_file("lua", true) },
              telemetry = { enable = false },
            },
          },
          root_markers = { ".git", ".luarc.json" },
        },
        taplo = {
          config_file = {
            enabled = true,
            path = (os.getenv("XDG_CONFIG_HOME") or "~/.config") .. "/taplo.toml",
          },
        },
        yamlls = {
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              keyOrdering = false,
              format = { enable = true },
              validate = true,
            },
          },
        },
        jsonls = {
          settings = {
            json = {
              format = { enable = true },
              validate = { enable = true },
            },
          },
        },
        marksman = {},
        clangd = function()
          if use_mason_clangd then
            return {}
          end
          return { mason = false }
        end,
        cmake = {},
        cssls = {},
        cssmodules_ls = {},
        bashls = {},
        glsl_analyzer = {},
        dockerls = {},
        html = {},
        pyright = {},
        ruff = {},
        rust_analyzer = {},
        biome = { enabled = false },
        denols = {
          root_markers = { "deno.json", "deno.jsonc" },
          root_dir = function(bufnr, on_dir)
            local pattern = require("lspconfig.util").root_pattern({ "deno.json", "deno.jsonc" })
            local dir = pattern(vim.uri_to_fname(vim.uri_from_bufnr(bufnr)))
            if dir ~= nil then
              on_dir(dir)
            end
          end,
        },
        ts_ls = {
          root_dir = function(bufnr, on_dir)
            local util = require("lspconfig.util")
            local f = vim.uri_to_fname(vim.uri_from_bufnr(bufnr))
            if util.root_pattern({ "deno.json", "deno.jsonc" })(f) ~= nil then
              return
            end
            local r = util.root_pattern({ "tsconfig.json", "jsconfig.json", "package.json", ".git" })(f)
            if r then
              on_dir(r)
            end
          end,
        },
      },
    },
    config = function(_, opts)
      for server, config in pairs(opts.servers) do
        local enabled = config ~= nil and config ~= false

        if type(config) == "function" then
          config = config()
        end

        if type(config) == "table" then
          if vim.tbl_contains(config, "enabled") then
            enabled = config["enabled"]
            config["enabled"] = nil
          end

          if not vim.tbl_isempty(config) then
            vim.lsp.config(server, config)
          end
        end

        if enabled then
          vim.lsp.enable(server)
        end
      end
    end,
  },
  {
    "mason-org/mason.nvim",
    event = { "VeryLazy" },
    cmd = { "Mason", "MasonInstall", "MasonLog", "MasonUninstall", "MasonUpdate" },
    opts = {
      max_concurrent_installers = 8, -- default 4
      ensure_installed = {
        -- LSP
        "lua-language-server",
        "taplo",
        "yaml-language-server",
        "marksman",
        "biome",
        "cmake-language-server",
        "cpptools",
        "codelldb",
        "css-lsp",
        "cssmodules-language-server",
        "deno",
        "dockerfile-language-server",
        "bash-language-server",
        -- "efm",
        "glsl_analyzer",
        -- "prisma-language-server",
        "html-lsp",
        "json-lsp",
        "pyright",
        "ruff",
        -- "rust-analyzer",
        "stylelint-lsp",
        "typescript-language-server",
        "tectonic",
        clangd = use_mason_clangd,

        "clang-format",
        "stylua",
        "shfmt",
        "black",
        "glow",
        "isort",
        "jq",
        "tex-fmt",
        "mypy",
        "prettier",
        "shellcheck",

        "tree-sitter-cli",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)

      for k, v in pairs(opts["ensure_installed"] or {}) do
        if type(v) == "string" or (type(v) == "function" and v()) or (type(v) == "boolean" and v) then
          local key = type(v) == "string" and v or k
          local pkg_name, version = require("mason-core.package").Parse(key)

          local ok, pkg = pcall(require("mason-registry").get_package, pkg_name)

          if ok then
            if not pkg:is_installed() and not pkg:is_installing() then
              vim.notify("[mason] installing " .. key)
              pkg:install(
                { version = version },
                vim.schedule_wrap(function(success, err)
                  if success then
                    vim.notify("[mason] successfully installed " .. key)
                  else
                    vim.notify("[mason] failed to install " .. key, vim.log.levels.ERROR)
                  end
                end)
              )
            end
          else
            vim.notify("[mason]: in ensure_installed, " .. key .. " is an invalid entry", vim.log.levels.WARN)
          end
        end
      end
    end,
  },
  -- {
  -- 		"mason-org/mason-lspconfig.nvim",
  --     dependencies = {
  --
  --       { "mason-org/mason.nvim", opts = {} },
  --         "neovim/nvim-lspconfig",
  --     },
  --
  -- 		event = { "VeryLazy" },
  -- 		cmd = { "LspInstall", "LspUninstall" },
  -- 		opts = {
  -- 			ensure_installed = {
  -- 				-- LSP
  -- 				"lua_ls",
  -- 				"taplo",
  -- 				"yamlls",
  -- 				"marksman",
  -- 				"texlab",
  -- 				"cmake",
  -- 				"cssls",
  -- 				"denols",
  -- 				"dockerfile-language-server",
  -- 				"bashls",
  -- 				"glsl_analyzer",
  -- 				-- "efm",
  -- 				"html",
  -- 				"jsonls",
  -- 				"pyright",
  -- 				-- "dprint",
  -- 				-- "ruff",
  -- 				-- "rust_analyzer",
  -- 				-- "biome",
  -- 				-- "stylelint-lsp",
  -- 				"ts_ls",
  --
  -- 				clangd = function()
  -- 					return false
  -- 				end,
  -- 			},
  -- 		},
  -- 		config = function(_, opts)
  -- 			local ensure_installed = vim.tbl_deep_extend("force", opts["ensure_installed"] or {}, {})
  -- 			local ensure = {}
  --
  -- 			for k, v in pairs(ensure_installed) do
  -- 				if type(v) == "string" or (type(v) == "function" and v()) then
  -- 					ensure[#ensure + 1] = type(v) == "string" and v or k
  -- 				end
  -- 			end
  --
  -- 			opts["ensure_installed"] = ensure
  --
  -- 			require("mason-lspconfig").setup(opts)
  -- 		end,
  -- 	},
}

-- return {
-- 	{ import = "plugins.lang" },
-- 	{
-- 		"b0o/SchemaStore.nvim",
-- 		-- lazy = true,
-- 		version = false,
-- 	},
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		event = { "BufRead", "VeryLazy" },
-- 		keys = {
-- 			{ "<leader>gs", ":ClangdSwitchSourceHeader<cr>", mode = "n", silent = true, ft = { "c", "cpp" } },
-- 		},
-- 		dependencies = {
-- 			"mason.nvim",
-- 			"williamboman/mason-lspconfig.nvim",
-- 			"b0o/SchemaStore.nvim",
-- 		},
-- 		opts = function()
-- 			local util = require("lspconfig.util")
--
-- 			return {
-- 				ensure_installed = {
-- 					"lua_ls",
-- 					"taplo",
-- 					"yamlls",
-- 					"marksman",
-- 					"texlab",
-- 					"clangd",
-- 					"cmake",
-- 					"cssls",
-- 					"denols",
-- 					"bashls",
-- 					"glsl_analyzer",
-- 					"efm",
-- 					"html",
-- 					"jsonls",
-- 					"pyright",
-- 					"diagnosticls",
-- 					"dprint",
-- 					"ruff",
-- 					"rust_analyzer",
-- 					"biome",
-- 					-- "vtsls",
-- 					"ts_ls",
-- 				},
-- 				diagnostics = {
-- 					icons = {
-- 						[vim.diagnostic.severity.ERROR] = " ",
-- 						[vim.diagnostic.severity.WARN] = " ",
-- 						[vim.diagnostic.severity.HINT] = " ",
-- 						[vim.diagnostic.severity.INFO] = " ",
-- 					},
-- 					underline = true,
-- 					update_in_insert = true,
-- 					-- virtual_lines = true,
-- 					virtual_text = {
-- 						prefix = "",
-- 						source = "if_many",
-- 					},
-- 					severity_sort = true,
-- 					signs = {
-- 						text = {
-- 							-- [vim.diagnostic.severity.ERROR] = " ",
-- 							-- [vim.diagnostic.severity.WARN] = " ",
-- 							-- [vim.diagnostic.severity.HINT] = " ",
-- 							-- [vim.diagnostic.severity.INFO] = " ",
-- 							[vim.diagnostic.severity.ERROR] = "",
-- 							[vim.diagnostic.severity.WARN] = "",
-- 							[vim.diagnostic.severity.HINT] = "",
-- 							[vim.diagnostic.severity.INFO] = "",
-- 						},
-- 						-- linehl = {
-- 						-- 	[vim.diagnostic.severity.ERROR] = "DiagnosticErrorLine",
-- 						-- 	[vim.diagnostic.severity.WARN] = "DiagnosticWarnLine",
-- 						-- 	[vim.diagnostic.severity.HINT] = "DiagnosticHintLine",
-- 						-- 	[vim.diagnostic.severity.INFO] = "DiagnosticInfoLine",
-- 						-- },
-- 						-- numhl = {
-- 						-- 	[vim.diagnostic.severity.ERROR] = "DiagnosticErrorNumLine",
-- 						-- 	[vim.diagnostic.severity.WARN] = "DiagnosticWarnNumLine",
-- 						-- 	[vim.diagnostic.severity.HINT] = "DiagnosticHintNumLine",
-- 						-- 	[vim.diagnostic.severity.INFO] = "DiagnosticInfoNumLine",
-- 						-- },
-- 					},
-- 				},
-- 				inlay_hints = { enabled = false },
-- 				codelens = { enabled = false },
-- 				capabilities = {
-- 					workspace = {
-- 						fileOperations = {
-- 							didRename = true,
-- 							willRename = true,
-- 						},
-- 					},
-- 				},
-- 				format = {
-- 					formatting_options = nil,
-- 					timeout_ms = nil,
-- 				},
-- 				servers = {
-- 					lua_ls = {
-- 						-- keys = {},
-- 						settings = {
-- 							Lua = {
-- 								workspace = { checkThirdParty = false },
-- 								codeLens = { enable = false },
-- 								completion = { callSnippet = "Replace" },
-- 								doc = { privateName = { "^_" } },
-- 								hint = {
-- 									enable = true,
-- 									setType = false,
-- 									paramType = true,
-- 									paramName = "Disable",
-- 									semicolon = "Disable",
-- 									arrayIndex = "Disable",
-- 								},
-- 							},
-- 						},
-- 					},
--
-- 					taplo = {
-- 						config_file = {
-- 							enabled = true,
-- 							path = (os.getenv("XDG_CONFIG_HOME") or "~/.config") .. "/taplo.toml",
-- 						},
-- 					},
-- 					yamlls = {
-- 						capabilities = {
-- 							textDocument = {
-- 								foldingRange = {
-- 									dynamicRegistration = false,
-- 									lineFoldingOnly = true,
-- 								},
-- 							},
-- 						},
-- 						settings = {
-- 							redhat = { telemetry = { enabled = false } },
-- 							yaml = {
-- 								keyOrdering = false,
-- 								format = { enable = true },
-- 								validate = true,
-- 							},
-- 						},
-- 					},
-- 					jsonls = {
-- 						settings = {
-- 							json = {
-- 								format = { enable = true },
-- 								validate = { enable = true },
-- 								schemas = require("schemastore").json.schemas(),
-- 							},
-- 						},
-- 					},
-- 					marksman = {},
-- 					cssls = {},
-- 					biome = {
-- 						enabled = false,
-- 						root_dir = util.root_pattern({ "biome.json", "biome.jsonc", "package.json" }),
-- 					},
-- 					denols = {
-- 						root_dir = util.root_pattern({ "deno.json", "deno.jsonc" }),
-- 					},
-- 					bashls = {},
-- 					dprint = {
-- 						filetypes = { "python" },
-- 					},
-- 					ts_ls = { enabled = true },
-- 					vtsls = { enabled = false },
-- 					efm = { enabled = false },
-- 				},
-- 				setup = {
-- 					-- example to setup with typescript.nvim
-- 					-- tsserver = function(_, opts)
-- 					--   require("typescript").setup({ server = opts })
-- 					--   return true
-- 					-- end,
-- 					-- Specify * to use this function as a fallback for any server
-- 					-- ["*"] = function(server, opts) end,
-- 				},
-- 			}
-- 		end,
-- 		config = function(_, opts)
-- 			-- diagnostics signs
-- 			-- if vim.fn.has("nvim-0.10.0") == 0 then
-- 			-- 	if type(opts.diagnostics.signs) ~= "boolean" then
-- 			-- 		for severity, icon in pairs(opts.diagnostics.signs.text) do
-- 			-- 			local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
-- 			-- 			name = "DiagnosticSign" .. name
-- 			-- 			vim.fn.sign_define(name, {
-- 			--            text = icon,
-- 			--            texthl = "DiagnosticSign" .. name,
-- 			--            linehl = "DiagnosticLine" .. name,
-- 			--            numhl = "DiagnosticNum" .. name,
-- 			--
-- 			--          })
-- 			-- 		end
-- 			-- 	end
-- 			-- end
--
-- 			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
-- 			vim.g.diagnostic_icons = opts.diagnostics.icons
--
-- 			local servers = opts.servers
-- 			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
-- 			local has_blink, blink = pcall(require, "blink.cmp")
-- 			local capabilities = vim.tbl_deep_extend(
-- 				"force",
-- 				{},
-- 				vim.lsp.protocol.make_client_capabilities(),
-- 				has_cmp and cmp_nvim_lsp.default_capabilities() or {},
-- 				-- has_blink and blink.get_lsp_capabilities() or {},
-- 				opts.capabilities or {}
-- 			)
-- 			capabilities = has_blink and blink.get_lsp_capabilities(capabilities) or capabilities
--
-- 			local function setup(server)
-- 				local server_opts = vim.tbl_deep_extend("force", {
-- 					capabilities = vim.deepcopy(capabilities),
-- 				}, servers[server] or {})
-- 				if server_opts.enabled == false then
-- 					return
-- 				end
--
-- 				if opts.setup[server] then
-- 					if opts.setup[server](server, server_opts) then
-- 						return
-- 					end
-- 				elseif opts.setup["*"] then
-- 					if opts.setup["*"](server, server_opts) then
-- 						return
-- 					end
-- 				end
-- 				require("lspconfig")[server].setup(server_opts)
-- 			end
--
-- 			-- get all the servers that are available through mason-lspconfig
-- 			local have_mason, mlsp = pcall(require, "mason-lspconfig")
-- 			local all_mslp_servers = {}
-- 			if have_mason then
-- 				all_mslp_servers = vim.tbl_keys(require("mason-lspconfig").get_mappings().lspconfig_to_package)
-- 			end
--
-- 			local ensure_installed = opts.ensure_installed or {}
-- 			for server, server_opts in pairs(servers) do
-- 				if server_opts then
-- 					server_opts = server_opts == true and {} or server_opts
-- 					if server_opts.enabled ~= false then
-- 						-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
-- 						if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
-- 							setup(server)
-- 						else
-- 							ensure_installed[#ensure_installed + 1] = server
-- 						end
-- 					end
-- 				end
-- 			end
--
-- 			if have_mason then
-- 				mlsp.setup({
-- 					ensure_installed = ensure_installed,
-- 					handlers = { setup },
-- 				})
-- 			end
-- 		end,
-- 	},
-- 	{
-- 		"williamboman/mason.nvim",
-- 		cmd = "Mason",
-- 		build = ":MasonUpdate",
-- 		opts_extend = { "ensure_installed" },
-- 		opts = {
-- 			ensure_installed = {
-- 				"stylua",
-- 				"shfmt",
-- 				"black",
-- 				"blackd-client",
-- 				"docformatter",
-- 				"gitui",
-- 				"glow",
-- 				"isort",
-- 				"jq",
-- 				"latexindent",
-- 				"mypy",
-- 				"prettier",
-- 				"prettierd",
-- 				"pydocstyle",
-- 				"shellcheck",
-- 			},
-- 		},
-- 		config = function(_, opts)
-- 			require("mason").setup(opts)
-- 			local mr = require("mason-registry")
-- 			mr:on("package:install:success", function()
-- 				vim.defer_fn(function()
-- 					-- trigger FileType event to possibly load this newly installed LSP server
-- 					require("lazy.core.handler.event").trigger({
-- 						event = "FileType",
-- 						buf = vim.api.nvim_get_current_buf(),
-- 					})
-- 				end, 100)
-- 			end)
--
-- 			mr.refresh(function()
-- 				for _, tool in ipairs(opts.ensure_installed) do
-- 					local p = mr.get_package(tool)
-- 					if not p:is_installed() then
-- 						p:install()
-- 					end
-- 				end
-- 			end)
-- 		end,
-- 	},
-- 	{
-- 		"simrat39/rust-tools.nvim",
-- 		opts = function(_, opts)
-- 			if opts.tools == nil then
-- 				opts.tools = {}
-- 			end
-- 			opts.tools.on_initialized = function() end
-- 			return opts
-- 		end,
-- 	},
-- }
