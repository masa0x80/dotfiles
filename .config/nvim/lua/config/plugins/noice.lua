require("noice").setup({
	messages = {
		view = "mini",
		view_warn = "mini",
		view_search = false,
	},
})

vim.keymap.set("n", ",m", "<Cmd>Noice<CR>", { noremap = true, silent = true, desc = "Show Messages" })

local color = require("config.color")
local set_hl = vim.api.nvim_set_hl
-- Fix NoiceLspProgressTitle
set_hl(0, "NonText", { fg = color.CommentGrey })
