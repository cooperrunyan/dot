local ok, luasnip = pcall(require, "luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

luasnip.config.set_config({
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
})

vim.cmd[[
  " Expand or jump in insert mode
  imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'

  " Jump forward through tabstops in visual mode
  smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

  " Jump backward through snippet tabstops with Shift-Tab
  imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
  smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'

  imap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
  smap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
]]

local ls = luasnip
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local line_begin = require("luasnip.extras.expand_conditions").line_begin

local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end
local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
local in_text = function()
  return not in_mathzone()
end
local in_comment = function()
  return vim.fn['vimtex#syntax#in_comment']() == 1
end
local in_env = function(name)
    is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
local in_equation = function()
    return in_env('equation')
end
local in_itemize = function()
    return in_env('itemize')
end
local in_tikz = function()
    return in_env('tikzpicture')
end

ls.add_snippets("tex", {
  s(
    "hi",
    { t("Hello, world!") }
  ),

 s({trig=";a", snippetType="autosnippet"},
    {
      t("\\alpha"),
    }
  ),
  s({trig=";b", snippetType="autosnippet"},
    {
      t("\\beta"),
    }
  ),
  s({trig=";g", snippetType="autosnippet"},
    {
      t("\\gamma"),
    }
  ),
  s({trig="\\eq", dscr="A LaTeX equation environment"},
    fmta(
      [[
        \begin{equation}
            <>
        \end{equation}
      ]],
      { i(1) },
    ),
    {condition = line_begin}
  ),
  s({trig="fr", dscr="Expands 'fr' into '\frac{}{}'"},
    fmta(
      "\\frac{<>}{<>}",
      { i(1), i(2) },
    ),
    {condition = in_mathzone}
  ),
  s({trig="[", dscr="Left bracket"},
    fmta("\\left["),
    {condition = in_mathzone}
  ),
  s({trig="]", dscr="Right bracket"},
    fmta("\\right]"),
    {condition = in_mathzone}
  ),
  s({trig="(", dscr="Left parentheses"},
    fmta("\\left("),
    {condition = in_mathzone}
  ),
  s({trig=")", dscr="Right parentheses"},
    fmta("\\right)"),
    {condition = in_mathzone}
  ),
  s({trig="<", dscr="Left angle"},
    fmta("\\left<"),
    {condition = in_mathzone}
  ),
  s({trig=">", dscr="Right angle"},
    fmta("\\right>"),
    {condition = in_mathzone}
  ),
  s({trig="{", dscr="Left curly"},
    fmta("\\left{"),
    {condition = in_mathzone}
  ),
  s({trig="}", dscr="Right curly"},
    fmta("\\right}"),
    {condition = in_mathzone}
  ),
  s({trig="beg", snippetType="autosnippet"},
    fmta(
      [[
        \begin{<>}
            <>
        \end{<>}
      ]],
      {
        i(1),
        i(2),
        rep(1),
      }
    ),
    {condition = line_begin}
  ),
  s({trig="tik"},
    fmta(
      [[
        \begin{tikzpicture}
            <>
        \end{tikzpicture}
      ]],
      {
        i(1),
      }
    ),
    {condition = line_begin}
  ),
  s({trig="\\hr", dscr="The hyperref package's href{}{} command (for url links)"},
    fmta(
      "\\href{<>}{<>}",
      {
        i(1, "url"),
        i(2, "display name"),
      }
    )
  ),
  s({trig = "([^%a])mm", wordTrig = false, regTrig = true},
    fmta(
      "<>$<>$",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
  s({trig = '([^%a])ee', regTrig = true, wordTrig = false},
    fmta(
      "<>e^{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual)
      }
    )
  ),
  s({trig = "draw"},
    fmta(
      "\\draw [<>] ",
      {
        i(1, "params"),
      }
    ),
    { condition = in_tikz }
  ),
  s({trig = "df", snippetType = "autosnippet"},
    { t("\\diff") },
    { condition = in_mathzone }
  ),
})
