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

vim.api.nvim_create_user_command("LG", function()
	require("toggleterm").exec_command('cmd="git fzf show" direction="float"')
end, {})

vim.api.nvim_create_user_command("REV", function()
	require("toggleterm").exec_command('cmd="git review" direction="float"')
end, {})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "double",
	},
	-- function to run on opening the terminal
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,
	-- function to run on closing the terminal
	on_close = function(term)
		vim.cmd("startinsert!")
	end,
})

function _lazygit_toggle()
	lazygit:toggle()
end
