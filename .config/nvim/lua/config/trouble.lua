local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
	return
end

trouble.setup()

vim.api.nvim_set_keymap("n", "<Leader>vv", "<Cmd>Trouble<CR>", { silent = true, noremap = true })
