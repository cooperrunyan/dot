-- ft tex

vim.pack.add({
  "https://github.com/lervag/vimtex",
  "https://github.com/L3MON4D3/LuaSnip",
})

vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }
-- vim.g.vimtex_compiler_silent = true
vim.g.vimtex_view_method = "skim"
vim.g.vimtex_view_enabled = true
vim.g.vimtex_view_automatic = true
vim.g.vimtex_complete_enabled = false
vim.g.vimtex_skim_sync = true -- Forward search after compilation
vim.g.vimtex_skim_activate = false -- Focus skim window
vim.g.vimtex_skim_no_select = true
-- vim.g.vimtex_view_general_options = "-r @line @pdf @tex"
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_mappings_enabled = false -- Disable default mappings
vim.g.tex_flavor = "latex"
-- vim.g.vimtex_compiler_method = "tectonic"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_format_enabled = false -- Enable formatting with latexindent
-- vim.g.vimtex_format_program = 'latexindent'
-- Indentation settings
vim.g.vimtex_indent_enabled = false -- Disable auto-indent from Vimtex
vim.g.tex_indent_items = false -- Disable indent for enumerate
vim.g.tex_indent_brace = false -- Disable brace indent
vim.g.vimtex_compiler_latexmk = {
  aux_dir = "build",
  out_dir = "build",
  build_dir = "build",
  options = {
    "-interaction=batchmode",
    -- "-interaction=nonstopmode",
    "-synctex=1",
    "-file-line-error",
    "-auxdir=build",
    "-outdir=build",
    "-shell-escape",
    "-time",
  },
}
-- vim.g.vimtex_compiler_latexmk_engines = {
--   ["_"] = "-lualatex",
-- }
vim.g.vimtex_compiler_tectonic = {
  out_dir = "build",
  options = {
    "-X",
    "compile",
    "--keep-intermediates",
    "--keep-logs",
    "--synctex",
  },
}

vim.g.vimtex_quickfix_ignore_filters = { -- Filter out common noise
  "Underfull",
  "Overfull",
  "specifier changed to",
  -- 'Token not allowed in a PDF string',
  "Package hyperref Warning",
}
vim.g.vimtex_log_ignore = { -- Suppress specific log messages
  "Underfull",
  "Overfull",
  "specifier changed to",
  -- 'Token not allowed in a PDF string',
}

-- vim.cmd("filetype plugin indent on")
-- vim.cmd("syntax enable")

local ok, ls = pcall(require, "luasnip")
if ok then
  local s = ls.snippet
  local sn = ls.snippet_node
  local t = ls.text_node
  local i = ls.insert_node
  local f = ls.function_node
  local d = ls.dynamic_node
  local fmt = require("luasnip.extras.fmt").fmt
  local fmta = require("luasnip.extras.fmt").fmta
  local rep = require("luasnip.extras").rep

  local as = function(trig, ...) return s({ trig = trig, snippetType = "autosnippet" }, ...) end

  local in_mathzone = function() return vim.fn["vimtex#syntax#in_mathzone"]() == 1 end

  ls.add_snippets("tex", {
    as("\\frac", { t("\\frac{"), i(1), t("}{"), i(2), t("}") }, { condition = in_mathzone() }),
    -- as("\\[", { t("\\[ "), i(1), t(" \\]") }),
    as("\\left", { t("\\left( "), i(1), t(" \\right)") }, { condition = in_mathzone() }),
    -- as("$$", { t("$ "), i(1), t(" $") }),
    as(
      "\\begin",
      fmta(
        [[
          \begin{<>}
              <>
          \end{<>}
        ]],
        { i(1), i(2), rep(1) }
      )
    ),
  })

  ls.setup({
    history = true,
    delete_check_events = "TextChanged",
    enable_autosnippets = true,
    update_events = "TextChanged,TextChangedI",
  })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function(ev)
    vim.keymap.set("n", "<leader>vv", ":VimtexView<cr>", { desc = "Latex view", buf = ev.buf })
    vim.keymap.set("n", "<leader>vc", ":VimtexCompile<cr>", { desc = "Compile Latex", buf = ev.buf })
    vim.keymap.set("n", "<leader>vC", ":VimtexCompileSS<cr>", { desc = "Compile Latex once", buf = ev.buf })
    vim.keymap.set("n", "<leader>vO", ":VimtexCompileOutput<cr>", { desc = "Show Latex output", buf = ev.buf })
  end,
})
