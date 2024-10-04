-- _G.ArcOpen = function(url)
--   os.execute([[osascript -e '
--     tell application "Arc"
--       make new tab with properties {URL:"]] .. url .. [["}
--       activate
--     end tell
--   ']])
-- end

-- return {
--   {
--     "iamcco/markdown-preview.nvim",
--     keys = {
--       { "<leader>cp", false },
--       { "<leader>pp", ft = "markdown", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
--     },
--     init = function()
--       vim.cmd([[
--         let g:mkdp_preview_options = {
--           \ 'mkit': {},
--           \ 'katex': {},
--           \ 'uml': {},
--           \ 'maid': {},
--           \ 'disable_sync_scroll': 0,
--           \ 'sync_scroll_type': 'middle',
--           \ 'hide_yaml_meta': 0,
--           \ 'sequence_diagrams': {},
--           \ 'flowchart_diagrams': {},
--           \ 'content_editable': v:false,
--           \ 'disable_filename': 1,
--           \ 'toc': {}
--           \ }
--       ]])
--       vim.cmd([[
--         function ArcOpenV(url)
--           execute 'lua ArcOpen(''' . a:url . ''')'
--         endfunction
--       ]])
--       vim.g.mkdp_combine_preview = 1
--       vim.g.mkdp_browserfunc = "ArcOpenV"
--       vim.g.mkdp_theme = "light"
--     end,
--   },
-- }

return {
  {
    "iamcco/markdown-preview.nvim",
    keys = {
      { "<leader>cp", false },
       { "<leader>pp", ft = "markdown", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
     },
   },
   { "bullets-vim/bullets.vim" },
   {
    "MeanderingProgrammer/markdown.nvim"
   },
  {
    enabled = false,
  "lukas-reineke/headlines.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    -- Define custom highlight groups using Vimscript
    -- vim.cmd([[highlight Headline1 guibg=#295715 guifg=white]])
    -- vim.cmd([[highlight Headline2 guibg=#8d8200 guifg=white]])
    -- vim.cmd([[highlight Headline3 guibg=#a56106 guifg=white]])
    -- vim.cmd([[highlight Headline4 guibg=#7e0000 guifg=white]])
    -- vim.cmd([[highlight Headline5 guibg=#1e0b7b guifg=white]])
    -- vim.cmd([[highlight Headline6 guibg=#560b7b guifg=white]])
    vim.cmd([[highlight Headline1 guibg=#261A27 guifg=#FF74B8]])
    vim.cmd([[highlight Headline2 guibg=#1F1D2E guifg=#C693FF]])
    vim.cmd([[highlight Headline3 guibg=#0C202E guifg=#04B4FE]])
    vim.cmd([[highlight Headline4 guibg=#0D2128 guifg=#00C1BB]])
    vim.cmd([[highlight Headline5 guibg=#0D211E guifg=#00C15B]])
    vim.cmd([[highlight Headline6 guibg=#212520 guifg=#D9E36A]])
    -- Defines the codeblock background color to something darker
    vim.cmd([[highlight CodeBlock guibg=#09090d]])
    -- When you add a line of dashes with --- this specifies the color, I'm not
    -- adding a "guibg" but you can do so if you want to add a background color
    vim.cmd([[highlight Dash guifg=white]])

    -- Setup headlines.nvim with the newly defined highlight groups
    require("headlines").setup({
      markdown = {
        -- If set to false, headlines will be a single line and there will be no
        -- "fat_headline_upper_string" and no "fat_headline_lower_string"
        fat_headlines = false,
        --
        -- Lines added above and below the header line makes it look thicker
        -- "lower half block" unicode symbol hex:2584
        -- "upper half block" unicode symbol hex:2580
        -- fat_headline_upper_string = "▄",
        fat_headline_lower_string = "▀",

        bullets = { "◉", "○", "✸", "✿" },
        codeblock_highlight = "CodeBlock",
        dash_highlight = "Dash",
        dash_string = "-",
        quote_highlight = "Quote",
        quote_string = "┃",
        fat_headline_upper_string = "▃",
        -- fat_headline_lower_string = " ",
        --
        -- You could add a full block if you really like it thick ;)
        -- fat_headline_upper_string = "█",
        -- fat_headline_lower_string = "█",
        --
        -- Other set of lower and upper symbols to try
        -- fat_headline_upper_string = "▃",
        -- fat_headline_lower_string = "-",
        --
        headline_highlights = {
          "Headline1",
          "Headline2",
          "Headline3",
          "Headline4",
          "Headline5",
          "Headline6",
        },
      },
    })
  end,
}
}
