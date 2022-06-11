local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<C-g><C-p>", "<Cmd>Back<CR>", opts)
keymap("n", "<C-g><C-n>", "<Cmd>Forward<CR>", opts)
