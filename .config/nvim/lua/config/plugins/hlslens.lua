local status_ok, _ = pcall(require, "hlslens")
if not status_ok then
	return
end

local opts = {}
local keymap = vim.api.nvim_set_keymap

keymap("n", "*", "<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>", opts)
keymap("n", "#", "<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>", opts)
keymap("n", "g*", "<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>", opts)
keymap("n", "g#", "<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>", opts)

keymap("x", "*", "<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>", opts)
keymap("x", "#", "<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>", opts)
keymap("x", "g*", "<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>", opts)
keymap("x", "g#", "<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>", opts)
