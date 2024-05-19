vim.cmd([[
    filetype plugin indent on
    syntax on
]])

vim.api.nvim_create_augroup("_", { clear = true })

-- ref. `:help restore-cursor`
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	group = "_",
	pattern = "*",
	callback = function()
		local line = vim.fn.line
		---@diagnostic disable-next-line: undefined-field
		if not vim.regex([[commit\|rebase]]):match_str(vim.o.ft) and line("'\"") > 1 and line("'\"") <= line("$") then
			vim.fn.execute('normal! g`"')
		end
	end,
})

vim.g.formatter_enabled = true
vim.api.nvim_create_user_command("ToggleFormatter", function()
	vim.g.formatter_enabled = not vim.g.formatter_enabled
	if vim.g.formatter_enabled then
		vim.notify("Formatter enabled")
	else
		vim.notify("Formatter disabled")
	end
end, { desc = "Toggle auto format enabled / disabled" })
