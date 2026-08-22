-- 現在のバッファの filetype (未設定なら "zsh") を返す
local function current_filetype()
	local filetype = vim.api.nvim_eval("&filetype")
	if filetype == "" then
		filetype = "zsh"
	end
	return filetype
end

vim.api.nvim_create_user_command("Silicon", function(opts)
	local cmd = "silicon --to-clipboard -l " .. current_filetype() .. " "
	if opts.range == 0 then
		cmd = cmd .. vim.fn.expand("%")
	else
		vim.fn.execute(opts.line1 .. "," .. opts.line2 .. "yank")
		cmd = cmd .. "--from-clipboard"
	end
	vim.fn.jobstart(cmd)
end, {
	range = 2,
})

vim.api.nvim_create_user_command("SiliconHighlight", function(opts)
	local cmd = "silicon --to-clipboard -l " .. current_filetype() .. " " .. vim.fn.expand("%")
	if opts.range == 2 then
		cmd = cmd .. " --highlight-lines " .. opts.line1 .. "-" .. opts.line2
	end
	vim.fn.jobstart(cmd)
end, {
	range = 2,
})
