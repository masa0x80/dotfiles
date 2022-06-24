local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

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
keymap("n", "<A-k>", "<Cmd>resize -2<CR>", opts)
keymap("n", "<A-j>", "<Cmd>resize +2<CR>", opts)
keymap("n", "<A-h>", "<Cmd>vertical resize -2<CR>", opts)
keymap("n", "<A-l>", "<Cmd>vertical resize +2<CR>", opts)

-- Disable EX-mode (if you enter EX-mode, push gQ)
keymap("n", "Q", "<Nop>", opts)

-- Save
keymap("n", ";", "<Nop>", opts)
keymap("n", ";;", "<Cmd>write<CR>", { noremap = true })

-- Quit
keymap("n", "<Leader>q", "<Cmd>q<CR>", opts)
keymap("n", "<Leader>Q", "<Cmd>qa<CR>", opts)

-- Windows
keymap("n", "<C-w>-", "<C-w>s", opts)
keymap("n", "<C-w>|", "<C-w>v", opts)
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

-- Reload vimrc
keymap("n", "<Leader>R", "<Cmd>source $MYVIMRC<CR> <Cmd>echom 'Reload ' .. $MYVIMRC<CR>", { noremap = true })

-- Replace
keymap("n", "<Leader>re", ":<C-u>%s;<C-r><C-w>;g<Left><Left>;", opts)

-- Toggle relativenumber
keymap("n", "<Leader>N", "<Cmd>setlocal relativenumber!<CR>", opts)

-- Folding
keymap("n", "z-", "zr", opts)
keymap("n", "z_", "zm", opts)

keymap("n", "<Leader>p", "<Cmd>cd \\$PWD<CR><Cmd>pwd<CR>", opts)
keymap("n", "<Leader>s", "<Cmd>cd \\$SCRAPBOOK_DIR<CR><Cmd>pwd<CR>", opts)

-- # Insert
keymap("i", "<C-p>", "<Up>", opts)
keymap("i", "<C-n>", "<Down>", opts)
keymap("i", "<C-b>", "<Left>", opts)
keymap("i", "<C-f>", "<Right>", opts)
keymap("i", "<C-a>", "<Esc>I", opts)
keymap("i", "<C-e>", "<Esc>A", opts)
keymap("i", "<C-d>", "<Del>", opts)
keymap("i", "<C-g><C-h>", "<Esc>bi", opts)
keymap("i", "<C-g><C-l>", "<Esc>ea", opts)

-- Indent
keymap("i", "<C-g><C-n>", "<Esc>v>gi<Right><Right>", opts)
keymap("i", "<C-g><C-p>", "<Left><Left><Esc>v<gi", opts)

-- # Visual
-- Paste
keymap("v", "p", '"_dP', opts)

-- Stay in indent mode
keymap("v", "<C-g><C-p>", "<gv", opts)
keymap("v", "<C-g><C-n>", ">gv", opts)

-- Move text up and down
keymap("v", "J", ":move '>+1<CR>gv-gv", opts)
keymap("v", "K", ":move '<-2<CR>gv-gv", opts)

-- # Command
keymap("c", "<C-b>", "<Left>", {})
keymap("c", "<C-f>", "<Right>", {})
keymap("c", "<C-a>", "<Home>", {})

-- Esc
keymap("n", "<C-c>", "<Esc>", opts)
keymap("i", "<C-c>", "<Esc>", opts)
keymap("n", "<Esc><Esc>", ":set nopaste<CR>:nohlsearch<CR>:cclose<CR>:lclose<CR>", opts)
keymap("n", "<C-c><C-c>", ":set nopaste<CR>:nohlsearch<CR>:cclose<CR>:lclose<CR>", opts)

-- Jump
keymap("n", "<C-g><C-j>", "]M", opts)
keymap("v", "<C-g><C-j>", "]M", opts)
keymap("n", "<C-g><C-k>", "[m", opts)
keymap("v", "<C-g><C-k>", "[m", opts)

-- Delete a character without yanking
keymap("n", "x", '"_x', opts)
