local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		path_display = { "smart" },
		sorting_strategy = "ascending",
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
				["<C-c>"] = { "<Esc>", type = "command" },
				["<C-c><C-c>"] = actions.close,
				["<C-g><C-g>"] = function()
					local selection = require("telescope.actions.state").get_selected_entry()
					local path = vim.fn.fnamemodify(selection.path, ":p:t")
					vim.notify(path, vim.log.levels.INFO, { title = "File Path" })
				end,
			},
			n = {
				["<C-n>"] = actions.move_selection_next,
				["<C-p>"] = actions.move_selection_previous,
				["<C-f>"] = actions.results_scrolling_up,
				["<C-b>"] = actions.results_scrolling_down,
				["q"] = actions.close,
				["<C-c>"] = actions.close,
				["<C-g><C-g>"] = function()
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
				["<C-y>"] = function()
					local selection = require("telescope.actions.state").get_selected_entry()
					local path = selection.path
					vim.fn.setreg("+", path)
					vim.fn.setreg('"', path)
					vim.notify(path, vim.log.levels.INFO, { title = "Copied" })
				end,
			},
		},
	},
	extensions = {
		coc = {
			prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
		},
	},
})

local tb = require("telescope.builtin")
local keymap = vim.keymap.set
keymap("n", "<Leader><Space>", function()
	tb.buffers({ sort_mru = true, ignore_current_buffer = true })
end, { desc = "[ ] Find existing buffers" })
keymap("n", "<Leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })

keymap("n", "<Leader>f", function()
	vim.fn.system("git rev-parse --is-inside-work-tree")
	if vim.v.shell_error == 0 then
		tb.git_files({ hidden = true })
	else
		tb.find_files({ hidden = true, no_ignore = true })
	end
end, { desc = "Search [F]iles" })
keymap("n", "<Leader>F", function()
	tb.find_files({ hidden = true, no_ignore = true })
end, { desc = "Search [F]iles" })
keymap("n", "<Leader>sh", tb.help_tags, { desc = "[S]earch [H]elp" })
keymap("n", "<Leader>g", tb.live_grep, { desc = "Search by [G]rep" })
keymap("n", "<Leader>G", tb.grep_string, { desc = "[G] Search current Word" })
keymap("n", "<Leader>sd", tb.diagnostics, { desc = "[S]earch [D]iagnostics" })
keymap("n", "<Leader>o", tb.oldfiles, { desc = "[o] Find recently opened files" })
keymap("n", "<Leader>k", tb.keymaps, { desc = "Search [K]eymaps" })
keymap("n", "<Leader>tt", tb.resume, { desc = "Telescope Resume" })

-- Commands
keymap("n", "<Leader>;", tb.commands, { desc = "[;] Search Commands" })
keymap("n", "<Leader>:", tb.command_history, { desc = "[:] Search Command History" })

require("telescope").load_extension("ghq")
keymap("n", ";e", function()
	require("telescope._extensions.ghq_builtin").list()
end, { desc = "Telescope ghq list" })
