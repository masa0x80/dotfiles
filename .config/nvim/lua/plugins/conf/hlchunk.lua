local c = require("config.color")

require("hlchunk").setup({
	chunk = {
		exclude_filetypes = {
			gitcommit = true,
			plantuml = true,
		},
	},
	blank = {
		chars = { "" },
	},
	indent = {
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
