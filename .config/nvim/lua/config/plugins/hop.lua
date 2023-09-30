local hop = require("hop")
hop.setup({
	uppercase_labels = true,
})

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap("n", "<Leader><Space>", hop.hint_words, opts)
