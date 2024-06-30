local opts = { noremap = true, silent = true, buffer = true, desc = "Insert dash" }
local map = vim.keymap.set

-- Insert dash
map("v", "<C-g><C-i>", "<Esc><Cmd>:'<,'>s/^\\(\\s*\\)\\(\\S\\)/\\1- \\2/g<CR>:nohlsearch<CR>", opts)
