local status_ok, p = pcall(require, "neogen")
if not status_ok then
	return
end

p.setup({})

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>aa", "<Cmd>lua require('neogen').generate()<CR>", opts)
