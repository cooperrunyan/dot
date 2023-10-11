local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
  return
end

local cmp_window_ok, cmp_window = pcall(require, "cmp.config.window")
if not cmp_window_ok then
  return
end

local snip_ok, luasnip = pcall(require, "luasnip")
if not snip_ok then
  return
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp_window.bordered(),
    documentation = cmp_window.bordered(),
  },
  completion = {
    -- autocomplete = {
    --   cmp.TriggerEvent.TextChanged,
    --   cmp.TriggerEvent.InsertEnter,
    -- },
    -- completeopt = "menu,noselect",
    completeopt = "menuone,noinsert,noselect",
    -- keyword_length = 1,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping.confirm({ select = false }),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "crates" },
    { name = "luasnip" },
    { name = "omni" },
    { name = "path" },
    { name = "buffer",  keyword_length = 3 },
  }),
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdLine(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdLine(),
  sources = cmp.config.sources({
    { name = "path" },
    { name = "cmdline" },
  }),
})
