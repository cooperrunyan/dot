vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_compiler_latexmk = {
    callback = 1,
    continuous = 1,
    executable = "latexmk",
    options = {
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
    },
}

vim.g.vimtex_imaps_enabled = 0
-- Do not open pdfviwer on compile
vim.g.vimtex_view_automatic = 0
-- Disable conceal
vim.g.vimtex_syntax_conceal = {
    accents = 0,
    cites = 0,
    fancy = 0,
    greek = 0,
    math_bounds = 0,
    math_delimiters = 0,
    math_fracs = 0,
    math_super_sub = 0,
    math_symbols = 0,
    sections = 0,
    styles = 0,
}

vim.g.vimtex_quickfix_ignore_mode = 0
vim.g.vimtex_compiler_progname = "nvr"

vim.g.vimtex_view_general_viewer = "SumatraPDF"
vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"

vim.g.vimtex_quickfix_mode = 0

vim.g.vimtex_fold_enabled = 1
vim.g.vimtex_fold_manual = 1
vim.g.vimtex_fold_types = {
    cmd_addplot = {
        cmds = { "addplot[+3]?" },
    },
    cmd_multi = {
        cmds = {
            "%(re)?new%(command|environment)",
            "providecommand",
            "presetkeys",
            "Declare%(Multi|Auto)?CiteCommand",
            "Declare%(Index)?%(Field|List|Name)%(Format|Alias)",
        },
    },
    cmd_single = {
        cmds = { "hypersetup", "tikzset", "pgfplotstableread", "lstset" },
    },
    cmd_single_opt = {
        cmds = { "usepackage", "includepdf" },
    },
    comments = {
        enabled = 0,
    },
    env_options = vim.empty_dict(),
    envs = {
        blacklist = {},
        whitelist = {
            "figure",
            "frame",
            "table",
            "example",
            "answer",
            "titlepage",
            "cvskills",
            "cventries",
            "cvhonors",
        },
    },
    items = {
        enabled = 0,
    },
    markers = vim.empty_dict(),
    preamble = {
        enabled = 0,
    },
    sections = {
        parse_levels = 0,
        parts = { "appendix", "frontmatter", "mainmatter", "backmatter" },
        sections = {
            "%(add)?part",
            "%(chapter|addchap)",
            "%(section|section\\*)",
            "%(subsection|subsection\\*)",
            "%(subsubsection|subsubsection\\*)",
            "paragraph",
        },
    },
}

vim.cmd[[
" Use Tab to expand and jump through snippets
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

" Use Shift-Tab to jump backwards through snippets
imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
]]
