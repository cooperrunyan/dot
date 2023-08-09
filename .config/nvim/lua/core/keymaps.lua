vim.g.mapleader = " "

vim.keymap.set("n", "<leader>l", "1000000l")
vim.keymap.set("n", "<leader>h", "1000000h")

vim.keymap.set("n", "<leader>nh", ":nohl<CR>")
vim.keymap.set("n", "<S-u>", ":redo<CR>")

vim.keymap.set("n", "<leader>=", "<C-a>")
vim.keymap.set("n", "<leader>-", "<C-x>")

vim.keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertical
vim.keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontal
vim.keymap.set("n", "<leader>se", "<C-w>=")
vim.keymap.set("n", "<leader>sx", ":close<CR>")

vim.keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>") -- previous tab

vim.keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- Toggle Nvim Tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- Write hotkey
vim.keymap.set("", "<C-w>", "<cmd>:wa<cr><cmd>:Prettier<cr>")
vim.keymap.set("", "<C-q>", "<cmd>:q<cr>")

-- Terminal
vim.keymap.set("n", "<leader>x", "<cmd>:ter<cr>i")
-- vim.keymap.set("t", "<Esc>", "<C-\\><C-n><C-^>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:q<CR>")
vim.keymap.set("n", "<leader>tn", ":FloatermNew --name=float --height=0.8 --width=0.7 --autoclose=2 zsh <CR>")
vim.keymap.set("n", "<leader>tt", ":FloatermToggle float<CR>")
