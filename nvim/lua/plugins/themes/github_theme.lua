return {
  "projekt0n/github-nvim-theme",
  name = "github-theme",
  enabled = true,
  lazy = false,
  priority = 1000,
  config = function(_, opts)
    require("github-theme").setup(opts)
    vim.cmd("colorscheme " .. opts.variant)
  end,
  opts = function()
    local variant = "github_dark_default"

    if vim.opt.background == "light" then variant = "github_light" end

    local palette = require("github-theme.palette").load(variant)

    return {
      variant = variant,
      options = {
        darken = {
          floats = false,
          sidebars = { enable = false },
        },
        hide_end_of_buffer = true,
      },
      groups = {
        all = {
          MatchParen = { link = "Visual" },
          -- MatchParen = { bg = palette.scale.gray[9] },
          -- Special = { link = "@constant" },
          -- Special = { link = "@function" },

          ["@label.latex"] = { link = "@string" },
          ["@punctuation.delimiter.latex"] = { link = "@conceal" },
          ["@punctuation.bracket.latex"] = { link = "@operator.latex" },

          CursorLine = { bg = "bg2" },
          NeoTreeDirectoryIcon = { fg = "bg4" },
          NeoTreeIndentMarker = { fg = "bg3" },
          NvimTreeIndentMarker = { fg = "bg3" },
          NeoTreeGitAdded = { link = "Normal" },
          NeoTreeGitIgnored = { link = "Comment" },
          NeoTreeGitUntracked = { fg = "palette.green" },
          NeoTreeGitModified = { fg = "palette.yellow" },
          NeoTreeGitConflict = { fg = "palette.red" },
          NeoTreeGitDeleted = { fg = "palette.red" },
          TelescopeBorder = { link = "FloatBorder" },
          -- Pmenu = { link = "FloatBorder" },
          -- PmenuSel = { link = "Visual" },

          DiagnosticErrorLine = { bg = palette.danger.subtle },
          DiagnosticErrorNumLine = { bg = palette.danger.subtle, fg = palette.danger.fg },
          DiagnosticWarnLine = { bg = palette.attention.subtle },
          DiagnosticWarnNumLine = { bg = palette.attention.subtle, fg = palette.attention.fg },
          DiagnosticHintLine = { bg = palette.neutral.subtle },
          DiagnosticHintNumLine = { bg = palette.neutral.subtle },
          DiagnosticInfoLine = { bg = palette.accent.subtle },
          DiagnosticInfoNumLine = { bg = palette.accent.subtle, fg = palette.accent.fg },
          FloatBorder = { fg = palette.border.subtle },
          MsgSeparator = { link = "FloatBorder" },
          Yanked = { bg = palette.scale.gray[7] },
          Search = { bg = palette.scale.gray[8] },
          Visual = { bg = palette.scale.gray[8] },
          IncSearch = { bg = palette.scale.blue[6], fg = "none" },
          BlinkCmpSignatureHelpActiveParameter = { bg = palette.scale.gray[9] },
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
    }
  end,
}
