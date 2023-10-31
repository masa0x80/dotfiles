-- ディレクトリーを開いたときにneo-treeを開く
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = "_",
	pattern = "",
	callback = function()
		if vim.fn.isdirectory(vim.fn.expand("%")) == 1 then
			vim.fn.execute("Neotree current %")
		end
	end,
})
