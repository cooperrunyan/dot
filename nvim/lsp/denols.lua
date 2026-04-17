--- @type vim.lsp.Config
return {
  root_markers = { "deno.json", "deno.jsonc" },
  root_dir = function(bufnr, on_dir)
    local pattern = require("lspconfig.util").root_pattern({ "deno.json", "deno.jsonc" })
    local dir = pattern(vim.uri_to_fname(vim.uri_from_bufnr(bufnr)))
    if dir ~= nil then on_dir(dir) end
  end,
}
