local c = require("config.color")

require("hlchunk").setup({
	chunk = {
		enable = true,
		exclude_filetypes = {
			gitcommit = true,
			plantuml = true,
		},
	},
	blank = {
		enable = true,
		chars = { "" },
	},
	indent = {
		enable = true,
		chars = {
			"┊",
		},
		style = {
			c.red,
			c.orange,
			c.yellow,
			c.green,
			c.cyan,
			c.blue,
			c.purple,
		},
	},
})
