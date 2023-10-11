local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

local trouble = require("trouble")

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<c-t>"] = trouble.open_with_trouble,
      },
      n = {
        ["<esc>"] = actions.close,

        ["<c-t>"] = trouble.open_with_trouble,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["?"] = actions.which_key,
      },
    },
    load_extensions = { "fzf", "yank_history" },
  },
})
