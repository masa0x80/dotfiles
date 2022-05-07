local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")

telescope.setup({
	defaults = {
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
			n = {
				["<C-n>"] = actions.move_selection_next,
				["<C-p>"] = actions.move_selection_previous,
				["<C-f>"] = actions.results_scrolling_up,
				["<C-b>"] = actions.results_scrolling_down,
				["q"] = actions.close,
				["<C-c><C-c>"] = actions.close,
			},
		},
	},
	pickers = {
		find_files = {
			theme = "dropdown",
		},
		git_files = {
			theme = "dropdown",
		},
		buffers = {
			theme = "dropdown",
		},
		live_grep = {
			theme = "dropdown",
		},
		grep_string = {
			theme = "dropdown",
		},
	},
})

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader><Leader>", "<Cmd>Telescope buffers<CR>", opts)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>f",
	"<Cmd>lua require('telescope.builtin').git_files({ hidden = true })<CR>",
	opts
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>F",
	"<Cmd>lua require('telescope.builtin').find_files({ hidden = true, no_ignore = true })<CR>",
	opts
)
vim.api.nvim_set_keymap("n", "<Leader>g", "<Cmd>Telescope live_grep<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>G", "<Cmd>Telescope grep_string<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>r", "<Cmd>Telescope resume<CR>", opts)
