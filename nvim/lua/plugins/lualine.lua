return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    { "andrewferrier/wrapping.nvim", optional = true },
    { "nvim-tree/nvim-web-devicons", optional = true },
  },
  opts = function()
    local lazy_status = require("lazy.status")
    local lazy = { lazy_status.updates, cond = lazy_status.has_updates }

    local branch = { "branch", icons_enabled = true, icon = "" }

    local mode = {
      "mode",
      right_padding = 2,
      fmt = function(str) return str:sub(1, 1) end,
    }

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn", "hint" },
      symbols = { error = " ", warn = " ", info = " ", hint = " " },
      colored = true,
      update_in_insert = true,
      -- always_visible = true,
    }

    local no_fmt = function()
      if vim.g.disable_autoformat or vim.b.disable_autoformat then return "no_fmt" end
      return ""
    end

    local okwrap, wrapping = pcall(require, "wrapping")

    local wrap = function()
      if not okwrap then return end
      return wrapping.get_current_mode() or ""
    end

    return {
      options = {
        disabled_filetypes = {
          ToggleTerm = {},
          NvimTree = {},
          trouble = {},
        },
        -- theme = "github_dark_default",
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { branch },
        lualine_c = { "location", diagnostics },
        lualine_x = { "searchcount", no_fmt, wrap, lazy },
        lualine_y = { "filetype" },
        lualine_z = { "filename" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filetype" },
        lualine_x = { "filename" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = {
        "neo-tree",
        "nvim-tree",
        "mason",
        "trouble",
        "man",
        "nvim-dap-ui",
        "lazy",
        "quickfix",
        "toggleterm",
      },
    }
  end,
}
