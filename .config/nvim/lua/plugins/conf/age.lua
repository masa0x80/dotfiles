require("age_secret").setup()

vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
	pattern = "*.age",
	callback = function()
		vim.bo.filetype = "markdown"
	end,
})
