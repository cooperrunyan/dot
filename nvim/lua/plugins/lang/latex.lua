return {
  {
    "lervag/vimtex",
    ft = { "tex" },
    lazy = false,
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saghen/blink.cmp",
      "micangl/cmp-vimtex",
    },
    config = function()
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

      local ls = require("luasnip")

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

      -- local group = vim.api.nvim_create_augroup("vimtex_mac", {})
      --
      -- vim.api.nvim_create_autocmd("BufWritePost", {
      --   group = group,
      --   desc = "Build on save",
      --   pattern = { "*.tex" },
      --   command = "VimtexCompile",
      --   once = vim.g.vimtex_compiler_method ~= "tectonic",
      -- })
      --
      -- vim.api.nvim_create_autocmd("User", {
      --   group = group,
      --   pattern = "VimtexEventQuit",
      --   callback = function()
      --     local cmd = [[
      --       tell application "Skim"
      --         close (every document whose name is "]] .. vim.b.vimtex.name .. [[.pdf")
      --         if (count of documents) is 0 then quit
      --       end tell
      --     ]]
      --     vim.system({ "osascript", "-e", cmd }):wait()
      --   end,
      -- })
    end,
    keys = {
      { "<leader>v", group = "Preview" },
      { "<localLeader>l", "", desc = "+vimtex", ft = "tex" },
      { "<leader>vv", ":VimtexView<CR>", desc = "Latex view", ft = "tex" },
      { "<leader>vc", ":VimtexCompile<CR>", desc = "Compile Latex", ft = "tex" },
      { "<leader>vC", ":VimtexCompileSS<CR>", desc = "Compile Latex Once", ft = "tex" },
      { "<leader>vO", ":VimtexCompileOutput<CR>", desc = "Show Latex Output", ft = "tex" },
    },
  },
}
