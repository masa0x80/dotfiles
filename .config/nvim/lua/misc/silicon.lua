vim.api.nvim_create_user_command("Silicon", function(opts)
	local filetype = vim.api.nvim_eval("&filetype")
	if filetype == "" then
		filetype = "zsh"
	end
	local cmd = "silicon --to-clipboard -l " .. filetype .. " "
	if opts.range == 0 then
		cmd = cmd .. vim.fn.expand("%")
	else
		vim.fn.execute(opts.line1 .. "," .. opts.line2 .. "yank")
		cmd = cmd .. "--from-clipboard"
	end
	vim.fn.jobstart(cmd)
	print(cmd)
end, {
	range = 2,
})

vim.api.nvim_create_user_command("SiliconHighlight", function(opts)
	local filetype = vim.api.nvim_eval("&filetype")
	if filetype == "" then
		filetype = "zsh"
	end
	local cmd = "silicon --to-clipboard -l " .. filetype .. " " .. vim.fn.expand("%")
	if opts.range == 2 then
		cmd = cmd .. " --highlight-lines " .. opts.line1 .. "-" .. opts.line2
	end
	vim.fn.jobstart(cmd)
	print(cmd)
end, {
	range = 2,
})
