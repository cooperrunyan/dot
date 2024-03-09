_G.ArcOpen = function(url)
  os.execute([[osascript -e '
    tell application "Arc"
      make new tab with properties {URL:"]] .. url .. [["}
      activate
    end tell
  ']])
end

return {
  {
    "iamcco/markdown-preview.nvim",
    keys = {
      { "<leader>cp", false },
      { "<leader>pp", ft = "markdown", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
    },
    init = function()
      vim.cmd([[
        let g:mkdp_preview_options = {
          \ 'mkit': {},
          \ 'katex': {},
          \ 'uml': {},
          \ 'maid': {},
          \ 'disable_sync_scroll': 0,
          \ 'sync_scroll_type': 'middle',
          \ 'hide_yaml_meta': 0,
          \ 'sequence_diagrams': {},
          \ 'flowchart_diagrams': {},
          \ 'content_editable': v:false,
          \ 'disable_filename': 1,
          \ 'toc': {}
          \ }
      ]])
      vim.cmd([[
        function ArcOpenV(url)
          execute 'lua ArcOpen(''' . a:url . ''')'
        endfunction
      ]])
      vim.g.mkdp_combine_preview = 1
      vim.g.mkdp_browserfunc = "ArcOpenV"
      vim.g.mkdp_theme = "light"
    end,
  },
}
