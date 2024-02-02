return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    version = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-git",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

      local cmp = require("cmp")
      local lspkind = require("lspkind")

      local opts = {
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 60,
            ellipsis_char = "...",
          }),
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          -- ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping.confirm({ select = false }),
        }),

        sources = cmp.config.sources({
          { name = "crates" },
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "luasnip" },
        }, {
          { name = 'buffer' },
        }
        ),
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
      }
      cmp.setup(opts)


      opts.sources = cmp.config.sources({
        { name = "git" }
      }, {
        { name = "buffer" }
      })
      cmp.setup.filetype('gitcommit', opts)

      opts.sources = cmp.config.sources({
        { name = "neorg" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" }
      })
      cmp.setup.filetype('norg', opts)


      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        }
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
          },
          {
            { name = "cmdline" }
          })
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    lazy = true,
    opts = {
      delete_check_events = "TextChanged",
      history = true,
    },
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<s-tab>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    },
  },
}
