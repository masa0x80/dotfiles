local map = vim.api.nvim_set_keymap
-- -- line comment
map("n", "<C-_><C-_>", "gcc", { desc = "Toggle line-comment" })
map("v", "<C-_><C-_>", "gc", { desc = "Toggle line-comment" })

-- -- block comment
map("n", "<C-_><C-b>", "gbc", { desc = "Toggle block-comment" })
map("v", "<C-_><C-b>", "gb", { desc = "Toggle block-comment" })
