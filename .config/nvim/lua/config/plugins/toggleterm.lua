require("toggleterm").setup({
	open_mapping = [[<C-\>]],
	direction = "float",
	float_opts = {
		border = "curved",
	},
	close_on_exit = true,
})

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

keymap("n", ";F", function()
	vim.cmd(vim.v.count1 .. "ToggleTerm direction=float")
end, { noremap = true, silent = true, desc = "<v:count1>ToggleTerm direction=float" })
keymap("n", ";J", function()
	vim.cmd(vim.v.count1 .. "ToggleTerm direction=horizontal")
end, { noremap = true, silent = true, desc = "<v:count1>ToggleTerm direction=horizontal" })

vim.api.nvim_create_user_command("LG", function()
	require("toggleterm").exec_command('cmd="git fzf show" direction="float"')
end, {})

vim.api.nvim_create_user_command("REV", function()
	require("toggleterm").exec_command('cmd="git review" direction="float"')
end, {})
