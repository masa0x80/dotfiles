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
		use_path_only = true,
	},
	note_id_func = function(title)
		return title
	end,
	disable_frontmatter = true,
	templates = {
		subdir = "templates",
		date_format = "%Y-%m-%d",
		time_format = "%H:%M",
	},
	follow_url_func = function(url)
		vim.fn.jobstart({ "open", url })
	end,
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
