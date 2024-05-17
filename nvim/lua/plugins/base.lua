return {
  { "j-hui/fidget.nvim" },
  { "jghauser/mkdir.nvim" },
  { "ap/vim-css-color" },
  { "yorickpeterse/nvim-pqf" },
  { "ku1ik/vim-pasta" },
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
