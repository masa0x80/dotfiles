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
			local templates_dir = vault_path .. "/templates"
			local files = vim.fn.glob(templates_dir .. "/**/*", false, true)
			local items = vim.iter(files)
				:filter(function(v)
					return vim.fn.filereadable(v) == 1
				end)
				:map(function(file)
					return { text = vim.fn.fnamemodify(file, ":."), file = file }
				end)
				:totable()

			Snacks.picker({
				title = "Apply template",
				items = items,
				format = function(item)
					return { { item.text } }
				end,
				preview = "file",
				confirm = function(picker, item)
					picker:close()
					if not item then
						return
					end
					vim.cmd("-1r " .. item.file)
					local function expand_includes()
						local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
						for lnum, line in ipairs(lines) do
							-- (.-) は非貪欲なキャプチャーで `includes%s+` の後の文字列を取得する
							local ref = line:match("{{include%s+(.-)%s*}}")
							if ref then
								local path
								if ref:find("^/") then
									path = ref
								elseif vim.fn.filereadable(templates_dir .. "/" .. ref) == 1 then
									path = templates_dir .. "/" .. ref
								else
									path = vault_path .. "/" .. ref
								end
								if vim.fn.filereadable(path) == 1 then
									local content = vim.fn.readfile(path)
									vim.api.nvim_buf_set_lines(0, lnum - 1, lnum, false, content)
									return expand_includes()
								end
							end
						end
					end
					expand_includes()

					local filename = vim.fn.expand("%:t:r")
					local date_pattern = "(%d%d%d%d%-%d%d%-%d%d)"
					local date = string.match(filename, date_pattern)
					if date ~= nil then
						vim.cmd("ReplaceDate " .. date)
					else
						vim.cmd("ReplaceDate")
					end
					vim.cmd("F")
				end,
			})
		end,
	},
}
