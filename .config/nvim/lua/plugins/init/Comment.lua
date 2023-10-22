-- line comment
vim.api.nvim_set_keymap("n", "<C-_><C-_>", "gcc", { desc = "Toggle line-comment" })
vim.api.nvim_set_keymap("v", "<C-_><C-_>", "gc", { desc = "Toggle line-comment" })

-- block comment
vim.api.nvim_set_keymap("n", "<C-_><C-b>", "gbc", { desc = "Toggle block-comment" })
vim.api.nvim_set_keymap("v", "<C-_><C-b>", "gb", { desc = "Toggle block-comment" })
