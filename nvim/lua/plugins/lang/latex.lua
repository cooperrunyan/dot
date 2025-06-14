return {
  {
    "lervag/vimtex",
    ft = { "tex" },
    lazy = true,
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saghen/blink.cmp",
      "micangl/cmp-vimtex",
    },
    config = function()
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_view_enabled = 1
      vim.g.vimtex_view_automatic = 1
      vim.g.vimtex_skim_sync = 1
      vim.g.vimtex_view_general_options = "-r @line @pdf @tex"
      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_compiler_method = "tectonic"
      vim.g.vimtex_compiler_latexmk = {
        aux_dir = "build/artifacts",
        out_dir = "build",
        callback = 1,
        continuous = 1,
        executable = "latexmk",
        hooks = {},
        options = {
          "-pdf",
          "-interaction=nonstopmode",
          "-synctex=1",
          "-auxdir=build/artifacts",
          "-outdir=build",
        },
      }
      vim.g.vimtex_compiler_tectonic = {
        hooks = {},
        options = {
          "-X",
          "compile",
        },
      }

      vim.cmd("filetype plugin indent on")
      vim.cmd("syntax enable")

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

      local as = function(trig, ...)
        return s({ trig = trig, snippetType = "autosnippet" }, ...)
      end

      local in_mathzone = function()
        return vim.fn["vimtex#syntax#in_mathzone"]() == 1
      end

      ls.add_snippets("tex", {
        as("\\frac", { t("\\frac{ "), i(1), t(" }{ "), i(2), t(" }") }, { condition = in_mathzone() }),
        as("\\[", { t("\\[ "), i(1), t(" \\]") }),
        as("\\left", { t("\\left( "), i(1), t(" \\right)") }, { condition = in_mathzone() }),
        as("$$", { t("$ "), i(1), t(" $") }),
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

      local group = vim.api.nvim_create_augroup("vimtex_mac", {})

      vim.api.nvim_create_autocmd("BufWritePost", {
        group = group,
        desc = "Build on save",
        pattern = { "*.tex" },
        command = "VimtexCompile",
        once = vim.g.vimtex_compiler_method ~= "tectonic",
      })

      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "VimtexEventQuit",
        callback = function()
          local cmd = [[  
            tell application "Skim"	
              close (every document whose name is "]] .. vim.b.vimtex.name .. [[.pdf") 
              if (count of documents) is 0 then quit 
            end tell 
          ]]
          vim.system({ "osascript", "-e", cmd }):wait()
        end,
      })
    end,
    keys = {
      { "<leader>v", group = "Preview" },
      { "<localLeader>l", "", desc = "+vimtex", ft = "tex" },
      { "<leader>vv", ":VimtexView<CR>", desc = "Latex view", ft = "tex" },
    },
  },
}
