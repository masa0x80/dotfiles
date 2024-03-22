local fp = require("fold-preview")
fp.setup({
	default_keybindings = false,
})

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap("n", "K", fp.show_preview, opts)

require("pretty-fold").setup({})
