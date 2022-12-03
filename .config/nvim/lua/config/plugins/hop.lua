local status_ok, p = pcall(require, "hop")
if not status_ok then
	return
end
p.setup()

local opts = {}
vim.keymap.set("", "<Leader>h", "<Cmd>HopChar2<CR>", opts)
vim.keymap.set("", "<Leader>w", "<Cmd>HopWord<CR>", opts)
vim.keymap.set("", "<Leader>l", "<Cmd>HopLine<CR>", opts)
