vim.opt.foldlevel = 1

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

local function cursor_pos()
	local cursor = vim.api.nvim_win_get_cursor(0) -- 1-based row, 0-based col
	local row = cursor[1] - 1
	local col = vim.fn.charcol("$") - 1
	return row, col
end

local UNORDERED_LIST_PATTERN = "^%s*[-*+] $"
local ORDERED_LIST_PATTERN = "^%s*%d+[%.%)] $"
local TASK_PATTERN = "^%s*[-*+] %[[x ]%] $"
local function backspace()
	local row, col = cursor_pos()
	local str = vim.api.nvim_buf_get_text(0, row, 0, row, col, {})[1]

	local cw = vim.api.nvim_replace_termcodes("<C-w>", true, false, true)
	local bs = vim.api.nvim_replace_termcodes("<C-h>", true, false, true)
	if
		string.match(str, UNORDERED_LIST_PATTERN)
		or string.match(str, ORDERED_LIST_PATTERN)
		or string.match(str, TASK_PATTERN)
	then
		vim.api.nvim_feedkeys(cw, "n", true)
	else
		vim.api.nvim_feedkeys(bs, "n", true)
	end
end
keymap("i", "<BS>", backspace, { noremap = true, silent = true })
keymap("i", "<C-h>", backspace, { noremap = true, silent = true })
keymap("i", "<Tab>", function()
	local row, col = cursor_pos()
	local str = vim.api.nvim_buf_get_text(0, row, 0, row, col, {})[1]

	local tab = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
	if
		string.match(str, UNORDERED_LIST_PATTERN)
		or string.match(str, ORDERED_LIST_PATTERN)
		or string.match(str, TASK_PATTERN)
	then
		vim.fn.execute("normal >>")
		vim.fn.execute("startinsert!")
	else
		vim.api.nvim_feedkeys(tab, "n", true)
	end
end, { noremap = true, silent = true })
keymap("i", "<S-Tab>", function()
	local row, col = cursor_pos()
	local str = vim.api.nvim_buf_get_text(0, row, 0, row, col, {})[1]

	local tab = vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true)
	if
		string.match(str, UNORDERED_LIST_PATTERN)
		or string.match(str, ORDERED_LIST_PATTERN)
		or string.match(str, TASK_PATTERN)
	then
		vim.fn.execute("normal <<")
		vim.fn.execute("startinsert!")
	else
		vim.api.nvim_feedkeys(tab, "n", true)
	end
end, { noremap = true, silent = true })
