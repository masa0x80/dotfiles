local status_ok, p = pcall(require, "incline")
if not status_ok then
	return
end

p.setup()

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<Leader><C-g>", "<Cmd>lua require'incline'.toggle()<CR>", opts)
