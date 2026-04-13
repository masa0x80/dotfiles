return {
	{
		"<leader>gl",
		function()
			Snacks.picker.git_log_line()
		end,
		desc = "Git Log Line",
	},
	{
		"<Leader>gL",
		function()
			Snacks.picker.git_log()
		end,
		desc = "Git Log",
	},
	{
		"<Leader>gs",
		function()
			Snacks.picker.git_status()
		end,
		desc = "Git Status",
	},
	{
		"<Leader>gS",
		function()
			Snacks.picker.git_stash()
		end,
		desc = "Git Stash",
	},
	{
		"<Leader>gd",
		function()
			Snacks.picker.git_diff()
		end,
		desc = "Git Diff (Hunks)",
	},
	{
		"<Leader>gf",
		function()
			Snacks.picker.git_log_file()
		end,
		desc = "Git Log File",
	},
	{
		"<Leader>gb",
		function()
			Snacks.gitbrowse()
		end,
		desc = "GitBrowse",
	},
}
