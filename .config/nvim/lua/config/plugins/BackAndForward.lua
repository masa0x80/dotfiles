local keymap = vim.keymap.set
keymap("n", "<C-g><C-o>", "<Cmd>Back<CR>", { noremap = true, silent = true, desc = "BackAndForward: Back" })
keymap("n", "<C-g><C-i>", "<Cmd>Forward<CR>", { noremap = true, silent = true, desc = "BackAndForward: Forward" })
