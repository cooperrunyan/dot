vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lualine/lualine.nvim",
})

local branch = { "branch", icons_enabled = true, icon = "" }

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
  -- 󰉥  
  --      󰁨 󱀌 󱀍
  function() return (vim.g.disable_autoformat or vim.b.disable_autoformat) and "  " or "  " end,
  on_click = function(_, _, mods) require("util.fmt_toggle").toggle(string.find(mods, "s") or string.find(mods, "c")) end,
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
    lualine_x = { "searchcount", no_fmt },
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
    "nvim-tree",
    "mason",
    "man",
    "quickfix",
    "toggleterm",
  },
})
