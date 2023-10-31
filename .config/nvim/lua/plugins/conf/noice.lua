require("noice").setup({
	messages = {
		view = "mini",
		view_error = "mini",
		view_warn = "mini",
		view_search = false,
	},
})

vim.keymap.set("n", ",m", "<Cmd>Noice<CR>", { noremap = true, silent = true, desc = "Show Messages" })
