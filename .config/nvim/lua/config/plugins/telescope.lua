local actions = require("telescope.actions")

local telescope = require("telescope")
telescope.setup({
	defaults = {
		path_display = { "smart" },
		sorting_strategy = "ascending",
		file_ignore_patterns = { "COMMIT_EDITMSG" },
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
		preview = {
			mime_hook = function(filepath, bufnr, opts)
				local extension = function(filepath)
					local split_path = vim.split(filepath:lower(), ".", { plain = true })
					return split_path[#split_path]
				end
				local is_image = function(filepath)
					local ext = extension(filepath)
					local extensions = { "png", "jpg", "jpeg", "gif" }
					return vim.tbl_contains(extensions, ext)
				end
				if is_image(filepath) then
					local term = vim.api.nvim_open_term(bufnr, {})
					local function send_output(_, data, _)
						for _, d in ipairs(data) do
							vim.api.nvim_chan_send(term, d .. "\r\n")
						end
					end
					vim.fn.jobstart({
						"catimg",
						filepath, -- Terminal image viewer command
					}, { on_stdout = send_output, stdout_buffered = true, pty = true })
				else
					require("telescope.previewers.utils").set_preview_message(
						bufnr,
						opts.winid,
						"Binary cannot be previewed"
					)
				end
			end,
		},
		mappings = {
			i = {
				["<C-k>"] = actions.preview_scrolling_up,
				["<C-j>"] = actions.preview_scrolling_down,
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
				["<C-k>"] = actions.preview_scrolling_up,
				["<C-j>"] = actions.preview_scrolling_down,
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
})

local tb = require("telescope.builtin")
local keymap = vim.keymap.set
keymap("n", "<Leader><CR>", function()
	tb.buffers({ sort_mru = true, ignore_current_buffer = true })
end, { desc = "[<CR>] Find existing buffers" })
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

telescope.load_extension("ghq")
keymap("n", ";e", function()
	require("telescope._extensions.ghq_builtin").list()
end, { desc = "Telescope ghq list" })
