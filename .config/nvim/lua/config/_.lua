vim.cmd([[
    filetype plugin indent on
    syntax on
]])

vim.g.formatter_enabled = true
vim.api.nvim_create_user_command("ToggleFormatter", function()
	vim.g.formatter_enabled = not vim.g.formatter_enabled
	if vim.g.formatter_enabled then
		vim.notify("Formatter enabled")
	else
		vim.notify("Formatter disabled")
	end
end, { desc = "Toggle auto format enabled / disabled" })
vim.api.nvim_create_user_command("DisableFormatter", function()
	vim.g.formatter_enabled = false
	vim.notify("Formatter disabled")
end, { desc = "Disalbe auto format" })
vim.api.nvim_create_user_command("EnableFormatter", function()
	vim.g.formatter_enabled = true
	vim.notify("Formatter enabled")
end, { desc = "Enable auto format" })
