local map = vim.keymap.set
map(
	"n",
	"<leader>gY",
	'<Cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<CR>',
	{ silent = true }
)
map(
	"v",
	"<leader>gY",
	'<Cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<CR>',
	{ silent = true }
)
map(
	"n",
	"<Leader>gr",
	'<Cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<CR>',
	{ silent = true }
)
vim.api.nvim_create_user_command("GhOpenRepo", function()
	require("gitlinker").get_repo_url({ action_callback = require("gitlinker.actions").open_in_browser })
end, {})
