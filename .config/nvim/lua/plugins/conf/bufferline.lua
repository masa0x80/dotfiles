local bufferline = require("bufferline")
bufferline.setup({
	options = {
		buffer_close_icon = "",
		indicator = {
			style = "none",
		},
		style_preset = bufferline.style_preset.no_italic,
		separator_style = "slant",
	},
})

local keymap = vim.keymap.set
keymap("n", "BO", "<Cmd>BufferLineCloseOthers<CR>", { noremap = true })
