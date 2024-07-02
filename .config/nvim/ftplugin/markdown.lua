local map = vim.keymap.set

-- Insert/Remove dash
map(
	"v",
	"<C-g><C-i>",
	"<Esc><Cmd>:'<,'>s/^\\(\\s*\\)\\(\\S\\)/\\1- \\2/g<CR>:nohlsearch<CR>",
	{ noremap = true, silent = true, buffer = true, desc = "Insert dash" }
)
map(
	"v",
	"<C-g><C-d>",
	"<Esc><Cmd>:'<,'>s/^\\(\\s*\\)[-*+] \\(\\[[ x]\\] \\)\\?\\(\\S\\)/\\1\\3/g<CR>:nohlsearch<CR>",
	{ noremap = true, silent = true, buffer = true, desc = "Remove dash" }
)
