-- JSON.stringify
vim.api.nvim_create_user_command("JsonStringify", function(args)
	local cmd
	if args.range == 2 then
		cmd = args.line1 .. "," .. args.line2 .. "!xargs -0 -I {} node -e 'console.log(JSON.stringify({}, null, 2))'"
	else
		cmd = "%!xargs -0 -I {} node -e 'console.log(JSON.stringify({}, null, 2))'"
	end
	vim.fn.execute(cmd)
end, {
	range = 2,
})

-- JSON.parse
vim.api.nvim_create_user_command("JsonParse", function(args)
	local cmd
	if args.range == 2 then
		cmd = args.line1 .. "," .. args.line2 .. "!xargs -0 -I {} node -e 'console.log({})'"
	else
		cmd = "%!xargs -0 -I {} node -e 'console.log({})'"
	end
	vim.fn.execute(cmd)
end, {
	range = 2,
})

-- Jq
vim.api.nvim_create_user_command("Jq", function(opts)
	local cmd
	if opts.range == 2 then
		cmd = opts.line1 .. "," .. opts.line2 .. "!jq ."
	else
		cmd = "%!jq ."
	end
	vim.fn.execute(cmd)
end, {
	range = 2,
})
vim.api.nvim_create_user_command("JqCompact", function(opts)
	local cmd
	if opts.range == 2 then
		cmd = opts.line1 .. "," .. opts.line2 .. "!jq -c ."
	else
		cmd = "%!jq -c ."
	end
	vim.fn.execute(cmd)
end, {
	range = 2,
})

vim.api.nvim_create_user_command("F", function(opts)
	local ft = opts.fargs[1]
	if ft ~= nil then
		vim.bo.filetype = ft
	else
		ft = string.match(vim.fn.expand("%:t"), "%.(%w+)%.%w+")
		if ft ~= nil then
			if ft == "md" then
				vim.bo.filetype = "markdown"
			else
				vim.bo.filetype = ft
			end
			vim.fn.execute("TSBufEnable " .. vim.bo.filetype)
		end
	end
end, {
	nargs = "?",
})

vim.api.nvim_create_user_command("AddAbbrComma", function(opts)
	local k = opts.fargs[1]
	local v = opts.fargs[2]
	local cmd = "iabbr " .. k .. " " .. v .. ":<Space>"
	vim.fn.execute(cmd)
end, {
	nargs = "*",
})

vim.api.nvim_create_user_command("EnableCompletion", function()
	vim.b.completion = true
end, {})
vim.api.nvim_create_user_command("DisableCompletion", function()
	vim.b.completion = false
end, {})

vim.api.nvim_create_user_command("ReplaceDate", function(opts)
	local date = opts.args
	if date == "" then
		date = os.date("%Y-%m-%d")
	end

	local date_pattern = "(%d%d%d%d)%-(%d%d)%-(%d%d)"
	local year, month, date = string.match(date, date_pattern)
	if year ~= nil then
		pcall(vim.fn.execute, "%s/YYYY/" .. year .. "/g")
	end
	if month ~= nil then
		pcall(vim.fn.execute, "%s/MM/" .. month .. "/g")
	end
	if date ~= nil then
		pcall(vim.fn.execute, "%s/DD/" .. date .. "/g")
	end
end, { nargs = "?" })

vim.api.nvim_create_user_command("RestoreCursor", function()
	if pcall(vim.cmd, "marks f", { silent = true }) then
		vim.cmd("normal! `fzt10k10j")
	end
end, {})
