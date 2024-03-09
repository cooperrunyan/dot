return {
  "folke/noice.nvim",
  opts = function(_, opts)
    opts.lsp.hover = { silent = true }
    opts.lsp.message = { view = "mini" }
    opts.presets.command_palette = false

    opts.messages = {
      view = "mini",
      view_warn = "mini",
      view_info = "mini",
      view_error = "notify",
    }
    opts.notify = {
      view = "mini",
      view_warn = "mini",
      view_info = "mini",
      view_error = "notify",
    }
    -- opts.popupmenu = { backend = "cmp" }
    opts.cmdline = { view = "cmdline" }
  end,
}
