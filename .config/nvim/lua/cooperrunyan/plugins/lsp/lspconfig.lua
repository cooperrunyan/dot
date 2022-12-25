local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local typescript = require("typescript")

local on_attach = function(client, buf)
  local opts = { noremap = true, silent = true, buffer = buf }

  vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
  vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()", opts)
  vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
  vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
  vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostis<CR>", opts)
  vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
  vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
  vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
  vim.keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)

  if client.name == "tsserver" then
    vim.keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>")
  end
end

local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig["html"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

typescript.setup({
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
  }
})


lspconfig["cssls"].setup({
  capabilities = capabilities,
  on_attach = on_attach
})

lspconfig["denols"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
})

lspconfig["dockerls"].setup({
  capabilities = capabilities,
  on_attach = on_attach
})

lspconfig["gopls"].setup({
  capabilities = capabilities,
  on_attach = on_attach
})

lspconfig["jsonls"].setup({
  capabilities = capabilities,
  on_attach = on_attach
})

lspconfig["marksman"].setup({
  capabilities = capabilities,
  on_attach = on_attach
})

lspconfig["sumneko_lua"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        }
      }
    }
  }
})
