local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
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
	completion = {
    autocomplete = {
      cmp.TriggerEvent.TextChanged,
      cmp.TriggerEvent.InsertEnter,
    },
    completeopt = "menu,noselect",
    -- completeopt = "menuone,noinsert,noselect",
    keyword_length = 1,
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
    { name = "luasnip" },
    { name = "omni" },
    { name = "buffer", keyword_length = 3 },
    { name = "spell",
      keyword_length = 4,
      option = {
          keep_all_entries = false,
          enable_in_context = function()
              return true
          end
      },
    },
    { name = "latex_symbols",
      filetype = { "tex", "latex" },
      option = { cache = true }, -- avoids reloading each time
    },
    { name = "path" },
	}),
	performance = {
     trigger_debounce_time = 500,
     throttle = 550,
     fetching_timeout = 80,
  },
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
