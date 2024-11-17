local k = vim.keymap.set
local s = { silent = true }

-- k("n", "U", "<cmd>redo<CR>", s)
k("v", "p", '"_dP', s)
k("v", "c", '"_c', s)
k("n", "x", '"_x', s)
k("n", "{", "[{")
k("n", "}", "]}")
k("o", "L", "$")
k("o", "H", "^")
k("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
k("v", "K", ":m '>-2<CR>gv=gv", { silent = true })

if vim.g.vscode then
    local action = function(cmd)
        return function()
            return require('vscode').action(cmd)
        end
    end

    k("n", "U", "<cmd>redo<cr>", { remap = true })
    k("v", ">", action('editor.action.indentLines'), s)
    k("v", "<", action('editor.action.outdentLines'), s)
    k("i", "<M-v>", "<c-o>P")
    k({ "n", "o", "x" }, "k", "gk", { remap = true, silent = true })
    k({ "n", "o", "x" }, "j", "gj", { remap = true, silent = true })
    k({ "n", "o", "x" }, "$", "g$", { remap = true, silent = true })
    k({ "n", "o", "x" }, "^", "g^", { remap = true, silent = true })
else
    k("n", "U", "<C-r>")
    k("n", "Q", "<cmd>qa<CR>")
    k("n", "W", "<cmd>w<CR>")
    k("n", "<leader>wa", "<cmd>wa<CR>")

    k("i", "<M-CR>", "<c-o><cmd>call append(line('.'), '')<CR>", s)
    k("i", "<M-S-CR>", "<c-o><cmd>call append(line('.')-1, '')<CR>", s)

    k("n", "<M-CR>", "<cmd>call append(line('.'), '')<CR>", s)
    k("n", "<M-S-CR>", "<cmd>call append(line('.')-1, '')<CR>", s)
    k("n", "<C-CR>", "o<esc>", s)
    k("n", "<C-S-CR>", "O<esc>", s)

    k("v", "p", '"_dP')
    k("n", "<leader>yc", "<cmd>t .<cr>kgccj", { remap = true })
    k("n", "<leader>yp", "<cmd>t .<cr>", s)
    k("n", "<leader>p", '"+p')
    k("n", "<leader>yy", '"+yy')
    k("v", "<leader>y", '"+y')

    k("n", "<D-s>", ":w<CR>")
    k("v", "<D-c>", '"+y')
    k("v", "<D-c>", '"+y')
    k("n", "<D-v>", '"+P')
    k("v", "<D-v>", '"+P')
    k("c", "<D-v>", "<C-R>+")
    k("i", "<D-v>", '<ESC>l"+Pli')

    k({ "n", "v" }, "<C-L>", "<cmd>wincmd l<CR>")
    k({ "n", "v" }, "<C-J>", "<cmd>wincmd j<CR>")
    k({ "n", "v" }, "<C-K>", "<cmd>wincmd k<CR>")
    k({ "n", "v" }, "<C-H>", "<cmd>wincmd h<CR>")
    k("n", "<leader>ss", "<C-w>v")
    k("n", "<leader>se", "<C-w>=")
    k("n", "<leader>sq", "<cmd>close<CR>")

    k("n", "tt", "<cmd>tab split<CR>")            -- open new tab
    k("n", "<leader><tab>", "<cmd>tab split<CR>") -- new tab
    k("n", "tq", "<cmd>tabclose<CR>")             -- close tab
    k("n", "to", "<cmd>tabo<CR>")                 -- close other tabs
    k("n", "tn", "<cmd>tabn<CR>")                 -- go to next tab
    k("n", "<tab>", "<cmd>tabn<CR>")              -- go to next tab
    k("n", "<S-tab>", "<cmd>tabp<CR>")            -- go to next tab
    k("n", "tp", "<cmd>tabp<CR>")                 -- previous tab

    -- k("t","<Esc>", "<C-\\><C-n>")
    k("t", "<Esc>", "<C-\\><C-n><C-w><C-p>")

    k("n", "<leader>chx", "<cmd>!chmod a+x %<CR>")

    k("n", "<C-.>", vim.lsp.buf.code_action)
    k("n", "<C-Space>", vim.lsp.buf.code_action)
    k("n", "K", vim.lsp.buf.hover)
    k("n", "gr", vim.lsp.buf.references)
    k("n", "<leader>r", vim.lsp.buf.rename)
    k("n", "gd", vim.lsp.buf.declaration)
    k("n", "gK", vim.lsp.buf.signature_help)

    k("n", "<leader>Q", "@q")
    k("x", "<leader>Q", ":norm @q<CR>")
    k("i", "<c-x>", '<C-o>"_x')

    local insert_ctrl_motions = { "w", "b", "u", "$", "^", "0", "e", "b" }

    for _, key in pairs(insert_ctrl_motions) do
        k("i", "<C-" .. key .. ">", "<C-o>" .. key)
    end

    k("i", "<C-h>", "<left>")
    k("i", "<C-j>", "<down>")
    k("i", "<C-k>", "<up>")
    k("i", "<C-l>", "<right>")

    k("i", "<C-p>", "<C-o>P")

    k("i", "<C-CR>", "<C-o>o")
    k("i", "<S-CR>", "<C-o>o")
    k("i", "<C-S-CR>", "<C-o>O")
end
