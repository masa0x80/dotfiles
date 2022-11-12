local status_ok, p = pcall(require, "trouble")
if not status_ok then
	return
end

p.setup({
	-- require folke/todo-comments.nvim
	mode = "todo",
})

vim.api.nvim_set_keymap("n", "<Leader>v", "<Cmd>Trouble<CR>", { silent = true, noremap = true })
