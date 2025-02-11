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

-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#m%E3%81%A7%E6%8B%AC%E5%BC%A7%E3%82%B8%E3%83%A3%E3%83%B3%E3%83%97
map("n", "<C-m>", "%", { remap = true, desc = "%" })

-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#u%E3%81%A7%E3%83%AA%E3%83%89%E3%82%A5
map("n", "U", "<C-r>", opts)

-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#x%E3%81%A7%E5%89%8A%E9%99%A4
map("n", "x", '"_x', opts)
map("n", "X", '"_D', opts)

-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#%E7%A9%BA%E8%A1%8C%E3%81%A7%E3%81%AE%E7%B7%A8%E9%9B%86%E9%96%8B%E5%A7%8B%E6%99%82%E3%81%AB%E8%87%AA%E5%8B%95%E3%81%A7%E3%82%A4%E3%83%B3%E3%83%87%E3%83%B3%E3%83%88
map("n", "i", function()
	return vim.fn.empty(vim.fn.getline(".")) == 1 and '"_cc' or "i"
end, { expr = true })
map("n", "A", function()
	return vim.fn.empty(vim.fn.getline(".")) == 1 and '"_cc' or "A"
end, { expr = true })

-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#%E3%83%9A%E3%83%BC%E3%82%B9%E3%83%88%E7%B5%90%E6%9E%9C%E3%81%AE%E3%82%A4%E3%83%B3%E3%83%87%E3%83%B3%E3%83%88%E3%82%92%E8%87%AA%E5%8B%95%E3%81%A7%E6%8F%83%E3%81%88%E3%82%8B
map("n", "p", "p`]", opts)
map("n", "P", "P`]", opts)

-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#%E7%9B%B4%E5%89%8D%E3%81%AE%E3%83%9A%E3%83%BC%E3%82%B9%E3%83%88%E7%AF%84%E5%9B%B2%E3%82%92%E9%81%B8%E6%8A%9E%E3%81%99%E3%82%8B
map("n", "gV", "`[v`]", opts)

-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#%E7%9B%B4%E5%89%8D%E3%83%BB%E7%9B%B4%E5%BE%8C%E3%81%AE%E7%A9%BA%E8%A1%8C%E3%81%AB%E9%A3%9B%E3%81%B6
map("n", "f<CR>", "}", opts)
map("n", "F<CR>", "{", opts)

-- messages
map("n", ",M", "<Cmd>messages<CR>", opts)

-- folding
map("n", "_", "zc", opts)
map("n", "+", "zO", opts)
map("n", "z'", "zA", opts)
map("n", "z;", "za", opts)

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
map("i", "<Tab>", "<C-t>", { noremap = true, silent = true, desc = "Indent <<" })
map("i", "<S-Tab>", "<C-d>", { noremap = true, silent = true, desc = "Indent <<" })

-- # Visual

-- # Command
map("c", "<C-b>", "<Left>", {})
map("c", "<C-f>", "<Right>", {})
map("c", "<C-a>", "<Home>", {})
map("c", "<C-e>", "<End>", {})

-- Esc
map({ "n", "i", "v" }, "<C-c>", "<Esc>", { remap = true })
map("n", "<Esc><Esc>", ":set nopaste<CR>:nohlsearch<CR>:cclose<CR>:lclose<CR>", opts)
map("n", "<C-c><C-c>", ":set nopaste<CR>:nohlsearch<CR>:cclose<CR>:lclose<CR>", opts)

-- Save
map({ "n", "v" }, ";;", "mm<Cmd>write<CR>`m", { noremap = true })

-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#i%3Cspace%3E%E3%81%A7word%E9%81%B8%E6%8A%9E
map({ "o", "x" }, "i<Space>", "iW", opts)
-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#visual-%E3%82%B3%E3%83%94%E3%83%BC%E6%99%82%E3%81%AB%E3%82%AB%E3%83%BC%E3%82%BD%E3%83%AB%E4%BD%8D%E7%BD%AE%E3%82%92%E4%BF%9D%E5%AD%98
map("x", "y", "mzy`z", opts)
-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#visual-%E3%83%9A%E3%83%BC%E3%82%B9%E3%83%88%E6%99%82%E3%81%AB%E3%83%AC%E3%82%B8%E3%82%B9%E3%82%BF%E3%81%AE%E5%A4%89%E6%9B%B4%E3%82%92%E9%98%B2%E6%AD%A2
map("x", "p", "P", opts)
-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#visual-%3C%2C-%3E%E3%81%A7%E9%80%A3%E7%B6%9A%E3%81%97%E3%81%A6%E3%82%A4%E3%83%B3%E3%83%87%E3%83%B3%E3%83%88%E3%82%92%E6%93%8D%E4%BD%9C
map("x", "<", "<gv", opts)
map("x", ">", ">gv", opts)
map("x", "<C-g><C-p>", "<gv", opts)
map("x", "<C-g><C-n>", ">gv", opts)
map("x", "<C-t><C-p>", "<gv", opts)
map("x", "<C-t><C-n>", ">gv", opts)
-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#%E8%A1%8C%E3%82%92%E4%B8%8A%E4%B8%8B%E3%81%AB%E7%A7%BB%E5%8B%95
map("x", "K", ":move'<-2<CR>gv", opts)
map("x", "J", ":move'>+1<CR>gv", opts)

-- Jira
map("n", ",j", ":<C-u>%s;\\(<C-r><C-w>\\);" .. vim.fn.expand("$JIRA_BASE_URL") .. "\\1;<CR>", opts)
