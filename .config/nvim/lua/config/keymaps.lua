local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- <Space> as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- # Normal

keymap("n", "<C-i>", function()
	vim.cmd("startinsert")
	vim.fn.execute("!kana", "silent")
end, opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize
--   ref. https://iterm2.com/faq.html
--     Q: How do I make the option/alt key act like Meta or send escape codes?
--     A: Go to Preferences > Profiles tab. Select your profile on the left, and then open the Keyboard tab.
--        At the bottom is a set of buttons that lets you select the behavior of the Option key.
--        For most users, Esc+ will be the best choice.
keymap("n", "<A-k>", "<Cmd>resize +2<CR>", opts)
keymap("n", "<A-j>", "<Cmd>resize -2<CR>", opts)
keymap("n", "<A-h>", "<Cmd>vertical resize -2<CR>", opts)
keymap("n", "<A-l>", "<Cmd>vertical resize +2<CR>", opts)

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Disable EX-mode (if you enter EX-mode, push gQ)
keymap("n", "Q", "<Nop>", opts)

-- Quit
keymap("n", "<Leader>q", "<Cmd>bd<CR>", opts)
keymap("n", "<Leader>Q", "<Cmd>qa<CR>", opts)

-- Windows
keymap("n", "<C-w>-", "<Cmd>split<CR>", opts)
keymap("n", "<C-w>\\", "<Cmd>vsplit<CR>L", opts)
keymap("n", "<C-w>o", "<NOP>", opts)
keymap("n", "<C-w>O", "<Cmd>only<CR>", opts)

-- Tabs
keymap("n", ",t", "<Cmd>tabedit %:p<CR>", opts)
keymap("n", "<C-t><C-n>", "<Cmd>tabnext<CR>", opts)
keymap("n", "<C-t><C-p>", "<Cmd>tabprevious<CR>", opts)
keymap("n", "<C-t>N", "<Cmd>tabmove +<CR>", opts)
keymap("n", "<C-t>P", "<Cmd>tabmove -<CR>", opts)

keymap("n", "[t", "<Cmd>tabprevious<CR>", opts)
keymap("n", "]t", "<Cmd>tabnext<CR>", opts)
keymap("n", "[T", "<Cmd>tabfirst<CR>", opts)
keymap("n", "]T", "<Cmd>tablast<CR>", opts)

-- Location list
keymap("n", "[l", "<Cmd>lpreious<CR>", opts)
keymap("n", "]l", "<Cmd>lnext<CR>", opts)
keymap("n", "[L", "<Cmd>lfirst<CR>", opts)
keymap("n", "]L", "<Cmd>llast<CR>", opts)

-- Replace
keymap(
	"n",
	",re",
	":<C-u>%s;<C-r><C-w>;g<Left><Left>;",
	{ noremap = true, silent = true, desc = "[re]place Current Word" }
)

-- Toggle relativenumber
keymap(
	"n",
	"<Leader>N",
	"<Cmd>setlocal relativenumber!<CR>",
	{ noremap = true, silent = true, desc = "Toggle Relative[N]umber" }
)

-- Indent
keymap("n", "<C-g><C-p>", "<<", opts)
keymap("n", "<C-g><C-n>", ">>", opts)
keymap("n", "<C-t><C-p>", "<<", opts)
keymap("n", "<C-t><C-n>", ">>", opts)

keymap("n", ";p", "<Cmd>cd \\$PWD<CR><Cmd>pwd<CR>", { noremap = true, silent = true, desc = "cd $PWD" })
keymap(
	"n",
	";s",
	"<Cmd>cd \\$SCRAPBOOK_DIR<CR><Cmd>pwd<CR>",
	{ noremap = true, silent = true, desc = "cd $SCRAPBOOK_DIR" }
)

-- Delete a character without yanking
keymap("n", "x", '"_x', opts)

-- Insert dash
keymap("n", "<C-g><C-i>", "I- <Esc>A<Esc>", { noremap = true, silent = true, desc = "Insert dash (Markdown)" })

-- messages
keymap("n", ",M", "<Cmd>messages<CR>", opts)

-- # Insert
keymap("i", "<C-b>", "<Left>", opts)
keymap("i", "<C-f>", "<Right>", opts)
keymap("i", "<C-a>", "<Esc>I", opts)
keymap("i", "<C-e>", "<Esc>A", opts)
keymap("i", "<C-d>", "<Del>", opts)
keymap("i", "<C-g><C-h>", "<Esc>bi", { noremap = true, silent = true, desc = "backward-word" })
keymap("i", "<C-g><C-l>", "<Esc>ea", { noremap = true, silent = true, desc = "forward-word" })

-- Insert dash
keymap("i", "<C-g><C-i>", "<Esc>I- <Esc>A", { noremap = true, silent = true, desc = "Insert dash (Markdown)" })

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

-- Insert ellipsis
keymap("i", "<A-;>", "…", opts)

-- # Visual

-- Paste
keymap("v", "p", '"_dP', opts)

-- List
keymap("v", "<C-g><C-i>", "<Esc><Cmd>:'<,'>s/^\\(\\s*\\)\\(\\S\\)/\\1- \\2/g<CR>:nohlsearch<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "<C-g><C-p>", "<gv", opts)
keymap("v", "<C-g><C-n>", ">gv", opts)
keymap("v", "<C-t><C-p>", "<gv", opts)
keymap("v", "<C-t><C-n>", ">gv", opts)

-- Move text up and down
keymap("v", "J", ":move '>+1<CR>gv-gv", opts)
keymap("v", "K", ":move '<-2<CR>gv-gv", opts)

-- # Command
keymap("c", "<C-b>", "<Left>", {})
keymap("c", "<C-f>", "<Right>", {})
keymap("c", "<C-a>", "<Home>", {})
keymap("c", "<C-e>", "<End>", {})

-- Esc
keymap({ "n", "i" }, "<C-c>", "<Esc>", opts)
keymap("n", "<Esc><Esc>", ":set nopaste<CR>:nohlsearch<CR>:cclose<CR>:lclose<CR>", opts)
keymap("n", "<C-c><C-c>", ":set nopaste<CR>:nohlsearch<CR>:cclose<CR>:lclose<CR>", opts)

-- Save
keymap({ "n", "v" }, ";;", "<Cmd>write<CR>", { noremap = true })

-- folding
local function foldlevel(num)
	local n = vim.o.foldlevel + num
	if n < 0 then
		n = 0
	end
	vim.o.foldlevel = n
	vim.notify("foldlevel: " .. n)
end
keymap("n", "z-", function()
	foldlevel(-1)
end, { noremap = true, desc = "Subtract foldlevel" })
keymap("n", "z+", function()
	foldlevel(1)
end, { noremap = true, desc = "Add foldlevel" })
keymap("n", "z=", function()
	foldlevel(1)
end, { noremap = true, desc = "Add foldlevel" })
keymap("n", "z'", "zX", opts)
keymap("n", "_", "zc", opts)
keymap("n", "+", "zO", opts)
keymap("n", "z;", "za", opts)

-- Jira
keymap("n", "<Leader>J", ":<C-u>%s;\\(<C-r><C-w>\\);" .. vim.fn.expand("$JIRA_BASE_URL") .. "\\1;<CR>", opts)

-- Preview
local utils = require("config.utils")
vim.keymap.set("n", ";M", function()
	vim.cmd("normal yy")
	local line = vim.fn.getreg('"')
	local path = string.gsub(line, ".*%((.*)%).*", "%1")
	path = string.gsub(path, "%%20", " ")
	utils.preview(vim.fn.expand("%:p:h") .. "/" .. path)
end, { noremap = true, silent = true, desc = "Preview multimedia file" })
