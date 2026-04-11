local M = {}

local UNORDERED_LIST_PATTERN = "^%s*[-*+] $"
local TASK_PATTERN = "^%s*[-*+] %[[x%- ]%] $"

M.toggle_todo = function(opts)
	opts = opts or {}

	local curlinenr = opts.linenr or vim.fn.line(".")
	local curline = vim.api.nvim_buf_get_lines(0, curlinenr - 1, curlinenr, false)[1]
	local stripped = vim.trim(curline)
	local repline

	if opts.reverse ~= true then
		if
			vim.startswith(stripped, "- ")
			and not vim.startswith(stripped, "- [x] ")
			and not vim.startswith(stripped, "- [-] ")
			and not vim.startswith(stripped, "- [ ] ")
		then
			repline = curline:gsub("%- ", "- [ ] ", 1)
		else
			if vim.startswith(stripped, "- [ ]") then
				if opts.skip_progress ~= true then
					repline = curline:gsub("%- %[ %]", "- [-]", 1)
				else
					repline = curline:gsub("%- %[ %]", "- [x]", 1)
				end
			elseif vim.startswith(stripped, "- [-]") then
				repline = curline:gsub("%- %[%-%]", "- [x]", 1)
			else
				if vim.startswith(stripped, "- [x]") then
					repline = curline:gsub("%- %[x%]", "-", 1)
				else
					repline = curline:gsub("(%S)", "- [ ] %1", 1)
				end
			end
		end
	else
		if
			vim.startswith(stripped, "- ")
			and not vim.startswith(stripped, "- [x] ")
			and not vim.startswith(stripped, "- [-] ")
			and not vim.startswith(stripped, "- [ ] ")
		then
			repline = curline:gsub("%- ", "- [x] ", 1)
		else
			if vim.startswith(stripped, "- [x]") then
				if opts.skip_progress ~= true then
					repline = curline:gsub("%- %[x%]", "- [-]", 1)
				else
					repline = curline:gsub("%- %[x%]", "- [ ]", 1)
				end
			elseif vim.startswith(stripped, "- [-]") then
				repline = curline:gsub("%- %[%-%]", "- [ ]", 1)
			else
				if vim.startswith(stripped, "- [ ]") then
					repline = curline:gsub("%- %[ %]", "-", 1)
				else
					repline = curline:gsub("(%S)", "- [x] %1", 1)
				end
			end
		end
	end
	vim.api.nvim_buf_set_lines(0, curlinenr - 1, curlinenr, false, { repline })
end

M.toggle_check = function(opts)
	opts = opts or {}

	local curlinenr = opts.linenr or vim.fn.line(".")
	local curline = vim.api.nvim_buf_get_lines(0, curlinenr - 1, curlinenr, false)[1]
	local repline

	if string.match(curline, string.sub(TASK_PATTERN, 0, -2)) then
		M.toggle_todo(opts)
		return
	elseif string.match(curline, string.sub(UNORDERED_LIST_PATTERN, 0, -2)) then
		repline = curline:gsub("[-*+] (%S)", "%1", 1)
	else
		repline = curline:gsub("(%S)", "- %1", 1)
	end
	vim.api.nvim_buf_set_lines(0, curlinenr - 1, curlinenr, false, { repline })
end

M.get_lines = function()
	local startline = vim.fn.line("v")
	local endline = vim.fn.line(".")
	if startline > endline then
		local tmp = startline
		startline = endline
		endline = tmp
	end
	return { startline, endline }
end

return M
