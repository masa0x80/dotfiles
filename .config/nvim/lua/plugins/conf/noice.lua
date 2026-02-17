require("noice").setup({
	routes = {
		{
			filter = {
				event = "notify",
				find = "No information available",
			},
			opts = { skip = true },
		},
	},
	messages = {
		view = "mini",
		view_error = "mini",
		view_warn = "mini",
		view_search = false,
	},
})

vim.keymap.set("n", "<Leader>m", "<Cmd>NoiceAll<CR>", { desc = "Show All Messages" })
