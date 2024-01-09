local c = require("config.color")
---@diagnostic disable-next-line: missing-fields
require("obsidian").setup({
	dir = vim.fn.expand("$SCRAPBOOK_DIR"),
	daily_notes = {
		folder = "daily",
		date_format = "%Y-%m-%d",
		template = "daily.md",
	},
	---@diagnostic disable-next-line: missing-fields
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
	---@diagnostic disable-next-line: missing-fields
	ui = {
		checkboxes = {
			[" "] = { char = "", hl_group = "ObsidianTodo" },
			["%-"] = { char = "󰡖", hl_group = "ObsidianDone" },
			["x"] = { char = "󰄵", hl_group = "ObsidianDone" },
			[">"] = { char = "", hl_group = "ObsidianRightArrow" },
			["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
		},
		hl_groups = {
			ObsidianTodo = { bold = true, fg = c.orange },
			ObsidianDone = { bold = true, fg = c.cyan },
			ObsidianRightArrow = { bold = true, fg = c.orange },
			ObsidianTilde = { bold = true, fg = c.red },
			ObsidianRefText = { underline = true, fg = c.purple },
			ObsidianExtLinkIcon = { fg = c.purple },
			ObsidianTag = { underline = true, fg = c.cyan, bg = c.bg0 },
			ObsidianHighlightText = { bg = c.dark_yellow },
		},
	},
})
