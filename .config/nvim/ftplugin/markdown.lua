local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Insert dash
keymap("n", "<C-g><C-i>", "I- <Esc>A<Esc>", { noremap = true, silent = true, desc = "Insert dash (Markdown)" })
keymap("i", "<C-g><C-i>", "<Esc>I- <Esc>A", { noremap = true, silent = true, desc = "Insert dash (Markdown)" })
keymap("v", "<C-g><C-i>", "<Esc><Cmd>:'<,'>s/^\\(\\s*\\)\\(\\S\\)/\\1- \\2/g<CR>:nohlsearch<CR>", opts)

-- Indent
local function indent(sign)
	local l, c = unpack(vim.api.nvim_win_get_cursor(0))
	local n = vim.o.shiftwidth
	sign = sign == nil and true or sign
	if sign then
		vim.fn.execute("normal >>")
	else
		vim.fn.execute("normal <<")
		n = -1 * n
	end
	vim.fn.execute("normal i")
	local col = c + n < 0 and 0 or c + n
	vim.api.nvim_win_set_cursor(0, { l, col })
end
keymap("i", "<C-g><C-n>", function()
	indent()
end, { noremap = true, silent = true, desc = "Indent >>" })
keymap("i", "<C-t><C-n>", function()
	indent()
end, { noremap = true, silent = true, desc = "Indent >>" })
keymap("i", "<C-g><C-p>", function()
	indent(false)
end, { noremap = true, silent = true, desc = "Indent <<" })
keymap("i", "<C-t><C-p>", function()
	indent(false)
end, { noremap = true, silent = true, desc = "Indent <<" })
