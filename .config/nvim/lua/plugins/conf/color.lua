vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter" }, {
	group = "_",
	pattern = { "*" },
	command = [[call matchadd('ExtraWhiteSpace', '[\u200B\u3000]')]],
})
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	group = "_",
	pattern = { "*" },
	callback = function()
		vim.api.nvim_set_hl(0, "ExtraWhiteSpace", { bg = "#2b5d63" })
	end,
})
