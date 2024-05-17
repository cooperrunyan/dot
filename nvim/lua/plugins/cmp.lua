local types = {
  Text = "txt",
  Method = "mthd",
  Function = "fn",
  Constructor = "ctor",
  Field = "fld",
  Class = "cls",
  Interface = "infc",
  Module = "mod",
  Property = "prop",
  Unit = "unit",
  Value = "val",
  Enum = "enum",
  Keyword = "kywd",
  Snippet = "snip",
  Color = "color",
  File = "file",
  Reference = "ref",
  Folder = "fldr",
  EnumMember = "vrnt",
  Constant = "const",
  Struct = "struct",
  Event = "evt",
  Operator = "op",
  TypeParameter = "type",
}

return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")

    opts.window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    }

    opts.mapping["<tab>"] = cmp.mapping.confirm({ select = false })
    opts.mapping["<CR>"] = nil
    opts.mapping["<c-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })
    opts.mapping["<c-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })
    opts.mapping["<c-p>"] = nil
    opts.mapping["<c-n>"] = nil
    opts.mapping["<c-b>"] = nil

    opts.formatting = {
      format = function(entry, item)
        item.kind = types[item.kind]
        return item
      end,
    }

    return opts
  end,
}
