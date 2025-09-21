local map = vim.keymap.set
map("n", "<C-g><C-l>", "<Plug>(git-messenger)<CR>", { desc = "Show Git Log" })

require("utils").create_autocmd({ "FileType" }, {
	pattern = "gitmessengerpopup",
	callback = function()
		map("n", "<C-o>", "o", { remap = true, buffer = true, desc = "GitMessenger: Back to older commit at the line" })
		map(
			"n",
			"<C-i>",
			"O",
			{ remap = true, buffer = true, desc = "GitMessenger: Forward to newer commit at the line" }
		)
		map("n", "<C-k>", "<Up>", { remap = true, buffer = true, desc = "GitMessenger: Scroll Up" })
		map("n", "<C-j>", "<Down>", { remap = true, buffer = true, desc = "GitMessenger: Scroll Down" })
	end,
})
