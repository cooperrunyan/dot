return {
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  { import = "lazyvim.plugins.extras.test.core" },
  { import = "lazyvim.plugins.extras.vscode" },
  { import = "lazyvim.plugins.extras.coding.yanky" },
  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.tex" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.lsp.none-ls" },
  { "j-hui/fidget.nvim" },
  { "jghauser/mkdir.nvim" },
  { "ap/vim-css-color" },
  { "yorickpeterse/nvim-pqf" },
  { "ku1ik/vim-pasta" },
  { "wellle/targets.vim" },
  { "alec-gibson/nvim-tetris", cmd = "Tetris" },
  -- {
  --   "CosmicNvim/cosmic-ui",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   opts = { border_style = "rounded" },
  -- },

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

  {
    "folke/which-key.nvim",
    keys = {
      { "<leader><space>", ":WhichKey <CR><leader>" },
    },
    opts = function(_, opts)
      opts.triggers = {}
      return opts
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    opts = {
      open_mapping = "<c-t>",
      direction = "horizontal",
    },
  },

  {
    "gbprod/yanky.nvim",
    keys = {
      { "<leader>p", false },
      -- stylua: ignore
      { "<leader>yh", function() require("telescope").extensions.yank_history.yank_history({ }) end, desc = "Open Yank History" },
    },
  },
}
