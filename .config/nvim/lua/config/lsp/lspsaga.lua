local status_ok, p = pcall(require, "lspsaga")
if not status_ok then
	return
end

p.setup({
	border_style = "round",
	rename_action_keys = {
		quit = "<C-c>",
	},
})

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
keymap("n", "gh", "<Cmd>Lspsaga lsp_finder<CR>", opts)
keymap("n", "<Leader>rn", "<Cmd>Lspsaga rename<CR>", opts)
keymap("i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)

keymap("n", "<Leader>ca", "<Cmd>Lspsaga code_action<CR>", opts)
keymap("v", "<Leader>ca", "<Cmd>Lspsaga range_code_action<CR>", opts)

keymap("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap("n", "<C-f>", "<Cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", {})
keymap("n", "<C-b>", "<Cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", {})
keymap("n", "<C-d>", "<Cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", {})
keymap("n", "<C-u>", "<Cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", {})
