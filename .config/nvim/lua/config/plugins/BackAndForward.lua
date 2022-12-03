local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<C-g><C-o>", "<Cmd>Back<CR>", opts)
keymap("n", "<C-g><C-i>", "<Cmd>Forward<CR>", opts)
