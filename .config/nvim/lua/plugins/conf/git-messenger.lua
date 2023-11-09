local keymap = vim.keymap.set
keymap("n", "<C-g><C-l>", "<Plug>(git-messenger)<CR>", { desc = "Show Git Log" })

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = "_",
	pattern = "gitmessengerpopup",
	callback = function()
		keymap(
			"n",
			"<C-o>",
			"o",
			{ remap = true, buffer = true, desc = "GitMessenger: Back to older commit at the line" }
		)
		keymap(
			"n",
			"<C-i>",
			"O",
			{ remap = true, buffer = true, desc = "GitMessenger: Forward to newer commit at the line" }
		)
		keymap("n", "<C-k>", "<Up>", { remap = true, buffer = true, desc = "GitMessenger: Scroll Up" })
		keymap("n", "<C-j>", "<Down>", { remap = true, buffer = true, desc = "GitMessenger: Scroll Down" })
	end,
})
