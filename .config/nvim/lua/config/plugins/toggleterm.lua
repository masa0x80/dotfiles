require("toggleterm").setup({
	open_mapping = [[<C-\>]],
	direction = "horizontal",
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

keymap("n", ",,f", function()
	vim.cmd(vim.v.count1 .. "ToggleTerm direction=float")
end, { noremap = true, silent = true, desc = "<v:count1>ToggleTerm direction=float" })
keymap("n", ",,j", function()
	vim.cmd(vim.v.count1 .. "ToggleTerm direction=horizontal")
end, { noremap = true, silent = true, desc = "<v:count1>ToggleTerm direction=horizontal" })
