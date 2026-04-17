--- @type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    local util = require("lspconfig.util")
    local f = vim.uri_to_fname(vim.uri_from_bufnr(bufnr))
    if util.root_pattern({ "deno.json", "deno.jsonc" })(f) ~= nil then return end
    local r = util.root_pattern({ "tsconfig.json", "jsconfig.json", "package.json", ".git" })(f)
    if r then on_dir(r) end
  end,
}
