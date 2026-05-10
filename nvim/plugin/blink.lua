vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
})

require("blink.cmp").setup({
  keymap = {
    preset = "super-tab",
    -- preset = "enter",
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-h>"] = { "show_signature", "hide_signature", "fallback" },
    ["<down>"] = { "select_next", "fallback" },
    ["<up>"] = { "select_prev", "fallback" },
    -- ["<tab>"] = { "accept", "snippet_forward", "fallback" },
    -- ["<esc>"] = { "cancel", "fallback" },
  },
  term = { enabled = false },
  cmdline = {
    enabled = true,
    keymap = {
      preset = "cmdline",
      ["<C-j>"] = { "select_next" },
      ["<C-k>"] = { "select_prev" },
      ["<C-space>"] = { "show", "cancel" },
      ["<down>"] = { "select_next", "fallback" },
      ["<up>"] = { "select_prev", "fallback" },
      -- ["<tab>"] = { "accept", "fallback" },
      ["<tab>"] = { "show", "select_and_accept" },
    },
    completion = {
      menu = { auto_show = true },
    },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono", -- "normal"
  },
  signature = {
    enabled = true,
    window = {
      show_documentation = true,
    },
    trigger = {
      enabled = true,
      show_on_insert = true,
    },
  },
  completion = {
    accept = { auto_brackets = { enabled = false } },
    menu = {
      -- scrollbar = false,
      draw = {
        -- columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
        treesitter = { "lsp" },

        -- components = {
        --   label = {
        --     text = function(ctx) return require("colorful-menu").blink_components_text(ctx) end,
        --     highlight = function(ctx) return require("colorful-menu").blink_components_highlight(ctx) end,
        --   },
        -- },
      },
    },
    -- ghost_text = { enabled = false },
    documentation = { auto_show = true },
    list = {
      selection = {
        preselect = function() return not require("blink.cmp").snippet_active() end,
        auto_insert = false,
      },
    },
  },
  sources = {
    default = {
      "lsp",
      -- "cmdline",
      -- "omni",
      -- "vimtex",
      "buffer",
      "path",
      -- "snippets",
    },
    providers = {
      lsp = {
        name = "LSP",
        module = "blink.cmp.sources.lsp",
        transform_items = function(_, items)
          return vim.tbl_filter(
            function(item) return item.kind ~= require("blink.cmp.types").CompletionItemKind.Keyword end,
            items
          )
        end,
      },
    },
  },
})
