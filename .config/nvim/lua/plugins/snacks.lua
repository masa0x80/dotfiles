return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		explorer = { enabled = true },
		image = { enabled = true },
		indent = { enabled = true },
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
					},
				},
				input = {
					keys = {
						["<C-j>"] = { "preview_scroll_down", mode = { "n", "i" } },
						["<C-k>"] = { "preview_scroll_up", mode = { "n", "i" } },
						["<C-a>"] = { "ctr_a", mode = { "i" } },
						["<C-f>"] = { "ctr_f", mode = { "i" } },
						["<C-b>"] = { "ctr_b", mode = { "i" } },
						["<C-f>"] = { "list_scroll_down", mode = { "n" } },
						["<C-b>"] = { "list_scroll_up", mode = { "n" } },
						["<C-z>"] = { "select_all", mode = { "n", "i" } },
						["<C-y>"] = { "yank", mode = { "n", "i" } },
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
			},
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
				Snacks.picker.grep()
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
				Snacks.explorer({
					hidden = true,
					ignored = true,
					win = {
						list = {
							keys = {
								["<C-l>"] = { "lcd" },
								["<C-c>"] = { "close" },
								["c"] = { { "yank_only_filename", "explorer_copy" } },
								["y"] = { "yank_only_filename" },
								["Y"] = { "explorer_yank" },
							},
						},
					},
					actions = {
						yank_only_filename = function(picker, item, action)
							if item then
								local reg = action.reg or vim.v.register
								local value = item[action.field] or item.data or item.text
								value = string.match(value, "[^/]*$")
								vim.fn.setreg(reg, value)
								if action.notify ~= false then
									local buf = item.buf or vim.api.nvim_win_get_buf(picker.main)
									local ft = vim.bo[buf].filetype
									Snacks.notify(
										("Yanked to register `%s`:\n```%s\n%s\n```"):format(reg, ft, value),
										{ title = "Snacks Picker" }
									)
								end
							end
						end,
					},
				})
			end,
			desc = "File Explorer",
		},
		{
			"-",
			function()
				Snacks.explorer({
					hidden = true,
					ignored = true,
					win = {
						list = {
							keys = {
								["<C-l>"] = { "lcd" },
								["<C-c>"] = { "close" },
								["c"] = { { "yank_only_filename", "explorer_copy" } },
								["y"] = { "yank_only_filename" },
								["Y"] = { "explorer_yank" },
							},
						},
					},
					actions = {
						yank_only_filename = function(picker, item, action)
							if item then
								local reg = action.reg or vim.v.register
								local value = item[action.field] or item.data or item.text
								value = string.match(value, "[^/]*$")
								vim.fn.setreg(reg, value)
								if action.notify ~= false then
									local buf = item.buf or vim.api.nvim_win_get_buf(picker.main)
									local ft = vim.bo[buf].filetype
									Snacks.notify(
										("Yanked to register `%s`:\n```%s\n%s\n```"):format(reg, ft, value),
										{ title = "Snacks Picker" }
									)
								end
							end
						end,
					},
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
				})
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
					hidden = true,
					ignored = true,
				})
			end,
			desc = "Find Dotfiles",
		},
		{
			"<Leader>ff",
			function()
				Snacks.picker.files({
					hidden = true,
					ignored = true,
				})
			end,
			desc = "Find Files",
		},
		{
			"<Leader>F",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<Space>ff",
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
			desc = "Find Git Files (under Telekasten home)",
		},
		{
			"<Space>F",
			function()
				Snacks.picker.git_files({
					cwd = require("telekasten").Cfg.home,
					sort = {
						fields = { "file:desc" },
					},
				})
			end,
			desc = "Find Files (under Telekasten home)",
		},
		{
			"<Leader>fl",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<Leader>fr",
			function()
				Snacks.picker.recent({
					filter = {
						paths = {
							[Snacks.git.get_root()] = true,
							[Snacks.git.get_root() .. "/.git/COMMIT_EDITMSG"] = false,
						},
					},
				})
			end,
			desc = "Recent",
		},
		{
			"<Space>fr",
			function()
				Snacks.picker.recent({
					filter = {
						paths = {
							[require("telekasten").Cfg.home] = true,
							[require("telekasten").Cfg.home .. "/.git/COMMIT_EDITMSG"] = false,
						},
					},
				})
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
			"<Leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gL",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "Git Log Line",
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
				})
			end,
			desc = "Grep",
		},
		{
			"<Leader>sG",
			function()
				Snacks.picker.grep_word({
					hidden = true,
				})
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		{
			"<Leader>G",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		{
			"<Space>sg",
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

			"<Space>sG",
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

			"<Space>G",
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
			"<Leader>R",
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
	},
}
