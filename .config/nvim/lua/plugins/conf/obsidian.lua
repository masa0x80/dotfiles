local opts = {
	dir = vim.fn.expand("$SCRAPBOOK_DIR"),
	daily_notes = {
		folder = "daily",
		date_format = "%Y-%m-%d",
		template = "daily.md",
	},
	completion = {
		nvim_cmp = true,
		min_chars = 1,
		new_notes_location = "current_dir",
		prepend_note_id = true,
		prepend_note_path = false,
		use_path_only = false,
	},
	disable_frontmatter = true,
	templates = {
		subdir = "templates",
		date_format = "%Y-%m-%d",
		time_format = "%H:%M",
	},
	ui = {
		checkboxes = {
			[" "] = { char = "", hl_group = "ObsidianTodo" },
			["%-"] = { char = "󰡖", hl_group = "ObsidianDone" },
			["x"] = { char = "󰄵", hl_group = "ObsidianDone" },
			[">"] = { char = "", hl_group = "ObsidianRightArrow" },
			["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
		},
	},
}
require("obsidian").setup(opts)
