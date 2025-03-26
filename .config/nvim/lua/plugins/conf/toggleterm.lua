require("toggleterm").setup({
	open_mapping = [[<C-\>]],
	direction = "horizontal",
	float_opts = {
		border = "curved",
	},
	close_on_exit = true,
})

local map = vim.keymap.set
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	map("t", "<Esc>", [[<C-\><C-n>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.api.nvim_create_autocmd({ "TermOpen" }, {
	group = "_",
	pattern = "term://*",
	command = "lua set_terminal_keymaps()",
})
