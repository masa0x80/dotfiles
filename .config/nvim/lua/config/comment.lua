local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

comment.setup()
vim.api.nvim_set_keymap("n", "<C-_><C-_>", "gcc", {})
vim.api.nvim_set_keymap("v", "<C-_><C-_>", "gc", {})
