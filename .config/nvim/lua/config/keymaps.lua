local map = function(modes, lhs, rhs, opts)
	vim.keymap.set(
		modes,
		lhs,
		rhs,
		vim.tbl_extend("force", {
			noremap = true,
			silent = true,
		}, opts or {})
	)
end

-- <Space> as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- # Normal

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Focus left" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus down" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus up" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right" })

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Disable EX-mode (if you enter EX-mode, push gQ)
map("n", "Q", "<Nop>")

-- Windows
map("n", "<C-w>-", "<Cmd>split<CR>", { desc = "split" })
map("n", "<C-w>\\", "<Cmd>vsplit<CR>L", { desc = "vsplit" })
map("n", "<C-w>o", "<NOP>", { desc = "NOP" })
map("n", "<C-w>O", "<Cmd>only<CR>", { desc = "only" })

-- Tabs
map("n", "<C-,><C-t>", function()
	vim.fn.execute("normal! mt")
	vim.fn.execute(":tabedit %:p")
	vim.fn.execute("normal! `t")
	vim.fn.execute(":delm t")
end, { desc = "tabedit %:p" })
map("n", "<C-t><C-t>", "g<Tab>", { desc = "g<Tab>" })
map("n", "<C-t><C-n>", "<Cmd>tabnext<CR>", { desc = "tabnext" })
map("n", "<C-t><C-p>", "<Cmd>tabprevious<CR>", { desc = "tabprev" })
map("n", "<C-t>N", "<Cmd>tabmove +<CR>", { desc = "tabmove +" })
map("n", "<C-t>P", "<Cmd>tabmove -<CR>", { desc = "tabmove -" })

-- Replace
map("n", "<C-,>re", ":<C-u>%s;<C-r><C-w>;g<Left><Left>;", { desc = "[re]place Current Word" })
map("n", "<C-,>R", "*Ncgn", { desc = "[R]eplace Current Word `*cgn`" })

-- marks
map("n", "<C-g><C-m>", "`mzt10<C-y>", { desc = "`mzt10<C-y>" })
map("n", "<C-g><C-;>", "zt10<C-y>", { desc = "zt10<C-y>" })
map("n", "<C-g><C-g><C-h>", function()
	vim.cmd("windo RestoreCursor")
	vim.cmd("normal! `zzt10k10j")
end, { desc = "`fzt10k10j" })

map("n", "<C-;>C", "<Cmd>cd \\$PWD<CR><Cmd>pwd<CR>", { desc = "cd $PWD" })
map("n", "<C-;>S", "<Cmd>cd \\$SCRAPBOOK_DIR<CR><Cmd>pwd<CR>", { desc = "cd $SCRAPBOOK_DIR" })

-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#u%E3%81%A7%E3%83%AA%E3%83%89%E3%82%A5
map("n", "U", "<C-r>", { desc = "undo" })

-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#y%E3%81%A7%E8%A1%8C%E6%9C%AB%E3%81%BE%E3%81%A7%E3%82%B3%E3%83%94%E3%83%BC
map("n", "Y", "y$", { desc = "y$" })

-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#%E7%A9%BA%E8%A1%8C%E3%81%A7%E3%81%AE%E7%B7%A8%E9%9B%86%E9%96%8B%E5%A7%8B%E6%99%82%E3%81%AB%E8%87%AA%E5%8B%95%E3%81%A7%E3%82%A4%E3%83%B3%E3%83%87%E3%83%B3%E3%83%88
map("n", "i", function()
	return vim.fn.empty(vim.fn.getline(".")) == 1 and '"_cc' or "i"
end, { expr = true })
map("n", "A", function()
	return vim.fn.empty(vim.fn.getline(".")) == 1 and '"_cc' or "A"
end, { expr = true })

-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#%E3%83%9A%E3%83%BC%E3%82%B9%E3%83%88%E7%B5%90%E6%9E%9C%E3%81%AE%E3%82%A4%E3%83%B3%E3%83%87%E3%83%B3%E3%83%88%E3%82%92%E8%87%AA%E5%8B%95%E3%81%A7%E6%8F%83%E3%81%88%E3%82%8B
map("n", "p", "p`]")
map("n", "P", "P`]")

-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#%E7%9B%B4%E5%89%8D%E3%81%AE%E3%83%9A%E3%83%BC%E3%82%B9%E3%83%88%E7%AF%84%E5%9B%B2%E3%82%92%E9%81%B8%E6%8A%9E%E3%81%99%E3%82%8B
map("n", "gV", "`[v`]")

-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#%E7%9B%B4%E5%89%8D%E3%83%BB%E7%9B%B4%E5%BE%8C%E3%81%AE%E7%A9%BA%E8%A1%8C%E3%81%AB%E9%A3%9B%E3%81%B6
map("n", "f<CR>", "}")
map("n", "F<CR>", "{")

map("n", "<Space>;", "@:", { desc = "Re-run the last command" })
map("n", "q:", "<Nop>", { desc = "Disable cmdwin" })

map("n", "gf", function()
	local cfile = vim.fn.expand("<cfile>")

	local orig_wildignore = vim.o.wildignore
	vim.o.wildignore = ""
	local path = vim.fn.findfile(cfile)
	vim.o.wildignore = orig_wildignore

	if path ~= "" then
		vim.api.nvim_feedkeys("gf", "n", false)
	else
		local dir = vim.fn.fnamemodify(cfile, ":h")
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
		if string.find(cfile, ".", 1, true) ~= nil then
			vim.cmd("edit " .. cfile)
		else
			vim.cmd("edit " .. cfile .. require("telekasten").Cfg.extension)
		end
	end
end, { desc = "Go to file under cursor" })

-- # Insert

-- Insertモードを抜けたときにIMEオフ
map("i", "<Esc>", function()
	local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
	vim.fn.execute("!im-select com.apple.keylayout.ABC", "silent")
	vim.api.nvim_feedkeys(esc, "n", true)
end)

-- Insert ellipsis
map("i", "<A-;>", "…")
map("i", "<A-Space>", " ")
map("i", "<A-->", "–")

map("i", "<C-g><C-n>", "<C-t>", { desc = "Indent" })
map("i", "<C-g><C-p>", "<C-d>", { desc = "Dedent" })
map("i", "<Tab>", "<C-t>", { desc = "Indent <<" })
map("i", "<S-Tab>", "<C-d>", { desc = "Indent <<" })

-- # Visual

-- # Command
-- Esc
map("n", "<C-g><C-g><C-g>", ":set nopaste<CR>:nohlsearch<CR>:cclose<CR>:lclose<CR>", { desc = "nopaste; nohlsearch" })

-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#i%3Cspace%3E%E3%81%A7word%E9%81%B8%E6%8A%9E
map({ "o", "x" }, "i<Space>", "iW", { desc = "select a word" })
-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#visual-%E3%82%B3%E3%83%94%E3%83%BC%E6%99%82%E3%81%AB%E3%82%AB%E3%83%BC%E3%82%BD%E3%83%AB%E4%BD%8D%E7%BD%AE%E3%82%92%E4%BF%9D%E5%AD%98
map("x", "y", function()
	vim.fn.execute("normal! myy`y")
	vim.fn.execute(":delm y")
end)
-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#visual-%E3%83%9A%E3%83%BC%E3%82%B9%E3%83%88%E6%99%82%E3%81%AB%E3%83%AC%E3%82%B8%E3%82%B9%E3%82%BF%E3%81%AE%E5%A4%89%E6%9B%B4%E3%82%92%E9%98%B2%E6%AD%A2
map("x", "p", "P")

-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#visual-%3C%2C-%3E%E3%81%A7%E9%80%A3%E7%B6%9A%E3%81%97%E3%81%A6%E3%82%A4%E3%83%B3%E3%83%87%E3%83%B3%E3%83%88%E3%82%92%E6%93%8D%E4%BD%9C
map("x", "<", "<gv", { desc = "Indent" })
map("x", ">", ">gv", { desc = "Dedent" })
map("x", "<C-g><C-n>", "<gv", { desc = "Indent" })
map("x", "<C-g><C-p>", ">gv", { desc = "Dedent" })

-- https://zenn.dev/vim_jp/articles/2024-06-05-vim-middle-class-features#%E5%BC%95%E7%94%A8%E7%AC%A6%E3%81%A7%E5%9B%B2%E3%81%BE%E3%82%8C%E3%81%9F%E7%AE%87%E6%89%80%E5%85%A8%E4%BD%93%E3%82%92%E9%81%B8%E6%8A%9E%E3%81%99%E3%82%8B
for _, quote in ipairs({ '"', "'", "`" }) do
	vim.keymap.set({ "x", "o" }, "a" .. quote, "2i" .. quote)
end

-- Save
map({ "n", "v" }, "<C-;><C-;>", "<Cmd>write<CR>", { desc = "Save" })

-- Emascs style
map({ "i", "c" }, "<C-b>", "<Left>", { desc = "Emacs like left" })
map({ "i", "c" }, "<C-f>", "<Right>", { desc = "Emacs like right" })
map({ "i", "c" }, "<C-a>", "<Home>", { desc = "Emacs like home" })
map({ "i", "c" }, "<C-e>", "<End>", { desc = "Emacs like end" })
map({ "i", "c" }, "<C-h>", "<BS>", { desc = "Emacs like bs" })
map({ "i", "c" }, "<C-d>", "<Del>", { desc = "Emacs like del" })

-- https://zenn.dev/vim_jp/articles/43d021f461f3a4#x%E3%81%A7%E5%89%8A%E9%99%A4
map("n", "x", '"_x')
map("n", "X", '"_D')
map("x", "x", '"_x')
map("o", "x", "d")

-- Jira
map("n", "<C-;>J", ":<C-u>%s;\\(<C-r><C-w>\\);" .. vim.fn.expand("$JIRA_BASE_URL") .. "\\1;<CR>", { desc = "Jira" })
