vim.cmd([[
    filetype plugin indent on
    syntax on
]])
vim.cmd.colorscheme("habamax")

vim.api.nvim_create_augroup("_", { clear = true })

-- ref. `:help restore-cursor`
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	group = "_",
	pattern = "*",
	callback = function()
		local line = vim.fn.line
		if not vim.regex([[commit\|rebase]]):match_str(vim.o.ft) and line("'\"") > 1 and line("'\"") <= line("$") then
			vim.fn.execute('normal! g`"')
		end
	end,
})
