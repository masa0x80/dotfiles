return {
	"folke/todo-comments.nvim",
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
				require("todo-comments").jump_next()
			end,
			desc = "Next Todo Comment",
		},
		{
			"[c",
			function()
				require("todo-comments").jump_prev()
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
