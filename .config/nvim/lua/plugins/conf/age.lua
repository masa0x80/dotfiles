require("age_secret").setup()

vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
	pattern = "*",
	callback = function()
		if vim.fn.expand("%:t"):match("%.md%.age$") then
			vim.bo.filetype = "markdown"
		elseif vim.fn.expand("%:t"):match("%.json%.age$") then
			vim.bo.filetype = "json"
		elseif vim.fn.expand("%:t"):match("%.csv%.age$") then
			vim.bo.filetype = "csv"
		end
	end,
})
