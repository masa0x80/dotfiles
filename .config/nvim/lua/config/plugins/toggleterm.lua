local status_ok, p = pcall(require, "toggleterm")
if not status_ok then
	return
end

p.setup({
	open_mapping = [[<c-\>]],
	direction = "float",
	float_opts = {
		border = "curved",
	},
	close_on_exit = true,
})

local keymap = vim.keymap.set
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	keymap("t", "<esc>", [[<C-\><C-n>]], opts)
	keymap("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	keymap("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.api.nvim_create_autocmd({ "TermOpen" }, {
	group = "_",
	pattern = "term://*",
	command = "lua set_terminal_keymaps()",
})

local opts = { noremap = true, silent = true }
keymap("n", ",,f", function()
	vim.cmd(vim.v.count1 .. "ToggleTerm direction=float")
end, opts)
keymap("n", ",,j", function()
	vim.cmd(vim.v.count1 .. "ToggleTerm direction=horizontal")
end, opts)
