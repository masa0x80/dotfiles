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
	end,
})

vim.g.git_messenger_always_into_popup = true
vim.g.git_messenger_include_diff = "current"
vim.g.git_messenger_date_format = "%F %T"
vim.g.git_messenger_floating_win_opts = { border = "rounded" }
