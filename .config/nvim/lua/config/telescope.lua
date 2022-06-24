local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")

telescope.setup({
	defaults = {
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
			},
			n = {
				["<C-n>"] = actions.move_selection_next,
				["<C-p>"] = actions.move_selection_previous,
				["<C-f>"] = actions.results_scrolling_up,
				["<C-b>"] = actions.results_scrolling_down,
				["q"] = actions.close,
				["<C-c>"] = actions.close,
				["y"] = function()
					local selection = require("telescope.actions.state").get_selected_entry()
					local path = vim.fn.fnamemodify(selection.path, ":p:t")
					vim.fn.setreg("+", path)
					vim.fn.setreg('"', path)
					print("Copied: " .. path)
				end,
				["Y"] = function()
					local selection = require("telescope.actions.state").get_selected_entry()
					local path = vim.fn.fnamemodify(selection.path, ":.")
					vim.fn.setreg("+", path)
					vim.fn.setreg('"', path)
					print("Copied: " .. path)
				end,
				["gy"] = function()
					local selection = require("telescope.actions.state").get_selected_entry()
					local path = selection.path
					vim.fn.setreg("+", path)
					vim.fn.setreg('"', path)
					print("Copied: " .. path)
				end,
			},
		},
	},
})

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap(
	"n",
	"<Leader><Leader>",
	"<Cmd>lua require('telescope.builtin').buffers({ sort_lastused = true, ignore_current_buffer = true })<CR>",
	opts
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>f",
	"<Cmd>lua require('telescope.builtin').git_files({ hidden = true, cwd='$PWD' })<CR>",
	opts
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>F",
	"<Cmd>lua require('telescope.builtin').find_files({ hidden = true, no_ignore = true, cwd='$PWD' })<CR>",
	opts
)
vim.api.nvim_set_keymap("n", "<Leader>g", "<Cmd>lua require('telescope.builtin').live_grep({ cwd='$PWD' })<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>G", "<Cmd>lua require('telescope.builtin').grep_string({ cwd='$PWD' })<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>r", "<Cmd>Telescope resume<CR>", opts)

vim.api.nvim_set_keymap(
	"n",
	",g",
	"<Cmd>lua require('telescope.builtin').live_grep({ cwd='$SCRAPBOOK_DIR' })<CR>",
	opts
)
vim.api.nvim_set_keymap(
	"n",
	",G",
	"<Cmd>lua require('telescope.builtin').grep_string({ cwd='$SCRAPBOOK_DIR' })<CR>",
	opts
)
vim.api.nvim_set_keymap(
	"n",
	",f",
	"<Cmd>lua require('telescope.builtin').find_files({ cwd='$SCRAPBOOK_DIR' })<CR>",
	opts
)
vim.api.nvim_set_keymap(
	"n",
	",F",
	"<Cmd>lua require('telescope.builtin').find_files({ hidden = true, no_ignore = true, cwd='$SCRAPBOOK_DIR' })<CR>",
	opts
)
