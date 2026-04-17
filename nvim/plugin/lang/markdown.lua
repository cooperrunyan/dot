-- ft markdown

vim.pack.add({
  "https://github.com/iamcco/markdown-preview.nvim",
  "https://github.com/bullets-vim/bullets.vim",
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "markdown-preview" and kind == "update" then
      if not ev.data.active then vim.cmd.packadd("markdown-preview") end
      vim.fn["mkdp#util#install"]()
    end
  end,
})

vim.g.mkdp_preview_options = {
  disable_filename = 1,
}

vim.g.mkdp_page_title = "${name}"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(ev)
    vim.keymap.set("n", "<leader>vv", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle Preview", buf = ev.buf })
  end,
})

vim.cmd([[do FileType]])
