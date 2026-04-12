local util = require("plugins.conf.telekasten_util")
local toggle_todo = util.toggle_todo
local toggle_check = util.toggle_check
local get_lines = util.get_lines

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
		{
			"<C-;>w",
			function()
				local cfg = require("telekasten").Cfg
				local vault_path = cfg.home
				local year = os.date("%Y")
				local month = os.date("%m")
				local d = os.date("%-d")
				local week_of_month = (d - 1) / 7 + 1
				local file_path = ("%s/weekly/%d/%s-w%d.md"):format(vault_path, year, month, week_of_month)
				vim.fn.execute("edit " .. file_path)
				if vim.fn.filereadable(file_path) == 0 then
					vim.fn.execute((":0r %s"):format(cfg.template_new_weekly))
				end
			end,
			desc = "Telekasten goto_thisweek",
		},
		{
			"<C-;>m",
			function()
				local vault_path = require("telekasten").Cfg.home
				local year = os.date("%Y")
				local month = os.date("%m")
				local file_path = ("%s/monthly/%s/%s-%s.md"):format(vault_path, year, year, month)
				vim.fn.execute(("edit %s"):format(file_path))
				if vim.fn.filereadable(file_path) == 0 then
					vim.fn.execute((":0r %s/templates/monthly.md"):format(vault_path))
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
	init = function()
		vim.api.nvim_create_user_command("DeleteTodoMark", function(o)
			if o.range == 0 then
				pcall(function()
					vim.fn.execute("%s/- \\[[x -]\\] [0-9][0-9]:[0-9][0-9]–[0-9][0-9]:[0-9][0-9] /- /g")
				end)
				pcall(function()
					vim.fn.execute("%s/- \\[[x -]\\] <.*> /- /g")
				end)
				pcall(function()
					vim.fn.execute("%s/- \\[[x -]\\] /- /g")
				end)
			else
				pcall(function()
					vim.fn.execute(
						o.line1
							.. ","
							.. o.line2
							.. "s/- \\[[x -]\\] [0-9][0-9]:[0-9][0-9]–[0-9][0-9]:[0-9][0-9] /- /g"
					)
				end)
				pcall(function()
					vim.fn.execute(o.line1 .. "," .. o.line2 .. "s/- \\[[x -]\\] <.*> /- /g")
				end)
				pcall(function()
					vim.fn.execute(o.line1 .. "," .. o.line2 .. "s/- \\[[x -]\\] /- /g")
				end)
			end
			vim.fn.execute("nohlsearch")
		end, {
			range = 2,
		})
	end,
	config = function()
		local home = vim.fn.expand("$SCRAPBOOK_DIR")
		require("telekasten").setup({
			home = home,

			auto_set_filetype = false,

			dailies = ("%s/daily/%s"):format(home, os.date("%Y")),
			weeklies = ("%s/weekly/%s"):format(home, os.date("%Y")),
			templates = ("%s/templates"):format(home),

			template_new_note = ("%s/templates/new_note.md"):format(home),
			template_new_daily = ("%s/templates/daily.md"):format(home),
			template_new_weekly = ("%s/templates/weekly.md"):format(home),

			journal_auto_open = true,

			calendar_opts = {
				-- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
				weeknm = 1,
				-- use monday as first day of week: 1 .. true, 0 .. false
				calendar_monday = 0,
				-- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
				calendar_mark = "left-fit",
			},

			image_link_style = "markdown",
			image_subdir = "assets",
			extension = ".md",

			uuid_type = "%Y%m%d%H%M%S",
			uuid_sep = "-",

			tag_notation = "#tag",
			subdirs_in_links = true,

			follow_creates_nonexisting = true,
			dailies_create_nonexisting = true,
			weeklies_create_nonexisting = true,

			sort = "filename",
			new_note_location = "prefer_home",

			rename_update_links = true,

			find_command = { "rg", "--files", "--sortr", "created", "--glob=!**/*.age" },
		})
	end,
	dependencies = {
		"renerocksai/calendar-vim",
	},
}
