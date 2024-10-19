local actions = require("telescope.actions")
local utils = require("config.utils")

local telescope = require("telescope")
telescope.setup({
	defaults = {
		path_display = {
			truncate = 3,
		},
		sorting_strategy = "ascending",
		file_ignore_patterns = { "COMMIT_EDITMSG" },
		-- add `--hidden` option
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
		},
		mappings = {
			i = {
				["<C-f>"] = { "<Right>", type = "command" },
				["<C-b>"] = { "<Left>", type = "command" },
				-- ["<C-e>"] = actions.move_selection_next, -- 行末移動に使用
				["<C-y>"] = actions.move_selection_previous,
				["<C-u>"] = actions.results_scrolling_up,
				["<C-d>"] = actions.results_scrolling_down,
				["<C-k>"] = actions.preview_scrolling_up,
				["<C-j>"] = actions.preview_scrolling_down,
				["<C-c>"] = { "<Esc>", type = "command" },
				["<C-c><C-c>"] = actions.close,
				["<A-l>"] = function()
					local selection = require("telescope.actions.state").get_selected_entry()
					local path = vim.fn.fnamemodify(selection.path, ":p:t")
					vim.notify(path, vim.log.levels.INFO, { title = "File Path" })
				end,
				["<C-S-k>"] = function()
					local selection = require("telescope.actions.state").get_selected_entry()
					local path = selection.path
					utils.preview(path)
				end,
			},
			n = {
				["<C-n>"] = actions.move_selection_next,
				["<C-p>"] = actions.move_selection_previous,
				["<C-e>"] = actions.move_selection_next,
				["<C-y>"] = actions.move_selection_previous,
				["<C-u>"] = actions.results_scrolling_up,
				["<C-d>"] = actions.results_scrolling_down,
				["<C-b>"] = actions.results_scrolling_up,
				["<C-f>"] = actions.results_scrolling_down,
				["<C-k>"] = actions.preview_scrolling_up,
				["<C-j>"] = actions.preview_scrolling_down,
				["q"] = actions.close,
				["<C-c>"] = actions.close,
				["<A-l>"] = function()
					local selection = require("telescope.actions.state").get_selected_entry()
					local path = vim.fn.fnamemodify(selection.path, ":p:t")
					vim.notify(path, vim.log.levels.INFO, { title = "File Path" })
				end,
				["yy"] = function()
					local selection = require("telescope.actions.state").get_selected_entry()
					local path = vim.fn.fnamemodify(selection.path, ":p:t")
					vim.fn.setreg("+", path)
					vim.fn.setreg('"', path)
					vim.notify(path, vim.log.levels.INFO, { title = "Copied" })
				end,
				["Y"] = function()
					local selection = require("telescope.actions.state").get_selected_entry()
					local path = vim.fn.fnamemodify(selection.path, ":.")
					vim.fn.setreg("+", path)
					vim.fn.setreg('"', path)
					vim.notify(path, vim.log.levels.INFO, { title = "Copied" })
				end,
				["<C-S-y>"] = function()
					local selection = require("telescope.actions.state").get_selected_entry()
					local path = selection.path
					vim.fn.setreg("+", path)
					vim.fn.setreg('"', path)
					vim.notify(path, vim.log.levels.INFO, { title = "Copied" })
				end,
				["K"] = function()
					local selection = require("telescope.actions.state").get_selected_entry()
					local path = selection.path
					utils.preview(path)
				end,
			},
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("ghq")
telescope.load_extension("dap")
telescope.load_extension("kensaku")
