local explorer = require("plugins.conf.snacks.explorer")
local obsidian = require("plugins.conf.snacks.obsidian")
local template = require("plugins.conf.snacks.template")

return {
	{
		"<Leader>e",
		function()
			Snacks.explorer(explorer.opts)
		end,
		desc = "File Explorer",
	},
	{
		"-",
		function()
			Snacks.explorer(vim.tbl_deep_extend("force", explorer.opts, {
				layout = explorer.float_layout,
				auto_close = true,
			}))
		end,
		desc = "File Explorer",
	},
	-- Zen
	{
		"<Leader>z",
		function()
			Snacks.zen.zoom()
		end,
		desc = "Toggle Zoom",
	},
	{
		"<Leader>Z",
		function()
			Snacks.zen()
		end,
		desc = "Toggle Zen Mode",
	},
	-- Scratch
	{
		"<Leader>.",
		function()
			Snacks.scratch()
		end,
		desc = "Toggle Scratch Buffer",
	},
	{
		"<Leader>S",
		function()
			Snacks.scratch.select()
		end,
		desc = "Select Scratch Buffer",
	},
	-- Notifications
	{
		"<Leader>n",
		function()
			Snacks.picker.notifications()
		end,
		desc = "Notification History",
	},
	{
		"<Leader>sn",
		function()
			Snacks.notifier.show_history()
		end,
		desc = "Notification History",
	},
	{
		"<Leader>un",
		function()
			Snacks.notifier.hide()
		end,
		desc = "Dismiss All Notifications",
	},
	-- Rename
	{
		"<Leader>cR",
		function()
			Snacks.rename.rename_file()
		end,
		desc = "Rename File",
	},
	-- Words
	{
		"]]",
		function()
			Snacks.words.jump(vim.v.count1)
		end,
		desc = "Next Reference",
		mode = { "n", "t" },
	},
	{
		"[[",
		function()
			Snacks.words.jump(-vim.v.count1)
		end,
		desc = "Prev Reference",
		mode = { "n", "t" },
	},
	-- Obsidian
	{
		"<C-;>o",
		desc = "Open in Obsidian",
		function()
			obsidian.open_current()
		end,
	},
	{
		"<C-;><C-o>",
		desc = "[Obsidian] Open tmp file",
		function()
			obsidian.open_tmp()
		end,
	},
	{
		"<C-;>q",
		desc = "Search in Obsidian",
		function()
			obsidian.search()
		end,
	},
	-- Template
	{
		"<C-;>t",
		desc = "Apply template",
		function()
			template.apply()
		end,
	},
}
