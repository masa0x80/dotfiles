local home = vim.fn.expand("$SCRAPBOOK_DIR")
require("telekasten").setup({
	home = home,

	auto_set_filetype = false,

	dailies = home .. "/" .. "daily",
	weeklies = home .. "/" .. "weekly",
	templates = home .. "/" .. "templates",

	template_new_note = home .. "/" .. "templates/new_note.md",
	template_new_daily = home .. "/" .. "templates/daily.md",
	template_new_weekly = home .. "/" .. "templates/weekly.md",

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
})
