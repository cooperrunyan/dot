return {
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
    init = function()
      vim.g.rustaceanvim = {
        tools = {
          code_actions = {
            ui_select_fallback = true,
          },
          float_win_config = {
            border = "rounded",
          },
        },
        server = {
          on_attach = function(_, bufnr)
            vim.keymap.set(
              "n",
              "<leader>a",
              function() vim.cmd.RustLsp("codeAction") end,
              { desc = "Code Action", buffer = bufnr }
            )
            vim.keymap.set(
              "n",
              "<leader>dr",
              function() vim.cmd.RustLsp("debuggables") end,
              { desc = "Rust Debuggables", buffer = bufnr }
            )
          end,
          default_settings = {
            ["rust-analyzer"] = {
              server = {
                extraEnv = {
                  -- Because of esp32
                  -- RUSTUP_TOOLCHAIN = "stable",
                },
              },
              -- files = { watcher = "server" },
              -- check = {
              --   command = "clippy",
              --   extraArgs = { "--no-deps" },
              -- },
              -- checkOnSave = true,
              -- -- procMacro = { enable = true },
              -- assists = { preferSelf = true },
              -- cargo = {
              --   -- allFeatures = false,
              --   -- allTargets = false,
              --   -- loadOutDirsFromCheck = true,
              --   -- buildScripts = { enable = true },
              -- },
              -- diagnostics = { enable = true },
            },
          },
        },
      }
    end,
  },
}
