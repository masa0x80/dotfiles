local UNORDERED_LIST_PATTERN = "^%s*[-*+] $"
local TASK_PATTERN = "^%s*[-*+] %[[x ]%] $"
local toggle_check = function()
	local row = vim.fn.line(".") - 1
	local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
	local new

	if string.match(line, string.sub(TASK_PATTERN, 0, -2)) then
		require("telekasten").toggle_todo()
		return
	elseif string.match(line, string.sub(UNORDERED_LIST_PATTERN, 0, -2)) then
		new = line:gsub("[-*+] (%S)", "%1", 1)
	else
		new = line:gsub("(%S)", "- %1", 1)
	end
	vim.api.nvim_buf_set_lines(0, row, row + 1, false, { new })
end

return {
	"renerocksai/telekasten.nvim",
	keys = {
		{ ";z", "<Cmd>Telekasten panel<CR>", noremap = true, silent = true },
		{ ";i", "<Cmd>Telekasten insert_link<CR>", noremap = true, silent = true },
		{ ";I", "<Cmd>Telekasten insert_img_link<CR>", noremap = true, silent = true },
		{ "g]", "<Cmd>Telekasten follow_link<CR>", noremap = true, silent = true },
		{ "g[", "<Cmd>Telekasten show_backlinks<CR>", noremap = true, silent = true },
		{ ";n", "<Cmd>Telekasten new_note<CR>", noremap = true, silent = true },
		{ ";r", "<Cmd>Telekasten find_friends<CR>", noremap = true, silent = true },
		{ ";t", "<Cmd>Telekasten show_tags<CR>", noremap = true, silent = true },
		{
			"<C-g><C-i>",
			toggle_check,
			noremap = true,
			silent = true,
			mode = { "n", "i" },
		},
		{
			"<C-g><C-i>",
			"<Esc><Cmd>:'<,'>s/^\\(\\s*\\)\\(\\S\\)/\\1- \\2/g<CR>:nohlsearch<CR>",
			noremap = true,
			silent = true,
			mode = { "x" },
		},
		{
			"<C-g><C-o>",
			toggle_check,
			noremap = true,
			silent = true,
			mode = { "n", "i" },
		},
		{
			"<C-g><C-o>",
			"<Esc><Cmd>:'<,'>s/^\\(\\s*\\)[-*+] \\(\\[[ x]\\] \\)\\?\\(\\S\\)/\\1\\3/g<CR>:nohlsearch<CR>",
			noremap = true,
			silent = true,
			mode = { "x" },
		},
		{
			"<C-g><C-g><C-i>",
			"<Esc><Cmd>lua require('telekasten').toggle_todo({ i = true })<CR>",
			noremap = true,
			silent = true,
			mode = "i",
		},
		{
			"<C-g><C-g><C-i>",
			"<Esc><Cmd>:'<,'>s/^\\(\\s*\\)\\(\\S\\)/\\1- [ ] \\2/g<CR>:nohlsearch<CR>",
			noremap = true,
			silent = true,
			mode = "x",
		},
		{
			"<C-g><C-g><C-o>",
			"<Esc><Cmd>lua require('telekasten').toggle_todo()<CR><Cmd>lua require('telekasten').toggle_todo({ i = true })<CR>",
			noremap = true,
			silent = true,
			mode = "i",
		},
		{
			"<C-g><C-g><C-o>",
			"<Esc><Cmd>:'<,'>s/^\\(\\s*\\)\\(\\S\\)/\\1- [x] \\2/g<CR>:nohlsearch<CR>",
			noremap = true,
			silent = true,
			mode = "x",
		},
		{
			"<C-g><C-g><C-i>",
			"<Cmd>lua require('telekasten').toggle_todo()<CR>",
			noremap = true,
			silent = true,
		},
		{
			"<C-g><C-g><C-o>",
			"<Cmd>lua require('telekasten').toggle_todo()<CR><Cmd>lua require('telekasten').toggle_todo()<CR>",
			noremap = true,
			silent = true,
		},
		{ ";d", "<Cmd>Telekasten goto_today<CR>", noremap = true, silent = true },
		{ ";w", "<Cmd>Telekasten goto_thisweek<CR>", noremap = true, silent = true },
		{ ";c", "<Cmd>Telekasten show_calendar<CR>", noremap = true, silent = true },
		{
			";k",
			"<Cmd>lua require('telescope._extensions.kensaku').exports.kensaku({ cwd = require('telekasten').Cfg.home })<CR>",
			noremap = true,
			silent = true,
		},
		{ ";v", "<Cmd>Telekasten switch_vault<CR>", noremap = true, silent = true },
		{ ";o", "<Cmd>OpenObsidian<CR>", noremap = true, silent = true },
	},
	config = require("config.utils").load("conf/telekasten"),
	init = require("config.utils").load("init/telekasten"),
	dependencies = {
		"renerocksai/calendar-vim",
	},
}
