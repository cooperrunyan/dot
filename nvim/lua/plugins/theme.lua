return {
  {
    "sontungexpt/witch",
    priority = 1000,
    enabled = false,
    lazy = false,
    config = function(_, opts)
      require("witch").setup(opts)
    end,
    dependencies = { {
      "LazyVim/LazyVim",
      opts = { colorscheme = "witch" },
    } },
  },
  {
    "oxfist/night-owl.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    dependencies = { {
      "LazyVim/LazyVim",
      opts = { colorscheme = "night-owl" },
    } },
    config = function()
      vim.cmd.colorscheme("night-owl")
    end,
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    dependencies = { {
      "LazyVim/LazyVim",
      opts = { colorscheme = "night-owl" },
    } },
    opts = {
      transparent = true,
      style = "night",
      styles = {
        sidebars = "transparent",
        floats = "dark",
      },
    },
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "olivercederborg/poimandres.nvim",
    enabled = true,
    opts = function()
      local p = require("poimandres.palette")
      local blend = require("poimandres.utils").blend

      return {
        disable_background = true,
        disable_float_background = true,
        disable_italics = true,
        groups = {
          border = "background1",
        },
        highlight_groups = {
          CursorLine = { bg = p.background2 },
          Visual = { bg = p.background1 },
          MiniIndentscopeSymbol = { fg = p.background1 },
          Comment = { fg = blend(p.background1, p.blueGray3, 0.25) },
        },
      }
    end,
    lazy = false,
    priority = 1000,
    dependencies = { {
      "LazyVim/LazyVim",
      opts = { colorscheme = "poimandres" },
    } },
    config = function(_, opts)
      require("poimandres").setup(opts)
      vim.cmd.colorscheme("poimandres")
    end,
  },
}
