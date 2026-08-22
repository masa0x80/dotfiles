-- Formatter toggle
vim.g.formatter_enabled = true
vim.api.nvim_create_user_command("ToggleFormatter", function()
	vim.g.formatter_enabled = not vim.g.formatter_enabled
	if vim.g.formatter_enabled then
		vim.notify("Formatter enabled")
	else
		vim.notify("Formatter disabled")
	end
end, { desc = "Toggle auto format enabled / disabled" })
vim.api.nvim_create_user_command("DisableFormatter", function()
	vim.g.formatter_enabled = false
	vim.notify("Formatter disabled")
end, { desc = "Disable auto format" })
vim.api.nvim_create_user_command("EnableFormatter", function()
	vim.g.formatter_enabled = true
	vim.notify("Formatter enabled")
end, { desc = "Enable auto format" })

-- range 指定があればその範囲、なければバッファ全体にフィルターコマンドを適用するユーザーコマンドを定義する
local function create_filter_command(name, filter)
	vim.api.nvim_create_user_command(name, function(opts)
		local range = opts.range == 2 and (opts.line1 .. "," .. opts.line2) or "%"
		vim.fn.execute(range .. "!" .. filter)
	end, {
		range = 2,
	})
end

-- JSON.stringify
create_filter_command("JsonStringify", "xargs -0 -I {} node -e 'console.log(JSON.stringify({}, null, 2))'")

-- JSON.parse
create_filter_command("JsonParse", "xargs -0 -I {} node -e 'console.log({})'")

-- Jq
create_filter_command("Jq", "jq .")
create_filter_command("JqCompact", "jq -c .")

vim.api.nvim_create_user_command("F", function(opts)
	local ft = opts.fargs[1]
	vim.bo.filetype = ft
end, {
	nargs = 1,
})

vim.api.nvim_create_user_command("AddAbbrComma", function(opts)
	local k = opts.fargs[1]
	local v = opts.fargs[2]
	local cmd = "iabbr " .. k .. " " .. v .. ":"
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

-- opts.range に応じて対象行範囲 (0-indexed、終端は exclusive) を返す
local function buf_range(opts)
	if opts.range == 2 then
		return opts.line1 - 1, opts.line2
	end
	return 0, vim.api.nvim_buf_line_count(0)
end

vim.api.nvim_create_user_command("ReplaceDate", function(opts)
	local date = opts.args
	if date == "" then
		date = os.date("%Y-%m-%d")
	end

	local date_pattern = "(%d%d%d%d)%-(%d%d)%-(%d%d)"
	local year, month, day = string.match(date, date_pattern)
	local line1, line2 = buf_range(opts)
	local lines = vim.api.nvim_buf_get_lines(0, line1, line2, false)
	for i, line in ipairs(lines) do
		if year and month and day then
			line = line:gsub("%f[%a]YYYY%-MM%-DD%f[%A]", string.format("%s-%s-%s", year, month, day))
		end
		if year and month then
			line = line:gsub("%f[%a]YYYY%-MM%f[%A]", string.format("%s-%s", year, month))
		end
		if year then
			line = line:gsub("%f[%a]YYYY%f[%A]", string.format("%s", year))
		end
		if month then
			line = line:gsub("%f[%a]MM%f[%A]", tonumber(month))
		end
		if day then
			line = line:gsub("%f[%a]DD%f[%A]", tonumber(day))
		end
		lines[i] = line
	end
	vim.api.nvim_buf_set_lines(0, line1, line2, false, lines)
end, {
	nargs = "?",
	range = 2,
})

vim.api.nvim_create_user_command("ReplaceHyphen", function(opts)
	local line1, line2 = buf_range(opts)
	local lines = vim.api.nvim_buf_get_lines(0, line1, line2, false)
	for i, line in ipairs(lines) do
		line = line:gsub("%-(%d)", "–%1")
		line = line:gsub("(%d)%-", "%1–")
		lines[i] = line
	end
	vim.api.nvim_buf_set_lines(0, line1, line2, false, lines)
end, {
	nargs = "?",
	range = 2,
})
