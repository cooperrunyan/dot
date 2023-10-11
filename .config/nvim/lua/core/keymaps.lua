vim.g.mapleader = " "

vim.keymap.set("n", "<leader>nh", "<cmd>nohl<CR>")
vim.keymap.set("n", "<S-u>", "<cmd>redo<CR>")

vim.keymap.set("n", "<leader>=", "<C-a>")
vim.keymap.set("n", "<leader>-", "<C-x>")

vim.keymap.set("n", "<D-s>", ":w<CR>")
vim.keymap.set("v", "<D-c>", '"+y')
vim.keymap.set("n", "<D-v>", '"+P')
vim.keymap.set("v", "<D-v>", '"+P')
vim.keymap.set("c", "<D-v>", "<C-R>+")
vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli')

vim.keymap.set("n", "<leader>sl", "<cmd>wincmd l<CR>")
vim.keymap.set("n", "<leader>sj", "<cmd>wincmd j<CR>")
vim.keymap.set("n", "<leader>sk", "<cmd>wincmd k<CR>")
vim.keymap.set("n", "<leader>sh", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<leader>ss", "<C-w>v")
vim.keymap.set("n", "<leader>se", "<C-w>=")
vim.keymap.set("n", "<leader>sq", "<cmd>close<CR>")

vim.keymap.set("n", "tt", "<cmd>tabnew<CR>")   -- open new tab
vim.keymap.set("n", "tq", "<cmd>tabclose<CR>") -- close tab
vim.keymap.set("n", "to", "<cmd>tabo<CR>")     -- close other tabs
vim.keymap.set("n", "tn", "<cmd>tabn<CR>")     -- go to next tab
vim.keymap.set("n", "tp", "<cmd>tabp<CR>")     -- previous tab

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- Terminal
vim.keymap.set("n", "<leader>x", "<cmd>ter<cr>i")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n><C-^>")
-- vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:q<CR>")

vim.keymap.set("n", "<leader>xx", function()
  require("trouble").open()
end)
vim.keymap.set("n", "<leader>xw", function()
  require("trouble").open("workspace_diagnostics")
end)
vim.keymap.set("n", "<leader>xd", function()
  require("trouble").open("document_diagnostics")
end)
vim.keymap.set("n", "<leader>xq", function()
  require("trouble").open("quickfix")
end)
vim.keymap.set("n", "<leader>xl", function()
  require("trouble").open("loclist")
end)

vim.keymap.set("n", "<C-.>", "<cmd>CodeActionMenu<CR>")
