local utils = require("config.utils")
local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- <Space> as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- # Normal
-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize
--   ref. https://iterm2.com/faq.html
--     Q: How do I make the option/alt key act like Meta or send escape codes?
--     A: Go to Preferences > Profiles tab. Select your profile on the left, and then open the Keyboard tab.
--        At the bottom is a set of buttons that lets you select the behavior of the Option key.
--        For most users, Esc+ will be the best choice.
map("n", "<A-k>", "<Cmd>resize +2<CR>", opts)
map("n", "<A-j>", "<Cmd>resize -2<CR>", opts)
map("n", "<A-h>", "<Cmd>vertical resize -2<CR>", opts)
map("n", "<A-l>", "<Cmd>vertical resize +2<CR>", opts)

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Disable EX-mode (if you enter EX-mode, push gQ)
map("n", "Q", "<Nop>", opts)

-- Quit
map("n", "<Leader>q", "<Cmd>bd<CR>", opts)
map("n", "<Leader>Q", "<Cmd>qa<CR>", opts)

-- Windows
map("n", "<C-w>-", "<Cmd>split<CR>", opts)
map("n", "<C-w>\\", "<Cmd>vsplit<CR>L", opts)
map("n", "<C-w>o", "<NOP>", opts)
map("n", "<C-w>O", "<Cmd>only<CR>", opts)

-- Tabs
map("n", ",t", "<Cmd>tabedit %:p<CR>", opts)
map("n", "<C-t><C-n>", "<Cmd>tabnext<CR>", opts)
map("n", "<C-t><C-p>", "<Cmd>tabprevious<CR>", opts)
map("n", "<C-t>N", "<Cmd>tabmove +<CR>", opts)
map("n", "<C-t>P", "<Cmd>tabmove -<CR>", opts)

map("n", "[t", "<Cmd>tabprevious<CR>", opts)
map("n", "]t", "<Cmd>tabnext<CR>", opts)
map("n", "[T", "<Cmd>tabfirst<CR>", opts)
map("n", "]T", "<Cmd>tablast<CR>", opts)

-- Location list
map("n", "[l", "<Cmd>lpreious<CR>", opts)
map("n", "]l", "<Cmd>lnext<CR>", opts)
map("n", "[L", "<Cmd>lfirst<CR>", opts)
map("n", "]L", "<Cmd>llast<CR>", opts)

-- Replace
map(
	"n",
	",re",
	":<C-u>%s;<C-r><C-w>;g<Left><Left>;",
	{ noremap = true, silent = true, desc = "[re]place Current Word" }
)
map("n", ",R", "*Ncgn", { noremap = true, silent = true, desc = "[R]eplace Current Word `*cgn`" })

-- Toggle relativenumber
map(
	"n",
	"<Leader>N",
	"<Cmd>setlocal relativenumber!<CR>",
	{ noremap = true, silent = true, desc = "Toggle Relative[N]umber" }
)

-- Indent
map("n", "<C-g><C-p>", "<<", opts)
map("n", "<C-g><C-n>", ">>", opts)
map("n", "<C-t><C-p>", "<<", opts)
map("n", "<C-t><C-n>", ">>", opts)

map("n", ";P", "<Cmd>cd \\$PWD<CR><Cmd>pwd<CR>", { noremap = true, silent = true, desc = "cd $PWD" })
map(
	"n",
	";S",
	"<Cmd>cd \\$SCRAPBOOK_DIR<CR><Cmd>pwd<CR>",
	{ noremap = true, silent = true, desc = "cd $SCRAPBOOK_DIR" }
)

-- Delete a character without yanking
map("n", "x", '"_x', opts)

-- messages
map("n", ",M", "<Cmd>messages<CR>", opts)

-- # Insert

-- Insertモードを抜けたときにIMEオフ
map("i", "<Esc>", function()
	local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
	vim.fn.execute("!im-select com.apple.keylayout.ABC", "silent")
	vim.api.nvim_feedkeys(esc, "n", true)
end, opts)

map("i", "<C-b>", "<Left>", opts)
map("i", "<C-f>", "<Right>", opts)
map("i", "<C-a>", "<Esc>I", opts)
map("i", "<C-e>", "<Esc>A", opts)
map("i", "<C-d>", "<Del>", opts)
map("i", "<C-g><C-h>", "<Esc>bi", { noremap = true, silent = true, desc = "backward-word" })
map("i", "<C-g><C-l>", "<Esc>ea", { noremap = true, silent = true, desc = "forward-word" })

-- Insert ellipsis
map("i", "<A-;>", "…", opts)

map("i", "<C-g><C-n>", "<C-t>", { noremap = true, silent = true, desc = "Indent >>" })
map("i", "<C-g><C-p>", "<C-d>", { noremap = true, silent = true, desc = "Indent <<" })

-- # Visual

-- Paste
map("v", "p", '"_dP', opts)

-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
map("v", "<C-g><C-p>", "<gv", opts)
map("v", "<C-g><C-n>", ">gv", opts)
map("v", "<C-t><C-p>", "<gv", opts)
map("v", "<C-t><C-n>", ">gv", opts)

-- Move text up and down
map("v", "J", ":move '>+1<CR>gv-gv", opts)
map("v", "K", ":move '<-2<CR>gv-gv", opts)

-- # Command
map("c", "<C-b>", "<Left>", {})
map("c", "<C-f>", "<Right>", {})
map("c", "<C-a>", "<Home>", {})
map("c", "<C-e>", "<End>", {})

-- Esc
map({ "n", "i" }, "<C-c>", "<Esc>", opts)
map("n", "<Esc><Esc>", ":set nopaste<CR>:nohlsearch<CR>:cclose<CR>:lclose<CR>", opts)
map("n", "<C-c><C-c>", ":set nopaste<CR>:nohlsearch<CR>:cclose<CR>:lclose<CR>", opts)

-- Save
map({ "n", "v" }, ";;", "<Cmd>write<CR>", { noremap = true })

-- folding
map("n", "_", "zc", opts)
map("n", "+", "zO", opts)
map("n", "z'", "zA", opts)
map("n", "z;", "za", opts)

-- Jira
map("n", "<Leader>J", ":<C-u>%s;\\(<C-r><C-w>\\);" .. vim.fn.expand("$JIRA_BASE_URL") .. "\\1;<CR>", opts)

-- Preview
map("n", ";<C-g>", function()
	vim.cmd("normal yy")
	local line = vim.fn.getreg('"')
	local path = string.gsub(line, ".*%((.*)%).*", "%1")
	path = string.gsub(path, "%%20", " ")
	utils.preview(vim.fn.expand("%:p:h") .. "/" .. path)
end, { noremap = true, silent = true, desc = "Preview multimedia file" })

-- JSON.stringify
vim.api.nvim_create_user_command("JsonStringify", function(args)
	local cmd
	if args.range == 2 then
		cmd = args.line1 .. "," .. args.line2 .. "!xargs -0 -I {} node -e 'console.log(JSON.stringify({}, null, 2))'"
	else
		cmd = "%!xargs -0 -I {} node -e 'console.log(JSON.stringify({}, null, 2))'"
	end
	vim.fn.execute(cmd)
end, {
	range = 2,
})

-- JSON.parse
vim.api.nvim_create_user_command("JsonParse", function(args)
	local cmd
	if args.range == 2 then
		cmd = args.line1 .. "," .. args.line2 .. "!xargs -0 -I {} node -e 'console.log({})'"
	else
		cmd = "%!xargs -0 -I {} node -e 'console.log({})'"
	end
	vim.fn.execute(cmd)
end, {
	range = 2,
})

-- Jq
vim.api.nvim_create_user_command("Jq", function(args)
	local cmd
	if args.range == 2 then
		cmd = args.line1 .. "," .. args.line2 .. "!jq ."
	else
		cmd = "%!jq ."
	end
	vim.fn.execute(cmd)
end, {
	range = 2,
})
vim.api.nvim_create_user_command("JqCompact", function(args)
	local cmd
	if args.range == 2 then
		cmd = args.line1 .. "," .. args.line2 .. "!jq -c ."
	else
		cmd = "%!jq -c ."
	end
	vim.fn.execute(cmd)
end, {
	range = 2,
})
