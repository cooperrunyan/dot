vim.pack.add({ "https://github.com/cooperrunyan/github-nvim-theme" })

local variant = function()
  if vim.o.background == "light" then
    return "github_light"
  else
    return "github_dark_default"
  end
end

require("github-theme").setup({
  options = {
    set_vim_background = false,
    darken = {
      floats = false,
      sidebars = { enable = false },
    },
    hide_end_of_buffer = true,
  },
  groups = {
    all = {
      MatchParen = { link = "Visual" },

      ["@label.latex"] = { link = "@string" },
      ["@punctuation.delimiter.latex"] = { link = "@conceal" },
      ["@punctuation.bracket.latex"] = { link = "@operator.latex" },

      CursorLine = { bg = "bg2" },
      NvimTreeIndentMarker = { fg = "bg3" },
      TelescopeBorder = { link = "FloatBorder" },
      -- Pmenu = { link = "FloatBorder" },
      -- PmenuSel = { link = "Visual" },

      DiagnosticUnderlineError = { bg = "palette.danger.subtle" },
      DiagnosticSignError = { bg = "palette.danger.subtle", fg = "palette.danger.fg" },
      DiagnosticUnderlineWarn = { bg = "palette.attention.subtle" },
      DiagnosticSignWarn = { bg = "palette.attention.subtle", fg = "palette.attention.fg" },
      DiagnosticUnderlineHint = { bg = "palette.neutral.subtle" },
      DiagnosticSignHint = { bg = "palette.neutral.subtle" },
      DiagnosticUnderlineInfo = { bg = "palette.accent.subtle" },
      DiagnosticSignInfo = { bg = "palette.accent.subtle", fg = "palette.accent.fg" },

      FloatBorder = { fg = "palette.border.subtle" },
      MsgSeparator = { link = "FloatBorder" },
      -- Yanked = { bg = palette.scale.gray[7] },
      Yanked = { bg = "bg3" },
      -- Search = { bg = "bg2" },
      -- Visual = { bg = "bg2" },

      -- Search = { bg = palette.scale.gray[8] },
      -- Visual = { bg = palette.scale.gray[8] },
      -- IncSearch = { bg = palette.scale.blue[6], fg = "none" },
      IncSearch = { bg = "sel0", fg = "none" },
      -- BlinkCmpSignatureHelpActiveParameter = { bg = "palette.border.default" },
      -- BlinkCmpSignatureHelpActiveParameter = { bg = palette.scale.gray[9] },
      BlinkCmpSignatureHelpActiveParameter = { bg = "bg2" },
      LspSignatureActiveParameter = { link = "BlinkCmpSignatureHelpActiveParameter" },
      BlinkCmpMenuBorder = { link = "FloatBorder" },
      BlinkCmpDocBorder = { link = "FloatBorder" },
      BlinkCmpDocSeparator = { link = "FloatBorder" },
      BlinkCmpSignatureHelpBorder = { link = "FloatBorder" },
      CmpDocumentationBorder = { link = "FloatBorder" },
      BlinkCmpDocCursorLine = { link = "Visual" },
      BlinkCmpGhostText = { link = "Comment" },
      SnacksPickerMatch = { link = "BlinkCmpLabelMatch" },
    },
  },
})

vim.cmd.colorscheme(variant())

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function(_) vim.cmd.colorscheme(variant()) end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("UserAutocommands", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "yanked",
      timeout = 200,
      priority = 900,
    })
  end,
})
