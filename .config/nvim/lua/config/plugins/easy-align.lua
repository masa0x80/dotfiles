local keymap = vim.keymap.set

-- Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
keymap("v", "<Enter>", "<Plug>(EasyAlign)", { desc = "EasyAlign" })

-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
keymap("n", "ga", "<Plug>(EasyAlign)", { desc = "EasyAlign" })
