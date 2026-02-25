local explorer_opts = {
	hidden = true,
	ignored = true,
	win = {
		list = {
			keys = {
				["<C-l>"] = { "lcd" },
				["<C-c>"] = { "close" },
				["c"] = { { "yank_only_filename", "explorer_copy" } },
				["y"] = { "copy_file_path" },
				["Y"] = { "explorer_yank" },
				["<Leader>h"] = { "toggle_hidden" },
				["H"] = false,
				["<C-n>g"] = "explorer_git_next",
				["<C-p>g"] = "explorer_git_prev",
				["<C-n>d"] = "explorer_diagnostic_next",
				["<C-p>d"] = "explorer_diagnostic_prev",
				["<C-n>w"] = "explorer_warn_next",
				["<C-p>w"] = "explorer_warn_prev",
				["<C-n>e"] = "explorer_error_next",
				["<C-p>e"] = "explorer_error_prev",
			},
		},
	},
	actions = {
		-- NOTE: https://ricoberger.de/blog/posts/neovim-extend-snacks-nvim-explorer/
		copy_file_path = {
			action = function(_, item)
				if not item then
					return
				end

				local vals = {
					["Filename"] = vim.fn.fnamemodify(item.file, ":t"),
					["Basename"] = vim.fn.fnamemodify(item.file, ":t:r"),
					["Extension"] = vim.fn.fnamemodify(item.file, ":t:e"),
					["Path"] = item.file,
					["Path (CWD)"] = vim.fn.fnamemodify(item.file, ":."),
					["Path (HOME)"] = vim.fn.fnamemodify(item.file, ":~"),
					["URI"] = vim.uri_from_fname(item.file),
				}

				local options = vim.tbl_filter(function(val)
					return vals[val] ~= ""
				end, vim.tbl_keys(vals))
				if vim.tbl_isempty(options) then
					vim.notify("No values to copy", vim.log.levels.WARN)
					return
				end
				table.sort(options)
				vim.ui.select(options, {
					prompt = "Choose to copy to clipboard:",
					format_item = function(list_item)
						return ("%s: %s"):format(list_item, vals[list_item])
					end,
				}, function(choice)
					local result = vals[choice]
					if result then
						vim.fn.setreg("+", result)
						Snacks.notify.info("Yanked `" .. result .. "`")
					end
				end)
			end,
		},
		yank_only_filename = {
			action = function(_, item)
				if not item then
					return
				end

				local result = vim.fn.fnamemodify(item.file, ":t")
				vim.fn.setreg("+", result)
				Snacks.notify.info("Yanked `" .. result .. "`")
			end,
		},
	},
}

return {
	"folke/snacks.nvim",
	version = "*",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		explorer = { enabled = true },
		image = { enabled = false },
		indent = { enabled = false },
		input = { enabled = true },
		picker = {
			enabled = true,
			win = {
				list = {
					keys = {
						["<C-j>"] = { "preview_scroll_down" },
						["<C-k>"] = { "preview_scroll_up" },
						["<C-y>"] = { "list_up" },
						["<C-e>"] = { "list_down" },
						["<C-f>"] = { "list_scroll_down" },
						["<C-b>"] = { "list_scroll_up" },
						["gi"] = { "toggle_focus" },
						["/"] = false,
					},
				},
				input = {
					keys = {
						["<C-j>"] = { "preview_scroll_down", mode = { "n", "i" } },
						["<C-k>"] = { "preview_scroll_up", mode = { "n", "i" } },
						["<C-a>"] = { "ctr_a", mode = { "i" } },
						---@diagnostic disable-next-line: duplicate-index
						["<C-f>"] = { "ctr_f", mode = { "i" } },
						---@diagnostic disable-next-line: duplicate-index
						["<C-b>"] = { "ctr_b", mode = { "i" } },
						---@diagnostic disable-next-line: duplicate-index
						["<C-f>"] = { "list_scroll_down", mode = { "n" } },
						---@diagnostic disable-next-line: duplicate-index
						["<C-b>"] = { "list_scroll_up", mode = { "n" } },
						["<C-z>"] = { "select_all", mode = { "n", "i" } },
						["<C-y>"] = { "yank", mode = { "n", "i" } },
						["<C-l>"] = { "show_full_path", mode = { "n", "i" } },
					},
				},
			},
			actions = {
				ctr_a = function()
					vim.fn.execute("normal I")
				end,
				ctr_f = function()
					vim.fn.execute("normal l")
				end,
				ctr_b = function()
					vim.fn.execute("normal h")
				end,
				show_full_path = function(picker)
					local item = picker:current()
					if item and item.file then
						vim.notify(item.file, vim.log.levels.INFO)
					end
				end,
			},
			formatters = { file = { truncate = 128 } },
		},
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = false },
		statuscolumn = { enabled = true },
		words = { enabled = false },
	},
	keys = {
		{
			"<Leader>/",
			function()
				Snacks.picker.grep({
					hidden = true,
					exclude = { "*.age" },
				})
			end,
			desc = "Grep",
		},
		{
			"<Leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<Leader>n",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notification History",
		},
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
		-- Find
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
				local root = require("snacks.git").get_root()
				if root == nil then
					Snacks.picker.files({
						hidden = true,
						ignored = true,
						sort = {
							fields = { "file:desc" },
						},
					})
				else
					Snacks.picker.git_files({
						untracked = true,
						sort = {
							fields = { "file:desc" },
						},
					})
				end
			end,
			desc = "Find Files",
		},
		{
			"<Leader>fr",
			function()
				local root = require("snacks.git").get_root()
				if root == nil then
					Snacks.picker.files({
						hidden = true,
						ignored = true,
						sort = {
							fields = { "file:asc" },
						},
					})
				else
					Snacks.picker.git_files({
						untracked = true,
						sort = {
							fields = { "file:asc" },
						},
					})
				end
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
				local root = require("snacks.git").get_root()
				if root == nil then
					Snacks.picker.files({
						hidden = true,
						ignored = true,
						cwd = require("telekasten").Cfg.home,
						sort = {
							fields = { "file:desc" },
						},
					})
				else
					Snacks.picker.git_files({
						untracked = true,
						cwd = require("telekasten").Cfg.home,
						sort = {
							fields = { "file:desc" },
						},
					})
				end
			end,
			desc = "Find Git Files (under Telekasten home)",
		},
		{
			"<C-;>fr",
			function()
				local root = require("snacks.git").get_root()
				if root == nil then
					Snacks.picker.files({
						hidden = true,
						ignored = true,
						cwd = require("telekasten").Cfg.home,
						sort = {
							fields = { "file:asc" },
						},
					})
				else
					Snacks.picker.git_files({
						untracked = true,
						cwd = require("telekasten").Cfg.home,
						sort = {
							fields = { "file:asc" },
						},
					})
				end
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
		-- Git
		{
			"<Leader>gb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git Branches",
		},
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
		-- Grep
		{
			"<Leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<Leader>sB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},
		{
			"<Leader>sg",
			function()
				Snacks.picker.grep({
					hidden = true,
					exclude = { "*.age" },
				})
			end,
			desc = "Grep",
		},
		{
			"<Leader>sG",
			function()
				Snacks.picker.grep_word({
					hidden = true,
					exclude = { "*.age" },
				})
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		{
			"<Leader>G",
			function()
				Snacks.picker.grep_word({
					hidden = true,
					exclude = { "*.age" },
				})
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		{
			"<C-;>sg",
			function()
				Snacks.picker.grep({
					hidden = true,
					cwd = require("telekasten").Cfg.home,
					exclude = { "*.age" },
				})
			end,
			desc = "Grep (under Telekasten home)",
		},
		{

			"<C-;>sG",
			function()
				Snacks.picker.grep_word({
					hidden = true,
					cwd = require("telekasten").Cfg.home,
					exclude = { "*.age" },
				})
			end,
			mode = { "n", "x" },
			desc = "Visual selection or word (under Telekasten home)",
		},
		{

			"<C-;>G",
			function()
				Snacks.picker.grep_word({
					hidden = true,
					cwd = require("telekasten").Cfg.home,
					exclude = { "*.age" },
				})
			end,
			mode = { "n", "x" },
			desc = "Visual selection or word (under Telekasten home)",
		},
		-- Search
		{
			'<Leader>s"',
			function()
				Snacks.picker.registers()
			end,
			desc = "Registers",
		},
		{
			"<Leader>s/",
			function()
				Snacks.picker.search_history()
			end,
			desc = "Search History",
		},
		{
			"<Leader>sa",
			function()
				Snacks.picker.autocmds()
			end,
			desc = "Autocmds",
		},
		{
			"<Leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<Leader>sc",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<Leader>sC",
			function()
				Snacks.picker.commands()
			end,
			desc = "Commands",
		},
		{
			"<Leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<Leader>sD",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Buffer Diagnostics",
		},
		{
			"<Leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<Leader>sH",
			function()
				Snacks.picker.highlights()
			end,
			desc = "Highlights",
		},
		{
			"<Leader>si",
			function()
				Snacks.picker.icons()
			end,
			desc = "Icons",
		},
		{
			"<Leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumps",
		},
		{
			"<Leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<Leader>sl",
			function()
				Snacks.picker.loclist()
			end,
			desc = "Location List",
		},
		{
			"<Leader>sm",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		{
			"<Leader>sM",
			function()
				Snacks.picker.man()
			end,
			desc = "Man Pages",
		},
		{
			"<Leader>sp",
			function()
				Snacks.picker.lazy()
			end,
			desc = "Search for Plugin Spec",
		},
		{
			"<Leader>sq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix List",
		},
		{
			"<Leader>rr",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<Leader>st",
			function()
				Snacks.picker.todo_comments()
			end,
			desc = "Todo",
		},
		{
			"<Leader>sT",
			function()
				Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME", "XXX" } })
			end,
			desc = "Todo/Fix/Fixme/XXX",
		},

		{
			"<Leader>su",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		{
			"<Leader>uC",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Colorschemes",
		},
		-- LSP
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gh",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto T[y]pe Definition",
		},
		{
			"<Leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<Leader>sS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
		-- Other
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
		{
			"<Leader>n",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
		{
			"<Leader>cR",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"<Leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
			mode = { "n", "v" },
		},
		{
			"<Leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<Leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
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
		{
			"<Leader>N",
			desc = "Neovim News",
			function()
				Snacks.win({
					file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
					width = 0.6,
					height = 0.6,
					wo = {
						spell = false,
						wrap = false,
						signcolumn = "yes",
						statuscolumn = " ",
						conceallevel = 3,
					},
				})
			end,
		},
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

					local l = vim.fn.line("$")
					if l == 1 then
						vim.fn.execute(":0r " .. choice)
					else
						vim.fn.execute(":" .. l)
						vim.fn.execute(":r " .. choice)
					end
					local filename = vim.fn.expand("%:t:r")
					local date_pattern = "(%d%d%d%d%-%d%d%-%d%d)"
					local date = string.match(filename, date_pattern)
					if date ~= nil then
						vim.cmd("ReplaceDate " .. date)
					else
						vim.cmd("ReplaceDate")
					end
				end)
			end,
		},
	},
}
