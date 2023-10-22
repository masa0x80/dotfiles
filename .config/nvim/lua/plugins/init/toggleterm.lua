local keymap = vim.keymap.set
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	keymap("t", "<Esc>", [[<C-\><C-n>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.api.nvim_create_autocmd({ "TermOpen" }, {
	group = "_",
	pattern = "term://*",
	command = "lua set_terminal_keymaps()",
})

vim.api.nvim_create_user_command("LG", function()
	require("toggleterm").exec_command('cmd="git fzf show" direction="float"')
end, {})

vim.api.nvim_create_user_command("REV", function()
	require("toggleterm").exec_command('cmd="git review" direction="float"')
end, {})
