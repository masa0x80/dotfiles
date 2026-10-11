return {
	"folke/todo-comments.nvim",
	version = "*",
	opts = {
		highlight = {
			pattern = [[.*<(KEYWORDS):?\s]],
		},
		search = {
			command = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--hidden",
			},
			pattern = [[\b(KEYWORDS):]],
		},
	},
	keys = {
		{
			"]c",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ vim.v.count1 .. "]c", bang = true })
				else
					require("todo-comments").jump_next()
				end
			end,
			desc = "Next Todo Comment",
		},
		{
			"[c",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ vim.v.count1 .. "[c", bang = true })
				else
					require("todo-comments").jump_prev()
				end
			end,
			desc = "Previous Todo Comment",
		},
		{
			"<Leader>st",
			function()
				Snacks.picker.todo_comments({ hidden = true })
			end,
			desc = "Todo",
		},
		{
			"<Leader>sT",
			function()
				Snacks.picker.todo_comments({
					keywords = { "TODO", "FIX", "FIXME", "XXX" },
					hidden = true,
				})
			end,
			desc = "Todo/Fix/Fixme",
		},
	},
}
