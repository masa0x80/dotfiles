require("gitlinker").setup()

vim.api.nvim_set_keymap(
	"n",
	"<Leader>gY",
	'<Cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<CR>',
	{ silent = true }
)
