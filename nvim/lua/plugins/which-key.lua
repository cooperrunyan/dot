-- vim.keymap.del("n", "grr")
-- vim.keymap.del("n", "gra")
-- vim.keymap.del("n", "gri")
-- vim.keymap.del("n", "grn")

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    delay = 150,
    triggers = {
      { "<auto>", mode = "nixsotc" },
      { "m", mode = { "n", "x" }, group = "Surround" },
    },
    icons = {
      mappings = false,
    },
    spec = {
      { "Q", "q", mode = "n", silent = true, remap = false, hidden = true },
      { "q", ":q<CR>", mode = "n", silent = true, remap = false, hidden = true },

      { "<leader>g", group = "Git" },
      { "<leader>f", group = "Picker" },
      { "<leader>x", group = "Diagnostic" },
      { "<leader>t", group = "Toggle" },

      { "<leader>c", "gcc", mode = "n", silent = true, remap = true, desc = "Comment line" },
      { "<leader>c", "gc", mode = "x", silent = true, remap = true, desc = "Comment" },
      { "<leader>C", "gc", mode = "n", silent = true, remap = true, desc = "Comment" },

      { "U", ":redo<CR>", mode = "nx", silent = true, desc = "Redo" },
      { "x", '"_x', mode = "nx", silent = true, desc = "Delete under cursor" },

      { "ge", "G", mode = "nxo", silent = true, desc = "End of file" },
      { "gb", "<C-o>", mode = "n", silent = true, remap = false, desc = "Go back" },
      { "L", "g$", mode = "ox", silent = true, desc = "End of line" },
      { "H", "g^", mode = "ox", silent = true, desc = "Start of line" },
      -- { "k", "gk", mode = "nx", silent = true, remap = false },
      -- { "j", "gj", mode = "nx", silent = true, remap = false },

      { "J", ":m '>+1<CR>gv=gv", mode = "x", silent = true, desc = "Move selection up" },
      { "K", ":m '<-2<CR>gv=gv", mode = "x", silent = true, desc = "Move selection down" },

      { "<C-q>", ":q<CR>", mode = "nx", silent = true, desc = "Close buffer" },
      { "<D-s>", ":w<CR>", mode = "nx", silent = true, desc = "Write buffer" },

      { "p", '"_dP', mode = "x", silent = true, desc = "Paste over selection" },
      { "c", '"_c', mode = "x", silent = true, desc = "Change selection" },
      { "<D-c>", '"+y', mode = "x", silent = true, desc = "Copy to system clipboard" },
      { "<D-v>", '"+P', mode = "n", silent = true, desc = "Paste system clipboard" },
      { "<D-v>", '"_d"+P', mode = "x", silent = true, desc = "Paste system clipboard" },
      { "<D-v>", '<C-R>+"P', mode = "c", silent = true, desc = "Paste system clipboard" },
      { "<D-v>", '<ESC>l"+Pli', mode = "i", silent = true, desc = "Paste system clipboard" },

      { "<leader>r", vim.lsp.buf.rename, mode = "nx", silent = true, desc = "Rename symbol" },
      { "<leader>a", vim.lsp.buf.code_action, mode = "nx", silent = true, desc = "Code action" },
      -- -- { "gr", vim.lsp.buf.references, silent = true, desc = "Go to references" },
      -- { "gD", vim.lsp.buf.declaration, silent = true, desc = "Go to declaration" },
      -- { "gd", vim.lsp.buf.definition, silent = true, desc = "Go to definition" },
      -- { "gt", vim.lsp.buf.type_definition, silent = true, desc = "Go to type definition" },
      -- -- { "gi", vim.lsp.buf.implementation, silent = true, desc = "Go to implementation" },
      {
        "K",
        function() vim.lsp.buf.hover({ border = "rounded" }) end,
        silent = true,
        desc = "Hover",
      },
      {
        "H",
        function() vim.lsp.buf.signature_help({ border = "rounded" }) end,
        silent = true,
        desc = "Signature help",
      },

      { "<leader>p", '"+p', mode = "nx", silent = true, desc = "Paste system clipboard" },
      { "<leader>y", '"+y', mode = "x", silent = true, desc = "Copy to system clipboard" },

      { "<C-L>", ":wincmd l<CR>", mode = "nx", silent = true, desc = "Focus left" },
      { "<C-J>", ":wincmd j<CR>", mode = "nx", silent = true, desc = "Focus down" },
      { "<C-K>", ":wincmd k<CR>", mode = "nx", silent = true, desc = "Focus up" },
      { "<C-H>", ":wincmd h<CR>", mode = "nx", silent = true, desc = "Focus right" },

      { "<leader>S", group = "Split" },
      { "<leader>Ss", "<C-w>v", silent = true, desc = "Split vertically" },
      { "<leader>Se", "<C-w>=", silent = true, desc = "Resize splits" },
      { "<leader>Sq", ":close<CR>", silent = true, desc = "Close splits" },

      { "<leader>T", group = "Tab" },
      { "<leader>Tt", ":tab split<CR>", silent = true, desc = "Open new tab" },
      { "<leader>Tq", ":tabclose<CR>", silent = true, desc = "Close tab" },
      { "<leader>To", ":tabo<CR>", silent = true, desc = "Close other tabs" },
      { "<leader>Tn", ":tabn<CR>", silent = true, desc = "Next tab" },
      { "<leader>Tp", ":tabp<CR>", silent = true, desc = "Previous tab" },

      { "<ESC>", "<C-\\><C-n><C-w><C-p>", mode = "t", silent = true },
      { "<ESC>", ":nohl<cr>", mode = "n", silent = true, remap = false },

      { ">", ">>", mode = "n", silent = true, remap = false, desc = "Indent" },
      { "<", "<<", mode = "n", silent = true, remap = false, desc = "Unindent" },
      { ">", ">gv", mode = "x", silent = true, remap = false, desc = "Indent" },
      { "<", "<gv", mode = "x", silent = true, remap = false, desc = "Unindent" },

      {
        "<leader>gs",
        ":ClangdSwitchSourceHeader<cr>",
        mode = "n",
        silent = true,
        remap = false,
        desc = "Goto header source",
      },
    },
  },
  keys = {
    {
      "<leader><leader>",
      function() require("which-key").show() end,
    },
  },
}
