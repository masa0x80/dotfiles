local status_ok, neogen = pcall(require, "neogen")
if not status_ok then
	return
end

neogen.setup({})

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>aa", "<Cmd>lua require('neogen').generate()<CR>", opts)
