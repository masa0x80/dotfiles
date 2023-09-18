local keymap = vim.keymap.set
keymap("n", ",w", "w", { remap = false, desc = "Word forward" })
keymap("n", ",b", "b", { remap = false, desc = "Word backward" })
keymap("n", ",e", "e", { remap = false, desc = "Forward to the end of word" })
keymap("n", ",ge", "ge", { remap = false, desc = "Backword to the end of word" })
keymap("n", "w", "<Plug>(smartword-w)", {})
keymap("n", "b", "<Plug>(smartword-b)", {})
keymap("n", "e", "<Plug>(smartword-e)", {})
keymap("n", "ge", "<Plug>(smartword-ge)", {})
