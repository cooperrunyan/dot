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
          if use_mason_clangd then return {} end
          return { mason = false }
        end,
        -- cmake = {},
        neocmake = {
          single_file_support = true,
          init_options = {
            format = { enable = true },
            lint = { enable = true },
            scan_cmake_in_package = true,
            enable_external_cmake_lint = true,
          },
          capabilities = {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
                relative_pattern_support = true,
              },
            },
            textDocument = {
              completion = {
                completionItem = {
                  snippetSupport = true,
                },
              },
            },
          },
        },
        cssls = {},
        cssmodules_ls = {},
        bashls = {},
        glsl_analyzer = {},
        dockerls = {},
        html = {},
        pyright = {},
        ruff = {},
        rust_analyzer = {},
        lemminx = {},
        biome = { enabled = false },
        denols = {
          root_markers = { "deno.json", "deno.jsonc" },
          root_dir = function(bufnr, on_dir)
            local pattern = require("lspconfig.util").root_pattern({ "deno.json", "deno.jsonc" })
            local dir = pattern(vim.uri_to_fname(vim.uri_from_bufnr(bufnr)))
            if dir ~= nil then on_dir(dir) end
          end,
        },
        ts_ls = {
          root_dir = function(bufnr, on_dir)
            local util = require("lspconfig.util")
            local f = vim.uri_to_fname(vim.uri_from_bufnr(bufnr))
            if util.root_pattern({ "deno.json", "deno.jsonc" })(f) ~= nil then return end
            local r = util.root_pattern({ "tsconfig.json", "jsconfig.json", "package.json", ".git" })(f)
            if r then on_dir(r) end
          end,
        },
      },
    },
    config = function(_, opts)
      for server, config in pairs(opts.servers) do
        local enabled = config ~= nil and config ~= false

        if type(config) == "function" then config = config() end

        if type(config) == "table" then
          if vim.tbl_contains(config, "enabled") then
            enabled = config["enabled"]
            config["enabled"] = nil
          end

          if not vim.tbl_isempty(config) then vim.lsp.config(server, config) end
        end

        if enabled then vim.lsp.enable(server) end
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
        -- "stylelint-lsp",
        "typescript-language-server",
        "lemminx",
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
}
