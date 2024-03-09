vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = { "*" },
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
      vim.cmd(":startinsert")
    end
  end,
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  callback = function()
    for _, buffers in ipairs(vim.fn.getbufinfo()) do
      local filetype = vim.api.nvim_buf_get_option(buffers.bufnr, "filetype")
      if filetype == "toggleterm" then
        vim.api.nvim_create_autocmd({ "ExitPre", "QuitPre", "WinClosed" }, {
          buffer = buffers.bufnr,
          command = "q!",
        })
      end
    end
  end,
})
