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
			"Orange",
			"Cyan",
			"Yellow",
		},
	},
})
