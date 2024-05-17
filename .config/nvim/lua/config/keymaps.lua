local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- <Space> as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- # Normal
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

keymap("n", ";P", "<Cmd>cd \\$PWD<CR><Cmd>pwd<CR>", { noremap = true, silent = true, desc = "cd $PWD" })
keymap(
	"n",
	";S",
	"<Cmd>cd \\$SCRAPBOOK_DIR<CR><Cmd>pwd<CR>",
	{ noremap = true, silent = true, desc = "cd $SCRAPBOOK_DIR" }
)

-- Delete a character without yanking
keymap("n", "x", '"_x', opts)

-- messages
keymap("n", ",M", "<Cmd>messages<CR>", opts)

-- # Insert

-- Insertモードを抜けたときにIMEオフ
keymap("i", "<Esc>", function()
	local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
	vim.fn.execute("!im-select com.apple.keylayout.ABC", "silent")
	vim.api.nvim_feedkeys(esc, "n", true)
end, opts)

keymap("i", "<C-b>", "<Left>", opts)
keymap("i", "<C-f>", "<Right>", opts)
keymap("i", "<C-a>", "<Esc>I", opts)
keymap("i", "<C-e>", "<Esc>A", opts)
keymap("i", "<C-d>", "<Del>", opts)
keymap("i", "<C-g><C-h>", "<Esc>bi", { noremap = true, silent = true, desc = "backward-word" })
keymap("i", "<C-g><C-l>", "<Esc>ea", { noremap = true, silent = true, desc = "forward-word" })

-- Insert ellipsis
keymap("i", "<A-;>", "…", opts)

-- # Visual

-- Paste
keymap("v", "p", '"_dP', opts)

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
keymap("n", "_", "zc", opts)
keymap("n", "+", "zO", opts)
keymap("n", "z'", "zA", opts)
keymap("n", "z;", "za", opts)

-- Jira
keymap("n", "<Leader>J", ":<C-u>%s;\\(<C-r><C-w>\\);" .. vim.fn.expand("$JIRA_BASE_URL") .. "\\1;<CR>", opts)

-- Preview
local utils = require("config.utils")
vim.keymap.set("n", ";<C-g>", function()
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
