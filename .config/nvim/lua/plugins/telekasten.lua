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
	cmd = { "Telekasten" },
	keys = {
		{ "<C-;>z", "<Cmd>Telekasten panel<CR>", desc = "Telekasten panel" },
		{ "<C-;>i", "<Cmd>Telekasten insert_link<CR>", desc = "Telekasten insert_link" },
		{ "<C-;>I", "<Cmd>Telekasten insert_img_link<CR>", desc = "Telekasten insert_img_link" },
		{ "<C-;>l", "<Cmd>Telekasten follow_link<CR>", desc = "Telekasten follow_link" },
		{ "<C-;>b", "<Cmd>Telekasten show_backlinks<CR>", desc = "Telekasten show_backlinks" },
		{ "<C-;>n", "<Cmd>Telekasten rename_note<CR>", desc = "Telekasten rename_note" },
		{ "<C-;>r", "<Cmd>Telekasten find_friends<CR>", desc = "Telekasten find_friends" },
		{ "<C-;>T", "<Cmd>Telekasten show_tags<CR>", desc = "Telekasten show_tags" },
		{
			"<C-g><C-i>",
			function()
				toggle_check({ skip_progress = true })
			end,
			mode = { "n", "i" },
			desc = "Toggle check",
		},
		{
			"<C-g><C-o>",
			function()
				toggle_check({ skip_progress = true, reverse = true })
			end,
			mode = { "n", "i" },
			desc = "Toggle check",
		},
		{
			"<C-g><C-i>",
			function()
				local lines = get_lines()
				for n = lines[1], lines[2] do
					toggle_check({ skip_progress = true, linenr = n })
				end
			end,
			mode = { "x" },
			desc = "Toggle check",
		},
		{
			"<C-g><C-o>",
			function()
				local lines = get_lines()
				for n = lines[1], lines[2] do
					toggle_check({ skip_progress = true, linenr = n, reverse = true })
				end
			end,
			mode = { "x" },
			desc = "Toggle check",
		},
		{
			"<C-g><C-g><C-i>",
			toggle_todo,
			mode = { "n", "i" },
			desc = "Toggle todo",
		},
		{
			"<C-g><C-g><C-o>",
			function()
				toggle_todo({ reverse = true })
			end,
			mode = { "n", "i" },
			desc = "Toggle todo",
		},
		{
			"<C-g><C-g><C-i>",
			function()
				local lines = get_lines()
				for n = lines[1], lines[2] do
					toggle_todo({ linenr = n })
				end
			end,
			mode = "x",
			desc = "Toggle todo",
		},
		{
			"<C-g><C-g><C-o>",
			function()
				local lines = get_lines()
				for n = lines[1], lines[2] do
					toggle_todo({ linenr = n, reverse = true })
				end
			end,
			mode = "x",
			desc = "Toggle todo",
		},
		{ "<C-;>d", "<Cmd>Telekasten goto_today<CR>", desc = "Telekasten goto_today" },
		{ "<C-;>w", "<Cmd>Telekasten goto_thisweek<CR>", desc = "Telekasten goto_thisweek" },
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
			desc = "Telekasten goto_thismonth",
		},
		{ "<C-;>c", "<Cmd>Telekasten show_calendar<CR>", desc = "Telekasten show_calendar" },
		{
			"<C-;>k",
			"<Cmd>lua require('telescope._extensions.kensaku').exports.kensaku({ cwd = require('telekasten').Cfg.home })<CR>",
			desc = "Telekasten kensaku",
		},
		{ "<C-;>v", "<Cmd>Telekasten switch_vault<CR>", desc = "Telekasten switch_vault" },
		{
			"<C-;><C-t>",
			function()
				vim.fn.setreg("+", ("%s/%s.md"):format(vim.fn.expand("%:.:h"), os.date("%Y-%m-%d")))
				require("telekasten").new_templated_note()
			end,
			desc = "Telekasten new_templated_note",
		},
	},
	config = require(".utils").load("conf/telekasten"),
	init = require("utils").load("init/telekasten"),
	dependencies = {
		"renerocksai/calendar-vim",
	},
}
