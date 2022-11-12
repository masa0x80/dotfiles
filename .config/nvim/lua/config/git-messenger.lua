local opts = {}
local keymap = vim.api.nvim_set_keymap
keymap("n", "<C-g><C-l>", "<Plug>(git-messenger)<CR>", opts)

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = "_",
	pattern = "gitmessengerpopup",
	callback = function()
		keymap("n", "<C-o>", "o", {})
		keymap("n", "<C-i>", "O", {})
	end,
})

vim.g.git_messenger_always_into_popup = true
vim.g.git_messenger_include_diff = "current"
vim.g.git_messenger_date_format = "%F %T"
vim.g.git_messenger_floating_win_opts = { border = "rounded" }
