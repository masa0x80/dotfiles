local keymap = vim.keymap.set
keymap(
	"n",
	"<leader>gY",
	'<Cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<CR>',
	{ silent = true }
)
keymap(
	"v",
	"<leader>gY",
	'<Cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<CR>',
	{ silent = true }
)
keymap(
	"n",
	"<Leader>gr",
	'<Cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<CR>',
	{ silent = true }
)
vim.api.nvim_create_user_command("GhOpenRepo", function()
	require("gitlinker").get_repo_url({ action_callback = require("gitlinker.actions").open_in_browser })
end, {})
