local conf = require("plugins.conf.snacks")
local smart_files = conf.smart_files

return {
	{
		"<Leader>fb",
		function()
			Snacks.picker.buffers()
		end,
		desc = "Buffers",
	},
	{
		"<Leader>b",
		function()
			Snacks.picker.buffers()
		end,
		desc = "Buffers",
	},
	{
		"<Leader>fc",
		function()
			Snacks.picker.git_files({
				cwd = os.getenv("DOTFILES"),
				untracked = true,
				hidden = true,
				ignored = true,
			})
		end,
		desc = "Find Dotfiles",
	},
	{
		"<Leader>ff",
		function()
			smart_files({ sort = { fields = { "file:desc" } } })
		end,
		desc = "Find Files",
	},
	{
		"<Leader>fr",
		function()
			smart_files({ sort = { fields = { "file:asc" } } })
		end,
		desc = "Find Files (rev)",
	},
	{
		"<Leader>F",
		function()
			Snacks.picker.files({
				hidden = true,
				ignored = true,
				sort = {
					fields = { "file:desc" },
				},
			})
		end,
		desc = "Find Git Files",
	},
	{
		"<Leader>R",
		function()
			Snacks.picker.files({
				hidden = true,
				ignored = true,
				sort = {
					fields = { "file:asc" },
				},
			})
		end,
		desc = "Find Git Files (rev)",
	},
	{
		"<C-;>ff",
		function()
			smart_files({
				cwd = require("telekasten").Cfg.home,
				sort = { fields = { "file:desc" } },
			})
		end,
		desc = "Find Git Files (under Telekasten home)",
	},
	{
		"<C-;>fr",
		function()
			smart_files({
				cwd = require("telekasten").Cfg.home,
				sort = { fields = { "file:asc" } },
			})
		end,
		desc = "Find Git Files (under Telekasten home; rev)",
	},
	{
		"<C-;>F",
		function()
			Snacks.picker.files({
				cwd = require("telekasten").Cfg.home,
				hidden = true,
				ignored = true,
				sort = {
					fields = { "file:desc" },
				},
			})
		end,
		desc = "Find Files (under Telekasten home)",
	},
	{
		"<C-;>R",
		function()
			Snacks.picker.files({
				cwd = require("telekasten").Cfg.home,
				hidden = true,
				ignored = true,
				sort = {
					fields = { "file:asc" },
				},
			})
		end,
		desc = "Find Files (under Telekasten home; rev)",
	},
	{
		"<Leader>fl",
		function()
			Snacks.picker.lines()
		end,
		desc = "Buffer Lines",
	},
	{
		"<Leader>re",
		function()
			Snacks.picker.recent({
				filter = {
					cwd = true,
					paths = {
						[Snacks.git.get_root() .. "/.git/COMMIT_EDITMSG"] = false,
					},
				},
			})
		end,
		desc = "Recent",
	},
	{
		"<Leader>RE",
		function()
			Snacks.picker.recent()
		end,
		desc = "Recent",
	},
	{
		"<C-;>re",
		function()
			Snacks.picker.recent({
				filter = {
					cwd = true,
					paths = {
						[require("telekasten").Cfg.home .. "/.git/COMMIT_EDITMSG"] = false,
					},
				},
			})
		end,
		desc = "Recent (under Telekasten home)",
	},
	{
		"<C-;>RE",
		function()
			Snacks.picker.recent()
		end,
		desc = "Recent (under Telekasten home)",
	},
}
