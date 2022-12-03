local keymap = vim.api.nvim_set_keymap

-- Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
keymap("v", "<Enter>", "<Plug>(EasyAlign)", {})

-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
keymap("n", "ga", "<Plug>(EasyAlign)", {})
