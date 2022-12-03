local status_ok, p = pcall(require, "Comment")
if not status_ok then
	return
end

p.setup()
-- line comment
vim.api.nvim_set_keymap("n", "<C-_><C-_>", "gcc", {})
vim.api.nvim_set_keymap("v", "<C-_><C-_>", "gc", {})
-- block comment
vim.api.nvim_set_keymap("n", "<C-_><C-b>", "gbc", {})
vim.api.nvim_set_keymap("v", "<C-_><C-b>", "gb", {})
