vim.api.nvim_create_user_command("GhOpenPR", function()
	vim.fn.system("gh pr view --web")
end, {})

vim.api.nvim_set_keymap("n", "<Leader>gp", ":GhOpenPR<CR>", { silent = true })
