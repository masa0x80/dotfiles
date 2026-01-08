local map = vim.api.nvim_set_keymap

-- line-comment
map("n", "<C-_><C-_>", "gcc", { desc = "Toggle line-comment" })
map("v", "<C-_><C-_>", "gc", { desc = "Toggle line-comment" })

-- block-comment
map("n", "<C-_><C-b>", "gbc", { desc = "Toggle block-comment" })
map("v", "<C-_><C-b>", "gb", { desc = "Toggle block-comment" })

-- line-comment (for Ghostty)
map("n", "<C-/><C-/>", "gcc", { desc = "Toggle line-comment" })
map("v", "<C-/><C-/>", "gc", { desc = "Toggle line-comment" })

-- block-comment (for Ghostty)
map("n", "<C-/><C-b>", "gbc", { desc = "Toggle block-comment" })
map("v", "<C-/><C-b>", "gb", { desc = "Toggle block-comment" })
