--- @type vim.lsp.Config
return {
  cmd = { "clangd", "--clang-tidy", "--background-index", "--query-driver=/usr/bin/gcc,/usr/bin/g++" },
}
