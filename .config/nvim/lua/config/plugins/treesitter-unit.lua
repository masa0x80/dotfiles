local status_ok, _ = pcall(require, "treesitter-unit")
if not status_ok then
	return
end

local opts = { noremap = true }
local keymap = vim.api.nvim_set_keymap

keymap("x", "iu", ':lua require"treesitter-unit".select()<CR>', opts)
keymap("x", "au", ':lua require"treesitter-unit".select(true)<CR>', opts)
keymap("o", "iu", ':<C-u>lua require"treesitter-unit".select()<CR>', opts)
keymap("o", "au", ':<C-u>lua require"treesitter-unit".select(true)<CR>', opts)
