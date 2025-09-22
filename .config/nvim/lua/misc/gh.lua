vim.api.nvim_create_user_command("GhOpenPR", function()
	vim.fn.system("gh pr view --web")
end, {})

local keymap = vim.keymap.set
keymap("n", "<Leader>ogp", "<Cmd>GhOpenPR<CR>", {})
