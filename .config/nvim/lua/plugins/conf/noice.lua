require("noice").setup({
	messages = {
		view = "mini",
		view_error = "mini",
		view_warn = "mini",
		view_search = false,
	},
})

vim.keymap.set("n", "<Leader>m", "<Cmd>NoiceAll<CR>", { noremap = true, silent = true, desc = "Show All Messages" })
