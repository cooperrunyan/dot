return {
  "folke/noice.nvim",
  dependencies = {
    {
      "rcarriga/nvim-notify",
      keys = {
        { "<leader>un", false },
        {
          "<leader>mk",
          function()
            require("notify").dismiss({ silent = true, pending = true })
          end,
          desc = "Dismiss all Notifications",
        },
        {
          "<leader>mh",
          function()
            require("telescope").extensions.notify.notify()
          end,
        },
      },
      opts = {
        timeout = 3000,
        background_colour = "#00000000",
        render = "minimal",
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
      },
    },
  },
  opts = {
    lsp = {
      hover = { silent = true },
      message = { view = "mini" },
    },
    presets = { command_pallette = false },
    notify = {
      view = "mini",
      view_info = "mini",
      view_error = "notify",
      view_warn = "notify",
    },
    message = {
      view = "mini",
      view_info = "mini",
      view_error = "notify",
      view_warn = "notify",
    },

    cmdline = { view = "cmdline" },
  },
}
