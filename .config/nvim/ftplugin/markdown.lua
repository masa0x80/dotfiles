local opts = { noremap = true, silent = true, buffer = true, desc = "Insert dash" }
local map = vim.keymap.set

-- Insert dash
map("n", "<C-g><C-i>", "I- <Esc>A<Esc>", opts)
map("i", "<C-g><C-i>", "<Esc>I- <Esc>A", opts)
map("v", "<C-g><C-i>", "<Esc><Cmd>:'<,'>s/^\\(\\s*\\)\\(\\S\\)/\\1- \\2/g<CR>:nohlsearch<CR>", opts)
