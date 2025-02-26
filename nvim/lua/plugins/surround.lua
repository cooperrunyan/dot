return {
  "kylechui/nvim-surround",
  dependencies = {
    { "folke/which-key.nvim", optional = true }
  },
  -- version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function(_, opts)
    require('nvim-surround').setup(opts)

    local ok, wk = pcall(require, "which-key")
    if not ok then
      return
    end

    wk.add({
      { mode={ "n", "x" }, "ms" },
      { mode= { "n", "x" }, "mr" },
      { mode={ "n", "x" }, "md" },
    })
  end,
  opts = {
    indent_lines = false,
    keymaps = {
      normal = "ms",
      -- normal_cur = "",
      normal_line = "mS",
      -- normal_cur_line = "",
      visual = "ms",
      visual_line = "ms",
      delete = "md",
      change = "mr",
      change_line = "mR",
    },
    highlight = {
      duration = 500
    },
    -- "begin"
    move_cursor = "",
    aliases = {
      ["a"] = ">",
      ["b"] = ")",
      ["B"] = "}",
      ["r"] = "]",
      indent_lines = false,
      ["q"] = { '"', "'", "`" },
      ["'"] = { '"', "'", "`" },
      ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
    },
  }
}
