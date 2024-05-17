local k = vim.keymap.set
local n = function(...)
  k("n", ...)
end
local x = function(...)
  k("x", ...)
end
local v = function(...)
  k("v", ...)
end
local i = function(...)
  k("i", ...)
end
local t = function(...)
  k("t", ...)
end
local c = function(...)
  k("c", ...)
end

local s = { silent = true }

n("U", "<cmd>redo<CR>")
n("Q", "<cmd>qa<CR>")
n("W", "<cmd>w<CR>")
n("<leader>wa", "<cmd>wa<CR>")

i("<M-CR>", "<c-o><cmd>call append(line('.'), '')<CR>", s)
i("<M-S-CR>", "<c-o><cmd>call append(line('.')-1, '')<CR>", s)

n("<M-CR>", "<cmd>call append(line('.'), '')<CR>", s)
n("<M-S-CR>", "<cmd>call append(line('.')-1, '')<CR>", s)
n("<C-CR>", "o<esc>", s)
n("<C-S-CR>", "O<esc>", s)

-- v("J", ":m '>+1<CR>gv=gv", { silent = true })
-- v("K", ":m '>-2<CR>gv=gv", { silent = true })

v("p", '"_dP')
n("<leader>yc", "<cmd>t .<cr>kgccj", { remap = true })
n("<leader>yp", "<cmd>t .<cr>", s)
-- n("<leader>p", '"+p')
-- n("<leader>yy", '"+yy')
-- v("<leader>y", '"+y')

n("<D-s>", ":w<CR>")
v("<D-c>", '"+y')
v("<D-c>", '"+y')
n("<D-v>", '"+P')
v("<D-v>", '"+P')
c("<D-v>", "<C-R>+")
i("<D-v>", '<ESC>l"+Pli')

k({ "n", "v" }, "<C-L>", "<cmd>wincmd l<CR>")
k({ "n", "v" }, "<C-J>", "<cmd>wincmd j<CR>")
k({ "n", "v" }, "<C-K>", "<cmd>wincmd k<CR>")
k({ "n", "v" }, "<C-H>", "<cmd>wincmd h<CR>")
n("<leader>ss", "<C-w>v")
n("<leader>se", "<C-w>=")
n("<leader>sq", "<cmd>close<CR>")

n("tt", "<cmd>tab split<CR>") -- open new tab
n("<leader><tab>", "<cmd>tab split<CR>") -- new tab
n("tq", "<cmd>tabclose<CR>") -- close tab
n("to", "<cmd>tabo<CR>") -- close other tabs
n("tn", "<cmd>tabn<CR>") -- go to next tab
n("<tab>", "<cmd>tabn<CR>") -- go to next tab
n("<S-tab>", "<cmd>tabp<CR>") -- go to next tab
n("tp", "<cmd>tabp<CR>") -- previous tab

-- t("<Esc>", "<C-\\><C-n>")
t("<Esc>", "<C-\\><C-n><C-w><C-p>")

n("<leader>chx", "<cmd>!chmod a+x %<CR>")

n("<C-.>", vim.lsp.buf.code_action)
n("<C-Space>", vim.lsp.buf.code_action)
n("K", vim.lsp.buf.hover)
n("gr", vim.lsp.buf.references)
n("<leader>r", vim.lsp.buf.rename)
n("gd", vim.lsp.buf.declaration)
n("gK", vim.lsp.buf.signature_help)

n("<leader>Q", "@q")
x("<leader>Q", ":norm @q<CR>")
n("x", '"_x')
i("<c-x>", '<C-o>"_x')

n("{", "[{")
n("}", "]}")

local insert_ctrl_motions = { "w", "b", "u", "$", "^", "0", "e", "b" }

for _, key in pairs(insert_ctrl_motions) do
  i("<C-" .. key .. ">", "<C-o>" .. key)
end

i("<C-h>", "<left>")
i("<C-j>", "<down>")
i("<C-k>", "<up>")
i("<C-l>", "<right>")

i("<C-p>", "<C-o>P")

i("<C-CR>", "<C-o>o")
i("<S-CR>", "<C-o>o")
i("<C-S-CR>", "<C-o>O")
