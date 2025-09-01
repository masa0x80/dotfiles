local UNORDERED_LIST_PATTERN = "^%s*[-*+] $"
local TASK_PATTERN = "^%s*[-*+] %[[x%- ]%] $"
local toggle_todo = function(opts)
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

local toggle_check = function(opts)
	opts = opts or {}

	local curlinenr = opts.linenr or vim.fn.line(".")
	local curline = vim.api.nvim_buf_get_lines(0, curlinenr - 1, curlinenr, false)[1]
	local repline

	if string.match(curline, string.sub(TASK_PATTERN, 0, -2)) then
		toggle_todo(opts)
		return
	elseif string.match(curline, string.sub(UNORDERED_LIST_PATTERN, 0, -2)) then
		repline = curline:gsub("[-*+] (%S)", "%1", 1)
	else
		repline = curline:gsub("(%S)", "- %1", 1)
	end
	vim.api.nvim_buf_set_lines(0, curlinenr - 1, curlinenr, false, { repline })
end

local get_lines = function()
	local startline = vim.fn.line("v")
	local endline = vim.fn.line(".")
	if startline > endline then
		local tmp = startline
		startline = endline
		endline = tmp
	end
	return { startline, endline }
end

return {
	"renerocksai/telekasten.nvim",
	version = "*",
	keys = {
		{ "<C-;>z", "<Cmd>Telekasten panel<CR>", noremap = true, silent = true },
		{ "<C-;>i", "<Cmd>Telekasten insert_link<CR>", noremap = true, silent = true },
		{ "<C-;>I", "<Cmd>Telekasten insert_img_link<CR>", noremap = true, silent = true },
		{ "g]", "<Cmd>Telekasten follow_link<CR>", noremap = true, silent = true },
		{ "g[", "<Cmd>Telekasten show_backlinks<CR>", noremap = true, silent = true },
		{ "<C-;>n", "<Cmd>Telekasten repline_note<CR>", noremap = true, silent = true },
		{ "<C-;>r", "<Cmd>Telekasten find_friends<CR>", noremap = true, silent = true },
		{ "<C-;>t", "<Cmd>Telekasten show_tags<CR>", noremap = true, silent = true },
		{
			"<C-g><C-i>",
			function()
				toggle_check({ skip_progress = true })
			end,
			noremap = true,
			silent = true,
			mode = { "n", "i" },
		},
		{
			"<C-g><C-o>",
			function()
				toggle_check({ skip_progress = true, reverse = true })
			end,
			noremap = true,
			silent = true,
			mode = { "n", "i" },
		},
		{
			"<C-g><C-i>",
			function()
				local lines = get_lines()
				for n = lines[1], lines[2] do
					toggle_check({ skip_progress = true, linenr = n })
				end
			end,
			noremap = true,
			silent = true,
			mode = { "x" },
		},
		{
			"<C-g><C-o>",
			function()
				local lines = get_lines()
				for n = lines[1], lines[2] do
					toggle_check({ skip_progress = true, linenr = n, reverse = true })
				end
			end,
			noremap = true,
			silent = true,
			mode = { "x" },
		},
		{
			"<C-g><C-g><C-i>",
			toggle_todo,
			noremap = true,
			silent = true,
			mode = { "n", "i" },
		},
		{
			"<C-g><C-g><C-o>",
			function()
				toggle_todo({ reverse = true })
			end,
			noremap = true,
			silent = true,
			mode = { "n", "i" },
		},
		{
			"<C-g><C-g><C-i>",
			function()
				local lines = get_lines()
				for n = lines[1], lines[2] do
					toggle_todo({ linenr = n })
				end
			end,
			noremap = true,
			silent = true,
			mode = "x",
		},
		{
			"<C-g><C-g><C-o>",
			function()
				local lines = get_lines()
				for n = lines[1], lines[2] do
					toggle_todo({ linenr = n, reverse = true })
				end
			end,
			noremap = true,
			silent = true,
			mode = "x",
		},
		{ "<C-;>d", "<Cmd>Telekasten goto_today<CR>", noremap = true, silent = true },
		{ "<C-;>w", "<Cmd>Telekasten goto_thisweek<CR>", noremap = true, silent = true },
		{
			"<C-;>m",
			function()
				local vault_path = require("telekasten").Cfg.home
				local year = os.date("%Y")
				local month = os.date("%m")
				local file_path = ("%s/monthly/%s/%s-%s.md"):format(vault_path, year, year, month)
				if vim.fn.filereadable(file_path) == 0 then
					vim.fn.execute(("edit %s/templates/monthly.md"):format(vault_path))
					vim.fn.execute("%y")
					vim.fn.execute("bd")
				end
				vim.fn.execute(("edit %s"):format(file_path))
				if vim.fn.filereadable(file_path) == 0 then
					vim.cmd("normal! P")
				end
			end,
			noremap = true,
			silent = true,
		},
		{ "<C-;>c", "<Cmd>Telekasten show_calendar<CR>", noremap = true, silent = true },
		{
			"<C-;>k",
			"<Cmd>lua require('telescope._extensions.kensaku').exports.kensaku({ cwd = require('telekasten').Cfg.home })<CR>",
			noremap = true,
			silent = true,
		},
		{ "<C-;>v", "<Cmd>Telekasten switch_vault<CR>", noremap = true, silent = true },
		{
			"<C-;>t",
			function()
				vim.fn.setreg("+", vim.fn.expand("%:."))
				require("telekasten").new_templated_note()
			end,
			noremap = true,
			silent = true,
		},
	},
	config = require("config.utils").load("conf/telekasten"),
	init = require("config.utils").load("init/telekasten"),
	dependencies = {
		"renerocksai/calendar-vim",
	},
}
