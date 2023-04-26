vim.api.nvim_create_user_command("GhOpenRepo", function()
	vim.fn.system("gh browse")
end, {})

vim.api.nvim_create_user_command("GhOpenFile", function()
	local branch = vim.fn.trim(vim.fn.system("git current-branch"))
	local path = vim.fn.substitute(vim.fn.expand("%"), vim.fn.expand("$PWD") .. "/", "", "")
	vim.fn.system("gh browse " .. path .. " --branch " .. branch)
end, {})

vim.api.nvim_create_user_command("GhOpenPR", function()
	vim.fn.system("gh pr view --web")
end, {})
