local conf = require("plugins.conf.snacks")
local explorer_opts = conf.explorer_opts

return {
	{
		"<Leader>e",
		function()
			Snacks.explorer(explorer_opts)
		end,
		desc = "File Explorer",
	},
	{
		"-",
		function()
			Snacks.explorer(vim.tbl_deep_extend("force", explorer_opts, {
				layout = {
					preview = true,
					layout = {
						box = "horizontal",
						backdrop = false,
						width = 0.8,
						height = 0.9,
						border = "none",
						{
							box = "vertical",
							{
								win = "input",
								height = 1,
								border = "rounded",
								title = "{title} {live} {flags}",
								title_pos = "center",
							},
							{ win = "list", title = " Results ", title_pos = "center", border = "rounded" },
						},
						{
							win = "preview",
							title = "{preview:Preview}",
							width = 0.45,
							border = "rounded",
							title_pos = "center",
						},
					},
				},
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
			local path = vim.fs.relpath(vim.fs.dirname(require("snacks.git").get_root()), vim.fn.expand("%:p"))
			vim.fn.jobstart(("open 'obsidian://vault/%s'"):format(path))
		end,
	},
	{
		"<C-;><C-o>",
		desc = "[Obsidian] Open tmp file",
		function()
			local vault_path = require("telekasten").Cfg.home
			local path = ("%s/tmp.md"):format(vault_path)
			vim.fn.execute(("tabedit %s"):format(path))
			vim.fn.jobstart(("open 'obsidian://open?path=%s'"):format(path))
		end,
	},
	{
		"<C-;>q",
		desc = "Search in Obsidian",
		function()
			local vault = vim.fs.basename(require("telekasten").Cfg.home)
			vim.ui.input({ prompt = "Input query to search in Obsidian" }, function(input)
				local query = input
				vim.fn.jobstart(("open 'obsidian://search?vault=%s&query=%s'"):format(vault, query))
			end)
		end,
	},
	-- Template
	{
		"<C-;>t",
		desc = "Apply template",
		function()
			local vault_path = require("telekasten").Cfg.home
			local files = vim.fn.glob(vault_path .. "/templates/**/*", false, true)
			local items = {}
			for i, file in
				ipairs(vim.iter(files)
					:filter(function(v)
						if vim.fn.filereadable(v) == 1 then
							return v
						end
					end)
					:totable())
			do
				local path = vim.fn.fnamemodify(file, ":.")
				items[i] = path
			end

			vim.ui.select(items, {
				prompt = "Select: ",
				format_item = function(item)
					return item
				end,
			}, function(choice)
				if choice == nil then
					return
				end

				vim.cmd("-1r " .. choice)
				local filename = vim.fn.expand("%:t:r")
				local date_pattern = "(%d%d%d%d%-%d%d%-%d%d)"
				local date = string.match(filename, date_pattern)
				if date ~= nil then
					vim.cmd("ReplaceDate " .. date)
				else
					vim.cmd("ReplaceDate")
				end
				vim.cmd("F")
			end)
		end,
	},
}
