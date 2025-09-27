require("mini.operators").setup({
	evaluate = {
		prefix = "<C-g>=",
	},

	-- Exchange text regions
	exchange = {
		prefix = "<C-g>x",
		reindent_linewise = true,
	},

	-- Multiply (duplicate) text
	multiply = {
		prefix = "<C-g>m",
	},

	-- Replace text with register
	replace = {
		prefix = "<C-g>r",
	},

	-- Sort text
	sort = {
		prefix = "<C-g>s",
	},
})
