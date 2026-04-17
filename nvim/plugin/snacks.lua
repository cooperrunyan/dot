vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
  bigfile = { enabled = true },
  -- dashboard = { enabled = true },
  -- explorer = { enabled = true },
  input = { enabled = true },
  picker = {
    enabled = true,
    ui_select = true,
    layout = { cycle = true },
  },
  notifier = {
    enabled = true,
    style = "minimal",
    top_down = false,
    margin = { bottom = 1, right = 1 },
  },
  -- quickfile = { enabled = true },
  -- scope = { enabled = true },
  -- scroll = { enabled = true },
  -- statuscolumn = { enabled = true },
  -- words = { enabled = true },
  styles = { float = { backdrop = false } },
})

local opts = function(desc)
  return {
    desc = desc,
    silent = true,
  }
end

vim.keymap.set("n", "<leader>/", function() require("snacks").picker.grep() end, opts("Grep"))
vim.keymap.set("n", "<leader>:", function() require("snacks").picker.command_history() end, opts("Command History"))
vim.keymap.set("n", "<leader>m", function() require("snacks").picker.notifications() end, opts("Notification History"))
vim.keymap.set("n", "<leader>fb", function() require("snacks").picker.buffers() end, opts("Buffers"))
vim.keymap.set("n", "<leader>fF", function() require("snacks").picker.files() end, opts("Find Files"))
vim.keymap.set("n", "<leader>gb", function() require("snacks").picker.git_branches() end, opts("Git Branches"))
vim.keymap.set("n", "<leader>gl", function() require("snacks").picker.git_log() end, opts("Git Log"))
vim.keymap.set("n", "<leader>gL", function() require("snacks").picker.git_log_line() end, opts("Git Log Line"))
vim.keymap.set("n", "<leader>gs", function() require("snacks").picker.git_status() end, opts("Git Status"))
vim.keymap.set("n", "<leader>gS", function() require("snacks").picker.git_stash() end, opts("Git Stash"))
vim.keymap.set("n", "<leader>gd", function() require("snacks").picker.git_diff() end, opts("Git Diff (Hunks)"))
vim.keymap.set("n", "<leader>gf", function() require("snacks").picker.git_log_file() end, opts("Git Log File"))
vim.keymap.set("n", '<leader>f"', function() require("snacks").picker.registers() end, opts("Registers"))
vim.keymap.set("n", "<leader>fl", function() require("snacks").picker.lines() end, opts("Buffer Lines"))
vim.keymap.set("n", "<leader>fC", function() require("snacks").picker.command_history() end, opts("Command History"))
vim.keymap.set("n", "<leader>fc", function() require("snacks").picker.commands() end, opts("Commands"))
vim.keymap.set("n", "<leader>fD", function() require("snacks").picker.diagnostics() end, opts("Diagnostics"))
vim.keymap.set(
  "n",
  "<leader>fd",
  function() require("snacks").picker.diagnostics_buffer() end,
  opts("Buffer Diagnostics")
)
vim.keymap.set("n", "<leader>fh", function() require("snacks").picker.help() end, opts("Help Pages"))
vim.keymap.set("n", "<leader>fi", function() require("snacks").picker.highlights() end, opts("Highlights"))
vim.keymap.set("n", "<leader>fm", function() require("snacks").picker.man() end, opts("Man Pages"))
vim.keymap.set("n", "<leader>fq", function() require("snacks").picker.qflist() end, opts("Quickfix List"))
vim.keymap.set("n", "<leader>fT", function() require("snacks").picker.colorschemes() end, opts("Colorschemes"))
-- LSP
vim.keymap.set("n", "gd", function() require("snacks").picker.lsp_definitions() end, opts("Goto Definition"))
vim.keymap.set("n", "gD", function() require("snacks").picker.lsp_declarations() end, opts("Goto Declaration"))
vim.keymap.set(
  "n",
  "gr",
  function() require("snacks").picker.lsp_references() end,
  { nowait = true, desc = "References" }
)
vim.keymap.set("n", "gI", function() require("snacks").picker.lsp_implementations() end, opts("Goto Implementation"))
vim.keymap.set("n", "gy", function() require("snacks").picker.lsp_type_definitions() end, opts("Goto Type Definition"))
