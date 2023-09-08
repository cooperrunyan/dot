local ok, mason = pcall(require, "mason")
if not ok then
  return
end

local m_lsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not m_lsp_ok then
  return
end

mason.setup({
	ui = {
		border = "none",
	},
})

mason_lspconfig.setup({
  automatic_installation = true,
	ensure_installed = {
		"tsserver",
		"html",
		"cssls",
		"denols",
		"dockerls",
		"jsonls",
		"lua_ls",
		"rust_analyzer",
		"yamlls",
	},
})
