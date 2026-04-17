vim.pack.add({
  { src = "https://github.com/kylechui/nvim-surround", version = "v3.1.8" },
})

require("nvim-surround").setup({
  indent_lines = false,
  keymaps = {
    normal = "ms",
    -- normal_cur = "",
    normal_line = "mS",
    -- normal_cur_line = "",
    visual = "ms",
    visual_line = "mS",
    delete = "md",
    change = "mr",
    change_line = "mR",
  },
  highlight = { duration = 500 },
  move_cursor = "sticky",
  aliases = {
    ["a"] = ">",
    ["b"] = { ")", "]", "}" },
    ["q"] = { '"', "'", "`" },
    ["'"] = { '"', "'", "`" },
    ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
  },
  surrounds = {
    ["("] = {
      add = { "(", ")" },
      find = function() return require("nvim-surround").get_selection({ motion = "a(" }) end,
      delete = "^(.)().-(.)()$",
    },
    ["{"] = {
      add = { "{", "}" },
      find = function() return require("nvim-surround").get_selection({ motion = "a{" }) end,
      delete = "^(.)().-(.)()$",
    },
    ["<"] = {
      add = { "<", ">" },
      find = function() return require("nvim-surround").get_selection({ motion = "a<" }) end,
      delete = "^(.)().-(.)()$",
    },
    ["["] = {
      add = { "[", "]" },
      find = function() return require("nvim-surround").get_selection({ motion = "a[" }) end,
      delete = "^(.)().-(.)()$",
    },
  },
})
