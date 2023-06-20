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
	image_subdir = "img",
	extension = ".md",

	uuid_type = "%Y%m%d%H%M%S",
	uuid_sep = "-",

	tag_notation = "#tag",

	follow_creates_nonexisting = true,
	dailies_create_nonexisting = true,
	weeklies_create_nonexisting = true,

	rename_update_links = true,
})

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", ";z", "<Cmd>Telekasten panel<CR>", opts)

keymap("n", ";i", "<Cmd>Telekasten insert_link<CR>", opts)
keymap("n", "g]", "<Cmd>Telekasten follow_link<CR>", opts)
keymap("n", "g[", "<Cmd>Telekasten show_backlinks<CR>", opts)

keymap("n", ";n", "<Cmd>Telekasten new_note<CR>", opts)
keymap("n", ";r", "<Cmd>Telekasten find_friends<CR>", opts)
keymap("n", ";t", "<Cmd>Telekasten show_tags<CR>", opts)

keymap("n", "<C-t><C-i>", "<Cmd>Telekasten toggle_todo<CR>", opts)
keymap("i", "<C-t><C-i>", "<Esc><Cmd>Telekasten toggle_todo<CR><Right>I", opts)

keymap("n", ";d", "<Cmd>Telekasten goto_today<CR>", opts)
keymap("n", ";w", "<Cmd>Telekasten goto_thisweek<CR>", opts)

keymap("n", ";c", "<Cmd>Telekasten show_calendar<CR>", opts)

keymap("n", ";f", "<Cmd>Telekasten find_notes<CR>", opts)
keymap("n", ";g", "<Cmd>Telekasten search_notes<CR>", opts)

vim.api.nvim_create_user_command("DeleteTodoMark", function()
	vim.fn.execute("%s/\\[[x ]\\] //g")
	vim.fn.execute("nohlsearch")
end, {})
