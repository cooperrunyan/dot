local k = vim.keymap.set
local s = { silent = true }

local action = function(cmd)
	return function()
		return require("vscode").action(cmd)
	end
end

-- k("n", "U", "<C-r>", { silent = true, desc="" })
k("n", "U", ":redo<CR>", { silent = true, desc = "Redo" })
k("v", "p", '"_dP', { silent = true, desc = "Paste over selection" })
k("v", "R", '"_dP', { silent = true, desc = "Paste over selection" })
k("v", "c", '"_c', { silent = true, desc = "Change selection" })
k("n", "x", '"_x', { silent = true, desc = "Delete under cursor" })
k("n", "{", "[{", { silent = true, desc = "Next {" })
k("n", "}", "]}", { silent = true, desc = "Prev }" })
k("o", "L", "$", { silent = true, desc = "End of line" })
k("o", "H", "^", { silent = true, desc = "Beginning of line" })
k("x", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection up" })
k("x", "K", ":m '>-2<CR>gv=gv", { silent = true, desc = "Move selection down" })
k({ "n", "x", "o" }, "ge", "G", { silent = true, desc = "Go to end of file" })

k({ "n", "v", "i" }, "<C-q>", ":q<CR>", { silent = true, desc = "Close buffer" })
k({ "n", "x", "i", "c" }, "<D-s>", ":w<CR>", { silent = true, desc = "Write buffer" })
k("v", "<D-c>", '"+y', { silent = true, desc = "Copy to system clipboard" })
k({ "n", "v" }, "<D-v>", '"+P', { silent = true, desc = "Paste system clipboard" })
k("c", "<D-v>", '<C-R>+"P')
k("i", "<D-v>", '<ESC>l"+Pli', { silent = true, desc = "Paste system clipboard" })
k({ "n", "v" }, "<leader>r", vim.lsp.buf.rename, { silent = true, desc = "Rename symbol" })

if vim.g.vscode then
	k(
		{ "n", "v" },
		">",
		action("editor.action.indentLines"),
		{ silent = true, remap = false, desc = "Indent selection" }
	)
	k(
		{ "n", "v" },
		"<",
		action("editor.action.outdentLines"),
		{ silent = true, remap = false, desc = "Unindent selection" }
	)
else
	k("n", ">", ">>", { silent = true, remap = false, desc = "Indent selection" })
	k("n", "<", "<<", { silent = true, remap = false, desc = "Unindent selection" })
	k("v", ">", ">gv", { silent = true, remap = false, desc = "Indent selection" })
	k("v", "<", "<gv", { silent = true, remap = false, desc = "Unindent selection" })
end

k({ "n", "x" }, "k", "gk", { remap = true, silent = true })
k({ "n", "x" }, "j", "gj", { remap = true, silent = true })
k({ "n", "o", "x" }, "$", "g$", { remap = true, silent = true })
k({ "n", "o", "x" }, "^", "g^", { remap = true, silent = true })

k("i", "<M-CR>", "<c-o><cmd>call append(line('.'), '')<CR>", { silent = true, desc = "Insert line below cursor" })
k("i", "<M-S-CR>", "<c-o><cmd>call append(line('.')-1, '')<CR>", { silent = true, desc = "Insert line above cursor" })

k("n", "<M-CR>", "<cmd>call append(line('.'), '')<CR>", { silent = true, desc = "Insert line below cursor" })
k("n", "<M-S-CR>", "<cmd>call append(line('.')-1, '')<CR>", { silent = true, desc = "Insert line above cursor" })
k("n", "<C-CR>", "o<esc>", { silent = true, desc = "Insert and move to line below cursor" })
k("n", "<C-S-CR>", "O<esc>", { silent = true, desc = "Insert and move to line above cursor" })

k("n", "<leader>p", '"+p', { silent = true, desc = "Paste system clipboard" })
k("n", "<leader>yy", '"+yy', { silent = true, desc = "Copy to system clipboard" })
k("v", "<leader>y", '"+y', { silent = true, desc = "Copy to system clipboard" })

k({ "n", "v", "i" }, "<C-L>", "<cmd>wincmd l<CR>", { silent = true, desc = "Focus window left" })
k({ "n", "v", "i" }, "<C-J>", "<cmd>wincmd j<CR>", { silent = true, desc = "Focus window down" })
k({ "n", "v", "i" }, "<C-K>", "<cmd>wincmd k<CR>", { silent = true, desc = "Focus window up" })
k({ "n", "v", "i" }, "<C-H>", "<cmd>wincmd h<CR>", { silent = true, desc = "Focus window right" })
k("n", "<leader>ss", "<C-w>v", { silent = true, desc = "Split vertical" })
k("n", "<leader>se", "<C-w>=", { silent = true, desc = "Resize splits" })
k("n", "<leader>sq", "<cmd>close<CR>", { silent = true, desc = "Close split" })

k("n", "tt", "<cmd>tab split<CR>", { silent = true, desc = "Open new tab" }) -- open new tab
k("n", "<leader><tab>", "<cmd>tab split<CR>", { silent = true, desc = "Open new tab" }) -- new tab
k("n", "tq", "<cmd>tabclose<CR>", { silent = true, desc = "Close tab" }) -- close tab
k("n", "to", "<cmd>tabo<CR>", { silent = true, desc = "Close other tabs" }) -- close other tabs
k("n", "tn", "<cmd>tabn<CR>", { silent = true, desc = "Next tab" }) -- go to next tab
k("n", "<C-tab>", "<cmd>tabn<CR>", { silent = true, desc = "Next tab" }) -- go to next tab
k("n", "<C-S-tab>", "<cmd>tabp<CR>", { silent = true, desc = "Previous tab" }) -- go to next tab
k("n", "tp", "<cmd>tabp<CR>", { silent = true, desc = "Previous tab" }) -- previous tab

-- k("t","<Esc>", "<C-\\><C-n>")
k("t", "<Esc>", "<C-\\><C-n><C-w><C-p>", { silent = true })

-- k("n", "<leader>chx", "<cmd>!chmod a+x %<CR>")

-- k("n", "<C-.>", vim.lsp.buf.code_action, {silent=true, desc="Code action"})
k("n", "<leader>a", vim.lsp.buf.code_action, { silent = true, desc = "Code action" })
k("n", "gH", vim.lsp.buf.hover, { silent = true, desc = "Hover" })
k("n", "gr", vim.lsp.buf.references, { silent = true, desc = "References" })
k("n", "gd", vim.lsp.buf.declaration, { silent = true, desc = "Go to declaration" })
k("n", "gK", vim.lsp.buf.signature_help, { silent = true, desc = "Signature help" })

k("i", "<C-CR>", "<C-o>o", { silent = true, desc = "New line below" })
k("i", "<S-CR>", "<C-o>o", { silent = true, desc = "New line below" })
k("i", "<C-S-CR>", "<C-o>O", { silent = true, desc = "New line above" })
