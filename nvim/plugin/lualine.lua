vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lualine/lualine.nvim",
})

local branch = { "branch", icons_enabled = true, icon = "" }
local filetype = { "filetype", icon_only = true }

local mode = {
  "mode",
  right_padding = 2,
  fmt = function(str) return str:sub(1, 1) end,
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", "hint", "info" },
  -- symbols = { error = " ", warn = " ", info = " ", hint = " " },
  symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
  colored = true,
  update_in_insert = true,
  -- always_visible = true,
}

local no_fmt = {
  -- 󰉥      
  --      󰁨 󱀌 󱀍
  function() return " " .. ((vim.g.disable_autoformat or vim.b.disable_autoformat) and " " or " ") end,
  -- color = function() return (vim.g.disable_autoformat or vim.b.disable_autoformat) and "Comment" or "Normal" end,
  on_click = function(_, _, mods) require("util.fmt_toggle").toggle(string.find(mods, "s") or string.find(mods, "c")) end,
  padding = 1,
}

local markdown_preview = {
  function()
    local ok, rm = pcall(require, "render-markdown")
    if ok then return "  " .. (rm.get() and " " or " ") end
  end,
  on_click = function(_, _, _)
    require("render-markdown").toggle()
    require("lualine").refresh({
      scope = "all",
      place = { "statusline" },
      trigger = "unknown",
    })
  end,
  padding = 1,
}

require("lualine").setup({
  options = {
    theme = "auto",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { branch },
    lualine_c = { "location", diagnostics },
    lualine_x = { "searchcount", markdown_preview, no_fmt },
    lualine_y = { filetype },
    lualine_z = { "filename" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filetype },
    lualine_x = { "filename" },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {
    "nvim-tree",
    "mason",
    "man",
    "quickfix",
    "toggleterm",
  },
})
