return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require("telescope.actions")

      opts.defaults.prompt_prefix = " "
      opts.defaults.mappings.i["<C-j>"] = actions.move_selection_next
      opts.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
      opts.defaults.mappings.i["<esc>"] = actions.close
      return opts
    end,
    keys = {
      { "<leader><space>", false },
    },
  },
}
