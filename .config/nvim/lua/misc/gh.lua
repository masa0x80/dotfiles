vim.api.nvim_create_user_command("GhOpenRepo", function()
	vim.fn.system("gh browse")
end, {})

vim.api.nvim_create_user_command("GhOpenFile", function()
	local branch = vim.fn.trim(vim.fn.system("git current-branch"))
	vim.fn.system("gh browse " .. vim.fn.expand("%") .. " --branch " .. branch)
end, {})

vim.api.nvim_create_user_command("GhOpenPR", function()
	vim.fn.system("gh pr view --web")
end, {})
