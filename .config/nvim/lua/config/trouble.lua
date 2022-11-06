local status_ok, p = pcall(require, "trouble")
if not status_ok then
	return
end

p.setup()

vim.api.nvim_set_keymap("n", "<Leader>V", "<Cmd>Trouble<CR>", { silent = true, noremap = true })
